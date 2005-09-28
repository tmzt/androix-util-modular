#!/bin/bash

# This script checks the contents of a dist tarball against a make
# clean'ed working copy.  The idea is to see if we have unused files
# sitting in cvs that could be removed or if we have files that should
# be dist'ed but aren't.
#
# Of course, a working copy will have a number of files that the
# tarball shouldn't have (e.g. autogen.sh) and vice versa
# (e.g. Makefile).  Fortunately, that's a pretty small fixed list so
# we just filter out those differences.
#
# The script should be run on a ./configure'd component from the
# modular release, for example:
#
#   ./check-tarball.sh cvs/lib/Xi
#
# will check the Xi library, assuming that ./configure has already
# been run in that working copy.  As the script runs, it will make
# clean the working copy.
#
# At the end of the run, the script will diff the list of files in the
# working copy against the list of files in the tarball.  Files in the
# working copy but not in the tarball will show up as deleted lines in
# the diff output.  For example, lib/Xi has XFreeLst.c in the working
# copy but it isn't dist'ed, giving this output:
#
#   --- module-files-24058.txt      2005-09-28 14:09:48.000000000 -0400
#   +++ tar-files-24058.txt 2005-09-28 14:09:49.000000000 -0400
#   @@ -50,7 +50,6 @@
#    src/XDevBell.c
#    src/XExtInt.c
#    src/XExtToWire.c
#   -src/XFreeLst.c
#    src/XGetBMap.c
#    src/XGetDCtl.c
#    src/XGetFCtl.c

# Strip trailing /
dir=${1%%/}

echo Checking $dir

if test ! -e $dir/Makefile; then
    echo $dir not ./configure\'d, bailing out
    exit 1
fi

make -C $dir dist
make -C $dir clean

# We can't easily extract name and version from the configure.ac, so
# we just glob for the dist tarball.

tarball=$dir/*.tar.bz2

blacklist="config.log config.status autogen.sh$ Makefile.in$ Makefile$ config.h$ .libs/ .deps/ configure$ ^autom4te.cache.* CVS/.* .*/$ .cvsignore$ .*tar.bz2$ .*tar.gz$ .*\.o$ .*\.lo$ .*\.Plo$ .*\.la$ .*\.pc$ stamp-h1$ ^libtool$ .*~$"

# handle grep escape madness
escaped_blacklist=$(for f in $blacklist; do echo -n '\('$f'\)\|'; done)
escaped_blacklist=${escaped_blacklist%%\\|}

module_files=module-files-$$.txt
tar_files=tar-files-$$.txt

find -L $dir -type f | sed -e "s,^$dir/,," | grep -v $escaped_blacklist | sort > $module_files

tar tf $tarball | cut -d / -f 2- | grep -v $escaped_blacklist | sort | tail +2 > $tar_files

echo 
echo === diffs to module files: ===
echo 

diff -u $module_files $tar_files

rm $module_files $tar_files

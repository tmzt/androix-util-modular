#!/bin/sh

if [ -d "obj-i386" ]; then
    OBJDIR="obj-i386"
elif [ -d "obj-amd64" ]; then
    OBJDIR="obj-amd64"
else
    OBJDIR="."
fi

tarball="$1"
section="$2"
file="$HOME/x/xorg/final/$tarball"
module="$(echo $tarball | cut -f1 -d-)"
version="$(echo $tarball | cut -f2 -d-)"
tarbz2="$tarball.tar.bz2"
targz="$tarball.tar.gz"

if ! [ -f "$OBJDIR/$tarbz2" ] || ! [ -f "$OBJDIR/$targz" ] || [ -z "$section" ]; then
    echo "incorrect parameters!"
    exit 1
fi

if ssh annarchy.freedesktop.org ls /srv/xorg.freedesktop.org/archive/individual/${section}/${targz} >/dev/null 2>&1 ||
   ssh annarchy.freedesktop.org ls /srv/xorg.freedesktop.org/archive/individual/${section}/${tarbz2} >/dev/null 2>&1; then
    if ! [ "x$3" = "xforce" ]; then
        echo "file already exists!"
        exit 1
    else
        echo "overriding released file ... here be dragons."
    fi
fi

if ! [ -d .git ]; then
    echo "do this from your git dir, weenie"
    exit 1
fi

echo "git tag: ${tarball}" >> $file
echo >> $file
echo "http://xorg.freedesktop.org/archive/individual/${section}/${tarbz2}" >> $file
echo -n "MD5: " >> $file
(cd $OBJDIR && md5sum ${tarbz2}) >> $file
echo -n "SHA1: " >> $file
(cd $OBJDIR && sha1sum ${tarbz2}) >> $file
echo >> $file
echo "http://xorg.freedesktop.org/archive/individual/${section}/${targz}" >> $file
echo -n "MD5: " >> $file
(cd $OBJDIR && md5sum ${targz}) >> $file
echo -n "SHA1: " >> $file
(cd $OBJDIR && sha1sum ${targz}) >> $file

scp $OBJDIR/$targz $OBJDIR/$tarbz2 annarchy.freedesktop.org:/srv/xorg.freedesktop.org/archive/individual/${section}
git push origin
git push --tags origin

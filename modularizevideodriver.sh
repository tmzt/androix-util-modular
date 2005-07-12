#!/bin/bash

###########################
#
#	Variables and setup
#

if [ -z $1 ] ; then
    echo
    echo Usage: $0 \<directory\>
    echo
    exit
fi

MODULAR_DIR=`( cd $1 ; cd ../.. ; pwd )`
MODULE_DIR=`( cd $1 ; pwd )`
MODULE_NAME=`( basename $MODULE_DIR )`
modulename=`echo $MODULE_NAME | tr "[:upper:]" "[:lower:]"`
drivername=`echo $MODULE_NAME | sed s/xf86-video-//`

if [ -z foo ]  ; then
    echo Modular dir: $MODULAR_DIR
    echo Module dir : $MODULE_DIR
    echo Name: $MODULE_NAME
    echo lower: $modulename
    echo Man dir: $HAS_MAN_DIR
    echo Include dir: $HAS_INCLUDE_DIR
fi

cd $MODULE_DIR

#
# man pages?
#

for x in `ls man/*` ; do
    man_pages=true
done


###############################
#
#	Generate autogen.sh
#

rm -f autogen.sh

cat <<EOF >> autogen.sh
#! /bin/sh

srcdir=\`dirname \$0\`
test -z "\$srcdir" && srcdir=.

ORIGDIR=\`pwd\`
cd \$srcdir

autoreconf -v --install || exit 1
cd \$ORIGDIR || exit \$?

\$srcdir/configure --enable-maintainer-mode "\$@"

EOF

chmod a+x autogen.sh


###################################
#
#     Generate toplevel Makefile.am
#

rm -f Makefile.am

cat <<EOF >> Makefile.am
#  Copyright 2005 Adam Jackson.
#
#  Permission is hereby granted, free of charge, to any person obtaining a
#  copy of this software and associated documentation files (the "Software"),
#  to deal in the Software without restriction, including without limitation
#  on the rights to use, copy, modify, merge, publish, distribute, sub
#  license, and/or sell copies of the Software, and to permit persons to whom
#  the Software is furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice (including the next
#  paragraph) shall be included in all copies or substantial portions of the
#  Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.  IN NO EVENT SHALL
#  ADAM JACKSON BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
#  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
#  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

AUTOMAKE_OPTIONS = foreign
SUBDIRS = src man
EOF

#
#	Generate configure.ac
#

rm -f configure.ac

cat <<EOF >> configure.ac
#  Copyright 2005 Adam Jackson.
#
#  Permission is hereby granted, free of charge, to any person obtaining a
#  copy of this software and associated documentation files (the "Software"),
#  to deal in the Software without restriction, including without limitation
#  on the rights to use, copy, modify, merge, publish, distribute, sub
#  license, and/or sell copies of the Software, and to permit persons to whom
#  the Software is furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice (including the next
#  paragraph) shall be included in all copies or substantial portions of the
#  Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.  IN NO EVENT SHALL
#  ADAM JACKSON BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
#  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
#  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# Process this file with autoconf to produce a configure script

AC_PREREQ(2.57)
AC_INIT([xf86-video-$drivername],
        0.1.0,
        [ajax@freedesktop.org],
        xf86-video-$drivername)

AC_CONFIG_SRCDIR([Makefile.am])
AM_CONFIG_HEADER([config.h])
AC_CONFIG_AUX_DIR(.)

AM_INIT_AUTOMAKE([dist-bzip2])

AM_MAINTAINER_MODE

# Checks for programs.
AC_PROG_LIBTOOL
AC_PROG_CC

AH_TOP([#include "xorg-server.h"])

# Checks for pkg-config packages
PKG_CHECK_MODULES(XORG, xorg-server)
inputdir=\$(pkg-config --variable=moduledir xorg-server)/input
AC_SUBST([inputdir])
sdkdir=\$(pkg-config --variable=sdkdir xorg-server)

CFLAGS="\$XORG_CFLAGS "' -I\$(top_srcdir)/src'
INCLUDES="\$XORG_INCS -I\${sdkdir} "'-I\$(top_srcdir)/src -I\$(prefix)/include'
AC_SUBST([CFLAGS])
AC_SUBST([INCLUDES])

# Checks for libraries.

# Checks for header files.
AC_HEADER_STDC

AC_OUTPUT([
	Makefile
	src/Makefile
EOF

if [ ! -z $man_pages ]  ; then 
    cat <<EOF >> configure.ac
	man/Makefile
EOF
fi

cat <<EOF >> configure.ac
])
EOF

##############################
#
#	man/Makefile.am
#
cd man

rm -f Makefile.am

if [ ! -z $man_pages ] ; then
    cat <<EOF >> Makefile.am
#  Copyright 2005 Adam Jackson.
#
#  Permission is hereby granted, free of charge, to any person obtaining a
#  copy of this software and associated documentation files (the "Software"),
#  to deal in the Software without restriction, including without limitation
#  on the rights to use, copy, modify, merge, publish, distribute, sub
#  license, and/or sell copies of the Software, and to permit persons to whom
#  the Software is furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice (including the next
#  paragraph) shall be included in all copies or substantial portions of the
#  Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.  IN NO EVENT SHALL
#  ADAM JACKSON BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
#  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
#  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

man_MANS = \\
EOF

    for x in `ls *.4` ; do
	LAST=$x ;
    done
    
    for x in `ls *.4` ; do
	if [ $x = $LAST ] ; then
	    echo \ \ \ \ \ \ \ \ \ $x		>> Makefile.am
	else
	    echo \ \ \ \ \ \ \ \ \ $x \\	>> Makefile.am
	fi
    done ;
fi

cd ..

############################
#
#	src/Makefile.am
#

cd src

rm -f Makefile.am

cat <<EOF >> Makefile.am
#  Copyright 2005 Adam Jackson.
#
#  Permission is hereby granted, free of charge, to any person obtaining a
#  copy of this software and associated documentation files (the "Software"),
#  to deal in the Software without restriction, including without limitation
#  on the rights to use, copy, modify, merge, publish, distribute, sub
#  license, and/or sell copies of the Software, and to permit persons to whom
#  the Software is furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice (including the next
#  paragraph) shall be included in all copies or substantial portions of the
#  Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.  IN NO EVENT SHALL
#  ADAM JACKSON BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
#  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
#  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


# this is obnoxious:
# -module lets us name the module exactly how we want
# -avoid-version prevents gratuitous .0.0.0 version numbers on the end
# _ladir passes a dummy rpath to libtool so the thing will actually link
# TODO: -nostdlib/-Bstatic/-lgcc platform magic, not installing the .a, etc.
${drivername}_drv_la_LTLIBRARIES = ${drivername}_drv.la
${drivername}_drv_la_LDFLAGS = -module -avoid-version
${drivername}_drv_ladir = @inputdir@

${drivername}_drv_la_SOURCES = \\
EOF

for x in `ls *.[ch]` ; do
    LAST=$x
done

for x in `ls *.[ch]` ; do
    if [ $x = $LAST ] ; then
	echo \ \ \ \ \ \ \ \ \ $x	>> Makefile.am
    else
	echo \ \ \ \ \ \ \ \ \ $x \\	>> Makefile.am
    fi
done

cd ..

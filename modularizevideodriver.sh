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

if [ ! -z $2 ] ; then
    if [ $2="dri" ] ; then
	has_dri="yes"
    fi
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
EOF

if [ -z $man_pages ]  ; then 
    echo SUBDIRS = src				>> Makefile.am
else
    echo SUBDIRS = src man			>> Makefile.am
fi

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
        [https://bugs.freedesktop.org/enter_bug.cgi?product=xorg],
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

AC_ARG_WITH(xorg-module-dir,
            AC_HELP_STRING([--with-xorg-module-dir=DIR],
                           [Default xorg module directory [[default=\$libdir/xorg/modules]]]),
            [moduledir="\$withval"],
            [moduledir="\$libdir/xorg/modules"])
EOF

if [ ! -z $has_dri ] ; then
    cat <<EOF >> configure.ac

AC_ARG_ENABLE(dri, AC_HELP_STRING([--disable-dri],
                                  [Disable DRI support [[default=auto]]]),
              [DRI="\$enableval"],
              [DRI=auto])
EOF
fi

cat <<EOF  >> configure.ac
# Checks for pkg-config packages
PKG_CHECK_MODULES(XORG, [xorg-server xproto])
sdkdir=\$(pkg-config --variable=sdkdir xorg-server)

# Checks for libraries.

# Checks for header files.
AC_HEADER_STDC

EOF

if [ ! -z $has_dri ] ; then
    cat <<EOF >> configure.ac
if test "\$DRI" != no; then
        AC_CHECK_FILE([\${sdkdir}/dri.h],
                      [have_dri_h="yes"], [have_dri_h="no"])
        AC_CHECK_FILE([\${sdkdir}/sarea.h],
                      [have_sarea_h="yes"], [have_sarea_h="no"])
        AC_CHECK_FILE([\${sdkdir}/dristruct.h],
                      [have_dristruct_h="yes"], [have_dristruct_h="no"])
fi

AC_MSG_CHECKING([whether to include DRI support])
if test x\$DRI = xauto; then
        if test "\$ac_cv_header_dri_h" = yes -a \\
                "\$ac_cv_header_sarea_h" = yes -a \\
                "\$ac_cv_header_dristruct_h" = yes; then
                DRI="yes"
        else
                DRI="no"
        fi
fi
AC_MSG_RESULT([\$DRI])

AM_CONDITIONAL(DRI, test x\$DRI = xyes)
if test "\$DRI" = yes; then
        PKG_CHECK_MODULES(DRI, [libdrm])
        AC_DEFINE(XF86DRI,1,[Enable DRI driver support])
        AC_DEFINE(XF86DRI_DEVEL,1,[Enable developmental DRI driver support])
fi

AC_SUBST([DRI_CFLAGS])
EOF
fi
cat <<EOF >> configure.ac
AC_SUBST([XORG_CFLAGS])
AC_SUBST([moduledir])

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
if [ ! -z $man_pages ] ; then
    cd man

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

dist_man_MANS = \\
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
    cd ..
fi

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
EOF

if [ ! -z $has_dri ]; then
    cat <<EOF >> Makefile.am
AM_CFLAGS = @XORG_CFLAGS@ @DRI_CFLAGS@
EOF
else
    cat <<EOF >> Makefile.am
AM_CFLAGS = @XORG_CFLAGS@
EOF
fi

cat <<EOF >> Makefile.am
${drivername}_drv_la_LTLIBRARIES = ${drivername}_drv.la
${drivername}_drv_la_LDFLAGS = -module -avoid-version
${drivername}_drv_ladir = @moduledir@/drivers

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

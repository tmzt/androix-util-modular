#!/bin/bash

# Variables

# fixme: modular dir should 

MODULAR_DIR=`( cd $1 ; cd ../.. ; pwd )`
MODULE_DIR=`( cd $1 ; pwd )`
MODULE_NAME=`( basename $MODULE_DIR )`
modulename=`echo $MODULE_NAME | tr "[:upper:]" "[:lower:]"`

echo Modular dir: $MODULAR_DIR
echo Module dir : $MODULE_DIR
echo Name: $MODULE_NAME
echo lower: $modulename

if [ -x $MODULE_DIR/man ] ; then
    HAS_MAN_DIR="yes"
else
    HAS_MAN_DIR="no"
fi

echo Man dir: $HAS_MAN_DIR

# 
#	Generate build files
#		Generate autogen.sh
#			Copy from Xfixes
cp $MODULAR_DIR/lib/Xfixes/autogen.sh $MODULAR_DIR/lib/$MODULE_NAME

cd $MODULE_DIR

touch		AUTHORS
touch		ChangeLog
touch		COPYING
touch		INSTALL
touch		NEWS
touch		README

#			touch
#		Generate README
#			touch
#		Generate Makefile.am

rm -f Makefile.am

cat <<EOF >> Makefile.am
# 
#  Copyright 2005  Red Hat, Inc.
# 
#  Permission to use, copy, modify, distribute, and sell this software and its
#  documentation for any purpose is hereby granted without fee, provided that
#  the above copyright notice appear in all copies and that both that
#  copyright notice and this permission notice appear in supporting
#  documentation, and that the name of Keith Packard not be used in
#  advertising or publicity pertaining to distribution of the software without
#  specific, written prior permission.  Keith Packard makes no
#  representations about the suitability of this software for any purpose.  It
#  is provided "as is" without express or implied warranty.
# 
#  RED HAT DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
#  INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
#  EVENT SHALL RED HAT BE LIABLE FOR ANY SPECIAL, INDIRECT OR
#  CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
#  DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
#  TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
#  PERFORMANCE OF THIS SOFTWARE.

EOF

if [ $HAS_MAN_DIR = "yes" ] ; then
cat << EOF >> Makefile.am
SUBDIRS = src man
EOF
else
cat <<EOF >> Makefile.am
SUBDIRS = src
EOF
fi

cat <<EOF >> Makefile.am

pkgconfigdir = \$(libdir)/pkgconfig
pkgconfig_DATA = $modulename.pc

EXTRA_DIST = $modulename.pc.in autogen.sh

EOF

#		Generate configure.ac

rm -f configure.ac

cat <<EOF >> $MODULE_DIR/configure.ac

dnl  Copyright 2005 Red Hat, Inc.
dnl 
dnl  Permission to use, copy, modify, distribute, and sell this software and its
dnl  documentation for any purpose is hereby granted without fee, provided that
dnl  the above copyright notice appear in all copies and that both that
dnl  copyright notice and this permission notice appear in supporting
dnl  documentation, and that the name of Keith Packard not be used in
dnl  advertising or publicity pertaining to distribution of the software without
dnl  specific, written prior permission.  Keith Packard makes no
dnl  representations about the suitability of this software for any purpose.  It
dnl  is provided "as is" without express or implied warranty.
dnl 
dnl  KEITH PACKARD DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
dnl  INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
dnl  EVENT SHALL KEITH PACKARD BE LIABLE FOR ANY SPECIAL, INDIRECT OR
dnl  CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
dnl  DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
dnl  TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
dnl  PERFORMANCE OF THIS SOFTWARE.
dnl
dnl Process this file with autoconf to create configure.

AC_PREREQ([2.57])

AC_INIT(lib$MODULE_NAME, 7.0.0, [sandmann@redhat.com], lib$MODULE_NAME)
AM_INIT_AUTOMAKE([dist-bzip2])
AM_MAINTAINER_MODE

AM_CONFIG_HEADER(config.h)

# Check for progs
AC_PROG_CC
AC_PROG_LIBTOOL

# Check for dependencies
PKG_CHECK_MODULES(DEP, x11)

AC_SUBST(DEP_CFLAGS)
AC_SUBST(DEP_LIBS)
		  
AC_OUTPUT([Makefile
	   src/Makefile
EOF
if [ $HAS_MAN_DIR = yes ] ; then
cat <<EOF >> configure.ac
	   man/Makefile
EOF
fi
cat <<EOF >> configure.ac
           $modulename.pc])
EOF

#		Generate .pc.in

cat <<EOF > $modulename.pc.in
prefix=@prefix@
exec_prefix=@exec_prefix@
libdir=@libdir@
includedir=@includedir@

Name: $MODULE_NAME
Description: The $MODULE_NAME Library
Version: @PACKAGE_VERSION@
Cflags: -I\${includedir} @DEP_CFLAGS@
Libs: -L\${libdir} -l$MODULE_NAME @DEP_LIBS@

EOF

#		src/Makefile

cd src

rm -f Makefile.am

cat <<EOF > Makefile.am
lib_LTLIBRARIES = lib$MODULE_NAME.la

lib${MODULE_NAME}_la_SOURCES = \ 
EOF

for x in `ls *.[ch]` ; do
    LAST=$x
done

for x in `ls *.[ch]`; do
    if [ $x = $LAST ] ; then
	echo \ \ \ \ \ \ \ \ \ $x			>> Makefile.am
    else
	echo \ \ \ \ \ \ \ \ \ $x \\			>> Makefile.am
    fi
done

cat <<EOF >> Makefile.am


lib${MODULE_NAME}_la_LDFLAGS = -version-info 7:0:0 -no-undefined
EOF

#
#		man/Makefile
#

if [ $HAS_MAN_DIR = yes ] ; then
cd ../man
rm Makefile.am
cat <<EOF > Makefile.am
man3_MANS = \\
EOF

for x in `ls *.3` ; do
    LAST=$x
done

for x in `ls *.3`; do
    if [ $x = $LAST ] ; then
	echo \ \ \ \ \ \ \ \ \ $x			>> Makefile.am
    else
	echo \ \ \ \ \ \ \ \ \ $x \\			>> Makefile.am
    fi
done

echo "EXTRA_DIST = \$(man3_MANS)"			>> Makefile.am

fi

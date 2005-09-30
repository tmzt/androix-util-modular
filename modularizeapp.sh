#!/bin/bash

# Variables

if [ -z $1 ] ; then
    echo
    echo Usage: $0 \<directory\>
    echo
    exit
fi

# fixme: modular dir should 

MODULAR_DIR=`( cd $1 ; cd ../.. ; pwd )`
MODULE_DIR=`( cd $1 ; pwd )`
MODULE_NAME=`( basename $MODULE_DIR )`
modulename=`echo $MODULE_NAME | tr "[:upper:]" "[:lower:]"`

if [ -z foo ]  ; then
    echo Modular dir: $MODULAR_DIR
    echo Module dir : $MODULE_DIR
    echo Name: $MODULE_NAME
    echo lower: $modulename
    echo Man dir: $HAS_MAN_DIR
    echo Include dir: $HAS_INCLUDE_DIR
fi

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
#  documentation, and that the name of Red Hat not be used in
#  advertising or publicity pertaining to distribution of the software without
#  specific, written prior permission.  Red Hat makes no
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

bin_PROGRAMS = $modulename

${modulename}_CFLAGS = \$(DEP_CFLAGS)
${modulename}_LDADD = \$(DEP_LIBS)

${modulename}_SOURCES =	\\
EOF

# Source files

for x in `ls *.[ch]` ; do
    LAST=$x
done

for x in `ls *.[ch]`; do
    if [ $x = $LAST ] ; then
	echo \ \ \ \ \ \ \ \ $x			>> Makefile.am
    else
	echo \ \ \ \ \ \ \ \ $x \\			>> Makefile.am
    fi
done

echo >> Makefile.am

# Man files

LAST=
for x in `ls *.man` ; do
    LAST=$x
done

if [ ! -z $LAST ] ; then
    echo dist_man_MANS =			\\	>> Makefile.am
    for x in `ls *.man` ; do
	if [ $x = $LAST ] ; then
	    echo \ \ \ \ \ \ \ \ $x		>> Makefile.am
	else
	    echo \ \ \ \ \ \ \ \ $x	\\	>> Makefile.am
	fi
    done

    echo >> Makefile.am
fi

# .ad files

LAST=
for x in `ls *.ad` ; do
    LAST=$x
done

if [ ! -z $LAST ] ; then
    cat <<EOF >> Makefile.am
# App default files  (*.ad)

appdefaultdir = \$(sysconfdir)/X11/app-defaults

EOF

    cat <<EOF >> Makefile.am

APPDEFAULTFILES = \\
EOF
    
    for x in `ls *.ad` ; do
	FILE=`echo $x | sed 's/\.ad//'`
	if [ $x = $LAST ] ; then
	    echo \ \ \ \ \ \ \ \ $FILE		>> Makefile.am
	else
	    echo \ \ \ \ \ \ \ \ $FILE	\\	>> Makefile.am
	fi
    done

    cat <<EOF >> Makefile.am

SUFFIXES = .ad

.ad:
	cp \$< \$@

appdefault_DATA = \$(APPDEFAULTFILES)

EXTRA_DIST = \$(APPDEFAULTFILES:%=%.ad)

CLEANFILES = \$(APPDEFAULTFILES)

EOF
fi

#		Generate configure.ac
rm -f configure.ac

cat <<EOF >> $MODULE_DIR/configure.ac

dnl  Copyright 2005 Red Hat, Inc.
dnl 
dnl  Permission to use, copy, modify, distribute, and sell this software and its
dnl  documentation for any purpose is hereby granted without fee, provided that
dnl  the above copyright notice appear in all copies and that both that
dnl  copyright notice and this permission notice appear in supporting
dnl  documentation, and that the name of Red Hat not be used in
dnl  advertising or publicity pertaining to distribution of the software without
dnl  specific, written prior permission.  Red Hat makes no
dnl  representations about the suitability of this software for any purpose.  It
dnl  is provided "as is" without express or implied warranty.
dnl 
dnl  RED HAT DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
dnl  INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
dnl  EVENT SHALL RED HAT BE LIABLE FOR ANY SPECIAL, INDIRECT OR
dnl  CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
dnl  DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
dnl  TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
dnl  PERFORMANCE OF THIS SOFTWARE.
dnl
dnl Process this file with autoconf to create configure.

AC_PREREQ([2.57])
AC_INIT($modulename,[7.0], [https://bugs.freedesktop.org/enter_bug.cgi?product=xorg],$modulename)
AM_INIT_AUTOMAKE([dist-bzip2])
AM_MAINTAINER_MODE

AM_CONFIG_HEADER(config.h)

AC_PROG_CC
AC_PROG_INSTALL

# Checks for pkg-config packages
PKG_CHECK_MODULES(DEP, x11)
AC_SUBST(DEP_CFLAGS)
AC_SUBST(DEP_LIBS)

AC_OUTPUT([Makefile])
EOF


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

#!/bin/bash

FILES=

[ -e AUTHORS ] && FILES="$FILES AUTHORS"
[ -e autogen.sh ] && FILES="$FILES autogen.sh"
[ -e ChangeLog ] && FILES="$FILES ChangeLog"
[ -e configure.ac ] && FILES="$FILES configure.ac"
[ -e COPYING ] && FILES="$FILES COPYING"
[ -e INSTALL ] && FILES="$FILES INSTALL"
[ -e NEWS ] && FILES="$FILES NEWS"
[ -e README ] && FILES="$FILES README"

for x in *.pc.in ; do
    FILES="$FILES $x"
done

for x in `find . -name Makefile.am` ; do
    FILES="$FILES $x"
done

cvs add $FILES

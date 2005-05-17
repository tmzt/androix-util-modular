#!/bin/bash

[ -e AUTHORS ] && cvs add AUTHORS
[ -e autogen.sh ] && cvs add autogen.sh
[ -e ChangeLog ] && cvs add ChangeLog
[ -e configure.ac ] && cvs add configure.ac
[ -e COPYING ] && cvs add COPYING
[ -e INSTALL ] && cvs add INSTALL
[ -e Makefile.am ] && cvs add Makefile.am
[ -e NEWS ] && cvs add NEWS
[ -e README ] && cvs add README
cvs add *.pc.in

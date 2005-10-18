#!/bin/sh

if test x$1 = x; then
    echo Usage $0 tag
    exit 1
fi

TAG=$1

haschanged() {
    if ! test -d $1; then
	exit $1 is not a directory
    fi
    cd $1
    for i in `ls -1`; do
	if test -e $i/configure.ac; then
	    CHANGED=no
	    cvs diff -uN -r $TAG -r HEAD $i > /dev/null 2>&1 || CHANGED=yes
	    if test $CHANGED = yes; then
		echo $1/$i has changed since $TAG
	    else
		echo $1/$i has not changed since $TAG
	    fi
	fi
    done
    cd ..
}

haschanged app
haschanged data
haschanged doc
haschanged driver
haschanged font
haschanged lib
haschanged proto
haschanged util
haschanged xserver

#!/bin/sh

# Usage: haschanged.sh [-l] [tag]
#
# Show changes in git for all modules since either tag specified on command
# line or the most recent tag on main branch (as found by git describe)
#
# If -l is given, shows git log since tag

SHOW_LOG=0

if test "x$1" = "x-l" ; then
    SHOW_LOG=1
    shift
fi

TAG=$1

haschanged() {
    if ! test -d $1; then
	exit $1 is not a directory
    fi
    cd $1
    for i in `ls -1`; do
	if test -e $i/configure.ac; then
	    cd $i
	    if test "x${TAG}" != "x" ; then
		LAST_TAG=`git tag -l $TAG`
	    else
		LAST_TAG=`git describe --abbrev=0`
	    fi
	    if test "x${LAST_TAG}" = "x" ; then
		echo $1/${i}: tag ${TAG} not found
	    else
		HEAD_DESC=`git describe`

		if test "${HEAD_DESC}" != "${LAST_TAG}" ; then
		    echo $1/$i has changed since $LAST_TAG
		    if test "${SHOW_LOG}" = 1 ; then
			echo ''
			git log "${LAST_TAG}"..
			echo '============================================'
			echo ''
		    fi
		else
		    echo $1/$i has not changed since $LAST_TAG
		fi
	    fi
	    cd ..
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

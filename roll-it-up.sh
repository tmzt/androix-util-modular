#!/bin/sh

# This script generates a set of $category/$module and $everything/$module
# links in the current directory, given a list of module versions for this
# release.  See module-list.txt for the last release's list.

individual_dir="/srv/xorg.freedesktop.org/archive/individual/"
xcb_dir="/srv/xcb.freedesktop.org/www/dist/"
relative_dir="../../../individual"

if [ ! -d $individual_dir ]; then
    echo "$i not a suitable base directory for individual packages."
    exit 1
fi

mkdir -p everything

while read name; do
    list=`find $individual_dir -name $name.tar\* `
    if test "x$list" != x; then
	for i in $list; do
	    i=`echo $i | sed -e "s|$individual_dir||g"`
	    mkdir -p `dirname $i`
	    ln -sf $relative_dir/$i $i
	    ln -sf $relative_dir/$i everything/`basename $i`
	done
    else
	list=`find $xcb_dir -name $name.tar\* `
	if test "x$list" = x; then
	    echo "Couldn't find module ${name}"
	fi
	for i in $list; do
	    mkdir -p xcb
	    b=`basename $i`
	    cp -pf $i xcb/$b
	    ln -sf ../xcb/$b everything/$b
	done
    fi
done

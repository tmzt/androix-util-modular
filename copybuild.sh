#!/usr/bin/env bash

function usage() {
    echo
    echo copybuild.sh   \<source directory\>   \<destination directory\>
    echo
}

if [ -z $1 ] ; then
    usage
    exit
fi

if [ -z $2 ] ; then
    usage
    exit
fi

if [ $1 = $2 ] ; then
    echo source and destination can\'t be the same
    usage
    exit
fi

src_dir=$1
dst_dir=$2

cp $src_dir/AUTHORS $dst_dir
cp $src_dir/autogen.sh $dst_dir
cp $src_dir/ChangeLog $dst_dir
cp $src_dir/configure.ac $dst_dir
cp $src_dir/COPYING $dst_dir
cp $src_dir/INSTALL $dst_dir
cp $src_dir/Makefile.am $dst_dir
cp $src_dir/NEWS $dst_dir
cp $src_dir/README $dst_dir
cp $src_dir/*.pc.in $dst_dir

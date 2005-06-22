#!/bin/sh

for each line of symlink.sh
    if line is symlink_app then
	print "symlink_$appname() {"
	print "src_dir $applocation"
	print "dst_dir $appdestination"
	for each c and h file
	    print "    action $filename"
	print
	for each man file
	    print "    action $filename"
	print "}"
	print ""
	print "symlink_app() {"
	print "    symlink_$appname"
    else
	print line

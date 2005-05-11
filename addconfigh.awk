#!/usr/bin/awk -f

# This script adds
#
#          #include <config.h>
#
# before the first #include line it finds.

function do_writeout ()
{
    if (output && writeout)
	system ("mv " output " " input );
}

{
    if (FNR == 1)
    {
	do_writeout();
    
#	beginning of a file
	
	input = FILENAME;
	output = FILENAME "-new";
	n_includes = 0;
	writeout = 1;
	done = 0;
    }
}

/\#include/ {
    if (n_includes == 0 && /\#include <config.h>/)
    {
	print "skipping " FILENAME
	writeout = 0;
	
	nextfile;
    }
    
    ++n_includes;
    if (!done) {
	print "#ifdef HAVE_CONFIG_H" > output;
	print "#include <config.h>"  > output;
	print "#endif"		     > output;
	  
	done = 1;
    }
}

{
    print > output
} 


END {
    do_writeout();
}

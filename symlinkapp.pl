#!/usr/bin/perl -w

$n_args = $#ARGV + 1;

if ($n_args < 1)
{
    print "usage: modularize_app <app directory>" ;
    print "\n" ;
    print "\n" ;
     
    exit 1
}

if (!-d $ARGV[0] ) 
{ 
    print "$ARGV[0] does not exist\n" ;
    exit 1
}

$app_location = `cd $ARGV[0] ; pwd`;
$app_location =~ s/^\s*(.*?)\s*$/$1/;

$app_name = `basename $app_location`;
$app_name =~ s/^\s*(.*?)\s*$/$1/;

$symlinksh = "../../../util/modular/symlink.sh";
$newsymlinksh = "../../../util/modular/symlink.sh.new";

open IN, "< $symlinksh" or die "can't open $symlinksh: $!";
open OUT, "> $newsymlinksh" or die "can't open $newsymlinksh for writing: $!";

while (<IN>)
{
    if (/symlink_app\(\) \{/)
    {
	print OUT "symlink_app_$app_name() {\n";
	print OUT "    src_dir programs/$app_name\n";
	print OUT "    dst_dir app/$app_name\n";
	
	print OUT "\n";

################# Add c files

	@files = ();

	print $app_name, "\n" ;
 	foreach $cfile ( `ls *.c` )
	{
	    @files = (@files, $cfile)
	}

	if ($#files + 1)
	{
	    foreach $cfile ( @files )
	    {
		$cfile = `basename $cfile`;
		$cfile =~ s/^\s*(.*?)\s*$/$1/;
	    if (-l $cfile)
	    {
		print "ASFSDFSDFSDF: $cfile\n";
	    }
		print OUT "    action\t$cfile\n";
	    }

	    print OUT "\n";
	}

################# Add README files
	
	@files = ();

	foreach $file ( `ls README` )
	{
	    @files = (@files, $file);
	}

	if ($#files + 1)
	{
	    foreach $file (@files)
	    {
		$file = `basename $file`;
		$file =~ s/^\s*(.*?)\s*$/$1/;
		print OUT "    action\t$file\n";
	    }

	    print OUT "\n" ;
	}



################# Add h files

	@files = ();

	foreach $hfile ( `ls *.h` )
	{
	    @files = (@files, $hfile);
	}

	if ($#files + 1)
	{
	    foreach $hfile (@files)
	    {
		$hfile = `basename $hfile`;
		$hfile =~ s/^\s*(.*?)\s*$/$1/;
		print OUT "    action\t$hfile\n";
	    }

	    print OUT "\n" ;
	}

################ Add man files

	@files = ();

	foreach $manfile (`ls *.man`)
	{
	    @files = (@files, $manfile);
	}

	if ($#files + 1)
	{
	    foreach $manfile ( @files )
	    {
		$manfile = `basename $manfile`;
		$manfile =~ s/^\s*(.*?)\s*$/$1/;
		print OUT "    action\t$manfile\n";
	    }

	    print OUT "\n" ;
	}

###################################

	print OUT "}\n";
	print OUT "\n";

	# print "symlink_app() {"
	
	print OUT ; 

	print OUT "    symlink_app_$app_name\n"
    }
    else
    {
	print OUT ; 
    }
}

system (  "mv $newsymlinksh $symlinksh\n" );

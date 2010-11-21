#! /usr/bin/perl -w

# Script to add some common URL's to X.Org module README files so that
# people finding them packaged in distros or mirrored on other sites
# have an easier time finding the origin and our bugtracker/git/etc.

###########################################################################
#
# Copyright (c) 2009, Oracle and/or its affiliates. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice (including the next
# paragraph) shall be included in all copies or substantial portions of the
# Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
###########################################################################

use strict;
use Cwd;

my $module = cwd();
$module =~ s|^.*/([^/]+)/([^/]+)$|$1/$2|;

my $modname = $2;

my $desc;

my @manpage = glob('man/*.man');
push @manpage, glob('*.man');

foreach my $manpage (@manpage) {
  if ($manpage && (-f $manpage)) {
    open(my $MANPAGE, '<', $manpage) or warn "Cannot read $manpage\n";

    while (my $l = <$MANPAGE>) {
      if ($l =~ /^.SH NAME/) {
	$desc = <$MANPAGE>;
	last;
      }
    }
    close($MANPAGE);

    chomp($desc);

    # Remove backslashes, such as \- instead of -
    $desc =~ s/\\//g;

    if ($modname =~ /^xf86-(input|video)-(.*)$/) {
      my $driver = $2;

      $desc =~ s/^\s*$driver/$modname/;
      $desc =~ s/driver$/driver for the Xorg X server/;
    }

    last if ($desc ne '');
  }
}

open(my $README, '>>', 'README') or die;

if ($desc) {
  print $README $desc, "\n";
}

print $README <<__EOF__;

All questions regarding this software should be directed at the
Xorg mailing list:

        http://lists.freedesktop.org/mailman/listinfo/xorg

Please submit bug reports to the Xorg bugzilla:

        https://bugs.freedesktop.org/enter_bug.cgi?product=xorg

The master development code repository can be found at:

        git://anongit.freedesktop.org/git/xorg/$module

        http://cgit.freedesktop.org/xorg/$module

For patch submission instructions, see:

	http://www.x.org/wiki/Development/Documentation/SubmittingPatches

For more information on the git code manager, see:

        http://wiki.x.org/wiki/GitPage

__EOF__

close($README);

#!/usr/bin/perl -w
my $ISCGI=TRUE;
if($ISCGI) {
	print "$ENV{'SERVER_PROTOCOL'} 200 OK\n";
	print "Server: $ENV{'SERVER_SOFTWARE'}\n";
	print "Content-type: text/plain\r\n\r\n";
	$| = 1;
}
#-----------------------

# Script that only checks if I'm already logged in
# Author: Shadi AKIKI
#---------------------

#use strict;
#use warnings;

use WWW::Mechanize;
use HTML::TreeBuilder::XPath;

package bla;

push @INC,"/home/shadi/experimental/MCAutomate";
use MCAutomate;

#=============
my $mca = new MCAutomate;
$mca->{ISCGI} = $ISCGI;

if($mca->CheckIfLoggedIn()) { print "Already logged in.\n"; }
else { print "Not logged in yet, or phpsessionid set in cookie is wrong.\n"; }

#
exit 0;

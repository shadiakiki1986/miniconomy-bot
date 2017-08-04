#!/usr/bin/perl -w
my $ISCGI=TRUE;
if($ISCGI) {
	print "$ENV{'SERVER_PROTOCOL'} 200 OK\n";
	print "Server: $ENV{'SERVER_SOFTWARE'}\n";
	print "Content-type: text/plain\r\n\r\n";
	$| = 1;
}
#-----------
# Retrieves prices from the whole market except my own shops
# It writes the data to an html file and opens it for display
#
#-----------

push @INC,"/home/shadi/experimental/MCAutomate";
use MCAutomate;

#=============
#
my $mca = new MCAutomate;
$mca->{ISCGI} = $ISCGI;

my @d = $mca->RetrieveUniqueProductsFromDb();
	for $i ( 0 .. $#d ) {
		print $d[$i][0];
		print "\n";
	}

#
exit 0;

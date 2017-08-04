#!/usr/bin/perl -w
use CGI qw(param);
my $reqprodname=param("reqprodname");
#--------------
my $ISCGI=TRUE;
if($ISCGI) {
	print "$ENV{'SERVER_PROTOCOL'} 200 OK\n";
	print "Server: $ENV{'SERVER_SOFTWARE'}\n";
	print "Content-type: text/html\r\n\r\n";
	$| = 1;
}
#-----------------------
if($reqprodname eq "") {die "Usage: perl ProductPrices_Show.pl reqprodname=[requested product name]\n"; }
print "Will request all database information regarding ",$reqprodname,".\n";
#-----------------------
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

my @d = $mca->RetrieveProductPriceFromDb( $reqprodname ); # this will be all the rows in ShopsData that have the product

if(1) {
	# printing to screen
	print "Table format of ShopsData: city, street, shopname, shopnumber, ownername, qt, pd, px\n";
	for $i ( 0 .. $#d ) {
		for $j ( 0 .. $#{$d[$i]} ) {
			print $d[$i][$j]."\t";
		}
		print "\n";
	}
}

if($ISCGI) { $mca -> PrintArray2dToHtml( @d );
}

#
exit 0;

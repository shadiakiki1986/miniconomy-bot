#!/usr/bin/perl -w
use CGI qw(param);
my $sellat=param("sellat");
my $N=param("N");
#---------------
my $ISCGI=TRUE;
if($ISCGI) {
	print "$ENV{'SERVER_PROTOCOL'} 200 OK\n";
	print "Server: $ENV{'SERVER_SOFTWARE'}\n";
	print "Content-type: text/plain\r\n\r\n";
	$| = 1;
}
if(!Scalar::Util::looks_like_number($sellat) | !Scalar::Util::looks_like_number($N)) {die "Usage: perl Auction_Get.pl sellat=[Price at which to sell] N=[Number of times to refresh before giving up]\n"; }
print "Will sell in the auction at ",$sellat," ISH. Will refresh ",$N," times before giving up.\n";
#-----------------------

# If used with the sellat argument, then it keeps updating and will sell at the sellat ISH requested, otherwise it periodically displays the state of the auction
# Note that it also times the web request, and hence calculates such that 30 seconds, e.g., is between displays accounts for the web request time.
# -------------

use WWW::Mechanize;
use HTML::TreeBuilder::XPath;
use Error;
use List::Util qw(first max maxstr min minstr reduce shuffle sum);

push @INC,"/home/shadi/experimental/MCAutomate";
use MCAutomate;

#=============
my @data = ();
#==========
my $mca = new MCAutomate;
$mca->{ISCGI} = $ISCGI;

$mca->Login();
my $mech = $mca->{mech};

print "Cookie:\n";
print $mech->cookie_jar->as_string();
print "\n\n";

#===========


my $url="http://www.miniconomy.com/auction.php";
my $webRequestTime = 0;

	my $counter=0;
	while($counter < $N) {
		$counter++;
		#
		if(!($sellat eq "")) { print "Will sell at ".$sellat." each.\n"; }

		# retrieving data
		$webRequestTime = time();
		$mech->get($url);
		my  $tree= HTML::TreeBuilder::XPath->new;
		$tree->parse($mech->content());
		#print $tree->as_XML_indented();
		$webRequestTime = time()-$webRequestTime;

		# displaying auction status
		 print "Product: ",$tree->findvalue("//span[\@id='prodname']" ),"\n";
		 print "Qty: ",$tree->findvalue("//span[\@id='prodnum']" ),"\n";
		 print "In warehouse: ",$tree->findvalue("//span[\@id='warehouse']" ),"\n";
		 print "Price (each): ",$tree->findvalue("//span[\@id='cur']" )," (",$tree->findvalue("//span[\@id='each']" ),")\n";

		# checking if the pxea (price each) is past the sellat that I have set or not and making the sale
		my $pxea = $tree->findvalue("//span[\@id='each']" );
		$pxea =~ s/^([0-9]*\.[0-9]*) ISH$/$1/g ;
		if(!Scalar::Util::looks_like_number($pxea)) { die("Auction price is unavailable. Aborting.\n"); }
		if($pxea > $sellat) {
			print "Selling at ".$pxea." > ".$sellat."\n";

			$mech->form_number(1);
			$mech->click_button('name'=>'buy');
		}

		# choosing sleep time depending on how close to target sellat we are
		my $sleep=10;
		if($sellat eq "") { $sleep=10; } # default if no sell at
		else {
			if( $sellat-$pxea > 10) { $sleep=30; }
			else {	if($sellat-$pxea > 4 ) { print "Yellow alert...\n"; $sleep=10; } # start refreshing every second
				else { print "Red alert...\n"; $sleep=0; }
			}
		}
		$sleep = max(0, $sleep-$webRequestTime);
		print "Will refresh in ".$sleep." secs (".$webRequestTime." secs for web request).\n"; sleep $sleep;

		print "\n";
	}

#
exit 0;

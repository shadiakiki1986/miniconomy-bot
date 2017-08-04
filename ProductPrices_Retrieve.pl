#!/usr/bin/perl -w
my $ISCGI=TRUE;
if($ISCGI) {
	print "$ENV{'SERVER_PROTOCOL'} 200 OK\n";
	print "Server: $ENV{'SERVER_SOFTWARE'}\n";
	print "Content-type: text/plain\r\n\r\n";
	$| = 1;
}
#-----------------------
# Retrieves prices from the whole market except my own shops
# It writes the data to an html file and opens it for display
#
#-----------

use WWW::Mechanize;
use HTML::TreeBuilder::XPath;

push @INC,"/home/shadi/experimental/MCAutomate";
use MCAutomate;

#=============
	my $reqprodname="";
	my $fn_save = "";

if($#ARGV+1==1) {
	#print "product has been specified already\n";
	$reqprodname=$ARGV[0];
}
if($#ARGV+1==2) {
	#print "requested filename to save to\n";
	$fn_save = $ARGV[1];
}

my @data = ();
#==========
my $mca = new MCAutomate;
$mca->{ISCGI} = $ISCGI;

$mca->Login();
my $mech = $mca->{mech};

#===========
# No more need for this map because of cityStreets() which builds the list of streets automagically
#my %MCmap = (
#	"Cashington" => 
#	#["One","Two","Three","Four"];
#	#["Main+street","Ashburton+Grove","Upton+Park","Stevenage+Road","Fulham+Road"];
#	#["Upton+Park"];
#	["2 Viraxje Vertical","3 Pim Parking Plaza","5 Bigger Budget Boul","4 - Mizzy Middle","1Tuned Topmost Trail"],
#	#
#	"Eurodam" =>
#	["Havenstraat","Zijstraat","Hoofdstraat","Lange+straat","lalalalstraat","linkse+straat","en+nog+een+extra","midduhstraat","dit+word+teveel","nog+een+straat","en+nog+een+keer","tweede+linkse+straat","op+naar+dat+ijzer"], # en nog een extra and so on are all bare desert
#	#
#	"City Roebelarendsveen" =>
#	["Havenstraat","De+RV+hoofdstraat","zjistraat","Coole+straat","Rockie"],
#	#
#	"Centropolis" =>
#	#@streets=("Harbour+road","side+road","liberty+road");
#	["B Road","A Road","C Road","E Road","D Road","X Road","Z Road"],
#
#	"Nasdaqar" =>
#	["Main Street", "Clubs and Houses","Golden Road"]
#
#);
#==========
my $City=$mca->currentCity();
#my @streets=@{$MCmap{$City}};
my @streets=$mca->cityStreets($City);
#==========
#
print "City: ".$City."\n";
my $counter_street=0;
foreach $street(@streets) {
	$counter_street++;
	print "Processing street ",$counter_street,"/",$#streets+1,": ".$street."...\n";

	print "Retrieving list of shops on ".$street."\n";
	print "\t Following page\n";
	#    #$mech->follow_link( url => 'http://www.miniconomy.com/street.php' );
	$mech->get( 'http://www.miniconomy.com/streetmain.php?straatnaam='.$street );
	my @links = $mech->find_all_links(class=>"winkel");

	my $counter_shop=0;
	  foreach $link(@links) {
		$counter_shop++;
		print "\t\tGathering prices from shop ",$counter_shop,"/",$#links+1,"...\n";

		#my $shopname = $link->url()=~m/http:\/\/www.miniconomy.com\/shop.php\?winkel=(.*)\&i=\d*$/; $shopname = $1;

		my $url = "http://www.miniconomy.com/".$link->url();
		#print $url,"\n";

		$mech->get($url);

		# Getting the shopname, owner's name, description, etc. from the table header
		my $tree0 = HTML::TreeBuilder::XPath->new;
		$tree0->parse($mech->content());
		#print $tree0->as_XML_indented();
		  my $ownername=$tree0->findvalue("//a[\@class='profile']" );
		  my $shopname=$tree0->findvalue("//div[\@class='mainbox']/table/tr[2]/td/div/b");
		$tree0->delete;

		#
		print "\t\t\tShop: ".$shopname.", Owner: ".$ownername."\n";

		#
		my  $tree= HTML::TreeBuilder::XPath->new;
		  $tree->parse($mech->content()); # "www.miniconomy.com/shop.php?winkel=".$shop_strrep.".php&i=6#" );
		#print $tree->as_XML_indented();

		  my $xpath = "/html/body/table[1]/tr[1]/td[2]/form[\@id='shop']/table/tr";
		if(!$tree->exists($xpath)) {
			print "xpath not found, probably because this shop is mine already\n"; 
		} else {
			  my @trs=$tree->findnodes($xpath);

		# getting the prices and quantities
		shift(@trs); # dropping the table header
		pop(@trs); # dropping the table footer
		print "\t\t\tProcessing ",.$#trs+1," products","...\n";
		my $counter_product=0;
			foreach $tr(@trs) {
				$counter_product++;
				#print "\t\t\tProcessing product ",$counter_product,"/",$#trs+1,"...\n";


			#	  my $qt=$tree->findvalue($xpath."/th[1]" );
			#	  my $pd=$tree->findvalue($xpath."/th[2]" );
			#	  my $pc=$tree->findvalue($xpath."/th[3]" );

				my $tree2 = HTML::TreeBuilder::XPath->new;
				$tree2->parse($tr->as_HTML());
				#print $tree2->as_XML_indented();

				  my $qt=$tree2->findvalue("/html/body/table/tr/td[1]" );
				  my $pd=$tree2->findvalue("/html/body/table/tr/td[2]/img/\@title" );
				  my $pc=$tree2->findvalue("/html/body/table/tr/td[3]" );
				$tree2->delete;

				#print $street,",",$shopname,",",$qt,",",$pd,",",$pc,"\n";
				push(@data,[$street,$shopname,$counter_shop,$ownername,$qt,$pd,$pc]);
			}
		}
		$tree->delete; # to avoid memory leaks, if you parse many HTML documents
		#}
	  }
} # foreach street

# sort @data array of arrays by product name and then by price and finally by quantity
@data = sort {
	lc($a->[5]) cmp lc($b->[5]) ||
	$a->[6] <=> $b->[6] ||
	$a->[4] <=> $b->[4] 
	} @data;

#
print "Saving the \@data array of arrays of strings to the mysql d/b\n";
$mca -> SaveProductPricesToDb( $City, @data );

if(0) {
	#
	print "Printing the \@data array of arrays of strings to html file\n";
	$mca -> PrintArray2dToHtml( @data, '>ProductPrices_'.$City.'.html' );
	
	#
	print "Opening for viewing\n";
	system(("firefox", "ProductPrices_".$City.".html")) == 0
  	or die "system firefox ... failed: $?";
}

#
exit(0);

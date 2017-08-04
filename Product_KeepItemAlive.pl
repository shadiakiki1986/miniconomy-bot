#!/usr/bin/perl -w
my $ISCGI=TRUE;
if($ISCGI) {
	print "$ENV{'SERVER_PROTOCOL'} 200 OK\n";
	print "Server: $ENV{'SERVER_SOFTWARE'}\n";
	print "Content-type: text/plain\r\n\r\n";
	$| = 1;
}
#-----------------------

use WWW::Mechanize;
use HTML::TreeBuilder::XPath;
use Error;

push @INC,"/home/shadi/experimental/MCAutomate";
use MCAutomate;

#=============
my $mca = new MCAutomate;
$mca->{ISCGI} = $ISCGI;

$mca->Login();
 my $mech = $mca->{mech};

#===========
#my $product="mach";
my $product="zaag";
my $productQty=8; # number of product to transport from warehouse at a time

#===========

my $urlmag="http://www.miniconomy.com/mag.php";
#my $urlpumpsmachines="http://www.miniconomy.com/shop.php?winkel=PumpsMachines+n+Com";
#my $urlpumpsmachines="http://www.miniconomy.com/shop.php?winkel=Lecto%20Shop%20Cash&i=16";

my $justMadeTransaction = 0;

	while(1) {
		my ($sec, $min, $hr, $day, $mon, $year) = localtime;
		$mech->get($urlmag);

		my  $tree= HTML::TreeBuilder::XPath->new;
		$tree->parse($mech->content());
		#print $tree->as_XML_indented();

		 my $numInShop = scalar($tree->findvalue("//tr[./td/input/\@name='".$product."']/td[4]"));
		my $numInWarehouse=scalar($tree->findvalue("//tr[./td/input/\@name='".$product."']/td[2]"));


		printf("%02d/%02d/%04d %02d:%02d:%02d\t",$day, $mon + 1, 1900 + $year, $hr, $min, $sec);
		 print "Num in shop: ",$numInShop,", Num in warehouse: ",$numInWarehouse,"\n";

		if($numInShop==0) {
			print "No more product X in shop\n";
			if($numInWarehouse>0) {
				 print "Transporting from warehouse\n";
				$mech->form_number(1);
				$mech->set_fields( $product => $productQty);
				$mech->click_button('name'=>'verplaats');

				$numInWarehouse--;
				$justMadeTransaction=1;
			} else {
				print "None available in warehouse\n";
			}
		}

#		if(0 && $numInShop==0 && $numInWarehouse==0) { # todo, optimize on the available prices in teh market
#			 print "No more machines in warehouse, nor in shop\n";
#
#			$mech->get($urlpumpsmachines);
#
#			# making sure that the price is right
#			my  $tree= HTML::TreeBuilder::XPath->new;
#			$tree->parse($mech->content());
#			 my $machinePrice = scalar($tree->findvalue("//tr[./td/input/\@name='".$product."']/td[3]"));
#
#			if($machinePrice<380) {
#				print "Buying a new Product X at ", $machinePrice, "ISH\n";
#
#				$mech->form_number(1);
#				$mech->set_fields( $product => '1');
#				$mech->click_button('name'=>'koop');
#
#				$justMadeTransaction=1;
#			} else {
#				print "Price is too high!... ", $machinePrice, "ISH\n";
#			}
#		}

		if(!$justMadeTransaction) { sleep 300; } else { $justMadeTransaction=0; sleep 60; }
	}

#
exit 0;

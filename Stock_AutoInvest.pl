# Script that can log in to miniconomy or use the existing session to buy and sell selected stocks using different strategies
# Security measures are implemented such as stopping at a threshold lumped loss
# Also, testing is possible with a written scenario
#
# Notice that there are things that are possible to do with this that are not so obvious to see
#	e.g. Enabling the BMQ strategy and setting the stopLossLimit_Lumped to a value < cost of strategy makes the script abort right after performing the buy. This is desirable if I don't want to abort my script right after the action taken.
#
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
# configuration
my $N=3; # number of points to keep in %PricesRecentHistory=
my $PollingInterval=20*60; # refresh data every 20 minutes
my $maxQty=1; # static maximum to maintain in possession per stock
my $minQty=0; # static minimum ...
my $stopLossLimit_Lumped=-20; # allow algorithm to make at most ISH 300 in total losses

#my @stocksToUse=('CAS','CPG','NSQ'); # Stocks I want to invest into. Complete list is below.
#my @stocksToUse=('ZWF','EEX'); #'NSQ'); # Stocks I want to invest into. Complete list is below.
my @stocksToUse=('ZWF'); #'NSQ'); # Stocks I want to invest into. Complete list is below.

my %useStrategy=( # to enable/disable different strategies
		"BLSH" => true,
		"BMQ" => false
	);

# Test values engine
my $istest = 0;
my %testdata=(
		CAS =>{
			value=>[100,110,120,130,140,135,130,125,120,110,100,105,100,105,110,115,120,110,105,100,90,85], # B100 S130 B110 S105 => totalProfit=+10-5=5
			possession => 0
		}
	);

#======================
# All stocks
my @stocks=('CAS','CPG','EEX','EPSX','KRONADAX','NSQ','TIM','USSREX','ZWF','MTI');
#=============
my %PricesRecentHistory=();
my %AccountPerStock=(); for $st(@stocks) { $AccountPerStock{$st}=0; }
my %possessionPerStock=();
#==========
my $mca = new MCAutomate;
$mca->Login();
my $mech = $mca->{mech};

#===========
my $urlstocks="http://www.miniconomy.com/stocks.php";


while(1) {
	# displaying status
	my ($sec, $min, $hr, $day, $mon, $year) = localtime;
	my $time = sprintf("%02d/%02d/%04d,%02d:%02d:%02d",$day, $mon + 1, 1900 + $year, $hr, $min, $sec);
	print $time."\tChecking stock prices...\n";

	print "\tCurrent session account:\n";
	$mca->printHashTableHorizontal(%AccountPerStock);
	print "\n";

	# refresh page
	if(istest==0) { $mech->get( $urlstocks ); }

	#------------------------------------
	#

	# Retrieve current values from page
	my $tree0 = HTML::TreeBuilder::XPath->new;
	$tree0->parse($mech->content());
	#print $tree0->as_XML_indented();

	foreach $st(@stocks) {

		my $ticker=$tree0->findvalue("//tr[./td/text()='".$st."']/td[1]" ); # supposedly, $st==$ticker
		my $value=$tree0->findvalue ("//tr[./td/text()='".$st."']/td[2]" );
		my $inpossession=$tree0->findvalue ("//tr[./td/text()='".$st."']/td[3]" );

		# testing
		if($istest && exists($testdata{$st})) {
			$value = shift(@{$testdata{$st}{value}});
			$inpossession = $testdata{$st}{possession};
		}

		#
		unshift @{$PricesRecentHistory{$st}}, $value;
		$possessionPerStock{$st} = $inpossession;

		# Keeping only the last N entries in the history array
		if (scalar(@{$PricesRecentHistory{$st}}) > $N) { pop @{$PricesRecentHistory{$st}}; }

		# Store the new values in the database
		# ... \todo
		# $inpossession and $value
	} # foreach stock

	#
	$tree0->delete;

	#
	print "\tPrices recent history:\n";
	$mca->printHashTableVertical(%PricesRecentHistory);
	print "\tCurrent book:\n";
	$mca->printHashTableHorizontal(%possessionPerStock);
	print "\n";

	#------------------------------------
	# Start executing strategies

	# Strategies BLSH: Buy Low Sell High
	# in case we don't have enough data
	my $NeedClick = 0;
	if($useStrategy{"BLSH"}) {
	print "Using strategy BLSH\n";
	if(scalar(@{$PricesRecentHistory{"CAS"}})==$N) { # CAS as example. All stocks price history should have the same length anyway
		for $st(@stocksToUse ) { # for each stock I want to invest in

			# prices recent history for the ticker in subject
			my @prh = @{$PricesRecentHistory{$st}};
			my $pps = $possessionPerStock{$st};

			# if price is increasing for the past 3 times and I have none in possession, then buy 1
			# Notice that this strategy buys as much as is needed to reach the maximum quantity permissible
			if(  $prh[0]>$prh[1] && $prh[1]>$prh[2] && $pps<$maxQty && $pps>=$minQty) { 
				my $buyAmount = $maxQty-$pps;
				print $time,"\tBuy $buyAmount $st at $prh[0]\n";

				if(!$istest) { 
					$mech->form_number(1);
					$mech->set_fields( 'a_'.lc($st) => '$buyAmount');

					$NeedClick = true;
				}

				$AccountPerStock{$st}-=$buyAmount*$prh[0];

				# testing
				if($istest && exists($testdata{$st})) { $testdata{$st}{possession}+=$buyAmount; }

			} else {
			# otherwise, if price is dropping for the last 3 times and I own something of it, sell 1.
			# Notice that this strategy sells as much as is needed to reach the minimum quantity permissible
			if(  $prh[0]<$prh[1] && $prh[1]<$prh[2] && $pps<=$maxQty && $pps>$minQty) { 
				my $sellAmount = $pps-$minQty;
				print $time,"\tSell $sellAmount $st at $prh[0]\n";

				if(!$istest) { 
					$mech->form_number(1);
					$mech->set_fields( 'a_'.lc($st) => '$sellAmount');
					$mech->click_button('name'=>'verkopen');

					$NeedClick = true;
				}

				$AccountPerStock{$st}+=$sellAmount*$prh[0];

				# testing
				if($istest && exists($testdata{$st})) { $testdata{$st}{possession}-=$sellAmount; }
			}
			}
		}
	}}

	# Strategy BMQ: Buy Minimum Qty
	# Buy till I have at least "minQty" in the stocks chosen to be invested in
	if($useStrategy{"BMQ"}) {
	for $st(@stocksToUse ) { # for each stock I want to invest in

		# prices recent history for the ticker in subject
		my @prh = @{$PricesRecentHistory{$st}};
		my $pps = $possessionPerStock{$st};

		# Buy until I have minQty
		if( $pps<$minQty) { 
			my $buyAmount = $minQty-$pps;
			print $time,"\tBuy $buyAmount $st at $prh[0]\n";

			if(!$istest) { 
				$mech->form_number(1);
				$mech->set_fields( 'a_'.lc($st) => '$buyAmount');

				$NeedClick = true;
			}

			$AccountPerStock{$st}-=$buyAmount*$prh[0];

			# testing
			if($istest && exists($testdata{$st})) { $testdata{$st}{possession}+=$buyAmount; }
		}
	}}

	#------------------------------------
	# sending orders together
	if($NeedClick) { print "Sending orders\n"; $mech->click_button('name'=>'kopen'); } # sending orders together

	# refresh page so that I don't "die" (below) before the orders are sent
	if($NeedClick) { $mech->get( $urlstocks ); }

	# Checking total losses and aborting if too much
	my $la=0;
	for $st(keys %AccountPerStock) {$la += $AccountPerStock{$st};}
	if($la < $stopLossLimit_Lumped) {
		die $time."\tToo much total losses: ".$la.". Aborting.\n";
	}

	#------------------------------------
	#
	sleep $PollingInterval;

} # while

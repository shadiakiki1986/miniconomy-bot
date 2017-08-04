#!/usr/bin/perl -w
use CGI qw(param);
my $reqprodname=param("reqprodname");
my $reqprodqty=param("reqprodqty");
my $reqprodrate=param("reqprodrate");

#--------------
my $ISCGI=TRUE;
if($ISCGI) {
	print "$ENV{'SERVER_PROTOCOL'} 200 OK\n";
	print "Server: $ENV{'SERVER_SOFTWARE'}\n";
	print "Content-type: text/plain\r\n\r\n";
	$| = 1;
}
#-----------------------
if($reqprodname eq "" | !Scalar::Util::looks_like_number($reqprodqty) | !Scalar::Util::looks_like_number($reqprodrate)) {die "Usage: perl ProductPrices_ProductionCosts.pl reqprodname=[requested product name] reqprodqty=[quantity of product to produce] reqprodrate=[rate at which to produce]\n"; }
print "Costs of ".$reqprodqty."x ".$reqprodname." at a rate of ".$reqprodrate." per production cycle\n";

#--------
# Checks the data in the d/b (make sure it is up-to-date with ProductPrices_Retrieve.pl)
# and tells me what the cost of producing something would be
# This excludes the production costs that are reduceable by skills
#
#-----------

use List::Util qw(first max maxstr min minstr reduce shuffle sum);

push @INC,"/home/shadi/experimental/MCAutomate";
use MCAutomate;

#==========
my $mca = new MCAutomate;
#$mca->Login();
# my $mech = $mca->{mech};

#===========
my %dependencies = (
	"Glass" => {
		"ingredients" => {"Clay" => 10,"Plastic"=>1},
		"tools" => {"Oven" => 1},
		"skills" => {"NA" => 0},
	},
	"Brick" => {
		"ingredients" => {"Clay" => 3, "Wood" => 1},
		"tools" => {"Oven" => 1,},
		"skills" => {"NA" => 0}
	},
	"Oven" => {
		"ingredients" => {"Brick" => 30,},
		"skills" => {"NA" => 0}
	},
	"Bulletproof Vest" => {
		"ingredients" => {"Iron" => 1,"Plastic" => 10,"Gold" => 7,},
		"skills" => {"NA" => 0}
	},
	"Pump" => {
		"ingredients" => {"Engine" => 1,"Plastic" => 1},
		"tools" => {"Screwdriver" => 1},
		"skills" => {"NA" => 0}
	},
	"Engine" => {
		"ingredients" => {"Iron" => 3,"Oil" => 5},
		"tools" => {"Screwdriver" => 1},
		"skills" => {"NA" => 0}
	},
	"Saw" => {
		"ingredients" => {"Iron" => 1,"Wood" => 1},
		"skills" => {"NA" => 0}
	},
	"Machine" => {
		"ingredients" => {"Iron" => 10,"Engine" => 1,"Pump" => 1},
		"tools" => {"Screwdriver" => 1},
		"skills" => {"NA" => 0}
	},
	"Chip" => {
		"ingredients" => {"Plastic" => 1,"Gold" => 4,},
		"tools" => {"Machine" => 1,"Screwdriver" => 1},
		"skills" => {"NA" => 0}
	},
	"Telephone" => {
		"ingredients" => {"Chip" => 5,"Plastic" => 5},
		"tools" => {"Machine" => 1,"Screwdriver" => 1},
		"skills" => {"NA" => 0}
	},
	"Camera" => {
		"ingredients" => {"Plastic" => 10,"Chip" => 4,},
		"tools" => {"Screwdriver" => 1},
		"skills" => {"NA" => 0}
	},
	"Alarm" => {
		"ingredients" => {"Plastic" => 10,"Chip" => 5,},
		"tools" => {"Machine" => 1,"Screwdriver" => 1},
		"skills" => {"NA" => 0}
	},
	"Computer" => {
		"ingredients" => {"Iron"=>3,"Plastic" =>5,"Chip" =>10,"Glass"=>1},
		"tools" => {"Machine" => 1,"Screwdriver" => 1},
		"skills" => {"NA" => 0}
	},
	"Shop" => {
		"ingredients" => {"Wood"=>20,"Brick" =>5,"Glass"=>1},
		"skills" => {"NA" => 0}
	},
);
#================

#
if(!exists($dependencies{$reqprodname})) { die "Product unavailable\n"; }

#
foreach $in(keys %{$dependencies{$reqprodname}}) {

	my $inCost=0;

	my $q = "";
	if($in eq "ingredients") { $q=$reqprodqty; }
	else {	if($in eq "tools") { $q = $reqprodrate; }
		else {	if($in eq "skills") { $q = 0; }
			else { die "what the fish?\n"; }
		}
	}

	foreach $x(keys %{$dependencies{$reqprodname}{$in}}) {
		my @d = $mca->RetrieveProductPriceFromDb( $x ); # this will be all the rows in ShopsData that have the product
		print $in.": ".$x.": ";

		my $qtysecured = 0;
		my $qtyrequired = $q*$dependencies{$reqprodname}{$in}{$x};
		my $i=0;
		# Listing the prices and quantities available to satisfy my need
		while( $qtysecured < $qtyrequired ) {
			if($i>$#d) {
				my $bla=$qtyrequired-$qtysecured;
				print "\tNot enough ".$x." in market to cover requested production. Need ".$bla." more.";
				last;
			}
			my $qtynow = min($qtyrequired -$qtysecured, $d[$i][5]);
			$qtysecured += $qtynow;
			print $qtynow."*".$d[$i][7].", ";

			$inCost+=$qtynow*$d[$i][7];

			$i++;
		}
		print "\n";
	}

	print $in." total cost = ".$inCost."\n";
}

print "Done\n";
exit 0;

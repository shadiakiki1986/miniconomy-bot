use WWW::Mechanize;
use HTML::TreeBuilder::XPath;

push @INC,"/home/shadi/experimental/MCAutomate";
use MCAutomate;

#=============

my @data = ();
#==========
my $mca = new MCAutomate;
$mca->Login();
 my $mech = $mca->{mech};

print "Cookie:\n";
print $mech->cookie_jar->as_string();
print "\n\n";



#===========
my $urlstocks="http://www.miniconomy.com/stocks.php";
my @stocks=('CAS','CPG','EEX','EPSX','KRONADAX','NSQ','TIM','USSREX','ZWF','MTI');

while(1) {
	my ($sec, $min, $hr, $day, $mon, $year) = localtime;
	my $time = sprintf("%02d/%02d/%04d,%02d:%02d:%02d",$day, $mon + 1, 1900 + $year, $hr, $min, $sec);
	print $time."\tRetrieving stock prices\n";

	$mech->get( $urlstocks );

	my @data=();
	foreach $st(@stocks) {

		my $tree0 = HTML::TreeBuilder::XPath->new;
		$tree0->parse($mech->content());
		#print $tree0->as_XML_indented();
		my $ticker=$tree0->findvalue("//tr[./td/text()='".$st."']/td[1]" );
		my $value=$tree0->findvalue ("//tr[./td/text()='".$st."']/td[2]" );
		my $inpossession=$tree0->findvalue ("//tr[./td/text()='".$st."']/td[3]" );

		$tree0->delete;

		push(@data,[$ticker,$value,$inpossession]);
	} # foreach stock 

	# now print the @data array of arrays of strings
	open (MYFILE, '>>StockPrices.txt');
	#print MYFILE "time, ticker, value, inpossession\n";
	for $i ( 0 .. $#data ) {
		print MYFILE $time,",";
		for $j ( 0 .. $#{$data[$i]} ) {
			print MYFILE $data[$i][$j],",";
		}
		print MYFILE "\n";
	}
	close (MYFILE);

	sleep 30*60;
} # while

use WWW::Mechanize;
use HTML::TreeBuilder::XPath;

push @INC,"/home/shadi/experimental/MCAutomate";
use MCAutomate;

#=============
my @dataPrev1=();
my @dataPrev2=();
my $sessionAccount=0;
#==========
my $mca = new MCAutomate;
$mca->Login();
 my $mech = $mca->{mech};

print "Cookie:\n";
print $mech->cookie_jar->as_string();
print "\n\n";

#===========
my $urlstocks="http://www.miniconomy.com/stocks.php";
#my @stocks=('CAS','CPG','EEX','EPSX','KRONADAX','NSQ','TIM','USSREX','ZWF','MTI');
my @stocks=('CAS');#,'CPG','NSQ');


while(1) {
	my ($sec, $min, $hr, $day, $mon, $year) = localtime;
	my $time = sprintf("%02d/%02d/%04d,%02d:%02d:%02d",$day, $mon + 1, 1900 + $year, $hr, $min, $sec);
	print $time."\tChecking stock prices.\tCurrent session account: ".$sessionAccount."\n";

	$mech->get( $urlstocks );

	my @dataNow=();
	foreach $st(@stocks) {

		my $tree0 = HTML::TreeBuilder::XPath->new;
		$tree0->parse($mech->content());
		#print $tree0->as_XML_indented();
		my $ticker=$tree0->findvalue("//tr[./td/text()='".$st."']/td[1]" );
		my $value=$tree0->findvalue ("//tr[./td/text()='".$st."']/td[2]" );
		my $inpossession=$tree0->findvalue ("//tr[./td/text()='".$st."']/td[3]" );

		$tree0->delete;

		push(@dataNow,[$ticker,$value,$inpossession]);
	} # foreach stock 

	if(scalar(@dataPrev1)==0) { @dataPrev1 = @dataNow; }
	else {
	if(scalar(@dataPrev2)==0) { @dataPrev2 = @dataPrev1; @dataPrev1 = @dataNow; }
	else {
		for $i ( 0 .. $#dataNow ) { # for each stock
			if( $dataPrev2[$i][1]<$dataPrev1[$i][1] && $dataPrev1[$i][1]<$dataNow[$i][1] && $dataNow[$i][2]==0) { 
				print $time,"\t";
				print "Buy\t".$dataPrev2[$i][0]." at ".$dataPrev2[$i][1]."\n";

				$mech->form_number(1);
				$mech->set_fields( 'a_'.lc($dataPrev2[$i][0]) => '1');
				$mech->click_button('name'=>'kopen');

				$sessionAccount-=$dataNow[$i][1];
			} else {
			if( $dataPrev2[$i][1]>$dataPrev1[$i][1] && $dataPrev1[$i][1]>$dataNow[$i][1] && $dataNow[$i][2]>0) { 
				print $time,"\t";
				print "Sell\t".$dataPrev2[$i][0]." at ".$dataPrev2[$i][1]."\n";

				$mech->form_number(1);
				$mech->set_fields( 'a_'.lc($dataPrev2[$i][0]) => '1');
				$mech->click_button('name'=>'verkopen');

				$sessionAccount+=$dataNow[$i][1];
			}
			}
		}

		@dataPrev2 = @dataPrev1;
		@dataPrev1 = @dataNow;
	}
	}

	if($sessionAccount < -600) { print $time."\tToo much losses: ".$sessionAccount.". Aborting.\n"; return; }
	sleep 20*60;
} # while

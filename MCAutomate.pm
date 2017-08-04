use WWW::Mechanize;
use WWW::Mechanize::Link;
use HTML::TreeBuilder::XPath;
use HTTP::Cookies;
use POSIX qw/strftime/;
use DBI;
use List::MoreUtils qw/uniq/;

package MCAutomate;

sub new {
    my $class=shift;
    my $tmpcookie = HTTP::Cookies->new(file => '/tmp/cookie.txt',autosave => 1, ignore_discard => 1);

    my $self = {
	     mech => WWW::Mechanize->new( cookie_jar => $tmpcookie, autocheck => 0 ),
	     ISCGI => FALSE

    };
    bless $self, $class;
    return $self;
}
#------------
sub Logout {
    my ($self) = @_;
	print "Logging out...\n";
	$self->{$mech}->get( "http://www.miniconomy.com/logout.php" );
	$self->{$mech}->cookie_jar->clear();
	print "Done.\n";
}

#===========
sub CheckIfLoggedIn {
	my ($self) = @_;
	my $mech = $self->{mech};
	$mech->get( "http://www.miniconomy.com/screen.php" );

	# checking if already logged in
	my $tree= HTML::TreeBuilder::XPath->new;
	$tree->parse($mech->content());
	#print $tree->as_XML_indented();
	return(!$tree->exists("//div[\@id='mc_login']"));
}

#-----------
sub Login {
	my ($self) = @_;

	if($self->CheckIfLoggedIn()) #;"//div[text()='Welcome to Miniconomy']"))
	{ print "Already logged in.\n"; }
	else {
#		my $normal;
#		print 'Not logged in. Do you want to log in via perl? [yes]:';
#		print '\n';
#		while (1) {
#			chomp( my $normal = <STDIN> );
#			$normal ||= 'yes';
#			$normal = 'yes' if $normal eq '';
#			last if grep { lc $normal eq $_ } 'yes', 'no';
#			print "\nERROR: Answer must be yes or no.\nTry again.\n";
#		}
#
#		if(lc $normal eq 'no') {
#			print "Not logging in. Please log in via the browser then, or try again to log in via perl.\n";
#		} else {
			print "Logging in...\n";

			my $mech = $self->{mech};
			my $cookie = $mech->cookie_jar;
			$cookie->revert();  # re-loads the save
			$mech->get( "http://www.miniconomy.com/screen.php" );
			$mech->submit_form(
					form_number => 1,
					fields      => {
					username    => 'shadiakiki',
					password    => 'shadiminiconomy1986',
					}
					);

			$tree->delete; # to avoid memory leaks, if you parse many HTML documents

	# Checking if log-in is successful
				$mech->get( "http://www.miniconomy.com/screen.php" );

			my $tree= HTML::TreeBuilder::XPath->new;
			$tree->parse($mech->content());
	#print $tree->as_XML_indented();
			my $xpath = "div[class='error round']";
			if($tree->exists($xpath)) { die "Error in username password\n"; }
			$tree->delete; # to avoid memory leaks, if you parse many HTML documents


	#
			$cookie->save;
			print "Logged in and cookie saved.\n";
#		}
	}
}

#==========
sub printHashTableHorizontal {
    my ($self,%h) = @_;
	print "\t\t"; foreach $key (keys %h) { print "$key\t"; } print "\n";
	print "\t\t"; foreach $key (keys %h) { print "$h{$key}\t"; } print "\n";
}
 
sub printHashTableVertical {
    my ($self,%h) = @_;
	foreach $key (keys %h) { print "\t\t$key: @{$h{$key}}\n"; } print "\n";
}

#sub exists {
#	my ($self,@a,$e) = @_;
#	return grep {$_ eq $e} @a;
#}

#======================
sub PrintArray2dToHtml {
    my($self,@data) = @_;

    print "<html><body>\n";
#    print "<h1>".strftime("%D %T",localtime)."</h1>";
    print "<table>\n";
    print "<tr><th>city</th><th>street</th><th>shopname</th><th>shopnumber</th><th>ownername</th><th>qt</th><th>pd</th><th>px</th></tr>\n";
    for $i ( 0 .. $#data ) {
    #if(length($reqprodname)==0 || $data[$i][5]=~m/^$reqprodname$/) {
    	print "<tr>";
	for $j ( 0 .. $#{$data[$i]} ) {
	           print "<td>".$data[$i][$j]."</td>";
	       }
    	print "</tr>\n";
    #}
    }
    print "</table>\n";
    print "</body></html>\n";
}

#===================
sub SaveProductPricesToDb {
	my($self,$City,@data) = @_;

	# set the data source name
	# format: dbi:db type:db name:host:port
	# mysql’s default port is 3306
	# if you are running mysql on another host or port,
	#    you must change it
	my $dsn = 'dbi:mysql:akiki_miniconomy:localhost:3306';
	 
	# set the user and password
	my $user = 'akiki_shadi';
	my $pass = 'shadi';
	 
	# now connect and get a database handle  
	my $dbh = DBI->connect($dsn, $user, $pass)
	 or die "Can’t connect to the DB: $DBI::errstr\n"; 

#	#
#	my $sqlq = '';
#	for $i ( 0 .. $#data ) {
#		#  <tr><th>street</th><th>shopname</th><th>shopnumber</th><th>ownername</th><th>qt</th><th>pd</th><th>pc</th></tr>
#		$sqlq = $sqlq."replace into ShopsGeneral set `name`='".$data[$i][1]."', `idcity`=1, `url`='bla.com';";
#	}
#	my $sth = $dbh->prepare($sqlq);
#	$sth->execute(); 

#	#
#	my $sqlq = '';
#	$sqlq = $sqlq.'delete from ShopsGeneral;'; # deleting all entries from table in d/b
#	$sqlq = $sqlq.'insert into ShopsGeneral(name,idcity,url) values ';
#	for $i ( 0 .. $#data ) {
#		#  <tr><th>street</th><th>shopname</th><th>shopnumber</th><th>ownername</th><th>qt</th><th>pd</th><th>pc</th></tr>
#		$sqlq = $sqlq."('".$data[$i][1]."',0,'bla.com'), ";
#	}
#	# dropping the last ", " and replacing it with ";"
#	$sqlq =~ s/^(.*), $/\1;/g ;
#	#
#	print "sqlq=".$sqlq."\n";
#	my $sth = $dbh->prepare($sqlq);
#	$sth->execute(); 

	#
	my $sqlq = "";
	$sqlq = $sqlq."delete from ShopsData where city='".$City."';"; # deleting all entries from table in d/b for this city
	my $sth = $dbh->prepare($sqlq);
	$sth->execute(); 

	#
	$sqlq = "";
	$sqlq = $sqlq."insert into ShopsData(city,street,shopname,shopnumber,ownername,qt,pd,px) values ";
	for $i ( 0 .. $#data ) {
		$sqlq = $sqlq."(";
		$sqlq = $sqlq."'".$City."',";
		for $j ( 0 .. $#{$data[$i]} ) {
			$sqlq = $sqlq."'".$data[$i][$j]."',";
		}
		$sqlq =~ s/^(.*),$/$1/g ; # dropping the last ,
		$sqlq = $sqlq."),";
	}
	$sqlq =~ s/^(.*),$/$1;/g ;	# dropping the last "," and replacing it with ";"
	#
	#print "\nsqlq=\n".$sqlq."\n.\n";
	$sth = $dbh->prepare($sqlq);
	$sth->execute(); 

}

sub RetrieveProductPriceFromDb {
	my($self,$reqprodname) = @_;

	# set the data source name
	# format: dbi:db type:db name:host:port
	# mysql’s default port is 3306
	# if you are running mysql on another host or port,
	#    you must change it
	my $dsn = 'dbi:mysql:akiki_miniconomy:localhost:3306';
	 
	# set the user and password
	my $user = 'akiki_shadi';
	my $pass = 'shadi';
	 
	# now connect and get a database handle  
	my $dbh = DBI->connect($dsn, $user, $pass)
	 or die "Can’t connect to the DB: $DBI::errstr\n"; 

	#
	my $sqlq = "";
	$sqlq = $sqlq."select * from ShopsData where pd = '".$reqprodname."' order by px;";
	#print "\nsqlq=\n".$sqlq."\n.\n";

	my $sth = $dbh->prepare($sqlq);
	$sth->execute(); 

	my @d = ();
	while(@row = $sth->fetchrow_array()) {
		push(@d,[@row]);
		#print $d[0][0]."\n";
	}

	return @d;
}


sub RetrieveUniqueProductsFromDb {
	my($self,$reqprodname) = @_;

	# set the data source name
	# format: dbi:db type:db name:host:port
	# mysql’s default port is 3306
	# if you are running mysql on another host or port,
	#    you must change it
	my $dsn = 'dbi:mysql:miniconomy:localhost:3306';
	 
	# set the user and password
	my $user = 'shadi';
	my $pass = 'shadi';
	 
	# now connect and get a database handle  
	my $dbh = DBI->connect($dsn, $user, $pass)
	 or die "Can’t connect to the DB: $DBI::errstr\n"; 

	#
	my $sqlq = "";
	$sqlq = $sqlq."select distinct pd from ShopsData order by pd;";
	#print "\nsqlq=\n".$sqlq."\n.\n";

	my $sth = $dbh->prepare($sqlq);
	$sth->execute(); 

	my @d = ();
	while(@row = $sth->fetchrow_array()) {
		push(@d,[@row]);
		#print $d[0][0]."\n";
	}

	return @d;
}

#====================
# Determining which City I'm in, and using the corresponding streets
sub currentCity {
	my($self) = @_;
	my $mech = $self->{mech};
	my $url = "http://www.miniconomy.com/right3.php";
	$mech->get($url);
	my $tree0 = HTML::TreeBuilder::XPath->new;
	$tree0->parse($mech->content());
	#print $tree0->as_XML_indented();
	my $City=$tree0->findvalue("//span[\@id='d_city']" );
	$tree0->delete;
	return $City;
}

sub cityStreets {
	print "Building list of streets in the current city.\n";

	my($self) = @_;
	my $mech = $self->{mech};
	my @streets=();
	my @roots=();

	# processing the 1st street at which we are
	my $url = "street.php";
	push(@roots,WWW::Mechanize::Link->new({url=>$url}));

	# iterating
	while($#roots+1 > 0) {
		my $sr = shift(@roots);
		my $url = "http://www.miniconomy.com/".$sr->url();
		#print $url."\n";

		# getting the street main page
		$mech->get($url);

		# finding this street's name
		my $tree0 = HTML::TreeBuilder::XPath->new;
		$tree0->parse($mech->content());
		#print $tree0->as_XML_indented();
		my $sn=$tree0->findvalue("//title");
		$tree0->delete;

		# checking if we already have this street (and hence its children)
		if(!grep(/$sn/,@streets)) {
			print "\tProceeding with ".$sn."\n";
			push(@streets,$sn);

			# navigating to children's page
			$url="http://www.miniconomy.com/".$mech->find_link(url_regex=>qr/streetbot/i)->url();
			$mech->get($url);
			#print $url."\n";

			# inserting the children's urls for later processing
			push(@roots,$mech->find_all_links(url_regex=>qr/gotostreet/i));
		}
	}

	return @streets;
}
#==============
1;

		my $normal;
		print 'Not logged in. Do you want to log in via perl? [yes]:';
		while (1) {
			chomp( my $normal = <STDIN> );
			$normal ||= 'yes';
			$normal = 'yes' if $normal eq '';
			last if grep { lc $normal eq $_ } 'yes', 'no';
			print "\nERROR: Answer must be yes or no.\nTry again.\n";
		}

		if(lc $normal eq 'no') {
			print "Not logging in. Please log in via the browser then, or try again to log in via perl.\n";
		} else {
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

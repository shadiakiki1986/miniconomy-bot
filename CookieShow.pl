#!/usr/bin/perl -w
my $ISCGI=TRUE;
if($ISCGI) {
	print "$ENV{'SERVER_PROTOCOL'} 200 OK\n";
	print "Server: $ENV{'SERVER_SOFTWARE'}\n";
	print "Content-type: text/plain\r\n\r\n";
	$| = 1;
}

#=============
open (MYFILE, '/tmp/cookie.txt');

print "Cookie:\n";
while (<MYFILE>) {
 	chomp;
 	print "$_\n";
 }
 close (MYFILE); 

#
exit 0;

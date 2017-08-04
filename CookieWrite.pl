#!/usr/bin/perl -w
use CGI qw(param);
my $phpsessionid=param("phpsessionid");
#----------
my $ISCGI=TRUE;
if($ISCGI) {
	print "$ENV{'SERVER_PROTOCOL'} 200 OK\n";
	print "Server: $ENV{'SERVER_SOFTWARE'}\n";
	print "Content-type: text/plain\r\n\r\n";
	$| = 1;
}
#-----------------------
if(length($phpsessionid)!=26) {die "Usage: perl ProductPrices_Show.pl phpsessionid=[26-character php session id obtained from browser]\n"; }
print "Writing cookie with phpsessionid ",$phpsessionid,".\n";

#=============
use Text::Template;
$template = Text::Template->new(TYPE => 'FILE',  SOURCE => 'cookie_template.txt')
or die "Couldn't construct template: $Text::Template::ERROR";
$hash = { phpsessionid => $phpsessionid};
$text = $template->fill_in(HASH=>$hash);

print $text;
#
open (MYFILE, '>/tmp/cookie.txt') or print "Cannot write to file.\n";
print MYFILE $text;
close (MYFILE); 

#
print "Done.\n";
exit 0;

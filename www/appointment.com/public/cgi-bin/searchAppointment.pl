#!/usr/bin/perl

use DBI;
use CGI qw(:standard);
use CGI;
use Cpanel::JSON::XS qw(encode_json decode_json);
use utf8;
use JSON;
use JSON::PP;
use Encode;

print header('application/json');

use open ':std', ':encoding(utf8)';  # Defaults

use JSON -support_by_pp;


my $cgi = CGI -> new;

my $s =$cgi->param("searchValue");

 
my $dbh =DBI->connect("dbi:SQLite:appointmentDB.db") || die "can not";
my $sql;

if($array[0] eq ""){
	$sql='SELECT * FROM appointment_table';
}

$sql = 'SELECT * FROM appointment_table where desc LIKE ?';
  
my $sth = $dbh->prepare($sql);

$sth->execute("$s%");

my $data_json=[];
while (my @row = $sth->fetchrow_array) {
	
        #storing data from Result set to array of objects
	push @{$data_json},{'date'=>$row[1],'time'=>$row[2],'desc'=>$row[3]}; 

}


my $json_d = to_json( $data_json, { utf8 => 1, pretty => 1 } ); # converting array of objects to json object

print "$json_d";


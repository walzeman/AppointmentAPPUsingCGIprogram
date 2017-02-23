#!/usr/bin/perl

use DBI;
use CGI;

if($ENV{'REQUEST_METHOD'} eq 'POST'){

	 read(STDIN,$buffer, $ENV{'CONTENT_LENGTH'});	

}

$count=0;
my @array; $array[4];

foreach(split(/&/,$buffer)){  

	 my($key,$value)= split(/=/,$_); 
	 $array[$count] =$value;
	 $count++;	
	 
 }
 
 
 my $dbh =DBI->connect("DBI:SQLite:appointmentDB.db") || die "can not";

 my $date=$array[0];
 my $time=$array[1]; 
 my $desc=$array[2];

 $dbh->do("CREATE TABLE appointment_table(id INTEGER PRIMARY KEY,date TEXT,time TEXT,desc VARCHAR(10))");
 $dbh->do("INSERT INTO appointment_table(date,time,desc) values(?,?,?)", undef, $date,$time,$desc);
 
 
print ("Location: http://localhost\n");      # post redirect get to the main page
print ("Content-type: text/html\n\n");
 


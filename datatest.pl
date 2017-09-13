#!/usr/bin/perl -w
use strict;
use DBI;
my $driver = "mysql";
my $dsn = "database=eveindustry";
my $username = "admin";
my $passwd = <stdin>;
chomp $passwd;
my $dbh = DBI->connect("dbi:$driver:$dsn", $username, $passwd, { AutoCommit => 1 }) or die "Failed to connect to database: $DBI::errstr";
my $getkey = $dbh -> prepare("SHOW TABLES")
                or die ("SHOW TABLES failed: $DBI::errstr\n");

$getkey -> execute
                or die ("execute failed: $DBI::errstr\n");

print ("Tables in test database on localhost,\n");
while (my @row = $getkey->fetchrow) {
        print "@row\n";
        }

use strict;
use warnings;
use JSON::XS;
use Data::Dumper;
use LWP::UserAgent;
#use Net::SSL;
 use URI::Escape;
 
 # Create a user agent object

 our $accesstoken;
our $hostname="https://esi.tech.ccp.is/latest/";
print "current iteration is _latest \n";
print "please select an endpoint (test with search): \t";
our $endpoint=<stdin>;
chomp($endpoint);
print "\nplease select a category if applicable (test with region): \t";
our $categories=<stdin>;
chomp($categories);
print "\nplease select a region to search for:\t";
our $search = <stdin>;
chomp($search);
print "]nsanitizing unsafe characters\n";
our $urlsanity=uri_escape($search);


our $URL= "${hostname}${endpoint}/?categories=${categories}&datasource=tranquility&language=en-us&search=${urlsanity}&strict=false";
print "\n\n$URL\n\n";
#our $sanitizedURL = uri_escape($URL);
#print "\n\n$sanitizedURL\n\n";
our $json;
 
 
 
 
 
  my $ua = LWP::UserAgent->new;
  $ua->agent("MyApp/0.1 ");

  # Create a request
  my $req = HTTP::Request->new(GET => $URL );
  $req->content_type('application/json');
 

  # Pass request to the user agent and get a response back
  my $res = $ua->request($req);

  # Check the outcome of the response
  if ($res->is_success) {
      print $res->content;
  }
  else {
      print $res->status_line, "\n";
  }
  
  
#  10000002 the forge
  
 # 34 tritanium
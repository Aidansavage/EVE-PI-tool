use strict;
use warnings;
use JSON::XS;
use Data::Dumper;
use LWP::UserAgent;
use Net::SSL;
 
 
 # Create a user agent object

 our $accesstoken;
our $hostname="https://esi.tech.ccp.is/latest/";
print "current iteration is _latest \n";
print "please select an endpoint: \t";
our $endpoint=<stdin>;
print "\nplease select a category if applicable: \t";
our $categories=<stdin>;
print "\nplease select a datasource: \t";
our $datasource=
our $URL="${hostname}characters/Basandra%20Skye/inventory?access_token=${APIKey}";
our $json;
 
 
 
 
 
  my $ua = LWP::UserAgent->new;
  $ua->agent("MyApp/0.1 ");

  # Create a request
  my $req = HTTP::Request->new(GET => 'https://esi.tech.ccp.is/latest/search/?categories=region&datasource=tranquility&language=en-us&search=the%20forge&strict=false' );
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
  
  
  10000002
  
  34
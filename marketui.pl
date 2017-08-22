use strict;
use warnings;
use JSON::XS;
use Data::Dumper;
use LWP::UserAgent;

#use Net::SSL;
use URI::Escape;

use diagnostics;

####
#### Tk module use block
use Tk;
use Tk::LabFrame;
use Tk::NoteBook;
use Tk::BrowseEntry;
####

our $main = MainWindow->new;
$main->geometry("800x600");

$main->configure( -menu => my $menubar = $main->Menu );
my $file = $menubar->cascade( -label => '~File' );
my $edit = $menubar->cascade( -label => '~Edit' );
my $help = $menubar->cascade( -label => '~Help' );

$file->separator;
$file->command(
                -label       => "Quit",
                -accelerator => 'Ctrl-q',
                -underline   => 0,
                -command     => \&exit,
);

$edit->command( -label => 'Preferences ...' );

$help->command( -label => 'Version', -command => sub { print "Version\n" } );
$help->separator;
$help->command( -label => 'About', -command => sub { print "About\n" } );

our $URL = $main->Label( -text => "https://esi.tech.is/latest/" )->pack;
my $endpoint = 'Search';

my $frame = $main->Frame;
my $endpointchoice = $frame->BrowseEntry(
                                          -label    => "Endpoint:",
                                          -variable => \$endpoint,
                                          ,
                                          -browsecmd => \&EndpointPop
);
$endpointchoice->pack;
$endpointchoice->insert( "end", "Search" );
my $buttonframe = $frame->Frame;
$buttonframe->Button(
    -text    => "Print value",
    -command => sub {
        print "The endpoint is $endpoint\n";
    },
    -relief => "raised"
)->pack;

$buttonframe->pack;
$frame->pack;
my $operation;
our $operationchoice;
my $frame2 = $main->Frame;
$operationchoice = $frame2->BrowseEntry(
    -label     => "Search Type:",
    -variable  => \$operation,
    -browsecmd => \&OperationPop

);

=begin comment
    -listcmd  => sub {
        if ( $endpoint eq 'Search' ) {
            $operationchoice->configure(
                                     -choices => [
                                                   'agent',     'alliance',
                                                   'character', 'constellation',
                                                   'corporation',   'faction',
                                                   'inventorytype', 'region',
                                                   'solarsystem',   'station',
                                                   'wormhole'
                                     ]
            );
        }
        else { 1 }
    }
=end comment
=cut

$operationchoice->pack;

my $buttonframe2 = $frame2->Frame;
$buttonframe2->Button(
    -text    => "Print value",
    -command => sub {
        print "The operation type is $operation\n";
    },
    -relief => "raised"
)->pack;

$buttonframe2->pack;
$frame2->pack;

MainLoop;

sub OperationPop {
    my $arg = $_[1];
    print "\n\n";
    print $arg;
    my $temp = $URL->cget( -text );
    print "\n\nCurrent URL is $temp\n";
    $temp = "${temp}${arg}&datasource=tranquility&language=en-us&search=";
    $URL->configure( -text => $temp );
    print "\n\nNew built URL is $URL";
}

sub EndpointPop {

    #access subroutine arguments via $_[index] to grab selection choice
    my $arg = $_[1];
    print "\n\n";
    print $arg;
    if ( $arg eq 'Search' ) {
        my $temp = $URL->cget( -text );
        print "\n\nCurrent URL is $temp\n";

        #$temp=
        $URL->configure( -text => "${temp}${arg}/?categories=" );
        print "\n\nNew built URL is " . $URL->cget( -text );
        $operationchoice->configure(
                                     -choices => [
                                               'agent',         'alliance',
                                               'character',     'constellation',
                                               'corporation',   'faction',
                                               'inventorytype', 'region',
                                               'solarsystem',   'station',
                                               'wormhole'
                                     ]
        );
    }
    else { 1 }
}

sub IFINEEDIT {

    # Create a user agent object
    our $hostname = "https://esi.tech.ccp.is/latest/";
    print "current iteration is _latest \n";
    print "please select an endpoint (test with search): \t";
    our $endpoint = <stdin>;
    chomp($endpoint);
    print "\nplease select a category if applicable (test with region): \t";
    our $categories = <stdin>;
    chomp($categories);
    print "\nplease select a region to search for:\t";
    our $search = <stdin>;
    chomp($search);
    print "\nsanitizing unsafe characters\n";
    our $urlsanity = uri_escape($search);

    our $URL =
"${hostname}${endpoint}/?categories=${categories}&datasource=tranquility&language=en-us&search=${urlsanity}&strict=false";
    print "\n\n$URL\n\n";

    #our $sanitizedURL = uri_escape($URL);
    #print "\n\n$sanitizedURL\n\n";
    our $json;

    my $ua = LWP::UserAgent->new;
    $ua->agent("MyApp/0.1 ");

    # Create a request
    my $req = HTTP::Request->new( GET => $URL );
    $req->content_type('application/json');

    # Pass request to the user agent and get a response back
    my $res = $ua->request($req);

    # Check the outcome of the response
    if ( $res->is_success ) {
        print $res->content;
        print "\nparsing response\n";
        $json = $res->decoded_content;
        print Dumper($json);
    }
    else {
        print $res->status_line, "\n";
    }

    our %test        = %{ decode_json($json) };
    our @anothertest = @{ $test{'region'} };

    print @anothertest;
    print $anothertest[0];

}

#  10000002 the forge

# 34 tritanium


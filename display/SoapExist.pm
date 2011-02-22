package SoapExist;
#
# XSP taglib for OUCS AxKit server
# Provides interface to eXist database
#
# $File: //src/xsp/oucsutils/liboucsutils-perl-1.0/SoapExist.pm $
# $Revision: #2 $
# $Date: 2002/03/14 $
# $Author: ray $
#

$VERSION = "1.0";

use AxKit ;
use Apache;
use Apache::URI;
use File::Basename;
use Apache::Request;
use Apache::AxKit::Language::XSP::TaglibHelper;
use AxKit::XSP::WebUtils;
use SOAP::Lite;

$NS = 'http://www.oucs.ox.ac.uk/NS/xsp/soapexist/v1';

@ISA = qw(Apache::AxKit::Language::XSP);

@EXPORT_TAGLIB = (
    'exist()',
    'hits():as_xml=true',
    'results():as_xml=true'
);
sub parse_char  { Apache::AxKit::Language::XSP::TaglibHelper::parse_char(@_); }
sub parse_start { Apache::AxKit::Language::XSP::TaglibHelper::parse_start(@_); }
sub parse_end   { Apache::AxKit::Language::XSP::TaglibHelper::parse_end(@_); }

use strict;

sub exist()
{
 my $service = SOAP::Lite->service("http://localhost:8080/exist/services/Query?WSDL");

 my $result = $service->query($query);
 my $resultSetId = $result->{'resultSetId'};
 my $hits = $result->{'hits'};
 my $queryTime = $result->{'queryTime'};
 my @collections = @{$result->{'collections'}};
}

foreach $collection (@collections) {
  $collectionName = $collection->{"collectionName"};
  my @docs = @{$collection->{'documents'}};
  foreach $doc (@docs) {
    $name = $doc->{'documentName'};
    $docHits = $doc->{'hitCount'};
    write(STDOUT);
  }
}
print "found $hits hits in $queryTime ms.\n";

# display hits 1 to 10
my $i = 1;
my $xml;

while($i < $hits && $i < 10) {
  $xml = $service->retrieve($resultSetId, $i, 'ISO-8859-1', 1);
  print $xml . "\n";
  $i++;
}

print $xml . "\n";

}

sub hits () {
    my $r = AxKit::Apache->request;
    my $uri = $r->parsed_uri();
    return dirname($uri->rpath());
}   

sub dirlist () {
    my $Request = AxKit::Apache->request;
    my $thisfile=$Request->filename();
    my $here;
    if (-d $thisfile) 
      { $here=$thisfile; }
    else 
      { $here=dirname($thisfile);}
    opendir HERE, $here ;
    my @files=grep !/^\.\.?$/,readdir HERE;
    closedir HERE;
    my $stuff='';
    foreach (@files) {
	next if $_ eq "index.xsp";
	next if $_ eq $thisfile;
	my ($size,$mtime) = (stat("$here/$_"))[7,9];
	$stuff .= "<row><cell><xptr url=\"$_\"/></cell>" ;
	if (-d "$here/$_")  
	{ 
	    $stuff .=    "<cell>(directory)</cell>" ; 
	}
	else     
	{     
	    $stuff .= "<cell>$size bytes</cell>";
	}
	$stuff .= "<cell>last modified " ;
	$stuff .= localtime $mtime ; 
	$stuff .=  "</cell>"; 
	$stuff .=  "</row>" ;
    }
    return "<table rend=\"frame\">$stuff</table>";
}

1;
__END__

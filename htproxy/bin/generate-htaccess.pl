#!/usr/bin/perl
#
# Generate the htaccess file. This is a script because the file depends
# on whether SSL is on, and also does minor data cleanup.
#
# Copyright (C) 2014 and later, Indie Computing Corp. All rights reserved. License: see package.
#

use strict;

use UBOS::Logging;
use UBOS::Utils;

my $hostname       = $config->getResolve( 'site.hostname' );
my $protocol       = $config->getResolve( 'site.protocol' );
my $htaccessFile   = $config->getResolve( 'appconfig.apache2.appconfigfragmentfile' );
my $contextOrSlash = $config->getResolve( 'appconfig.contextorslash' );
my $targetRoot     = $config->getResolve( 'installable.customizationpoints.targetroot.value' );

if( 'deploy' eq $operation ) {
    $targetRoot =~ s!/$!!; # remove trailing slash if entered
    my $content = <<CONTENT;
#
# Apache config file fragment for application htproxy at $hostname$contextOrSlash,
# which proxies to $targetRoot$contextOrSlash
#

# ProxyPass /robots.txt !
# ProxyPass /favicon.ico !
# ProxyPass /sitemap.xml !
# ProxyPass /.well-known !
# ProxyPass /_common !
# Just the errors:
ProxyPass /_errors !

ProxyPass        $contextOrSlash $targetRoot$contextOrSlash
ProxyPassReverse $contextOrSlash $targetRoot$contextOrSlash

<Location $contextOrSlash>
    ProxyPreserveHost On
</Location>
CONTENT
    if( 'https' eq $protocol ) {
        $content .= <<CONTENT;

SSLProxyEngine on
CONTENT
    }

    UBOS::Utils::saveFile( $htaccessFile, $content );
}

if( 'undeploy' eq $operation ) {
    UBOS::Utils::deleteFile( $htaccessFile );
}

1;




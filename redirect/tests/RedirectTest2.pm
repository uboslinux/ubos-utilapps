#!/usr/bin/perl
#
# Simple test for redirect, with default
#
# Copyright (C) 2014 and later, Indie Computing Corp. All rights reserved. License: see package.
#

use strict;
use warnings;

package RedirectTest1;

use UBOS::WebAppTest;

# The states and transitions for this test

my $TEST = new UBOS::WebAppTest(
    appToTest   => 'redirect',
    description => 'Tests redirects',
    customizationPointValues => {
        'target' => 'http://ubos.net/',
    },
    checks      => [
            new UBOS::WebAppTest::StateCheck(
                    name  => 'virgin',
                    check => sub {
                        my $c = shift;

                        my $default = 'http://ubos.net/';

                        $c->getMustRedirect( '/',                       $default,                  undef, 'Redirected to wrong place' );
                        $c->getMustRedirect( '/below',                  $default,                  undef, 'Redirected to wrong place' );
                        $c->getMustRedirect( '/below/some?where=there', $default . '?where=there', undef, 'Redirected to wrong place' );

                        return 1;
                    }
            )
    ]
);

$TEST;

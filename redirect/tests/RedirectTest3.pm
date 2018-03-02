#!/usr/bin/perl
#
# Simple test for redirect, with customizationpoint that reuses the incoming URL
#
# Copyright (C) 2014 and later, Indie Computing Corp. All rights reserved. License: see package.
#

use strict;
use warnings;

package RedirectTest1;

use UBOS::WebAppTest;

# The states and transitions for this test

my $target = 'http://cnn.com/';
my $TEST = new UBOS::WebAppTest(
    appToTest   => 'redirect',
    description => 'Tests redirects',
    customizationPointValues => {
        'redirect' => {
            'target' => $target . '?was=$1'
        }
    },
    checks      => [
            new UBOS::WebAppTest::StateCheck(
                    name  => 'virgin',
                    check => sub {
                        my $c = shift;
                        
                        $c->getMustRedirect( '/',      "$target?was=",      undef, 'Redirected to wrong place' );
                        $c->getMustRedirect( '/below', "$target?was=below", undef, 'Redirected to wrong place' );

                        return 1;
                    }
            )
    ]
);

$TEST;

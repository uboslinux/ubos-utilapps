#!/usr/bin/perl
#
# Simple test for redirect, with customizationpoint
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
            'target' => $target
        }
    },
    checks      => [
            new UBOS::WebAppTest::StateCheck(
                    name  => 'virgin',
                    check => sub {
                        my $c = shift;
                        
                        $c->getMustRedirect( '/',                       $target,                  undef, 'Redirected to wrong place' );
                        $c->getMustRedirect( '/below',                  $target,                  undef, 'Redirected to wrong place' );
                        $c->getMustRedirect( '/below/some?where=there', $target . '?where=there', undef, 'Redirected to wrong place' );

                        return 1;
                    }
            )
    ]
);

$TEST;

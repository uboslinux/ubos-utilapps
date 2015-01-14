#!/usr/bin/perl
#
# Simple test for redirect, with default
#
# This file is part of redirect.
# (C) 2012-2015 Indie Computing Corp.
#
# gladiwashere is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# gladiwashere is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with gladiwashere.  If not, see <http://www.gnu.org/licenses/>.
#

use strict;
use warnings;

package RedirectTest1;

use UBOS::WebAppTest;

# The states and transitions for this test

my $TEST = new UBOS::WebAppTest(
    appToTest   => 'redirect',
    description => 'Tests redirects',
    testContext => '/foo',
    checks      => [
            new UBOS::WebAppTest::StateCheck(
                    name  => 'virgin',
                    check => sub {
                        my $c = shift;

                        my $default = 'http://indiebox.net/';

                        $c->getMustRedirect( '/',                       $default,                  undef, 'Redirected to wrong place' );
                        $c->getMustRedirect( '/below',                  $default,                  undef, 'Redirected to wrong place' );
                        $c->getMustRedirect( '/below/some?where=there', $default . '?where=there', undef, 'Redirected to wrong place' );

                        return 1;
                    }
            )
    ]
);

$TEST;

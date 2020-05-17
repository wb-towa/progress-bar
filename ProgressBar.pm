#!/usr/bin/env perl

# Author: William B
# Email: toadwarrior@gmail.com
# Date: 2014-Nov-18
# Copyright (c) 2014-2020 All Rights Reserved https://github.com/wb-towa/progress-bar
#
# GPL v3 licence
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# TODO:
#
# - Tests
# - More formatting options (Might want to include bracketing within the class i.e. [.....])
# - Better way to set autoflush rather than each time in increment()?
# - Set which percentage it prints on (i.e. may want 1% rather than 10%)
#

package ProgressBar;

use 5.18.2;
use strict;
use warnings;
use POSIX "fmod";

our $VERSION = 0.50;

sub new {

    my $class = shift;
    my $self = {
        _total => shift,
        _tick => '|',
        _pos => 0,
        _progress_string => ""
    };

    bless $self, $class;

    return $self;
}

sub setTick {

    my $self = shift;

    $self->{_tick} = shift;
}

sub percent {

    my $self = shift;

    return ($self->{_pos} / $self->{_total}) * 100;
}

sub reset {

    my $self = shift;

    $self->{_progress_string} = "";
    $self->{_pos} = 0;
}

sub increment {

    my $self = shift;
    local $| = 1;

    if ($self->{_pos} <= $self->{_total}) {

        if ($self->{_pos} > 0 && fmod($self->percent(), 10) == 0) {

            print "\b" x length($self->{_progress_string});

            $self->{_progress_string} .= $self->{_tick};

            print $self->{_progress_string};
        }

        $self->{_pos}++;

        return 1;
    } else {
        return 0;
    }
}

1;

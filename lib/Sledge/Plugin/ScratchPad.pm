package Sledge::Plugin::ScratchPad;
# $Id$
#
# Tatsuhiko Miyagawa <miyagawa@edge.co.jp>
# Livin' On The EDGE, Limited.
#

use strict;
use vars qw($VERSION);
$VERSION = 0.01;

sub import {
    my $class = shift;
    my $pkg = caller;

    no strict 'refs';
    *{"$pkg\::pad"} = sub {
	my $self = shift;
	return $self->{pad};	# read only
    };

    $pkg->register_hook(
	AFTER_INIT => sub {
	    my $self = shift;
	    $self->{pad} = Sledge::Plugin::ScratchPad->new;
	},
    );
}


sub new { bless {}, shift }

sub param {
    my $self = shift;
    if (@_ == 0) {
	return keys %$self;
    }
    elsif (@_ == 1) {
	return $self->{$_[0]};
    }
    else {
	$self->{$_[0]} = $_[1];
    }
}

sub clear {
    my $self = shift;
    %$self = ();
}

1;

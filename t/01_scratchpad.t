# $Id$

use strict;
use Test::More tests => 7;

require Sledge::Plugin::ScratchPad;

my $pad = Sledge::Plugin::ScratchPad->new;
isa_ok $pad, 'Sledge::Plugin::ScratchPad';

$pad->param(foo => 'bar');
is $pad->param('foo'), 'bar';
is_deeply [ $pad->param ], [ 'foo' ];

$pad->param(bar => 'baz');
is_deeply [ sort $pad->param ], [ sort 'foo', 'bar' ];

package Test::Pages;
use base qw(Sledge::Pages::Base);
use Sledge::Plugin::ScratchPad;

package main;
my $p = bless {}, 'Test::Pages';
$p->invoke_hook('AFTER_INIT');

isa_ok $p->{pad}, 'Sledge::Plugin::ScratchPad';

package Test::Pages::Inherit;
use base qw(Test::Pages);

package main;
my $i = bless {}, 'Test::Pages::Inherit';
$i->invoke_hook('AFTER_INIT');

isa_ok $i->{pad}, 'Sledge::Plugin::ScratchPad';

$i->pad->param(foo => 'foo');
$i->pad->clear;
is_deeply [ $i->pad->param ], [];


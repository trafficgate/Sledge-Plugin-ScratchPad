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

__END__

=head1 NAME

Sledge::Plugin::ScratchPad - temporary data buffer

=head1 SYNOPSIS

  package Foo::Pages::Bar;
  use Sledge::Plugin::ScratchPad;

  sub dispatch_baz {
      my $self = shift;
      $self->pad->param(foo => 'bar');    # store
      my $bar = $self->pad->param('foo'); # fetch
  }

=head1 DESCRIPTION

ScratchPadプラグインは、テンポラリにデータを書きこむ領域を提供します。
各オブジェクト間でデータを引きまわす際に、Pagesオブジェクトを通じてデー
タをやりとりすることができます。格納されたデータは、dispatchメソッドが
終了すると破棄されます。

=head1 METHODS

C<use Sledge::Plugin::ScrachPad> を宣言することで、そのクラスで C<pad>
メソッドが利用可能になります。C<pad> メソッドは
Sledge::Plugin::ScratchPad クラスのインスタンスへの read only accessor
で、set/get 可能な C<param()> メソッドおよび、中身を空にするC<clear()>
メソッドを実装しています。

=head1 AUTHOR

Tatsuhiko Miyagawa <miyagawa@edge.co.jp> with Sledge development team.

=head1 SEE ALSO

pnotes in L<Apache>

=cut



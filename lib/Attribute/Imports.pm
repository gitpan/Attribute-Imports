use 5.10.0;

package Attribute::Handlers;

our $VERSION    = '0.1';

use strict;

use Attribute::Handlers;

use Symbol  qw( qualify_to_ref );

my %thingz
= qw
(
    $   SCALAR
    @   ARRAY
    %   HASH
    &   CODE
);

sub UNIVERSAL::imports  :ATTR
{
    my ( $package, $dest, undef, undef, $data ) = @_;

    given( $dest )
    {
        # no good way to handle these since there isn't
        # a place to install the value.

        when( 'ANON' )
        {
            die "Unable to import anonymous subroutines ($data).";
        }

        when( 'LEXICAL' )
        {
            die "Unable to import lexical variables ($data).";
        }
    }

    my $name    = *{ $dest }{ NAME };

    my $source  = $data->[0];

    my $sigil   = substr $source, 0, 1, '';

    my $thing   = $thingz{ $sigil }
    or die "Bogus imports: unknown type '$sigil'";

    my $ref     = qualify_to_ref $source
    or die "Bogus imports: invalid symbol '$source'";

    print STDERR "\nImporting '$source' ($thing) -> '$name'\n"
    if exists $ENV{ VERBOSE_IMPORTS };

    *$dest      = *{ $ref }{ $thing };
}

# keep require happy

1

__END__

=head1 NAME

Attribute::Imports: pull code, scalar, array, or hash 
symbols into the current package.

=head1 SYNOPSIS

Modules that export items by name can cause confusion
due to undocumented exports or collisions due to re-used
names. Importing the symbols into explicitly named items
in the local package avoids [most] issues.

    # say you wanted to use 'filebase' as the sub 
    # name to determine the base name of a file.

    use File::Basename qw();

    sub filebase :imports( qw( &File::Basename::basename ) );

    # or you wanted to avoid varaible collisions.

    require Foo;
    require Bar;

    our $foo_verbose    :imports( qw( $Foo::verbose ) );
    our $bar_verbose    :imports( qw( $Bar::verbose ) );

    # or give more descriptive values to the 
    # variables in your context.

    our @prefix         :imports( qw( @Mod1::Names ) );
    our @suffix         :imports( qw( @Mod2::Names ) );

    our %matchlist      :imports( qw( %Blah::known_names ) );

    # notice the lack of lexical variables 
    # and anonymous subs: neither of these
    # have a symbol table entry to install
    # the imported symbol into.

=head1 DESCRIPTION

This uses the Symbol module to access the value of a 
requested symbol, and the CODE, SCALAR, ARRAY, or HASH
entry of the remote symbol to pull a value into the 
current package. 

=head1 LICENSE

This module is released under the same terms as Perl-5.10.0.

=head1 AUTHOR

Steven Lembark <lembark@wrkhors.com>


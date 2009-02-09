
package Bar;

our @random = map { rand 100 } ( 0 .. rand 20 );

package Foo;

use strict;

use Attribute::Imports;
use Test::More;

plan tests => 1 + @random;

our @value  : imports( '@Bar::random' );

ok @value == @Bar::random, '@value == @Bar::random';

for( 0 .. $#value )
{
    ok $value[ $_ ] == $Bar::random[ $_ ], "Offset $_ matches";
}

__END__

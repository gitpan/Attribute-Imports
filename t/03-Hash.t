
package Bar;

my $key = ( 'a' .. 'z' )[ rand 26 ];

our %random
= map
{
    ( ++$key => rand 20 )
}
( 0 .. 1 + rand 20 );

package Foo;

use strict;

use Attribute::Imports;
use Test::More;

plan tests => 1 + 2 * keys %Bar::random;

our %value  : imports( '%Bar::random' );

ok keys %value == keys %Bar::random, 'Key counts match';

for( sort keys %Bar::random )
{
    ok exists $value{ $_ },                 "Found key: $_";
    ok $value{ $_ } == $Bar::random{ $_ },  "Matching value: $_";
}

__END__

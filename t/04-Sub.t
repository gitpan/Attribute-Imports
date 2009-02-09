
package Bar;


{
    my $rndval  = rand 100;

    sub random  { $rndval }
}

package Foo;

use strict;

use Attribute::Imports;
use Test::More;

plan tests => 2;

sub value   : imports( '&Bar::random' );

$DB::single = 1;

$a  = value;
$b  = &Bar::random;

ok __PACKAGE__->can( 'value' );

ok $a == $b,    'Random values match';

__END__

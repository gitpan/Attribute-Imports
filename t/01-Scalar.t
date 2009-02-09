
package Bar;

our $random = rand 100;

package Foo;

use strict;
use Test::More;

use Attribute::Imports;

plan tests => 1;

our $value  : imports( '$Bar::random' );

ok $value == $Bar::random, '$value == $Bar::random';

__END__

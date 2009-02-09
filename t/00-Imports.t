
use strict;
use Test::More;

my $class   = 'Attribute::Imports';

plan tests => 2;

use_ok $class;

ok ( UNIVERSAL->can( 'imports' ) ), "UNIVERSAL can 'imports'";

__END__

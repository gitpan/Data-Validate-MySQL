#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
#use Test::More skip_all => 'exhaustive test is too memory intensive';
BEGIN { use_ok('Data::Validate::MySQL', qw(is_mediumtext)) };

#########################

# these fields are too big to test up to capacity
# without running out of memory.  Just test some normal values.

# valid tests
my @good = (
	'',
	'x' x (2**10),
);
foreach my $value (@good){
	ok(defined(is_mediumtext($value)), "valid: $value");
}

# invalid tests
my @bad = (
	#'x' x 2**24
);
foreach my $value (@bad){
	ok(!defined(is_mediumtext($value)), "invalid: $value");
}

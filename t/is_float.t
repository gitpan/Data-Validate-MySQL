#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 22;
BEGIN { use_ok('Data::Validate::MySQL', qw(is_float)) };

#########################

# valid tests
my @good = (
	[0,'','',0],
	[1,'','',0],
	[1,1,'',0],
	[1.1,'','',0],
	[1.1,2,1,0],
	['-3.402823466E38','','',0],
	['3.402823466E38','','',0],
	['-1.175494351E-38','','',0],
	['1.175494351E-38','','',0],
);
foreach my $set (@good){
	ok(defined(is_float($set->[0], $set->[1], $set->[2], $set->[3])), "valid: $set->[0], $set->[1], $set->[2], $set->[3]");
}

# invalid tests
my @bad = (
	['', '','',0],
	['', '','',1],
	['abc', '','',0],
	['abc', '','',1],
	['abc', 1,'',0],
	['abc', 1,1,0],
	['100.1', 2,1,0],
	['100.1111', 7,1,0],
	['-3.402823466E39','','',0],
	['3.402823466E39','','',0],
	['-1.175494351E-39','','',0],
	['1.175494351E-39','','',0],
);
foreach my $set (@bad){
	ok(!defined(is_float($set->[0], $set->[1], $set->[2], $set->[3])), "invalid: $set->[0], $set->[1], $set->[2], $set->[3]");
}
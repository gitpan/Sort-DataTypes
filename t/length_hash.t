#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'Length (hash)';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

sub test {
  (@test)=@_;
  %hash=@test;
  @list=keys %hash;
  sort_length(\@list,\%hash);
  return @list;
}

$tests = "
1 foo 2 bar 3 zed => 2 1 3

1 foo 2 a 3 mi 4 m 5 mo 6 zed => 2 4 3 5 1 6

";

$t->tests(func  => \&test,
          tests => $tests);
$t->done_testing();


1;
# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 3
# cperl-continued-statement-offset: 2
# cperl-continued-brace-offset: 0
# cperl-brace-offset: 0
# cperl-brace-imaginary-offset: 0
# cperl-label-offset: -2
# End:


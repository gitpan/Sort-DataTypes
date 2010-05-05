#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'Numerical';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

sub test {
  (@test)=@_;
  sort_numerical(\@test);
  return @test;
}

$tests = "
1 3 2 => 1 2 3

-2 -3 -1 => -3 -2 -1

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


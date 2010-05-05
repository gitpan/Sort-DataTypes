#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'Length (reverse)';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

sub test {
  (@test)=@_;
  sort_rev_length(\@test);
  return @test;
}

$tests = "
foo bar zed => zed foo bar

foo a mi m mo zed => zed foo mo mi m a

aaa ccc bbb => ccc bbb aaa

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


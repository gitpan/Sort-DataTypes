#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'Date (hash,reverse)';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

BEGIN { $t->use_ok('Date::Manip'); }
Date_Init("TZ=EST");

sub test {
  (@test)=@_;
  %hash=@test;
  @list=keys %hash;
  sort_rev_date(\@list,\%hash);
  return @list;
}

$tests = "
a 'Jul 4 2000'
b 'May 31 2000'
c 'Dec 31 1999'
d 'Jan 3 2001'
=>
  d
  a
  b
  c

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


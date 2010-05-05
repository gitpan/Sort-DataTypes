#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'IP (hash,reverse)';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

sub test {
  (@test)=@_;
  %hash=@test;
  @list=keys %hash;
  sort_rev_ip(\@list,\%hash);
  return @list;
}

$tests = "
a 128.227.208.63 b 10.227.208.42 c 128.227.208.75 d 10.227.208.3 => c a b d

a 10.20.30.40
b 10.20.30.41/4
c 10.20.30.41
d 10.20.30.42
e 10.20.30.41/16
=>
  d
  e
  b
  c
  a
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


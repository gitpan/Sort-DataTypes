#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'Version (hash,reverse)';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

sub test {
  (@test)=@_;
  %hash=@test;
  @list=keys %hash;
  sort_rev_version(\@list,\%hash);
  return @list;
}

$tests = "
a 1.1.x b 1.2 c 1.2.x => c b a

a 1.aaa b 1.bbb => b a

a 1.2a b 1.2 c 1.03 => c b a

a 1.a b 1.2a => b a

a 1.01a b 1.1a => b a

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


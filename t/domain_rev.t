#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'Domain (reverse)';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

sub test {
  (@test)=@_;
  if ($test[$#test] eq "SEP") {
    pop(@test);
    sort_rev_domain(\@test);
  } else {
    $sep = pop(@test);
    sort_rev_domain(\@test,$sep);
  }
  return @test;
}

$tests = '
aaa.bbb
aa.bbb
\.
=>
  aaa.bbb
  aa.bbb

aaa.bbb.ccc
bbb.ccc
aaa.ccc
\.
=>
  aaa.bbb.ccc
  bbb.ccc
  aaa.ccc

aaa.bbb
aaa.ccc
SEP
=>
  aaa.ccc
  aaa.bbb

aaa::bbb
aa::bbb
::
=>
  aaa::bbb
  aa::bbb

aaa::bbb::ccc
bbb::ccc
aaa::ccc
::
=>
  aaa::bbb::ccc
  bbb::ccc
  aaa::ccc

aaa::bbb
aaa::ccc
::
=>
  aaa::ccc
  aaa::bbb

';

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


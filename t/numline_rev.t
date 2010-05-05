#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'NumLine (reverse)';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

sub test {
  (@test)= @_;
  $sep   = pop(@test);
  $n     = pop(@test);
  sort_rev_numline(\@test,$n,$sep);
  return @test;
}

$tests = '
a:3:b:c
e:2:a:f
c:1:x:d
1
:
   =>
   e:2:a:f
   c:1:x:d
   a:3:b:c

a:3:b:c
e:2:a:f
c:1:x:d
2
:
   =>
   a:3:b:c
   e:2:a:f
   c:1:x:d

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


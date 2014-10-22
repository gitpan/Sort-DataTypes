#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'Line';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

sub test {
  (@test)= @_;
  $sep   = pop(@test);
  $n     = pop(@test);
  sort_line(\@test,$n,$sep);
  return @test;
}

$tests = '
a:3:b:c
e:2:a:f
c:1:x:d
1
:
   =>
   a:3:b:c
   c:1:x:d
   e:2:a:f

a:3:b:c
e:2:a:f
c:1:x:d
3
:
   =>
   e:2:a:f
   a:3:b:c
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


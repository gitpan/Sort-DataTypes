#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'Path (reverse)';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

sub test {
  (@test)=@_;
  $sep = pop(@test);
  sort_rev_path(\@test,$sep);
  return @test;
}

$tests = '
aa.a a.b c.d.e a.b.c \. => c.d.e aa.a a.b.c a.b

aa/a a/b c/d/e a/b/c / => c/d/e aa/a a/b/c a/b

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


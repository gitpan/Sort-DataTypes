#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'Path (hash,reverse)';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

sub test {
  (@test)=@_;
  my $n    = $#test + 1;
  my $sep  = (2*int($n/2) == $n ? "" : shift(@test));
  my %hash = @test;
  my @list = keys %hash;

  if ($sep) {
    sort_rev_path(\@list,$sep,\%hash);
  } else {
    sort_rev_path(\@list,\%hash);
  }
  return @list;
}

$tests = '
1 aa.a 2 a.b 3 c.d.e 4 a.b.c => 3 1 4 2

/ 1 aa/a 2 a/b 3 c/d/e 4 a/b/c => 3 1 4 2

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


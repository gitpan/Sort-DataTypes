#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'Line (hash)';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

sub test {
  (@test)=@_;
  my $f    = shift(@test);
  my $n    = $#test + 1;
  my $sep  = (2*int($n/2) == $n ? "" : shift(@test));
  my %hash = @test;
  my @list = keys %hash;

  if ($sep) {
    sort_line(\@list,$f,$sep,\%hash);
  } else {
    sort_line(\@list,$f,\%hash);
  }
  return @list;
}

$tests = '
1 : a a:3:b:c b e:2:a:f c c:1:x:d => a c b

3 : a a:3:b:c b e:2:a:f c c:1:x:d => b a c

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


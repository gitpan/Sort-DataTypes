#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'NumDomain (hash)';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

sub test {
  (@test)=@_;
  if ($test[$#test] eq "SEP") {
    pop(@test);
    $i=1;
    %hash=map { $i++ => $_ } @test;
    @tmp=(1..$i-1);
    sort_numdomain(\@tmp,\%hash);
    @test=map { $hash{$_} } @tmp;
    return @test;
  } else {
    $sep = pop(@test);
    $i=1;
    %hash=map { $i++ => $_ } @test;
    @tmp=(1..$i-1);
    sort_numdomain(\@tmp,$sep,\%hash);
    @test=map { $hash{$_} } @tmp;
    return @test;
  }
  return @test;
}

$tests = '
a.11.c
a.2.c
SEP
=>
  a.2.c
  a.11.c

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


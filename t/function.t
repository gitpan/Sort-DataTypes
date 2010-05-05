#!/usr/bin/perl -w

BEGIN {
  use Test::Inter;
  $t = new Test::Inter 'Function';
}

BEGIN { $t->use_ok('Sort::DataTypes',':all'); }

# Do an alphabetic sort except put m-z before a-l)
sub testcmp {
  my($x,$y) = @_;
  if ($x lt "m"  &&  $y ge "m") {
     return 1
  } elsif ($x ge "m"  &&  $y lt "m") {
     return -1;
  } else {
     return $x cmp $y;
  }
}

sub test {
  (@test)=@_;
  sort_function(\@test,\&testcmp);
  return @test;
}

$tests = "
abc
bcd
mno
nop
=>
  mno
  nop
  abc
  bcd

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


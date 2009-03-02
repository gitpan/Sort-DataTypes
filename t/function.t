#!/usr/bin/perl -w

require 5.001;

$runtests=shift(@ARGV);
if ( -f "t/test.pl" ) {
  require "t/test.pl";
  $dir="t";
} elsif ( -f "test.pl" ) {
  require "test.pl";
  $dir=".";
} else {
  die "ERROR: cannot find test.pl\n";
}

unshift(@INC,$dir);
use Sort::DataTypes qw(:all);

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
~
  mno
  nop
  abc
  bcd

";

print "Function...\n";
test_Func(\&test,$tests,$runtests);

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


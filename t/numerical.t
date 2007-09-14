#!/usr/local/bin/perl -w

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

$tests = "
1 3 2 ~ 1 2 3

-2 -3 -1 ~ -3 -2 -1

";

sub test {
  (@test)=@_;
  sort_numerical(\@test);
  return @test;
}

print "Numerical...\n";
test_Func(\&test,$tests,$runtests);

1;

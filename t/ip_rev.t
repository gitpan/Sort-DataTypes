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
128.227.208.63
10.227.208.42
128.227.208.75
10.227.208.3
~
  128.227.208.75
  128.227.208.63
  10.227.208.42
  10.227.208.3

";

sub test {
  (@test)=@_;
  sort_rev_ip(\@test);
  return @test;
}

print "IP (reverse)...\n";
test_Func(\&test,$tests,$runtests);

1;

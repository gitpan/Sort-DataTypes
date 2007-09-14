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
foo bar zed ~ zed foo bar

foo a mi m mo zed ~ zed foo mo mi m a

";

sub test {
  (@test)=@_;
  sort_rev_length(\@test);
  return @test;
}

print "Length (reverse)...\n";
test_Func(\&test,$tests,$runtests);

1;

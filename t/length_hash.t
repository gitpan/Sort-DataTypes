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
foo bar zed ~ bar foo zed

foo a mi m mo zed ~ a m mi mo foo zed

";

sub test {
  (@test)=@_;
  $i=1;
  %hash=map { $i++ => $_ } @test;
  @tmp=(1..$i-1);
  sort_length(\@tmp,%hash);
  @test=map { $hash{$_} } @tmp;
  return @test;
}

print "Length (hash)...\n";
test_Func(\&test,$tests,$runtests);

1;

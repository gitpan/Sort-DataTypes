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
Jul 4 2000
May 31 2000
Dec 31 1999
Jan 3 2001
~
  Jan 3 2001
  Jul 4 2000
  May 31 2000
  Dec 31 1999

";

sub test {
  (@test)=@_;
  $i=1;
  %hash=map { $i++ => $_ } @test;
  @tmp=(1..$i-1);
  sort_rev_date(\@tmp,%hash);
  @test=map { $hash{$_} } @tmp;
  return @test;
}

print "Date (hash,reverse)...\n";
test_Func(\&test,$tests,$runtests);

1;

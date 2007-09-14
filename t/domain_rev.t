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
aaa.bbb
aa.bbb
~
  aaa.bbb
  aa.bbb

aaa.bbb.ccc
bbb.ccc
aaa.ccc
~
  aaa.bbb.ccc
  bbb.ccc
  aaa.ccc

aaa.bbb
aaa.ccc
~
  aaa.ccc
  aaa.bbb

";

sub test {
  (@test)=@_;
  sort_rev_domain(\@test);
  return @test;
}

print "Domain (reverse)...\n";
test_Func(\&test,$tests,$runtests);

1;

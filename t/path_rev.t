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
aa.a a.b c.d.e a.b.c . ~ c.d.e aa.a a.b.c a.b

aa/a a/b c/d/e a/b/c / ~ c/d/e aa/a a/b/c a/b

";

sub test {
  (@test)=@_;
  $sep = pop(@test);
  sort_rev_path(\@test,$sep);
  return @test;
}

print "Path (reverse)...\n";
test_Func(\&test,$tests,$runtests);

1;

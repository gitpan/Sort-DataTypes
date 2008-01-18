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

$tests = "
1 foo 2 bar 3 zed ~ 3 1 2

1 foo 2 a 3 mi 4 m 5 mo 6 zed ~ 6 1 5 3 4 2

";

sub test {
  (@test)=@_;
  %hash=@test;
  @list=keys %hash;
  sort_rev_length(\@list,\%hash);
  return @list;
}

print "Length (hash,reverse)...\n";
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


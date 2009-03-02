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

sub test {
  (@test)=@_;
  %hash=@test;
  @list=keys %hash;
  sort_rev_version(\@list,\%hash);
  return @list;
}

$tests = "
a 1.1.x b 1.2 c 1.2.x ~ c b a

a 1.aaa b 1.bbb ~ b a

a 1.2a b 1.2 c 1.03 ~ c b a

a 1.a b 1.2a ~ b a

a 1.01a b 1.1a ~ b a

";

print "Version (hash,reverse)...\n";
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


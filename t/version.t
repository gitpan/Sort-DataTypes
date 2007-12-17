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
1.1.x 1.2 1.2.x ~ 1.1.x 1.2 1.2.x

1.aaa 1.bbb ~ 1.aaa 1.bbb

1.2a 1.2 1.03 ~ 1.2a 1.2 1.03

1.a 1.2a ~ 1.a 1.2a

1.01a 1.1a ~ 1.01a 1.1a

";

sub test {
  (@test)=@_;
  sort_version(\@test);
  return @test;
}

print "Version...\n";
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


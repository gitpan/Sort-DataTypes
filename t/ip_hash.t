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
  sort_ip(\@list,\%hash);
  return @list;
}

$tests = "
a 128.227.208.63 b 10.227.208.42 c 128.227.208.75 d 10.227.208.3 ~ d b a c

a
10.20.30.40
b
10.20.30.41/4
c
10.20.30.41
d
10.20.30.42
e
10.20.30.41/16
~
  a
  c
  b
  e
  d
";

print "IP (hash)...\n";
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


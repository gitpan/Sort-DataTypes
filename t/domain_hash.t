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
  my $n    = $#test + 1;
  my $sep  = (2*int($n/2) == $n ? "" : shift(@test));
  my %hash = @test;
  my @list = keys %hash;

  if ($sep) {
    sort_domain(\@list,$sep,\%hash);
  } else {
    sort_domain(\@list,\%hash);
  }
  return @list;
}

$tests = '
1 aaa.bbb 2 aa.bbb ~ 2 1

\. 1 aaa.bbb.ccc 2 bbb.ccc 3 aaa.ccc ~ 3 2 1

1 aaa.bbb 2 aaa.ccc ~ 1 2

:: 1 aaa::bbb 2 aaa::ccc ~ 1 2

';

print "Domain (hash)...\n";
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


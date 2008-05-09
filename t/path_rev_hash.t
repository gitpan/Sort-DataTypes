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

$tests = '
1 aa.a 2 a.b 3 c.d.e 4 a.b.c ~ 3 1 4 2

/ 1 aa/a 2 a/b 3 c/d/e 4 a/b/c ~ 3 1 4 2

';

sub test {
  (@test)=@_;
  my $n    = $#test + 1;
  my $sep  = (2*int($n/2) == $n ? "" : shift(@test));
  my %hash = @test;
  my @list = keys %hash;

  if ($sep) {
    sort_rev_path(\@list,$sep,\%hash);
  } else {
    sort_rev_path(\@list,\%hash);
  }
  return @list;
}

print "Path (hash,reverse)...\n";
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

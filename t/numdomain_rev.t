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
a.11.c
a.2.c
SEP
~
  a.11.c
  a.2.c

';

sub test {
  (@test)=@_;
  if ($test[$#test] eq "SEP") {
    pop(@test);
    sort_rev_numdomain(\@test);
  } else {
    $sep = pop(@test);
    sort_rev_numdomain(\@test,$sep);
  }
  return @test;
}

print "NumDomain (reverse)...\n";
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


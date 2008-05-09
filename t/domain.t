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
aaa.bbb
aa.bbb
\.
~
  aa.bbb
  aaa.bbb

aaa.bbb.ccc
bbb.ccc
aaa.ccc
\.
~
  aaa.ccc
  bbb.ccc
  aaa.bbb.ccc

aaa.bbb
aaa.ccc
SEP
~
  aaa.bbb
  aaa.ccc

aaa::bbb
aa::bbb
::
~
  aa::bbb
  aaa::bbb

aaa::bbb::ccc
bbb::ccc
aaa::ccc
::
~
  aaa::ccc
  bbb::ccc
  aaa::bbb::ccc

aaa::bbb
aaa::ccc
::
~
  aaa::bbb
  aaa::ccc

';

sub test {
  (@test)=@_;
  if ($test[$#test] eq "SEP") {
    pop(@test);
    sort_domain(\@test);
  } else {
    $sep = pop(@test);
    sort_domain(\@test,$sep);
  }
  return @test;
}

print "Domain...\n";
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

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
  (@test)= @_;
  $sep   = pop(@test);
  $n     = pop(@test);
  sort_rev_numline(\@test,$n,$sep);
  return @test;
}

$tests = '
a:3:b:c
e:2:a:f
c:1:x:d
1
:
   ~
   e:2:a:f
   c:1:x:d
   a:3:b:c

a:3:b:c
e:2:a:f
c:1:x:d
2
:
   ~
   a:3:b:c
   e:2:a:f
   c:1:x:d

';

print "NumLine (reverse)...\n";
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


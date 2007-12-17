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
a:3:b:c
e:2:a:f
c:1:x:d
1
:
   ~
   a:3:b:c
   c:1:x:d
   e:2:a:f

a:3:b:c
e:2:a:f
c:1:x:d
3
:
   ~
   e:2:a:f
   a:3:b:c
   c:1:x:d

';

sub test {
  (@test)=@_;
  $sep   = pop(@test);
  $n     = pop(@test);

  $i=1;
  %hash=map { $i++ => $_ } @test;
  @tmp=(1..$i-1);
  sort_line(\@tmp,$n,$sep,%hash);
  @test=map { $hash{$_} } @tmp;
  return @test;
}

print "Line (hash)...\n";
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


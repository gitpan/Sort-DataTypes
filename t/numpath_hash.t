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
\.
~
  a.2.c
  a.11.c

';

sub test {
  (@test)=@_;
  if ($test[$#test] eq "SEP") {
    pop(@test);
    $i=1;
    %hash=map { $i++ => $_ } @test;
    @tmp=(1..$i-1);
    sort_numpath(\@tmp,%hash);
    @test=map { $hash{$_} } @tmp;
    return @test;
  } else {
    $sep = pop(@test);
    $i=1;
    %hash=map { $i++ => $_ } @test;
    @tmp=(1..$i-1);
    sort_numpath(\@tmp,$sep,%hash);
    @test=map { $hash{$_} } @tmp;
    return @test;
  }
  return @test;
}

print "NumPath (hash)...\n";
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


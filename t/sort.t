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
alphabetic
foo
bar
zed
   ~
   bar
   foo
   zed

rev_date
Jul 4 2000
May 31 2000
Dec 31 1999
Jan 3 2001
~
  Jan 3 2001
  Jul 4 2000
  May 31 2000
  Dec 31 1999

domain
aaa.bbb
aa.bbb
--
\.
~
  aa.bbb
  aaa.bbb

rev_domain
aaa::bbb::ccc
bbb::ccc
aaa::ccc
--
::
~
  aaa::bbb::ccc
  bbb::ccc
  aaa::ccc

';

sub test {
  ($method,@test) = @_;
  my(@list,@args) = ();
  my($args)       = 0;

  foreach my $ele (@test) {
     if ($args) {
        push(@args,$ele);
     } elsif ($ele eq "--") {
        $args = 1;
     } else {
        push(@list,$ele);
     }
  }

  sort_by_method($method,\@list,@args);
  return @list;
}

print "Sort...\n";
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


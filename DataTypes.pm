package Sort::DataTypes;
# Copyright (c) 2007-2007 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

###############################################################################
# HISTORY
###############################################################################

# Version 1.00  2007-09-05
#    Initial release
#
# Version 1.01  2007-09-19
#    Added separator to domain sorting.
#    Added numdomain and numpath sorting.
#    Added line and numline sorting.
#    Added sort_valid_method and sort_by_method routines.

$VERSION = "1.01";
###############################################################################

require 5.000;
require Exporter;
use Carp;
use Date::Manip;
Date_Init();

@ISA = qw(Exporter);
@EXPORT_OK = qw(sort_valid_method
                sort_by_method
                sort_numerical  sort_rev_numerical
                sort_alphabetic sort_rev_alphabetic
                sort_ip         sort_rev_ip
                sort_domain     sort_rev_domain
                sort_numdomain  sort_rev_numdomain
                sort_random     sort_rev_random
                sort_version    sort_rev_version
                sort_date       sort_rev_date
                sort_length     sort_rev_length
                sort_path       sort_rev_path
                sort_numpath    sort_rev_numpath
                sort_line       sort_rev_line
                sort_numline    sort_rev_numline
               );
%EXPORT_TAGS = (all => \@EXPORT_OK);

@methods = qw(numerical  rev_numerical
              alphabetic rev_alphabetic
              ip         rev_ip
              domain     rev_domain
              numdomain  rev_numdomain
              random     rev_random
              version    rev_version
              date       rev_date
              length     rev_length
              path       rev_path
              numpath    rev_numpath
              line       rev_line
              numline    rev_numline);
use vars qw(%methods);
%methods = map { $_,1 } @methods;

use strict;
###############################################################################

=pod

=head1 NAME

Sort::DataTypes - Sort a list of data using methods relevant to the type of data

=head1 SYNOPSIS

   use Sort::DataTypes qw(:all);

=head1 DESCRIPTION

This allows you to sort a list of data elements using methods that are
relevant to the type of data it is.

=head1 ROUTINES

=over 4

=cut

###############################################################################
###############################################################################
=pod

=item sort_valid_method

  use Sort::DataTypes qw(:all)

  $flag = sort_valid_method($string);

This returns 1 if there is a valid sort method named $string in the
module. For example:

  sort_valid_method("numerical")
     => 1

  sort_valid_method("foobar")
     => 0

=cut

sub sort_valid_method {
   my($method) = @_;
   return (exists $methods{$method} ? 1 : 0);
}

=item sort_by_method

  use Sort::DataTypes qw(:all)

  sort_by_method($method,\@list [,@args]);

This sorts a list using the given method (which is any string which
returns 1 when passed to sort_valid_method. @args are arguments to
pass to the sort.

If the method is not valid, the list is left untouched.

=cut

sub sort_by_method {
   my($method,$list,@args) = @_;

   return  if (! sort_valid_method($method));

   if      ($method eq "numerical") {
      sort_numerical($list,@args);
   } elsif ($method eq "rev_numerical") {
      sort_rev_numerical($list,@args);

   } elsif ($method eq "alphabetic") {
      sort_alphabetic($list,@args);
   } elsif ($method eq "rev_alphabetic") {
      sort_rev_alphabetic($list,@args);

   } elsif ($method eq "length") {
      sort_length($list,@args);
   } elsif ($method eq "rev_length") {
      sort_rev_length($list,@args);

   } elsif ($method eq "ip") {
      sort_ip($list,@args);
   } elsif ($method eq "rev_ip") {
      sort_rev_ip($list,@args);

   } elsif ($method eq "domain") {
      sort_domain($list,@args);
   } elsif ($method eq "rev_domain") {
      sort_rev_domain($list,@args);

   } elsif ($method eq "numdomain") {
      sort_numdomain($list,@args);
   } elsif ($method eq "rev_numdomain") {
      sort_rev_numdomain($list,@args);

   } elsif ($method eq "path") {
      sort_path($list,@args);
   } elsif ($method eq "rev_path") {
      sort_rev_path($list,@args);

   } elsif ($method eq "numpath") {
      sort_numpath($list,@args);
   } elsif ($method eq "rev_numpath") {
      sort_rev_numpath($list,@args);

   } elsif ($method eq "random") {
      sort_random($list,@args);
   } elsif ($method eq "rev_random") {
      sort_rev_random($list,@args);

   } elsif ($method eq "version") {
      sort_version($list,@args);
   } elsif ($method eq "rev_version") {
      sort_rev_version($list,@args);

   } elsif ($method eq "date") {
      sort_date($list,@args);
   } elsif ($method eq "rev_date") {
      sort_rev_date($list,@args);

   } elsif ($method eq "line") {
      sort_line($list,@args);
   } elsif ($method eq "rev_line") {
      sort_rev_line($list,@args);

   } elsif ($method eq "numline") {
      sort_numline($list,@args);
   } elsif ($method eq "rev_numline") {
      sort_rev_numline($list,@args);
   }
}

###############################################################################
=pod

=item sort_numerical, sort_rev_numerical, sort_alphabetic, sort_rev_alphabetic

  use Sort::DataTypes qw(:all)

  sort_numerical(\@list);
  sort_rev_numerical(\@list);

These sorts a list numerically or alphabetically (normal or reverse). There's
little reason to use these... but are included for the sake of completeness.

  sort_numerical(\@list,%hash);
  sort_rev_numerical(\@list,%hash);

These sort a list based on a hash. Every element in @list has a key in %hash,
and the values of those keys determine the order of the list elements. They
are sorted alphabetically or numerically.

=cut

sub sort_numerical {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { $hash{$a} <=> $hash{$b}  ||  $hash{$a} cmp $hash{$b} } @$list;
   } else {
      @$list = sort { $a <=> $b  ||  $a cmp $b } @$list;
   }
}

sub sort_rev_numerical {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { $hash{$b} <=> $hash{$a}  ||  $hash{$b} cmp $hash{$a} } @$list;
   } else {
      @$list = sort { $b <=> $a  ||  $b cmp $a } @$list;
   }
}

sub sort_alphabetic {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { $hash{$a} cmp $hash{$b} } @$list;
   } else {
      @$list = sort { $a cmp $b } @$list;
   }
}

sub sort_rev_alphabetic {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { $hash{$b} cmp $hash{$a} } @$list;
   } else {
      @$list = sort { $b cmp $a } @$list;
   }
}

###############################################################################
=pod

=item sort_length, sort_rev_length

  use Sort::DataTypes qw(:all)

  sort_length(\@list);
  sort_rev_length(\@list);

  sort_length(\@list,%hash);
  sort_rev_length(\@list,%hash);

These sorts a list of strings by length.

=cut

sub sort_length {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { length($hash{$a}) <=> length($hash{$b})  ||
                      $hash{$a} cmp $hash{$b}
                    } @$list;
   } else {
      @$list = sort { length($a) <=> length($b) ||  $a cmp $b } @$list;
   }
}

sub sort_rev_length {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { length($hash{$b}) <=> length($hash{$a})  ||
                      $hash{$b} cmp $hash{$a}
                    } @$list;
   } else {
      @$list = sort { length($b) <=> length($a)  ||
                      $b cmp $a
                    } @$list;
   }
}

###############################################################################
=pod

=item sort_ip, sort_rev_ip

  use Sort::DataTypes qw(:all)

  sort_ip(\@list);
  sort_rev_ip(\@list);

  sort_ip(\@list,%hash);
  sort_rev_ip(\@list,%hash);

These sorts a list A.B.C.D IP numbers.

=cut

sub sort_ip {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { _cmp_ip($hash{$a},$hash{$b}) } @$list;
   } else {
      @$list = sort { _cmp_ip($a,$b) } @$list;
   }
}

sub sort_rev_ip {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { _cmp_ip($hash{$b},$hash{$a}) } @$list;
   } else {
      @$list = sort { _cmp_ip($b,$a) } @$list;
   }
}

sub _cmp_ip {
   my($a,$b) = @_;
   my(@a,@b);
   (@a)=split('\.',$a);
   (@b)=split('\.',$b);
   return ($a[0] <=> $b[0]  ||
           $a[1] <=> $b[1]  ||
           $a[2] <=> $b[2]  ||
           $a[3] <=> $b[3]);
}

###############################################################################
=pod

=item sort_domain, sort_rev_domain, sort_numdomain, sort_rev_numdomain

  use Sort::DataTypes qw(:all)

  sort_domain(\@list [,$sep]);
  sort_rev_domain(\@list [,$sep]);

  sort_domain(\@list [,$sep] ,%hash);
  sort_rev_domain(\@list [,$sep] ,%hash);

This sorts domain names (A.B.C...) or anything else consisting of a class,
subclass, subsubclass, etc., with the most significant class at the right.

Elements in the domain are separated from each other by a period (.)
unless $sep is passed in. If $sep is passed in, it is a regular expression
to split the elements in a domain.

Since the most significan element in the domain is at the right, any
domain ending with ".com" would come before any domain ending in ".edu".

  a.b < z.b < a.bb < z.bb < a.c

A related type of sorting is:

  sort_numdomain(\@list [,$sep]);
  sort_rev_numdomain(\@list [,$sep]);

  sort_numdomain(\@list [,$sep] ,%hash);
  sort_rev_numdomain(\@list [,$sep] ,%hash);

numdomain sorting is identical to domain sorting except that if two
elements in the domain are integers, numerical sorts will be done. So:

  a.11.c < a.2.c

=cut

{
   my $S;
   my $N = 0;

   sub sort_domain {
      my($list,@arg) = @_;
      if (! @arg  ||  ($#arg % 2) == 1) {
         $S = '\.';
      } else {
         $S = shift(@arg);
      }
      my %hash = @arg;

      if (%hash) {
         @$list = sort { _cmp_domain($hash{$a},$hash{$b}) } @$list;
      } else {
         @$list = sort { _cmp_domain($a,$b) } @$list;
      }
   }

   sub sort_numdomain {
      $N = 1;
      my @ret = sort_domain(@_);
      $N = 0;
      @ret;
   }

   sub sort_rev_domain {
      my($list,@arg) = @_;
      if (! @arg  ||  ($#arg % 2) == 1) {
         $S = '\.';
      } else {
         $S = shift(@arg);
      }
      my %hash = @arg;

      if (%hash) {
         @$list = sort { _cmp_domain($hash{$b},$hash{$a}) } @$list;
      } else {
         @$list = sort { _cmp_domain($b,$a) } @$list;
      }
   }

   sub sort_rev_numdomain {
      $N = 1;
      my @ret = sort_rev_domain(@_);
      $N = 0;
      @ret;
   }

   sub _cmp_domain {
      my($a,$b) = @_;
      my(@a,@b);
      (@a)=split(/$S/,$a);
      (@b)=split(/$S/,$b);

      while (@a) {
         return 1  if (! @b);
         my $aa  = pop(@a);
         my $bb  = pop(@b);

         my $ret;
         if ($N  &&  $aa =~ /^\d+$/  &&  $bb =~ /^\d+$/) {
            $ret = ($aa <=> $bb);
         } else {
            $ret = ($aa cmp $bb);
         }
         return $ret  if ($ret);
      }
      return -1  if (@b);
      return  0;
   }
}

###############################################################################
=pod

=item sort_path, sort_rev_path, sort_numpath, sort_rev_numpath

  use Sort::DataTypes qw(:all)

  sort_path(\@list [,$sep]);
  sort_rev_path(\@list [,$sep]);

  sort_path(\@list [,$sep] ,%hash);
  sort_rev_path(\@list [,$sep] ,%hash);

This sorts paths (/A/B/C...) or anything else consisting of a class,
subclass, subsubclass, etc., with the most significant class at the left.

Elements in a path are separated from each other by a slash (/) unless
$sep is passed in. If $sep is passed in, it is a regular expression to
split the elements in a path.

Since the most significan element in the domain is at the left, you
get the following behavior:

  a/b < a/z < aa/b < aa/z < b/b

A related type of sorting is:

  sort_numpath(\@list [,$sep]);
  sort_rev_numpath(\@list [,$sep]);

  sort_numpath(\@list [,$sep] ,%hash);
  sort_rev_numpath(\@list [,$sep] ,%hash);

numpath sorting is identical to path sorting except that if two
elements in the path are integers, numerical sorts will be done. So:

  a/2/c < a/11/c

=cut

{
   my $S;
   my $N = 0;

   sub sort_path {
      my($list,@arg) = @_;
      if (! @arg  ||  ($#arg % 2) == 1) {
         $S = '\.';
      } else {
         $S = shift(@arg);
      }
      my %hash = @arg;

      if (%hash) {
         @$list = sort { _cmp_path($hash{$a},$hash{$b}) } @$list;
      } else {
         @$list = sort { _cmp_path($a,$b) } @$list;
      }
   }

   sub sort_numpath {
      $N = 1;
      my @ret = sort_path(@_);
      $N = 0;
      @ret;
   }

   sub sort_rev_path {
      my($list,@arg) = @_;
      if (! @arg  ||  ($#arg % 2) == 1) {
         $S = '\.';
      } else {
         $S = shift(@arg);
      }
      my %hash = @arg;

      if (%hash) {
         @$list = sort { _cmp_path($hash{$b},$hash{$a}) } @$list;
      } else {
         @$list = sort { _cmp_path($b,$a) } @$list;
      }
   }

   sub sort_rev_numpath {
      $N = 1;
      my @ret = sort_rev_path(@_);
      $N = 0;
      @ret;
   }

   sub _cmp_path {
      my($a,$b) = @_;
      my(@a,@b);
      (@a)=split(/$S/,$a);
      (@b)=split(/$S/,$b);

      while (@a) {
         return 1  if (! @b);
         my $aa  = shift(@a);
         my $bb  = shift(@b);

         my $ret;
         if ($N  &&  $aa =~ /^\d+$/  &&  $bb =~ /^\d+$/) {
            $ret = ($aa <=> $bb);
         } else {
            $ret = ($aa cmp $bb);
         }
         return $ret  if ($ret);
      }
      return -1  if (@b);
      return  0;
   }
}

###############################################################################
=pod

=item sort_random, sort_rev_random

  use Sort::DataTypes qw(:all)

  sort_random(\@list);
  sort_rev_random(\@list);

  sort_random(\@list,%hash);
  sort_rev_random(\@list,%hash);

This uses the Fisher-Yates algorithm to randomly shuffle an array in place.
This routine was taken from the book

  The Perl Cookbook
  Tom Christiansen and Nathan Torkington

The sort_rev_random is identical, and is included simply for the situation
where the sort routines are being called in some automatically generated
code that may add the 'rev_' prefix.

=cut

# This routine was taken from The Perl Cookbook
sub sort_random {
   my($list,%hash) = @_;
   _randomize();

   my $i;
   for ($i = @$list; --$i; ) {
      my $j = int rand ($i+1);
      next if $i == $j;
      @$list[$i,$j] = @$list[$j,$i];
   }
}
sub sort_rev_random {
   sort_random(@_);
}

{
   my $randomized = 0;

   sub _randomize {
      return  if ($randomized);
      $randomized = 1;
      srand(time);
   }
}

###############################################################################
=pod

=item sort_version, sort_rev_version

  use Sort::DataTypes qw(:all)

  sort_version(\@list);
  sort_rev_version(\@list);

  sort_version(\@list,%hash);
  sort_rev_version(\@list,%hash);

These sorts a list of version numbers of the form MAJOR.MINOR.SUBMINOR ...
(any number of levels are allowed). The following examples should illustrate
the ordering:

  1.1.x < 1.2 < 1.2.x  Numerical versions are compared first at
                       the highest level, then at the next highest,
                       etc. The first non-equal compare sets the
                       order.
  1.a < 1.b            Alphanumeric levels that start with a letter
                       are compared alphabetically.
  1.2a < 1.2 < 1.03a   Alphanumeric levels that start with a number
                       are first compared numerically with only the
                       numeric part. If they are equal, alphanumeric
                       levels come before purely numerical levels.
                       Otherwise, they are compared alphabetically.
  1.a < 1.2a           An alphanumeric level that starts with a letter
                       comes before one that starts with a number.
  1.01a < 1.1a         Two alphanumeric levels that are numerically
                       equal in the number part and equal in the
                       remaining part are compared alphabetically.

=cut

sub sort_version {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { _cmp_version($hash{$a},$hash{$b}) } @$list;
   } else {
      @$list = sort { _cmp_version($a,$b) } @$list;
   }
}

sub sort_rev_version {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { _cmp_version($hash{$b},$hash{$a}) } @$list;
   } else {
      @$list = sort { _cmp_version($b,$a) } @$list;
   }
}

sub _cmp_version {
   my($a,$b) = @_;
   my(@a,@b);
   (@a)=split(/\./,$a);
   (@b)=split(/\./,$b);

   while (@a) {
      return 1  if (! @b);
      my $aa=shift(@a);
      my $bb=shift(@b);

      if ($aa =~ /^(\d+)(.*)$/) {
         my($av,$as) = ($1+0,$2);
         if ($bb =~ /^(\d+)(.*)$/) {
            my($bv,$bs) = ($1+0,$2);
            my $ret = ($av <=> $bv);
            return $ret  if ($ret);
            return -1  if ($as && ! $bs);
            return  1  if ($bs && ! $as);
            $ret = ($aa cmp $bb);
            return $ret  if ($ret);
         } else {
            return 1;
         }
      } elsif ($bb =~ /^(\d+)(.*)$/) {
         return -1;
      } elsif ($aa || $bb) {
         my $ret=($aa cmp $bb);
         return $ret  if ($ret);
      }
   }
   return -1  if (@b);
   return  0;
}

###############################################################################
=pod

=item sort_date, sort_rev_date

  use Sort::DataTypes qw(:all)

  sort_date(\@list);
  sort_rev_date(\@list);

  sort_date(\@list,%hash);
  sort_rev_date(\@list,%hash);

These sorts a list of dates. Dates are anything that can be parsed
with Date::Manip.

=cut

sub sort_date {
   my($list,%hash) = @_;
   my(@list) = @$list;
   my %dates;
   if (%hash) {
      foreach my $key (keys %hash) {
         $dates{ ParseDate($hash{$key}) } = $key;
      }
   } else {
      foreach my $date (@list) {
         $dates{ ParseDate($date) } = $date;
      }
   }
   my @sorted = sort { Date_Cmp($a,$b) } keys %dates;
   @list = ();
   foreach my $date (@sorted) {
      push(@list,$dates{$date});
   }
   @$list=@list;
}

sub sort_rev_date {
   my($list,%hash) = @_;
   sort_date($list,%hash);
   @$list = reverse @$list;
}

###############################################################################
=pod

=item sort_line, sort_rev_line, sort_numline, sort_rev_numline

  use Sort::DataTypes qw(:all)

  sort_line(\@list,$n [,$sep]);
  sort_rev_line(\@list,$n [,$sep]);

  sort_line(\@list,$n [,$sep] ,%hash);
  sort_rev_line(\@list,$n [,$sep] ,%hash);

These take a list of lines and sort on the Nth field using $sep as the
regular expression splitting the lines into fields. If no $sep is
given, it defaults to white space.

  sort_numline(\@list,$n [,$sep]);
  sort_rev_numline(\@list,$n [,$sep]);

  sort_numline(\@list,$n [,$sep] ,%hash);
  sort_rev_numline(\@list,$n [,$sep] ,%hash);

These are similar but will sort numerically if the Nth field is an
integer, and alphabetically otherwise.

=cut

{
   my $S;
   my $N = 0;
   my $F;

   sub sort_line {
      my($list,$n,@arg) = @_;
      $F = $n;
      if (! @arg  ||  ($#arg % 2) == 1) {
         $S = '\s+';
      } else {
         $S = shift(@arg);
      }
      my %hash = @arg;

      if (%hash) {
         @$list = sort { _cmp_line($hash{$a},$hash{$b}) } @$list;
      } else {
         @$list = sort { _cmp_line($a,$b) } @$list;
      }
   }

   sub sort_numline {
      $N = 1;
      my @ret = sort_line(@_);
      $N = 0;
      @ret;
   }

   sub sort_rev_line {
      my($list,$n,@arg) = @_;
      $F = $n;
      if (! @arg  ||  ($#arg % 2) == 1) {
         $S = '\S+';
      } else {
         $S = shift(@arg);
      }
      my %hash = @arg;

      if (%hash) {
         @$list = sort { _cmp_line($hash{$b},$hash{$a}) } @$list;
      } else {
         @$list = sort { _cmp_line($b,$a) } @$list;
      }
   }

   sub sort_rev_numline {
      $N = 1;
      my @ret = sort_rev_line(@_);
      $N = 0;
      @ret;
   }

   sub _cmp_line {
      my($a,$b) = @_;
      my(@a,@b);
      (@a)=split(/$S/,$a);
      (@b)=split(/$S/,$b);

      my $aa  = (defined $a[$F-1] ? $a[$F-1] : "");
      my $bb  = (defined $b[$F-1] ? $b[$F-1] : "");

      my $ret = 0;
      if ($N  &&  $aa =~ /^\d+$/  &&  $bb =~ /^\d+$/) {
         $ret = ($aa <=> $bb);
      } else {
         $ret = ($aa cmp $bb);
      }
      return $ret;
   }
}

###############################################################################
###############################################################################
=pod

=back

=head1 KNOWN PROBLEMS

None at this point.

=head1 AUTHOR

Sullivan Beck (sbeck@cpan.org)

=cut

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

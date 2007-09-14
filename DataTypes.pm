package Sort::DataTypes;
# Copyright (c) 2007-2007 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

###############################################################################
# HISTORY
###############################################################################

# Version 1.00  2007-09-05
#    Initial release

$VERSION = "1.00";
###############################################################################

require 5.000;
require Exporter;
use Carp;
use Date::Manip;
Date_Init();

@ISA = qw(Exporter);
@EXPORT_OK = qw(sort_numerical  sort_rev_numerical
                sort_alphabetic sort_rev_alphabetic
                sort_ip         sort_rev_ip
                sort_domain     sort_rev_domain
                sort_random     sort_rev_random
                sort_version    sort_rev_version
                sort_date       sort_rev_date
                sort_length     sort_rev_length
                sort_path       sort_rev_path
               );
%EXPORT_TAGS = (all => \@EXPORT_OK);

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

=item sort_numerical, sort_rev_numerical, sort_alphabetic, sort_rev_alphabetic

  use Sort::DataTypes qw(:sort)

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

  use Sort::DataTypes qw(:sort)

  sort_length(\@list);
  sort_rev_length(\@list);

  sort_length(\@list,%hash);
  sort_rev_length(\@list,%hash);

These sorts a list of strings by length.

=cut

sub sort_length {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { length($hash{$a}) <=> length($hash{$b})  ||  $hash{$a} cmp $hash{$b} } @$list;
   } else {
      @$list = sort { length($a) <=> length($b) ||  $a cmp $b } @$list;
   }
}

sub sort_rev_length {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { length($hash{$b}) <=> length($hash{$a})  ||  $hash{$b} cmp $hash{$a} } @$list;
   } else {
      @$list = sort { length($b) <=> length($a) ||  $b cmp $a } @$list;
   }
}

###############################################################################
=pod

=item sort_ip, sort_rev_ip

  use Sort::DataTypes qw(:sort)

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

sub sort_rev_ip {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { _cmp_ip($hash{$b},$hash{$a}) } @$list;
   } else {
      @$list = sort { _cmp_ip($b,$a) } @$list;
   }
}

###############################################################################
=pod

=item sort_domain, sort_rev_domain

  use Sort::DataTypes qw(:sort)

  sort_domain(\@list);
  sort_rev_domain(\@list);

  sort_domain(\@list,%hash);
  sort_rev_domain(\@list,%hash);

These sorts a list A.B.C.D... domain names. It is done starting with the last
element in the domain, so foo.com comes before bar.edu.

=cut

sub sort_domain {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { _cmp_domain($hash{$a},$hash{$b}) } @$list;
   } else {
      @$list = sort { _cmp_domain($a,$b) } @$list;
   }
}

sub _cmp_domain {
   my($a,$b) = @_;
   my(@a,@b);
   (@a)=split('\.',$a);
   (@b)=split('\.',$b);
   
   while (@a) {
      return 1  if (! @b);
      my $aa=pop(@a);
      my $bb=pop(@b);

      my $ret = ($aa cmp $bb);
      return $ret  if ($ret);
   }
   return -1  if (@b);
   return  0;
}

sub sort_rev_domain {
   my($list,%hash) = @_;
   if (%hash) {
      @$list = sort { _cmp_domain($hash{$b},$hash{$a}) } @$list;
   } else {
      @$list = sort { _cmp_domain($b,$a) } @$list;
   }
}

###############################################################################
=pod

=item sort_path, sort_rev_path

  use Sort::DataTypes qw(:sort)

  sort_path(\@list,$sep);
  sort_rev_path(\@list,$sep);

  sort_path(\@list,$sep,%hash);
  sort_rev_path(\@list,$sep,%hash);

These sort anything in a path-type structure. This could include file paths,
classes, etc.

A "path" in of the form "A.B.C..." where any separator string can be used
to separate elements in the path. If $sep is passed in, it is the separator
to use. If not passed in, it defaults to "/".

=cut

{
   my $S;

   sub sort_path {
      my($list,$sep,%hash) = @_;
      $sep = "/"  if (! $sep);
      $S = $sep;
      if (%hash) {
         @$list = sort { _cmp_path($hash{$a},$hash{$b}) } @$list;
      } else {
         @$list = sort { _cmp_path($a,$b) } @$list;
      }
   }

   sub _cmp_path {
      my($a,$b) = @_;
      my(@a,@b);
      (@a)=split("\Q$S\E",$a);
      (@b)=split("\Q$S\E",$b);

      while (@a) {
         return 1  if (! @b);
         my $aa=shift(@a);
         my $bb=shift(@b);

         my $ret = ($aa cmp $bb);
         return $ret  if ($ret);
      }
      return -1  if (@b);
      return  0;
   }

   sub sort_rev_path {
      my($list,$sep,%hash) = @_;
      $sep = "/"  if (! $sep);
      $S = $sep;
      if (%hash) {
         @$list = sort { _cmp_path($hash{$b},$hash{$a}) } @$list;
      } else {
         @$list = sort { _cmp_path($b,$a) } @$list;
      }
   }
}

###############################################################################
=pod

=item sort_random, sort_rev_random

  use Sort::DataTypes qw(:sort)

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

  use Sort::DataTypes qw(:sort)

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

  use Sort::DataTypes qw(:sort)

  sort_date(\@list);
  sort_rev_date(\@list);

  sort_date(\@list,%hash);
  sort_rev_date(\@list,%hash);

These sorts a list of dates.

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
# indent-tabs-mode: nil
# End:

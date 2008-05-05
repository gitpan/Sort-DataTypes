package Sort::DataTypes;
# Copyright (c) 2007-2008 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

###############################################################################

$VERSION = "2.01";

require 5.000;
require Exporter;
use warnings;
use Date::Manip;
Date_Init();

@ISA = qw(Exporter);
@EXPORT_OK =
  qw(sort_valid_method
     sort_by_method
     sort_numerical  sort_rev_numerical
     sort_alphabetic sort_rev_alphabetic
     sort_ip         sort_rev_ip
     sort_domain     sort_rev_domain      sort_numdomain  sort_rev_numdomain
     sort_random     sort_rev_random
     sort_version    sort_rev_version
     sort_date       sort_rev_date
     sort_length     sort_rev_length
     sort_path       sort_rev_path        sort_numpath    sort_rev_numpath
     sort_line       sort_rev_line        sort_numline    sort_rev_numline
     sort_function   sort_rev_function
     cmp_valid_method
     cmp_by_method
     cmp_numerical   cmp_rev_numerical
     cmp_alphabetic  cmp_rev_alphabetic
     cmp_ip          cmp_rev_ip
     cmp_domain      cmp_rev_domain       cmp_numdomain   cmp_rev_numdomain
     cmp_random      cmp_rev_random
     cmp_version     cmp_rev_version
     cmp_date        cmp_rev_date
     cmp_length      cmp_rev_length
     cmp_path        cmp_rev_path         cmp_numpath     cmp_rev_numpath
     cmp_line        cmp_rev_line         cmp_numline     cmp_rev_numline
     cmp_function    cmp_rev_function
   );
%EXPORT_TAGS = (all => \@EXPORT_OK);

@methods =
  qw(numerical       rev_numerical
     alphabetic      rev_alphabetic
     ip              rev_ip
     domain          rev_domain           numdomain  rev_numdomain
     random          rev_random
     version         rev_version
     date            rev_date
     length          rev_length
     path            rev_path             numpath    rev_numpath
     line            rev_line             numline    rev_numline
     function        rev_function
   );
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
relevant to the type of data it is. This modules does not attempt to
be the fastest sorter on the block. If you are sorting thousands of
elements and need a lot of speed, you should refer to a module
specializing in the specific type of sort you will be doing. However,
to do smaller sorts of different types of data, this is the module to
use.

=head1 ROUTINES

All sort routines are named sort_METHOD where METHOD is the name of
the method. All sort_METHOD have both a forward and reverse sort:

  sort_METHOD(\@list,@args);
  sort_rev_METHOD(\@list,@args);

where @args are any additional arguments needed for that sort method.

Corresponding to every sort_METHOD routine is a cmp_METHOD routine
which takes two elements (and possibly additional arguments as
required by the actual method) and returns a -1, 0, or 1 (similar to
the cmp or <=> operators).

  $flag = cmp_METHOD($x,$y,@args);
  $flag = cmp_rev_METHOD($x,$y,@args);

All sort_METHOD functions can also be used to sort a list using a
hash:

  sort_METHOD(\@list,[@args],\%hash);
  sort_rev_METHOD(\@list,[@args],\%hash);

In this case, elements of @list are used as keys in %hash. The values
of the hash are compared using the cmp_METHOD function to sort the
keys in @list.

For example, if %hash contains the key/value pairs:

  foo => 3
  bar => 5
  ick => 1

and @list contains (foo,bar,ick), then sorting:

  sort_numerical(\@list,%hash)
    => @list = (ick,foo,bar)

since "ick" corresponds to a numerical value of 1, "foo" to 3, and
"bar" to 5.

=cut

###############################################################################
###############################################################################
=pod

=over 4

=item sort_valid_method, cmp_valid_method

  use Sort::DataTypes qw(:all)

  $flag = sort_valid_method($string);
  $flag = cmp_valid_method($string);

These are identical and return 1 if there is a valid sort method named
$string in the module. For example, there is a function
"sort_numerical" defined in this modules, but there is no function
"sort_foobar", so the following would occur:

  sort_valid_method("numerical")
     => 1

  sort_valid_method("foobar")
     => 0

Note that the methods must NOT include the "sort_" or "cmp_" prefix.

=cut

sub sort_valid_method {
   my($method) = @_;
   return (exists $methods{$method} ? 1 : 0);
}

sub cmp_valid_method {
   my($method) = @_;
   return (exists $methods{$method} ? 1 : 0);
}

=item sort_by_method, cmp_by_method

  use Sort::DataTypes qw(:all)

  sort_by_method($method,\@list [,@args]);
  cmp_by_method ($method,$ele1,$ele2 [,@args]);

These sort a list, or compare two elements, using the given method
(which is any string which returns 1 when passed to
sort_valid_method. @args are arguments to pass to the sort.

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

sub cmp_by_method {
   my($method,$list,@args) = @_;

   return  if (! cmp_valid_method($method));

   if      ($method eq "numerical") {
      cmp_numerical($list,@args);
   } elsif ($method eq "rev_numerical") {
      cmp_rev_numerical($list,@args);

   } elsif ($method eq "alphabetic") {
      cmp_alphabetic($list,@args);
   } elsif ($method eq "rev_alphabetic") {
      cmp_rev_alphabetic($list,@args);

   } elsif ($method eq "length") {
      cmp_length($list,@args);
   } elsif ($method eq "rev_length") {
      cmp_rev_length($list,@args);

   } elsif ($method eq "ip") {
      cmp_ip($list,@args);
   } elsif ($method eq "rev_ip") {
      cmp_rev_ip($list,@args);

   } elsif ($method eq "domain") {
      cmp_domain($list,@args);
   } elsif ($method eq "rev_domain") {
      cmp_rev_domain($list,@args);

   } elsif ($method eq "numdomain") {
      cmp_numdomain($list,@args);
   } elsif ($method eq "rev_numdomain") {
      cmp_rev_numdomain($list,@args);

   } elsif ($method eq "path") {
      cmp_path($list,@args);
   } elsif ($method eq "rev_path") {
      cmp_rev_path($list,@args);

   } elsif ($method eq "numpath") {
      cmp_numpath($list,@args);
   } elsif ($method eq "rev_numpath") {
      cmp_rev_numpath($list,@args);

   } elsif ($method eq "random") {
      cmp_random($list,@args);
   } elsif ($method eq "rev_random") {
      cmp_rev_random($list,@args);

   } elsif ($method eq "version") {
      cmp_version($list,@args);
   } elsif ($method eq "rev_version") {
      cmp_rev_version($list,@args);

   } elsif ($method eq "date") {
      cmp_date($list,@args);
   } elsif ($method eq "rev_date") {
      cmp_rev_date($list,@args);

   } elsif ($method eq "line") {
      cmp_line($list,@args);
   } elsif ($method eq "rev_line") {
      cmp_rev_line($list,@args);

   } elsif ($method eq "numline") {
      cmp_numline($list,@args);
   } elsif ($method eq "rev_numline") {
      cmp_rev_numline($list,@args);
   }
}

###############################################################################
=pod

=item sort_numerical, sort_rev_numerical, cmp_numerical, cmp_rev_numerical

  use Sort::DataTypes qw(:all)

  sort_numerical(\@list);
  sort_rev_numerical(\@list);

  sort_numerical(\@list,\%hash);
  sort_rev_numerical(\@list,\%hash);

  $flag = cmp_numerical($x,$y);
  $flag = cmp_rev_numerical($x,$y);

These sorts a list numerically in forward or reverse order, or compare two
elements numerically. There is little reason to use either of these
routines (it would be more efficient to simply call sort as:

  sort { $a <=> $b } @list

but they are included for the sake of completeness (and for use by the
sort_by_method/cmp_by_method routines). Also, if the code is being
automatically generated, numerical sorts won't have to be a special
case.

=cut

sub sort_numerical {
   my($list,$hash) = @_;
   if (defined $hash) {
      @$list = sort { cmp_numerical($$hash{$a},$$hash{$b}) ||
                      $a cmp $b
                    } @$list;
   } else {
      @$list = sort { cmp_numerical($a,$b) } @$list;
   }
}

sub cmp_numerical {
   my($x,$y) = @_;
   return ($x <=> $y);
}

sub sort_rev_numerical {
   my($list,@args) = @_;
   sort_numerical($list,@args);
   @$list = reverse @$list;
}

sub cmp_rev_numerical {
   my($x,$y) = @_;
   return cmp_numerical($y,$x);
}

###############################################################################
=pod

=item sort_alphabetic, sort_rev_alphabetic, cmp_alphabetic, cmp_rev_alphabetic

  use Sort::DataTypes qw(:all)

  sort_alphabetic(\@list);
  sort_rev_alphabetic(\@list);

  sort_alphabetic(\@list,\%hash);
  sort_rev_alphabetic(\@list,\%hash);

  $flag = cmp_alphabetic($x,$y);
  $flag = cmp_rev_alphabetic($x,$y);

These do alphabetic sorts. As with numerical sorts, there is little reason
to call these, and they are included for the sake of completeness.

=cut

sub sort_alphabetic {
   my($list,$hash) = @_;
   if (defined $hash) {
      @$list = sort { cmp_alphabetic($$hash{$a},$$hash{$b}) ||
                      $a cmp $b
                    } @$list;
   } else {
      @$list = sort { cmp_alphabetic($a,$b) } @$list;
   }
}

sub cmp_alphabetic {
   my($x,$y) = @_;
   return ($x cmp $y);
}

sub sort_rev_alphabetic {
   my($list,@args) = @_;
   sort_alphabetic($list,@args);
   @$list = reverse @$list;
}

sub cmp_rev_alphabetic {
   my($x,$y) = @_;
   return ($y <=> $x);
}

###############################################################################
=pod

=item sort_length, sort_rev_length, cmp_length, cmp_rev_length

  use Sort::DataTypes qw(:all)

  sort_length(\@list);
  sort_rev_length(\@list);

  sort_length(\@list,\%hash);
  sort_rev_length(\@list,\%hash);

  $flag = cmp_length($x,$y);
  $flag = cmp_rev_length($x,$y);

These take strings and compare them by length and alphabetically if they
are the same length.

=cut

sub sort_length {
   my($list,$hash) = @_;
   if (defined $hash) {
      @$list = sort { cmp_length($$hash{$a},$$hash{$b}) ||
                      $a cmp $b
                    } @$list;
   } else {
      @$list = sort { cmp_length($a,$b) } @$list;
   }
}

sub cmp_length {
   my($x,$y) = @_;
   return ( length($x) <=> length($y)  ||
            $x cmp $y );
}

sub sort_rev_length {
   my($list,@args) = @_;
   sort_length($list,@args);
   @$list = reverse @$list;
}

sub cmp_rev_length {
   my($x,$y) = @_;
   return ($y <=> $x);
}

###############################################################################
=pod

=item sort_ip, sort_rev_ip, cmp_ip, cmp_rev_ip

  use Sort::DataTypes qw(:all)

  sort_ip(\@list);
  sort_rev_ip(\@list);

  sort_ip(\@list,\%hash);
  sort_rev_ip(\@list,\%hash);

  $flag = cmp_ip($x,$y);
  $flag = cmp_rev_ip($x,$y);

These sort/compare IP numbers of the form A.B.C.D.

=cut

sub sort_ip {
   my($list,$hash) = @_;
   if (defined $hash) {
      @$list = sort { cmp_ip($$hash{$a},$$hash{$b}) ||
                      $a cmp $b
                    } @$list;
   } else {
      @$list = sort { cmp_ip($a,$b) } @$list;
   }
}

sub cmp_ip {
   my($x,$y) = @_;
   my(@x,@y);
   (@x)=split('\.',$x);
   (@y)=split('\.',$y);
   return ($x[0] <=> $y[0]  ||
           $x[1] <=> $y[1]  ||
           $x[2] <=> $y[2]  ||
           $x[3] <=> $y[3]);
}

sub sort_rev_ip {
   my($list,@args) = @_;
   sort_ip($list,@args);
   @$list = reverse @$list;
}

sub cmp_rev_ip {
   my($x,$y) = @_;
   return ($y <=> $x);
}

###############################################################################
=pod

=item sort_domain, sort_rev_domain, cmp_domain, cmp_rev_domain

  use Sort::DataTypes qw(:all)

  sort_domain(\@list [,$sep]);
  sort_rev_domain(\@list [,$sep]);

  sort_domain(\@list, [$sep,] \%hash);
  sort_rev_domain(\@list, [$sep,] \%hash);

  $flag = cmp_domain($x,$y [,$sep]);
  $flag = cmp_rev_domain($x,$y [,$sep]);

These sort domain names (A.B.C...) or anything else consisting of a class,
subclass, subsubclass, etc., with the most significant class at the right.

Elements in the domain are separated from each other by a period (.)
unless $sep is passed in. If $sep is passed in, it is a regular expression
to split the elements in a domain.

Since the most significan element in the domain is at the right, any
domain ending with ".com" would come before any domain ending in ".edu".

  a.b < z.b < a.bb < z.bb < a.c

=item sort_numdomain, sort_rev_numdomain, cmp_numdomain, cmp_rev_numdomain

  use Sort::DataTypes qw(:all)

  sort_numdomain(\@list [,$sep]);
  sort_rev_numdomain(\@list [,$sep]);

  sort_numdomain(\@list, [$sep,] \%hash);
  sort_rev_numdomain(\@list, [$sep,] \%hash);

  $flag = cmp_numdomain($x,$y [,$sep]);
  $flag = cmp_rev_numdomain($x,$y [,$sep]);

A related type of sorting is numdomain sorting. This is identical to
domain sorting except that if two elements in the domain are integers,
numerical sorts will be done. So:

  a.2.c < a.11.c

=cut

{
   my $S;
   my $N = 0;

   sub sort_domain {
      my($list,@arg) = @_;
      my($hash);
      if ($#arg == 1) {
         ($S,$hash) = @arg;
      } elsif ($#arg == 0  &&  ! ref($arg[0])) {
         $S = $arg[0];
      } else {
         $hash = $arg[0]  if (@arg);
         $S = '\.';
      }

      if (defined $hash) {
         @$list = sort { cmp_domain($$hash{$a},$$hash{$b}) ||
                           $a cmp $b
                        } @$list;
      } else {
         @$list = sort { cmp_domain($a,$b) } @$list;
      }
   }

   sub cmp_domain {
      my($x,$y,$sep) = @_;
      $S = $sep  if (defined $sep);
      $S = '\.'  if ($S eq "");
      my(@x,@y);
      (@x)=split(/$S/,$x);
      (@y)=split(/$S/,$y);

      while (@x) {
         return 1  if (! @y);
         my $xx  = pop(@x);
         my $yy  = pop(@y);

         my $ret;
         if ($N  &&  $xx =~ /^\d+$/  &&  $yy =~ /^\d+$/) {
            $ret = ($xx <=> $yy);
         } else {
            $ret = ($xx cmp $yy);
         }
         return $ret  if ($ret);
      }
      return -1  if (@y);
      return  0;
   }

   sub sort_rev_domain {
      my($list,@args) = @_;
      sort_domain($list,@args);
      @$list = reverse @$list;
   }

   sub cmp_rev_domain {
      my($x,$y,@args) = @_;
      return cmp_domain($y,$x,@args);
   }

   sub sort_numdomain {
      $N = 1;
      my @ret = sort_domain(@_);
      $N = 0;
      @ret;
   }

   sub cmp_numdomain {
      $N = 1;
      my $ret = cmp_domain(@_);
      $N = 0;
      $ret;
   }

   sub sort_rev_numdomain {
      my($list,@args) = @_;
      sort_numdomain($list,@args);
      @$list = reverse @$list;
   }

   sub cmp_rev_numdomain {
      my($x,$y,@args) = @_;
      return cmp_numdomain($y,$x,@args);
   }
}

###############################################################################
=pod

=item sort_path, sort_rev_path, cmp_path, cmp_rev_path

  use Sort::DataTypes qw(:all)

  sort_path(\@list [,$sep]);
  sort_rev_path(\@list [,$sep]);

  sort_path(\@list, [$sep,] \%hash);
  sort_rev_path(\@list, [$sep,] \%hash);

  $flag = cmp_path($x,$y [,$sep]);
  $flag = cmp_rev_path($x,$y [,$sep]);

This sorts paths (/A/B/C...) or anything else consisting of a class,
subclass, subsubclass, etc., with the most significant class at the left.

Elements in a path (or classes, subclasses, etc.) are separated from
each other by a slash (/) unless $sep is passed in. If $sep is passed
in, it is a regular expression to split the elements in a path.

Since the most significant element in the domain is at the left, you
get the following behavior:

  a/b < a/z < aa/b < aa/z < b/b

When sorting lists that have a mixture of relative paths and
explicit paths, the explicit paths will come first. So:

  /b/c < a/b

=item sort_numpath, sort_rev_numpath, cmp_numpath, cmp_rev_numpath

  use Sort::DataTypes qw(:all)

  sort_numpath(\@list [,$sep]);
  sort_rev_numpath(\@list [,$sep]);

  sort_numpath(\@list, [$sep,] \%hash);
  sort_rev_numpath(\@list, [$sep,] \%hash);

  $flag = cmp_numpath($x,$y [,$sep]);
  $flag = cmp_rev_numpath($x,$y [,$sep]);

A related type of sorting is numpath sorting. This is identical to
path sorting except that if two elements in the path are integers,
numerical sorts will be done. So:

  a/2/c < a/11/c

=cut

{
   my $S;
   my $N = 0;

   sub sort_path {
      my($list,@arg) = @_;
      my($hash);
      if ($#arg == 1) {
         ($S,$hash) = @arg;
      } elsif ($#arg == 0  &&  ! ref($arg[0])) {
         $S = $arg[0];
      } else {
         $hash = $arg[0]  if (@arg);
         $S = '\/';
      }

      if (defined $hash) {
         @$list = sort { cmp_path($$hash{$a},$$hash{$b}) ||
                           $a cmp $b
                        } @$list;
      } else {
         @$list = sort { cmp_path($a,$b) } @$list;
      }
   }

   sub cmp_path {
      my($x,$y,$sep) = @_;
      $S = $sep  if (defined $sep);
      $S = '\/'  if ($S eq "");
      my(@x,@y);
      (@x)=split(/$S/,$x);
      (@y)=split(/$S/,$y);

      while (@x) {
         return 1  if (! @y);
         my $xx  = shift(@x);
         my $yy  = shift(@y);

         my $ret;
         if ($N  &&  $xx =~ /^\d+$/  &&  $yy =~ /^\d+$/) {
            $ret = ($xx <=> $yy);
         } else {
            $ret = ($xx cmp $yy);
         }
         return $ret  if ($ret);
      }
      return -1  if (@y);
      return  0;
   }

   sub sort_rev_path {
      my($list,@args) = @_;
      sort_path($list,@args);
      @$list = reverse @$list;
   }

   sub cmp_rev_path {
      my($x,$y,@args) = @_;
      return cmp_path($y,$x,@args);
   }

   sub sort_numpath {
      $N = 1;
      my @ret = sort_path(@_);
      $N = 0;
      @ret;
   }

   sub cmp_numpath {
      $N = 1;
      my $ret = cmp_path(@_);
      $N = 0;
      $ret;
   }

   sub sort_rev_numpath {
      my($list,@args) = @_;
      sort_numpath($list,@args);
      @$list = reverse @$list;
   }

   sub cmp_rev_numpath {
      my($x,$y,@args) = @_;
      return cmp_numpath($y,$x,@args);
   }
}

###############################################################################
=pod

=item sort_random, sort_rev_random, cmp_random, cmp_rev_random

  use Sort::DataTypes qw(:all)

  sort_random(\@list);
  sort_rev_random(\@list);

  sort_random(\@list,\%hash);
  sort_rev_random(\@list,\%hash);

  $flag = cmp_random($x,$y);
  $flag = cmp_rev_random($x,$y);

This uses the Fisher-Yates algorithm to randomly shuffle an array in place.
This routine was taken from the book

  The Perl Cookbook
  Tom Christiansen and Nathan Torkington

The sort_rev_random is identical, and is included simply for the situation
where the sort routines are being called in some automatically generated
code that may add the 'rev_' prefix.

The cmp_random simply returns a random -1, 0, or 1.

=cut

sub sort_random {
   my($list,$hash) = @_;
   _randomize();

   my $i;
   for ($i = @$list; --$i; ) {
      my $j = int rand ($i+1);
      next if $i == $j;
      @$list[$i,$j] = @$list[$j,$i];
   }
}

sub cmp_random {
   my($x,$y) = @_;
   _randomize();
   return int(rand(3)) - 1;
}

sub sort_rev_random {
   my($list,@args) = @_;
   sort_random($list,@args);
}

sub cmp_rev_random {
   my($x,$y) = @_;
   return cmp_random($y,$x);
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

=item sort_version, sort_rev_version, cmp_version, cmp_rev_version

  use Sort::DataTypes qw(:all)

  sort_version(\@list);
  sort_rev_version(\@list);

  sort_version(\@list,\%hash);
  sort_rev_version(\@list,\%hash);

  $flag = cmp_version($x,$y);
  $flag = cmp_rev_version($x,$y);

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
   my($list,$hash) = @_;
   if (defined $hash) {
      @$list = sort { cmp_version($$hash{$a},$$hash{$b}) ||
                      $a cmp $b
                    } @$list;
   } else {
      @$list = sort { cmp_version($a,$b) } @$list;
   }
}

sub cmp_version {
   my($x,$y) = @_;
   my(@x,@y);
   (@x)=split(/\./,$x);
   (@y)=split(/\./,$y);

   while (@x) {
      return 1  if (! @y);
      my $xx=shift(@x);
      my $yy=shift(@y);

      if ($xx =~ /^(\d+)(.*)$/) {
         my($xv,$xs) = ($1+0,$2);
         if ($yy =~ /^(\d+)(.*)$/) {
            my($yv,$ys) = ($1+0,$2);
            my $ret = ($xv <=> $yv);
            return $ret  if ($ret);
            return -1  if ($xs && ! $ys);
            return  1  if ($ys && ! $xs);
            $ret = ($xx cmp $yy);
            return $ret  if ($ret);
         } else {
            return 1;
         }
      } elsif ($yy =~ /^(\d+)(.*)$/) {
         return -1;
      } elsif ($xx || $yy) {
         my $ret=($xx cmp $yy);
         return $ret  if ($ret);
      }
   }
   return -1  if (@y);
   return  0;
}

sub sort_rev_version {
   my($list,@args) = @_;
   sort_version($list,@args);
   @$list = reverse @$list;
}

sub cmp_rev_version {
   my($x,$y) = @_;
   return cmp_version($y,$x);
}

###############################################################################
=pod

=item sort_date, sort_rev_date, cmp_date, cmp_rev_date

  use Sort::DataTypes qw(:all)

  sort_date(\@list);
  sort_rev_date(\@list);

  sort_date(\@list,\%hash);
  sort_rev_date(\@list,\%hash);

  $flag = cmp_date($x,$y);
  $flag = cmp_rev_date($x,$y);

These sorts a list of dates. Dates are anything that can be parsed
with Date::Manip.

=cut

sub sort_date {
   my($list,$hash) = @_;
   if (defined $hash) {
      foreach my $key (@$list) {
         $$hash{$key} = ParseDate($$hash{$key});
      }
   } else {
      foreach my $key (@$list) {
         $$hash{$key} = ParseDate($key);
      }
   }

   @$list = sort { cmp_date($$hash{$a},$$hash{$b}) ||
                     $a cmp $b
                  } @$list;
}

sub cmp_date {
   my($x,$y) = @_;
   return Date_Cmp($x,$y);
}

sub sort_rev_date {
   my($list,@args) = @_;
   sort_date($list,@args);
   @$list = reverse @$list;
}

sub cmp_rev_date {
   my($x,$y) = @_;
   return cmp_date($y,$x);
}

###############################################################################
=pod

=item sort_line, sort_rev_line, cmp_line, cmp_rev_line

  use Sort::DataTypes qw(:all)

  sort_line(\@list,$n [,$sep]);
  sort_rev_line(\@list,$n [,$sep]);

  sort_line(\@list,$n, [$sep,] \%hash);
  sort_rev_line(\@list,$n, [$sep,] \%hash);

  $flag = cmp_line($x,$y,$n [,$sep]);
  $flag = cmp_rev_line($x,$y,$n [,$sep]);

These take a list of lines and sort on the Nth field using $sep as the
regular expression splitting the lines into fields. Fields are
numbered starting at 0.  If no $sep is given, it defaults to white
space.

=item sort_numline, sort_rev_numline, cmp_numline, cmp_rev_numline

  use Sort::DataTypes qw(:all)

  sort_numline(\@list,$n [,$sep]);
  sort_rev_numline(\@list,$n [,$sep]);

  sort_numline(\@list,$n, [$sep,] \%hash);
  sort_rev_numline(\@list,$n, [$sep,] \%hash);

  $flag = cmp_numline($x,$y,$n [,$sep]);
  $flag = cmp_rev_numline($x,$y,$n [,$sep]);

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
      my($hash);
      if ($#arg == 1) {
         ($S,$hash) = @arg;
      } elsif ($#arg == 0  &&  ! ref($arg[0])) {
         $S = $arg[0];
      } else {
         $hash = $arg[0]  if (@arg);
         $S = '\s+';
      }

      if (defined $hash) {
         @$list = sort { cmp_line($$hash{$a},$$hash{$b}) ||
                           $a cmp $b
                        } @$list;
      } else {
         @$list = sort { cmp_line($a,$b) } @$list;
      }
   }

   sub cmp_line {
      my($x,$y,@args) = @_;
      $F = shift(@args)  if (@args);
      $S = shift(@args)  if (@args);
      $S = '\s+'  if ($S eq "");

      my(@x,@y);
      (@x)=split(/$S/,$x);
      (@y)=split(/$S/,$y);

      my $xx  = (defined $x[$F-1] ? $x[$F-1] : "");
      my $yy  = (defined $y[$F-1] ? $y[$F-1] : "");

      my $ret = 0;
      if ($N  &&  $xx =~ /^\d+$/  &&  $yy =~ /^\d+$/) {
         $ret = ($xx <=> $yy);
      } else {
         $ret = ($xx cmp $yy);
      }
      return $ret;
   }

   sub sort_rev_line {
      my($list,@args) = @_;
      sort_line($list,@args);
      @$list = reverse @$list;
   }

   sub cmp_rev_line {
      my($x,$y,@args) = @_;
      return cmp_line($y,$x,@args);
   }

   sub sort_numline {
      $N = 1;
      my @ret = sort_line(@_);
      $N = 0;
      @ret;
   }

   sub cmp_numline {
      $N = 1;
      my $ret = cmp_line(@_);
      $N = 0;
      $ret;
   }

   sub sort_rev_numline {
      my($list,@args) = @_;
      sort_numline($list,@args);
      @$list = reverse @$list;
   }

   sub cmp_rev_numline {
      my($x,$y,@args) = @_;
      return cmp_numline($y,$x,@args);
   }
}

###############################################################################
=pod

=item sort_function, sort_rev_function, cmp_function, cmp_rev_function

  use Sort::DataTypes qw(:all)

  sort_function(\@list,\&func);
  sort_rev_function(\@list,\&func);

  sort_function(\@list,\&func,\%hash);
  sort_rev_function(\@list,\&func,\%hash);

  $flag = cmp_function($x,$y,\&func);
  $flag = cmp_rev_function($x,$y,\&func);

This is a catch-all sort function. It takes a reference to a function
suitable to compare two elements and return -1, 0, or 1 depending on
the order of the elements.

=cut

sub sort_function {
   my($list,$func,$hash) = @_;
   if (defined $hash) {
      @$list = sort { cmp_function($$hash{$a},$$hash{$b},$func) ||
                      $a cmp $b
                    } @$list;
   } else {
      @$list = sort { cmp_function($a,$b,$func) } @$list;
   }
}

sub cmp_function {
   my($x,$y,$func) = @_;
   return &$func($x,$y);
}

sub sort_rev_function {
   my($list,@args) = @_;
   sort_function($list,@args);
   @$list = reverse @$list;
}

sub cmp_rev_function {
   my($x,$y,@args) = @_;
   return cmp_function($y,$x,@args);
}

###############################################################################
###############################################################################
=pod

=back

=head1 BACKWARDS INCOMPATIBILITIES

The following are a list of backwards incompatibilities.

=over 4

=item Version 2.00 handling of hashes

In version 1.xx, when sorting by hash, the hash was passed in
as the hash. As of 2.00, it is passed in by reference to avoid
any confusion with optional arguments.

=back

=head1 KNOWN PROBLEMS

None at this point.

=head1 LICENSE

This script is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

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

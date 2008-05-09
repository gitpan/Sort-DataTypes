package Sort::DataTypes;
# Copyright (c) 2007-2008 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

###############################################################################

$VERSION = "2.03";

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
###############################################################################

sub sort_valid_method {
   my($method) = @_;
   return (exists $methods{$method} ? 1 : 0);
}

sub cmp_valid_method {
   my($method) = @_;
   return (exists $methods{$method} ? 1 : 0);
}

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

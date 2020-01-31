#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Test::More;

my ($type, $name) = @ARGV;

if (not defined $type and not defined $name) {
  die "-- Usage : $0 camelize <string to camelize>\n-- Usage : $0 decamelize <string to camelize>\n";
}

sub camelize {
    my ($s) = @_;
    $s =~ s{(\w+)}{
        ($a = lc $1) =~ s<(^[a-z]|_[a-z])><
            ($b = uc $1) =~ s/^_//;
            $b;
        >eg;
        $a;
    }eg;
    $s;
}

sub decamelize {
    my ($s) = @_;
    $s =~ s{(\w+)}{
        ($a = $1) =~ s<(^[A-Z]|(?![a-z])[A-Z])><
            "_" . lc $1
        >eg;
        substr $a, 1;
    }eg;
    $s;
}

if ( $type eq "camelize" )
{
  print camelize($name);
  exit(0);
}

if ( $type eq "decamelize" )
{
  print decamelize($name);
  exit(0);
}

die "   Usage : $0 <string to camelize>\n";


#is camelize('snake_case'), 'SnakeCase';
#is decamelize('CamelCase'), 'camel_case';
#is decamelize(camelize('snake_case')), 'snake_case';
#is camelize(decamelize('CamelCase')), 'CamelCase';

#done_testing
__END__

=head1 NAME

    perl.pl - NO DESCRIPTION YET.


=head1 SYNOPSIS


=head1 OPTIONS


=head1 AUTHOR

tyru <tyru.exe@gmail.com>

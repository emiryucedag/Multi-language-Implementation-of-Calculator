#!/usr/bin/perl
use strict;
use warnings;

print "Enter expression (e.g., 3 + 4 * (2 - 1) or 2 ** 3 or 2 ^ 3):\n";

while (1) {
    print "> ";
    my $line = <STDIN>;
    last unless defined $line;

    chomp($line);

    $line =~ s/\^/**/g;

    if ($line =~ /^[\d\s\+\-\*\/\(\)\.]+$/) {
        my $result = eval $line;
        if ($@) {
            print "Error in expression: $@\n";
        } else {
            print "Result: $result\n";
        }
    } else {
        print "Invalid characters in expression.\n";
    }
}
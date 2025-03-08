#!/usr/bin/perl
use warnings;
use strict;

sub main {
  my $result = parse_file();
  count_how_many_rows_are_safe($result);
}

sub count_how_many_rows_are_safe {
  my $row = $_[0];
  my $row_len = @{$row};

  my $safe = 0;
  my $unsafe = 0;
  for (my $i = 0; $i < $row_len; $i++) {
    my $is_safe = is_row_safe($row->[$i]);
    

    debug($row->[$i], $is_safe);
    
    if ($is_safe) {
      $safe++;
    } else {
      $unsafe++;
    }
  }

  print "Safe: $safe, Unsafe: $unsafe\n";
}

sub debug {
  my $row     = $_[0];
  my $is_safe = $_[1];
  my @arr = join(", ", @$row);
  
  if ($is_safe)  { print "S: @arr \n"; } 
  if (!$is_safe) { print "U: @arr \n"; }
}

# It is safe if the entire row is increasing or decreasing by the columns
sub is_row_safe {
  my $row = $_[0];
  my $col_len = @{$row};

  my $previous = $row->[0];
  my $is_increasing = 0;
  my $is_decreasing = 0;
  for (my $i = 1; $i < $col_len; $i++) {
    my $current = $row->[$i];
    my $level = abs($current - $previous);

    if (!$is_increasing) { $is_increasing = $previous < $current ? 1 : 0; }
    if (!$is_decreasing) { $is_decreasing = $previous > $current ? 1 : 0; }

    if ($is_increasing && $is_decreasing) { return 0; }
    if ($level < 1 || $level > 3)         { return 0; }

    $previous = $current;
  }

  # If doesn´t found any unsafe row, that means the row is safe.
  return 1;
}

sub parse_file {
  # Read all lines and store in @lines
  my $input = './input.txt';
  # my $input = './sample.txt';
  open(my $fh, '<', $input) or die "Could not open a file '$input' $!";
  my @lines = <$fh>;
  close($fh);

  # Loop lines and parse to a matrix
  my $matrix; 
  for my $row_index (0 .. $#lines) {
    chomp $lines[$row_index]; # Remove the newline character
    my @elements = split(' ', $lines[$row_index]);

    for my $col_index (0 .. $#elements) {
      # print "Row: $row_index, Column: $col_index, Value: $elements[$col_index]\n";
      $matrix->[$row_index][$col_index] = $elements[$col_index];
    }
  }

  return $matrix;
}

main();

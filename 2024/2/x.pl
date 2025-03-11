#!/usr/bin/perl
use v5.38;
use warnings;
use autodie;

my $result = parse_file(); 
count_how_many_rows_are_safe($result);

sub count_how_many_rows_are_safe ($rows) {
  my $row_len = @{$rows};

  my $safe = 0;
  my $unsafe = 0;
  for my $row (@ $rows) {
    my $is_safe = is_row_safe($row);

    debug($row, $is_safe);
    
    if ($is_safe) {
      $safe++;
    } else {
      $unsafe++;
    }
  }

  print "Safe: $safe, Unsafe: $unsafe\n";
}

sub debug ($rows, $is_safe) {
  my $row = join(", ", @$rows);
  if ($is_safe)  { print "S: $row \n"; } 
  if (!$is_safe) { print "U: $row \n"; }
}

# It is safe if the entire row is increasing or decreasing by the columns
sub is_row_safe ($row) {
  my $col_len = @{$row};

  my $is_increasing = 0;
  my $is_decreasing = 0;
  for (my $i = 1; $i < $col_len; $i++) {
    my $previous = $row->[$i-1];
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
  my $data;

  while (<>) {
    chomp;
    push @$data, [ split ];
  }

  return $data;
}
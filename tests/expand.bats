#!/usr/bin/env bats

load "helpers/print/bprint"

source "$BATS_TEST_DIRNAME/../dns-check"

@test "Should resolve with no range" {
  run dns-check.expand 10.0.0.0

  [ $status -eq 0 ]
  [[ "$output" == '10.0.0.0' ]]
}

@test "Should resolve a range indicated by a hyphen" {
  run dns-check.expand 10.0.0.0-1

  [ $status -eq 0 ]
  [[ "$output" == "$(echo -e '10.0.0.0\n10.0.0.1')" ]]
}

@test "Should resolve a range indicated by a cidr" {
  run dns-check.expand 10.0.0.0/31

  [ $status -eq 0 ]
  [[ "$output" == "$(echo -e '10.0.0.0\n10.0.0.1')" ]]
}

@test "Should error when min > max" {
  run dns-check.expand 10.0.0.1-0
  [ $status -ne 0 ]
}

@test "Should error when min < 0" {
  run dns-check.expand 10.0.0.-1-25
  [ $status -ne 0 ]
}

@test "Should error when max > 255" {
  run dns-check.expand 10.0.0.0-256
  [ $status -ne 0 ]
}

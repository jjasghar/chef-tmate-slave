#!/usr/bin/env bats

@test "confirm keys are in /tmp/tmate-slave/keys/ssh_host_dsa_key.pub" {
  run ls /tmp/tmate-slave/keys/ssh_host_dsa_key.pub
  [ "$status" -eq  0 ]
}

@test "confirm keys are in //tmp/tmate-slave/keys/ssh_host_dsa_key" {
  run ls /tmp/tmate-slave/keys/ssh_host_dsa_key
  [ "$status" -eq  0 ]
}

@test "confirm that you changed tmate.io in tmate.h" {
  run grep tmate.io /tmp/tmate-slave/tmate.h
  [ "$status" -eq  1 ]
}

@test "confirm that tmate-slave is there" {
  run ls /tmp/tmate-slave/tmate-slave
  [ "$status" -eq  0 ]
}



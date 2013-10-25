#!/usr/bin/env bats

@test "libevent-2.0.so.5.1.9 installed" {
  run ls /usr/local/lib/libevent-2.0.so.5.1.9
  [ "$status" -eq  0 ]
}

@test "libevent-2.0.21 installed" {
  run ls /usr/local/lib/libevent_extra-2.0.so.5.1.9
  [ "$status" -eq  0 ]
}


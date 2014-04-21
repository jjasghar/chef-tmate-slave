#!/usr/bin/env bats

@test "confirm keys are in /root/tmate-slave/keys/ssh_host_dsa_key.pub" {
  run ls /root/tmate-slave/keys/ssh_host_dsa_key.pub
  [ "$status" -eq  0 ]
}

@test "confirm keys are in /root/tmate-slave/keys/ssh_host_dsa_key" {
  run ls /root/tmate-slave/keys/ssh_host_dsa_key
  [ "$status" -eq  0 ]
}

@test "confirm that tmate-slave is there" {
  run ls /root/tmate-slave/tmate-slave
  [ "$status" -eq  0 ]
}

@test "confirm that the init/tmate-slave is there" {
  run ls /etc/init/tmate-slave.conf
  [ "$status" -eq  0 ]
}

@test "confirm that the default/tmate-slave is there" {
  run ls /etc/default/tmate-slave
  [ "$status" -eq  0 ]
}

@test "confirm that the init.d symlink is there" {
  run ls /etc/init.d/tmate-slave
  [ "$status" -eq  0 ]
}

@test "confirm that the binary installed" {
  run ls /usr/bin/tmate-slave
  [ "$status" -eq  0 ]
}

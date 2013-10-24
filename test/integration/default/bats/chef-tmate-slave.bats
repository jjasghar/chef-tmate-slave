#!/usr/bin/env bats

@test "git-core installed" {
  run git
  [ "$status" -eq  0 ]
}

@test  "git installed at /usr/bin/git" {
  run which git
  [ "${line[0]" = "/usr/bin/git" ]
}
@test  "tmate-installed" {

}


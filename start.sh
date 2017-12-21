#!/bin/bash

(($(id -u))) && echo "Error: Use sudo to run this script!" && exit

# Your theos path
export THEOS=/opt/theos

make clean
make package

expect <<- DONE
  set timeout -1

  spawn make install

  match_max 100000

  # Look for passwod prompt
  expect "*?assword:*"
  # Send password aka $password
  send -- "alpine\r"
  # send blank line (\r) to make sure we get back to gui
  send -- "\r"
  expect "*?assword:*"
  send -- "alpine\r"
  # send blank line (\r) to make sure we get back to gui
  send -- "\r"
  expect eof
DONE

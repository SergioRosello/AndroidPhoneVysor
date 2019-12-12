#!/usr/bin/env bash 

# This script manages the connected android devices
# and starts a scrcpy session for each of them

var=1

# List available adb devices:
(adb devices) | grep -w "device" | awk '{ print $1 }' | 

# Execute the scrcpy command on every device connected
while read device
do
  echo $var
  echo $device
  nohup scrcpy -s $device &>/dev/null &
  ((var++))
done

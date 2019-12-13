#!/usr/bin/env bash 

# This script manages the connected android devices
# and starts a scrcpy session for each of them

# List available adb devices:
(adb devices) | grep -w "device" | awk '{ print $1 }' | 

# Execute the scrcpy command on every device connected
while read device
do
  sleep 4
  nohup scrcpy -s $device &>/dev/null &
done

#!/usr/bin/env bash 

# This script manages the connected android devices
# and starts a scrcpy session for each of them
# URL for documentation: https://stackoverflow.com/a/29754866/4264080
# Tutorial: https://wiki.bash-hackers.org/howto/getopts_tutorial

execute () {
  i=0
  # List available adb devices:
  (adb devices) | grep -w "device" | awk '{ print $1 }' | 

# Execute the scrcpy command on every device connected
  while [ $(read device) -o $i -l $OPTARG ] 
  do
    sleep 4
    nohup scrcpy -s $device &>/dev/null &
    ((i++))
  done

}

while getopts ":n:" opt; do
  case $opt in
    n)
      echo "-n was triggered, Parameter: $OPTARG" >&2
      execute
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

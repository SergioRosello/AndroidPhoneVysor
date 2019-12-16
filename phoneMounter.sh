#!/usr/bin/env bash 

# This script manages the connected android devices
# and starts a scrcpy session for each of them
# URL for documentation: https://stackoverflow.com/a/29754866/4264080
# Tutorial: https://wiki.bash-hackers.org/howto/getopts_tutorial

#TODO: pass parameter to execute, not use OPTARG directly. This way we can control if we want to use every device or only X devices

execute () {
  i=0
  #Gets the value of the parameter passed to the function
  max_devices=$1
  # List available adb devices:
  (adb devices) | grep -w "device" | awk '{ print $1 }' | 

# Execute the scrcpy command on every device connected
  while read device
  do
    if [[ "$max_devices" == "all" ]]; then
      sleep 4
      nohup scrcpy -s $device &>/dev/null &
    elif [[ "$i" -lt "$max_devices" ]]; then
      sleep 4
      nohup scrcpy -s $device &>/dev/null &
      ((i++))
    fi
  done
}

while getopts ":n: a" opt; do
  case $opt in
    a)
      execute "all"
      ;;
    n)
      execute $OPTARG
      ;;
    \?)
      echo "Invalid option: $OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option $OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

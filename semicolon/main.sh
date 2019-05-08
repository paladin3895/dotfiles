#!/bin/bash
cwd=$(echo $(dirname $0))

evalmode=0
while getopts ":e" opt; do
  case ${opt} in
    h ) echo "Usage: cmd [-e] [file/config]"
      ;;
    e ) # process option t
      evalmode=1
      ;;
    \? ) echo "Usage: cmd [-e] [file/config]"
      ;;
  esac
done

# Use tasks.json as default, otherwise use incoming path
if [[ $evalmode == 1 ]]
then
  config="${2:-"[]"}"
  tasks=$config
else
  config="${1:-"$cwd/config/index.json"}"
  tasks=$(cat $config)
fi

# Pass tasks to rofi, and get the output as the selected option
selected=$(echo $tasks | jq -j 'map(.name) | join("\n")' | rofi -dmenu -matching fuzzy -i -p "Search tasks")
task=$(echo $tasks | jq ".[] | select(.name == \"$selected\")")

# Exit if no task was found
if [[ $task == "" ]]; then
  echo "No task defined as '$selected' within config file."
  exit 1
fi

task_command=$(echo $task | jq -r ".command")
confirm=$(echo $task | jq ".confirm")
copy=$(echo $task | jq ".copy")
recursive=$(echo $task | jq ".recursive")

if [[ $copy == "true" ]]; then
  echo -n $task_command | xclip -i -sel clipboard;
  exit;
fi

# Check whether we need confirmation to run this task
if [[ $confirm == "true" ]]; then
  # Chain the confirm command before executing the selected command
  confirm_script="$cwd/confirm.sh 'Confirm $selected?'"
  eval "cd $cwd && $confirm_script && $task_command > /dev/null &"

elif [[ $recursive == "true" ]]; then
  eval "cd $cwd && $task_command > /dev/null &"

else
  #statements
  eval "cd $cwd && $task_command > /dev/null &"
fi
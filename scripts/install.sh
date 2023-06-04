#!/bin/bash

scripts=../../cv-generator-life-sugar/scripts
scriptName=$(basename "${0%.*}")
scriptDescription='Event Bus Install'
. "$scripts"/start.sh

command='list'
# command='go'
. "$scripts"/warn.sh "Using the "$'\033[0;35m'"""$command"""$'\033[0;33m'" command."
echo

location=../
. "$scripts"/detail.sh "Using the "$'\033[0;35m'"""$location"""$'\033[1;30m'" task scheduler folder."

extension=xml
. "$scripts"/detail.sh "Using the "$'\033[0;35m'"""$extension"""$'\033[1;30m'"-type task definitions."
echo

shopt -s dotglob globstar
taskDefinitions=("$location"**/*."$extension")
. "$scripts"/detail.sh "Looking at "$'\033[0;34m'"${#taskDefinitions[@]}"$'\033[1;30m'" tasks in the following task definitions list: "$'\033[0;35m'"${taskDefinitions[*]}"$'\033[1;30m'""
echo

taskFolderMaintenance=
for i in "${!taskDefinitions[@]}"; do
    taskDefinition="${taskDefinitions[$i]}"

    taskPath="${taskDefinition/$location/}"
    taskPath="${taskPath////\\}"

    if [[ "$command" == 'go' ]]; then
        schtasks.exe -create -TN "$taskPath" -XML "$taskDefinition"
    fi

    . "$scripts"/detail.sh "Created a "$'\033[0;32m'"""$taskPath"""$'\033[1;30m'" task."
done
echo

. "$scripts"/finish.sh
# echo

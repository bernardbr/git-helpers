#!/bin/bash

if [ -z "$1" ];
then
    echo "A new branch name must be filled."
    exit 0
fi

current_branch=$(git branch --show-current)
echo "Renaming..."
echo "Old branch: $current_branch"
echo "New branch: $1"

while true; do
  read -p "Do you want to rename the branch? (Y/N) " confirmation
  case $confirmation in
    [Yy]* ) 
      echo "Renaming locally..."
      git branch -m $1

      echo "Pushing changes to remote..."
      git push -u origin $1
      git push origin --delete $current_branch
      break;;
    [Nn]* ) 
      echo "Aborted." 
      exit 0;;
    * ) 
      echo "Please answer Y or N.";;
  esac
done

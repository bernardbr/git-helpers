#!/bin/bash

# Asks user confirmation to proceed
while true; do
  read -p "This command will delete all local branches that no longer exist in the remote repository. Do you wish to continue? ([Y]es/[N]o/[A]ll) " confirm
  if [[ "$confirm" == "Y" || "$confirm" == "y" || "$confirm" == "N" || "$confirm" == "n" || "$confirm" == "A" || "$confirm" == "a" ]]; then
    break
  else
    echo "Invalid input. Please enter a valid option."
  fi
done

if [[ "$confirm" == "N" || "$confirm" == "n" ]]; then
  echo "Operation canceled."
  exit 1
fi

# Gets the list of local branches
local_branches=$(git branch --format '%(refname:short)')

# Gets the list of remote branches
remote_branches=$(git ls-remote --heads origin | awk '{print $2}' | sed 's#refs/heads/##')

# Iterates over each local branch and deletes it if it doesn't exist in the remote repository
for branch in $local_branches; do
  if [[ "$branch" != "master" && "$branch" != "main" && ! "$remote_branches" =~ "$branch" ]]; then
    if [[ "$confirm" == "A" || "$confirm" == "a" ]]; then
      git branch -D "$branch"
      echo "Local branch \"$branch\" deleted."
    else
      while true; do
        read -p "Do you want to delete local branch \"$branch\"? (Y/N) " confirm_delete
        if [[ "$confirm_delete" == "Y" || "$confirm_delete" == "y" || "$confirm_delete" == "N" || "$confirm_delete" == "n" ]]; then
          break
        else
          echo "Invalid input. Please enter a valid option."
        fi
      done
      if [[ "$confirm_delete" == "Y" || "$confirm_delete" == "y" ]]; then
        git branch -D "$branch"
        echo "Local branch \"$branch\" deleted."
      else
        echo "Local branch \"$branch\" kept."
      fi
    fi
  fi
done

echo "Operation complete."

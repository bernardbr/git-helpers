#!/bin/bash

# Check if the current directory is a valid Git repository
if ! git rev-parse --is-inside-work-tree &> /dev/null; then
    echo "Error: This directory is not a Git repository."
    exit 1
fi

# Get the list of local tags
local_tags=$(git tag)

# Get the list of remote tags (removing duplicates and '^{}' annotations)
remote_tags=$(git ls-remote --tags origin | awk '{print $2}' | sed -E 's|refs/tags/||' | sed -E 's|\^\{\}||' | sort -u)

# Convert the lists into arrays
local_tags_array=($local_tags)
remote_tags_array=($remote_tags)

# Find tags to be deleted
tags_to_delete=()
for tag in "${local_tags_array[@]}"; do
    if [[ ! " ${remote_tags_array[@]} " =~ " ${tag} " ]]; then
        tags_to_delete+=("$tag")
    fi
done

# Check if there are tags to delete
if [ ${#tags_to_delete[@]} -eq 0 ]; then
    echo "No local tags need to be deleted."
    exit 0
fi

# Warning message
echo "WARNING: The following local tags do not exist in the remote repository:"
printf '%s\n' "${tags_to_delete[@]}"
echo ""
echo "This includes tags that you created locally but never pushed to the remote repository."
echo "Once deleted, these tags cannot be recovered unless you have a backup."
echo ""

# Ask for confirmation mode
read -p "Do you want to proceed? (Y = Confirm one by one, A = Remove all, N = Cancel): " mode

# Convert input to uppercase
mode=${mode^^}

echo $mode

# Handle user choice
if [[ "$mode" == "N" ]]; then
    echo "Operation canceled."
    exit 0
elif [[ "$mode" == "A" ]]; then
    # Remove all tags without confirmation
    for tag in "${tags_to_delete[@]}"; do
        echo "Deleting tag: $tag"
        git tag -d "$tag"
    done
    echo "All listed tags have been removed."
    exit 0
elif [[ "$mode" == "Y" ]]; then
    # Ask for each tag individually
    for tag in "${tags_to_delete[@]}"; do
        read -p "Do you want to delete the tag '$tag'? (Y/N): " confirmation
        confirmation=${confirmation^^} # Convert to uppercase
        if [[ "$confirmation" == "Y" ]]; then
            echo "Deleting tag: $tag"
            git tag -d "$tag"
        else
            echo "Skipping tag: $tag"
        fi
    done
    echo "Process completed!"
    exit 0
else
    echo "Invalid option. Operation canceled."
    exit 1
fi

# git-helpers
A set of helper scripts for the Git command line.

## Git Aliases for Time-Saving Commands
Git is a powerful tool for version control, but some commands can be time-consuming and repetitive. Luckily, git provides a way to create aliases for frequently used commands, allowing for quicker and easier use. Here are three scripts and how to add them as aliases to your git workflow:

### Delete Stale Branches
This script, delete-stale-branches.sh, checks for all local branches that no longer exist on the server and deletes them. To add this script as an alias:

```shell
git config --global alias.delete-stale-branches '!bash {path}/delete-stale-branches.sh'
```

To use this alias, simply run `git delete-stale-branches` in your terminal. This will save you time by automatically deleting local branches that are no longer needed.

### Rename Branch
The rename-branch.sh script allows you to rename both the local and remote branches. The syntax for this script is `git rename <new-branch-name>`. To add this script as an alias:

```shell
git config --global alias.rename '!bash {path}/rename-branch.sh'
```
  
Once added, you can use this alias by running `git rename <new-branch-name>` in your terminal. This will save you time by quickly renaming branches without having to use multiple commands.

### Show Last Tag
The show-last-tag.sh script displays the latest tag created. To add this script as an alias:

```shell
git config --global alias.show-last-tag '!bash {path}/show-last-tag.sh'
```

To use this alias, simply run `git show-last-tag` in your terminal. This will save you time by quickly displaying the latest tag without having to search through the commit history.

Using these three aliases can significantly streamline your git workflow and save you valuable time.

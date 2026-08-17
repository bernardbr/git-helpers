# git-helpers

A set of helper scripts for the Git command line designed to automate repetitive tasks and keep your repository clean.

## 🚀 Installation & Setup

To ensure portability across different machines and operating systems without hardcoding paths, this repository includes setup scripts that register the installation directory as an environment variable (`GIT_HELPERS`).

### Linux (Ubuntu/Debian)

Clone the repository and run the Bash installation script. This will add the `GIT_HELPERS` variable to your `.bashrc` or `.profile`.

```bash
git clone [https://github.com/bernardbr/git-helpers.git](https://github.com/bernardbr/git-helpers.git)
cd git-helpers
chmod +x install-env.sh
./install-env.sh
```

Apply the changes:
```bash
source ~/.bashrc
```

### macOS (Zsh)

Clone the repository and run the Zsh installation script optimized for macOS. This will add the `GIT_HELPERS` variable to your `.zshrc`.

```zsh
git clone [https://github.com/bernardbr/git-helpers.git](https://github.com/bernardbr/git-helpers.git)
cd git-helpers
chmod +x install.zsh
./install.zsh
```

Apply the changes:
```zsh
source ~/.zshrc
```

### Windows (PowerShell)

Clone the repository and run the PowerShell installation script. Instead of a shell rc file, it registers `GIT_HELPERS` as a **User** environment variable (persisted in the registry, no admin rights required), so it is visible to `git.exe` and Git Bash from any terminal.

```powershell
git clone https://github.com/bernardbr/git-helpers.git
cd git-helpers
./install-env.ps1
```

If script execution is blocked by the current policy, run it for this session only:
```powershell
powershell -ExecutionPolicy Bypass -File .\install-env.ps1
```

The variable is set in the current session automatically. Other terminals and applications pick it up after being restarted.

> **Note:** the helper scripts are Bash scripts, so Git for Windows (which ships with Git Bash) must be installed — the `!bash ...` aliases below work as-is.

***

## ⚙️ Configuration

Once the `GIT_HELPERS` variable is set, you can configure your global `.gitconfig` using the variable. This approach works natively on Linux, macOS, WSL, and Windows (Git Bash resolves `$GIT_HELPERS` at runtime).

### Option A: Edit `.gitconfig` directly (Recommended)

Open your global config (`git config --global -e`) and paste the following block:

```ini
[alias]
    # Deletes local branches that are gone on the remote
    delete-stale-branches = !bash "$GIT_HELPERS"/delete-stale-branches.sh
    
    # Renames current branch locally and on remote
    rename = !bash "$GIT_HELPERS"/rename-branch.sh
    
    # Shows the latest tag
    last-tag = !bash "$GIT_HELPERS"/show-last-tag.sh
    
    # Deletes local tags that are gone on the remote
    delete-stale-tags = !bash "$GIT_HELPERS"/delete-stale-tags.sh
```

### Option B: Via Command Line

Alternatively, you can run these commands one by one:

```bash
git config --global alias.delete-stale-branches '!bash "$GIT_HELPERS"/delete-stale-branches.sh'
git config --global alias.rename '!bash "$GIT_HELPERS"/rename-branch.sh'
git config --global alias.last-tag '!bash "$GIT_HELPERS"/show-last-tag.sh'
git config --global alias.delete-stale-tags '!bash "$GIT_HELPERS"/delete-stale-tags.sh'
```

On PowerShell, use double quotes with the `$` escaped so PowerShell does not expand it:

```powershell
git config --global alias.delete-stale-branches "!bash `"`$GIT_HELPERS`"/delete-stale-branches.sh"
git config --global alias.rename "!bash `"`$GIT_HELPERS`"/rename-branch.sh"
git config --global alias.last-tag "!bash `"`$GIT_HELPERS`"/show-last-tag.sh"
git config --global alias.delete-stale-tags "!bash `"`$GIT_HELPERS`"/delete-stale-tags.sh"
```

***

## 🛠️ Scripts Description

### Delete Stale Branches

Checks for all local branches that no longer exist on the server (remote) and deletes them.

* **Usage:** `git delete-stale-branches`

### Rename Branch

Renames both the local and remote branches while maintaining tracking.

* **Usage:** `git rename <new-branch-name>`

### Show Last Tag

Displays the latest tag created in the current tree.

* **Usage:** `git last-tag`

### Delete Stale Tags

Syncs your local tags with the remote, removing tags locally that were deleted on the server.

* **Usage:** `git delete-stale-tags`


***
Made with ❤️ by Bernardo
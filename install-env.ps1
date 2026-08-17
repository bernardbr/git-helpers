#!/usr/bin/env pwsh

# 1. Absolute directory of this script
$RepoPath = $PSScriptRoot
if (-not $RepoPath) {
    $RepoPath = Split-Path -Parent $MyInvocation.MyCommand.Path
}

# 2. On Windows the equivalent of a shell rc file is the User environment scope
#    (persisted in the registry, no admin rights required, visible to git.exe
#    and to Git Bash regardless of which terminal is used)
$Existing = [Environment]::GetEnvironmentVariable('GIT_HELPERS', 'User')

# 3. Idempotency check to avoid overwriting an existing setup
if ($Existing) {
    Write-Host "WARNING: The GIT_HELPERS variable already exists for the current user."
    Write-Host "Current value: $Existing"
    Write-Host "Check if the path is correct: $RepoPath"
}
else {
    # 4. Persists the configuration for future sessions
    [Environment]::SetEnvironmentVariable('GIT_HELPERS', $RepoPath, 'User')

    Write-Host "SUCCESS! Path registered for the current user:"
    Write-Host "GIT_HELPERS=$RepoPath"
    Write-Host ""
    Write-Host "To take effect elsewhere, open a new terminal."
}

# 5. Makes it available immediately in the current session
$env:GIT_HELPERS = $RepoPath

#!/usr/bin/env bash

# Get the root directory of the current git repository
# If not in a git repository, display an error message
repo_root=$(git rev-parse --show-toplevel 2>/dev/null || echo "Not in a git repository" >&2)

# Get the current branch name
repo_branch=$(git branch --show-current)

# Generate a unique temporary name for the repository using UUID
repo_root_tmp_name=$(uuidgen)

# Move the repository to the temporary location with the UUID name
# This frees up the original directory name
mv "$repo_root" "$repo_root_tmp_name"

# Create a new empty directory with the same name as the original repository
mkdir -p "$repo_root"

# Create a subdirectory named after the current branch
mkdir -p "$repo_root/$repo_branch"

# Move all contents from the temporary location into the branch-named subdirectory
# This reorganizes the repo structure to: original_repo_name/branch_name/...
mv "$repo_root_tmp_name"/* "$repo_root/$repo_branch/"

# Clean up the now-empty temporary directory
rmdir "$repo_root_tmp_name"

#!/bin/env/bash

# Rebuild NixOS & switch
echo "Rebuilding NixOS..."
git add -A
sudo nixos-rebuild switch --flake .#default --builders ""

# Add all changes to git
echo "Adding all changes to git..."
nix fmt
git add --all
git status

# Ask for confirmation before committing
read -r -p "Do you want to commit these changes? (y/n) " confirm
if [[ $confirm =~ ^[Yy]$ ]]; then
    # Prompt for commit message
    read -r -p "Enter commit message: " message

    # Commit and push if message is not empty
    if [ -n "$message" ]; then
        git commit -m "$message"
        git push
    else
        echo "Commit message cannot be empty. Aborting."
        exit 1
    fi
else
    echo "Commit aborted."
    exit 0
fi

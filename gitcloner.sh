#!/bin/bash

# To use open git bash 
# Then 'cd path of the folder ' to the path where you want to clone
# and then run the command "./gitcloner.sh"


#repository url here 
repo_url=""
#folder name here 

clone_dir=""

# Clone the repository
git clone $repo_url $clone_dir

# Check if the cloning was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone the repository."
    exit 1
fi

# Move into the cloned repository directory
cd $clone_dir

# Fetch all remote branches
git fetch --all

# Get the list of remote branches
branches=$(git branch -a | grep remotes/origin | grep -v HEAD | awk -F'/' '{print $3}')

# Check if there are branches to clone
if [ -z "$branches" ]; then
    echo "Error: No branches found to clone."
    exit 1
fi

# Loop through each branch and create a local branch tracking the remote branch
for branch in $branches; do
    git checkout -B $branch origin/$branch
    echo "Cloning branch: $branch"
    git clone --branch $branch --single-branch $repo_url $clone_dir-$branch
done

echo "All branches cloned successfully."

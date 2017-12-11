#!/bin/bash

# 1. Create or clone a new local repository
# 2. `cd` into the repository's directory
# 3. Run this script to push the default content
# 4. Edit and commit changes; Merge locally or online

# Configuration
mybranch="add-default-content"
mycommitmsg="Add default content from repo_defaults"

# Define the usage function
function usage {
  echo " "
  echo "Run this script inside a Git repository to copy files from solvaholic's repo_defaults."
  echo "  Usage: `basename $0`"
  echo " "
  exit 1
}

# Make sure we're running from within a Git repository
git status &>/dev/null
if [ $? -ne 0 ]; then
  echo " "; echo "This doesn't look like a Git repository!";
  usage
fi

# Create a branch for this work
git checkout -b $mybranch

# Copy in the default content
myTFile=$( tempfile )
myXPath="solvaholic-solvaholic.github.io-*/templates/repo_defaults/*"
curl -Lo $myTFile https://github.com/solvaholic/solvaholic.github.io/tarball/master
tar xzf $myTFile "$myXPath" 2&>1 /dev/null || tar xzf $myTFile --wildcards "$myXPath" 2&>1 /dev/null
mv solvaholic-solvaholic.github.io-*/templates/repo_defaults/{*,.git?*} ./
rm -rf solvaholic-solvaholic.github.io-*
rm -f $myTFile

# Commit the changes
git add .
git commit -m "$mycommitmsg"

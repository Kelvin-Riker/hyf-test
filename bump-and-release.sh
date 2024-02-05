#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <major|minor|patch>"
  exit 1
fi

# Assign arguments to variables
version_bump=$1
release_target=$(git rev-parse --abbrev-ref HEAD)

# Bump the version in package.json
npm version $version_bump -m "Bump version to %s"

# Commit the changes
git add package.json
git commit -m "Bump version"

# Push the changes to the current branch
git push origin $release_target

# Create a GitHub release with the specified target
gh release create v$(node -p "require('./package.json').version") \
  -t "Release $(node -p "require('./package.json').version")" \
  -n "Release notes for $(node -p "require('./package.json').version")" \
  --target $release_target

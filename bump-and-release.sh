#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <major|minor|patch>"
  exit 1
fi

# Bump the version in package.json
npm version $1 -m "Bump version to %s"

# Commit the changes
git add package.json
git commit -m "Bump version"

# Push the changes to the main branch
git push origin main

# Create a GitHub release
gh release create v$(node -p "require('./package.json').version") -t "Release $(node -p "require('./package.json').version")" -n "Release notes for $(node -p "require('./package.json').version")"


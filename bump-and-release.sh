#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: $0 <major|minor|patch> [target-branch] [production]"
  exit 1
fi

# Assign arguments to variables
version_bump=$1
release_target=${2:-main}
is_production=${3:-}

# Bump the version in package.json
npm version $version_bump -m "Bump version to %s"

# Commit the changes
git add package.json
git commit -m "Bump version"

# Push the changes to the specified branch
git push origin $release_target

# Create a GitHub release with the specified target
gh release create v$(node -p "require('./package.json').version") \
  -t "Release $(node -p "require('./package.json').version")" \
  -n "Release notes for $(node -p "require('./package.json').version")" \
  --target $release_target \
  $( [ "$is_production" == "production" ] && echo "--title production --notes \"This is a production release\"" || echo "--prerelease" )

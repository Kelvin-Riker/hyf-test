#!/bin/bash

# Set default values
update_type="patch"
pre_release=true

update_version() {
  # Update version based on the specified type and commit the changes
  version=$(npm version "$update_type")
  git add package.json 
  git commit -m "Bump version to $version"
  
  # Check if the git commands were successful
  if [ $? -ne 0 ]; then
    echo "Error: Failed to commit version changes."
    exit 1
  fi

  git push  # Push the changes to the remote repository
  
  # Check if the git push was successful
  if [ $? -ne 0 ]; then
    echo "Error: Failed to push version changes."
    exit 1
  fi

  echo "$version"  # Return the version
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -r)
            shift
            update_type="$1"
            ;;
        -prod)
            pre_release=false
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
    shift
done

# Get the current branch name
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Update version only if it's a pre-release
if [ "$pre_release" = true ]; then
    version=$(update_version)
else
  # Use the existing version in package.json
  version=$(jq -r '.version' package.json)
fi

# Create a new release with the generated version
if [ "$pre_release" = true ]; then
  gh release create "$version" --generate-notes -p --target "$current_branch"
  echo "Pre-release $version created."
else
  gh release edit v"$version" --prerelease=false --latest
  echo "Release $version released."
fi


#!/bin/bash

# Set default values
update_type="patch"
pre_release=true

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


# Create a new release with the generated version
if [ "$pre_release" = true ]; then

  #Update version based on the specified type
  version=$(npm version "$update_type")
  git add package.json 
  git commit -m "Bump version to $version"
  git push

  gh release create "$version" --generate-notes -p --target "$current_branch"
  echo "Pre-release $version created."
else
  version=$(jq -r '.version' package.json)
  echo $version
  gh release edit v"$version" --prerelease=false --latest
  echo "Release $version released."
fi

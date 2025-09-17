#!/bin/bash

# Version Bump Script for Scrix
# Usage: ./scripts/bump-version.sh [major|minor|patch]

set -euo pipefail

VERSION_FILE="VERSION"
PACKAGE_FILE="package.json"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to get current version
get_current_version() {
    if [[ -f "$VERSION_FILE" ]]; then
        cat "$VERSION_FILE"
    else
        echo "0.0.0"
    fi
}

# Function to bump version
bump_version() {
    local current_version="$1"
    local bump_type="$2"
    
    IFS='.' read -r major minor patch <<< "$current_version"
    
    case "$bump_type" in
        major)
            major=$((major + 1))
            minor=0
            patch=0
            ;;
        minor)
            minor=$((minor + 1))
            patch=0
            ;;
        patch)
            patch=$((patch + 1))
            ;;
        *)
            echo -e "${RED}❌ Invalid bump type. Use: major, minor, or patch${NC}"
            exit 1
            ;;
    esac
    
    echo "$major.$minor.$patch"
}

# Function to update VERSION file
update_version_file() {
    local new_version="$1"
    echo "$new_version" > "$VERSION_FILE"
    echo -e "${GREEN}✅ Updated VERSION file to $new_version${NC}"
}

# Function to update package.json
update_package_json() {
    local new_version="$1"
    node scripts/update-version.js
    echo -e "${GREEN}✅ Updated package.json to $new_version${NC}"
}

# Function to create git tag
create_git_tag() {
    local new_version="$1"
    git add "$VERSION_FILE" "$PACKAGE_FILE"
    git commit -m "chore: bump version to $new_version"
    git tag "v$new_version"
    echo -e "${GREEN}✅ Created git tag v$new_version${NC}"
}

# Main function
main() {
    local bump_type="${1:-patch}"
    local current_version
    local new_version
    
    echo -e "${BLUE}🚀 Scrix Version Bump Tool${NC}"
    echo "=========================="
    
    # Get current version
    current_version=$(get_current_version)
    echo -e "${YELLOW}📋 Current version: $current_version${NC}"
    
    # Bump version
    new_version=$(bump_version "$current_version" "$bump_type")
    echo -e "${YELLOW}📈 New version: $new_version${NC}"
    
    # Confirm
    read -p "Do you want to bump to version $new_version? (y/N): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${RED}❌ Version bump cancelled${NC}"
        exit 0
    fi
    
    # Update files
    update_version_file "$new_version"
    update_package_json "$new_version"
    
    # Create git tag if in git repository
    if git rev-parse --git-dir > /dev/null 2>&1; then
        create_git_tag "$new_version"
        echo -e "${BLUE}💡 To push changes: git push && git push --tags${NC}"
    else
        echo -e "${YELLOW}⚠️  Not in a git repository, skipping git operations${NC}"
    fi
    
    echo ""
    echo -e "${GREEN}🎉 Version bump completed successfully!${NC}"
    echo -e "${BLUE}📦 New version: $new_version${NC}"
}

# Run main function with all arguments
main "$@"

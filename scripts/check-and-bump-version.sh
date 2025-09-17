#!/bin/bash

# Check NPM version and bump if needed
# This script checks if current version exists on NPM and bumps if necessary

set -euo pipefail

VERSION_FILE="VERSION"
PACKAGE_FILE="package.json"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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
    IFS='.' read -r major minor patch <<< "$current_version"
    patch=$((patch + 1))
    echo "$major.$minor.$patch"
}

# Function to check if version exists on NPM
check_npm_version() {
    local version="$1"
    if npm view scrix@$version version >/dev/null 2>&1; then
        return 0  # Version exists
    else
        return 1  # Version doesn't exist
    fi
}

# Function to update version files
update_version_files() {
    local new_version="$1"
    echo "$new_version" > "$VERSION_FILE"
    node scripts/update-version.js
    echo -e "${GREEN}✅ Updated version to $new_version${NC}"
}

# Main function
main() {
    echo -e "${BLUE}🔍 Checking NPM version availability...${NC}"
    
    local current_version
    current_version=$(get_current_version)
    echo -e "${YELLOW}📋 Current version: $current_version${NC}"
    
    if check_npm_version "$current_version"; then
        echo -e "${RED}❌ Version $current_version already exists on NPM${NC}"
        
        # Bump version
        local new_version
        new_version=$(bump_version "$current_version")
        echo -e "${YELLOW}📈 Bumping to version: $new_version${NC}"
        
        # Update files
        update_version_files "$new_version"
        
        echo -e "${GREEN}🎉 Version bumped to $new_version${NC}"
        echo -e "${BLUE}💡 Ready for deployment${NC}"
        
        # Return new version for workflow
        if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
            echo "NEW_VERSION=$new_version" >> $GITHUB_OUTPUT
        fi
    else
        echo -e "${GREEN}✅ Version $current_version is available for publishing${NC}"
        
        # Return current version for workflow
        if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
            echo "NEW_VERSION=$current_version" >> $GITHUB_OUTPUT
        fi
    fi
}

# Run main function
main "$@"

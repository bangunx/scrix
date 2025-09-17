#!/bin/bash

# Bump Version and Sync Script for Scrix
# This script bumps version in VERSION file and syncs with package.json

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

# Function to sync with package.json
sync_package_json() {
    echo -e "${BLUE}🔄 Syncing package.json...${NC}"
    node scripts/sync-version.js sync
}

# Function to validate sync
validate_sync() {
    echo -e "${BLUE}🔍 Validating version sync...${NC}"
    if node scripts/sync-version.js validate; then
        echo -e "${GREEN}✅ Version sync validated${NC}"
        return 0
    else
        echo -e "${RED}❌ Version sync validation failed${NC}"
        return 1
    fi
}

# Main function
main() {
    local bump_type="${1:-patch}"
    local current_version
    local new_version
    
    echo -e "${BLUE}🚀 Scrix Version Bump and Sync Tool${NC}"
    echo "====================================="
    
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
    
    # Update VERSION file
    update_version_file "$new_version"
    
    # Sync with package.json
    sync_package_json
    
    # Validate sync
    if validate_sync; then
        echo ""
        echo -e "${GREEN}🎉 Version bump and sync completed successfully!${NC}"
        echo -e "${BLUE}📦 New version: $new_version${NC}"
        echo ""
        echo -e "${YELLOW}💡 Next steps:${NC}"
        echo "1. Commit changes: git add VERSION package.json"
        echo "2. Commit: git commit -m \"chore: bump version to $new_version\""
        echo "3. Push: git push"
        echo "4. Publish: npm publish"
    else
        echo -e "${RED}❌ Version sync failed${NC}"
        exit 1
    fi
}

# Run main function with all arguments
main "$@"

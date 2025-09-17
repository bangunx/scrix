#!/bin/bash

# Test Version Logic for GitHub Workflow
# This script tests the version checking and bumping logic

set -euo pipefail

echo "🧪 Testing Version Logic for GitHub Workflow"
echo "============================================="

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to test version logic
test_version_logic() {
    local test_version="$1"
    local expected_result="$2"
    
    echo -e "${BLUE}📋 Testing version: $test_version${NC}"
    
    # Set test version
    echo "$test_version" > VERSION
    node scripts/update-version.js >/dev/null
    
    # Get current version
    CURRENT_VERSION=$(cat VERSION)
    echo "Current version: $CURRENT_VERSION"
    
    # Check if version exists on NPM
    if npm view scrix@$CURRENT_VERSION version >/dev/null 2>&1; then
        echo -e "${RED}❌ Version $CURRENT_VERSION already exists on NPM${NC}"
        
        # Bump version
        IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"
        NEW_PATCH=$((PATCH + 1))
        NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH"
        echo "$NEW_VERSION" > VERSION
        node scripts/update-version.js >/dev/null
        echo -e "${YELLOW}📈 Bumped to version: $NEW_VERSION${NC}"
        FINAL_VERSION="$NEW_VERSION"
    else
        echo -e "${GREEN}✅ Version $CURRENT_VERSION is available for publishing${NC}"
        FINAL_VERSION="$CURRENT_VERSION"
    fi
    
    echo -e "${BLUE}📦 Final version: $FINAL_VERSION${NC}"
    
    # Check if result matches expected
    if [[ "$FINAL_VERSION" == "$expected_result" ]]; then
        echo -e "${GREEN}✅ Test passed!${NC}"
        return 0
    else
        echo -e "${RED}❌ Test failed! Expected: $expected_result, Got: $FINAL_VERSION${NC}"
        return 1
    fi
}

# Test cases
echo -e "${YELLOW}🔍 Running test cases...${NC}"
echo ""

# Test 1: Version that exists (2.0.0)
test_version_logic "2.0.0" "2.0.1"
echo ""

# Test 2: Version that exists (2.0.1) 
test_version_logic "2.0.1" "2.0.2"
echo ""

# Test 3: Version that doesn't exist (2.0.3)
test_version_logic "2.0.3" "2.0.3"
echo ""

# Test 4: Version that doesn't exist (2.1.0)
test_version_logic "2.1.0" "2.1.0"
echo ""

echo -e "${GREEN}🎉 All version logic tests completed!${NC}"
echo -e "${BLUE}💡 The workflow should now handle version conflicts correctly${NC}"

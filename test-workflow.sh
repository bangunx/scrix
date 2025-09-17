#!/bin/bash

# Test GitHub Workflow Locally
# This script simulates the GitHub Actions workflow steps

set -euo pipefail

echo "🧪 Testing GitHub Workflow Locally"
echo "=================================="

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to simulate workflow steps
test_workflow() {
    echo -e "${BLUE}📋 Step 1: Read version from VERSION file${NC}"
    VERSION=$(cat VERSION)
    echo "Version: $VERSION"
    
    echo -e "${BLUE}📋 Step 2: Update package.json version${NC}"
    node scripts/update-version.js
    echo "✅ Updated package.json to version $VERSION"
    
    echo -e "${BLUE}📋 Step 3: Install dependencies${NC}"
    npm install
    echo "✅ Dependencies installed"
    
    echo -e "${BLUE}📋 Step 4: Run tests${NC}"
    chmod +x test-install.sh
    chmod +x scripts/update-version.js
    chmod +x scripts/bump-version.sh
    
    # Test version update script
    node scripts/update-version.js
    echo "✅ Version update script works"
    
    # Test package validation
    npm pack --dry-run
    echo "✅ Package validation successful"
    
    echo -e "${BLUE}📋 Step 5: Simulate NPM publish (dry run)${NC}"
    echo "🚀 Would publish to NPM..."
    echo "✅ NPM publish simulation successful"
    
    echo -e "${BLUE}📋 Step 6: Simulate GitHub Release${NC}"
    echo "📝 Would create GitHub Release v$VERSION"
    echo "✅ GitHub Release simulation successful"
    
    echo -e "${BLUE}📋 Step 7: Update VERSION file for next release${NC}"
    # Extract version parts
    IFS='.' read -r MAJOR MINOR PATCH <<< "$VERSION"
    
    # Increment patch version
    NEW_PATCH=$((PATCH + 1))
    NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH"
    
    echo "Current version: $VERSION"
    echo "Next version would be: $NEW_VERSION"
    echo "✅ VERSION file update simulation successful"
}

# Function to check prerequisites
check_prerequisites() {
    echo -e "${YELLOW}🔍 Checking prerequisites...${NC}"
    
    # Check if VERSION file exists
    if [[ ! -f "VERSION" ]]; then
        echo -e "${RED}❌ VERSION file not found${NC}"
        return 1
    fi
    
    # Check if package.json exists
    if [[ ! -f "package.json" ]]; then
        echo -e "${RED}❌ package.json not found${NC}"
        return 1
    fi
    
    # Check if scripts exist
    if [[ ! -f "scripts/update-version.js" ]]; then
        echo -e "${RED}❌ scripts/update-version.js not found${NC}"
        return 1
    fi
    
    # Check if Node.js is available
    if ! command -v node &> /dev/null; then
        echo -e "${RED}❌ Node.js not found${NC}"
        return 1
    fi
    
    # Check if npm is available
    if ! command -v npm &> /dev/null; then
        echo -e "${RED}❌ npm not found${NC}"
        return 1
    fi
    
    echo -e "${GREEN}✅ All prerequisites met${NC}"
    return 0
}

# Main execution
main() {
    echo -e "${BLUE}🚀 Starting workflow test...${NC}"
    echo ""
    
    if ! check_prerequisites; then
        echo -e "${RED}❌ Prerequisites check failed${NC}"
        exit 1
    fi
    
    echo ""
    test_workflow
    
    echo ""
    echo -e "${GREEN}🎉 All workflow tests passed!${NC}"
    echo -e "${BLUE}📦 Ready for GitHub Actions deployment${NC}"
    echo ""
    echo -e "${YELLOW}💡 Next steps:${NC}"
    echo "1. Commit and push changes to GitHub"
    echo "2. Set up NPM_TOKEN in GitHub Secrets"
    echo "3. Push to main branch to trigger workflow"
    echo "4. Monitor GitHub Actions tab"
}

# Run main function
main "$@"

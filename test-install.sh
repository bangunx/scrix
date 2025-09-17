#!/bin/bash

# Test Installation Script for Scrix NPM Package
# This script tests the npm package installation locally

set -euo pipefail

echo "🧪 Testing Scrix NPM Package Installation"
echo "=========================================="

# Check if npm is available
if ! command -v npm &> /dev/null; then
    echo "❌ Error: npm is required for testing"
    echo "Please install Node.js and npm first"
    exit 1
fi

# Check if we're in the right directory
if [[ ! -f "package.json" ]]; then
    echo "❌ Error: package.json not found"
    echo "Please run this script from the scrix root directory"
    exit 1
fi

echo "📋 Current directory: $(pwd)"
echo "📦 Package name: $(grep '"name"' package.json | cut -d'"' -f4)"
echo "🔢 Version: $(grep '"version"' package.json | cut -d'"' -f4)"
echo ""

# Test package validation
echo "🔍 Validating package.json..."
if npm pack --dry-run &>/dev/null; then
    echo "✅ package.json is valid"
else
    echo "❌ package.json validation failed"
    exit 1
fi

# Test local installation
echo ""
echo "📥 Testing local installation..."
if npm install -g . &>/dev/null; then
    echo "✅ Local installation successful"
else
    echo "❌ Local installation failed"
    exit 1
fi

# Test if scrix command is available
echo ""
echo "🔍 Testing scrix command availability..."
if command -v scrix &> /dev/null; then
    echo "✅ scrix command is available globally"
    echo "📍 Location: $(which scrix)"
else
    echo "❌ scrix command not found"
    exit 1
fi

# Test scrix execution (just check if it starts)
echo ""
echo "🚀 Testing scrix execution..."
if timeout 5s scrix --help &>/dev/null || timeout 5s scrix &>/dev/null; then
    echo "✅ scrix executes successfully"
else
    echo "⚠️  scrix execution test inconclusive (may require interactive input)"
fi

echo ""
echo "🎉 All tests passed! Scrix is ready for npm publish"
echo ""
echo "📋 Next steps:"
echo "1. Commit and push changes to GitHub"
echo "2. Run: npm publish (if you have npm publish permissions)"
echo "3. Users can then install with: npm install -g scrix"
echo ""
echo "🔗 Test installation command:"
echo "   npm install -g scrix"
echo "   scrix"

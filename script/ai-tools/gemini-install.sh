#!/bin/bash

# Google Gemini CLI Installation Script
# This script installs Google Gemini CLI tool globally using npm

set -euo pipefail  # Exit on any error, undefined vars, pipe failures

echo "🤖 Installing Google Gemini CLI..."
echo "=================================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Error: Node.js is required but not installed."
    echo "Please install Node.js first:"
    echo "  Ubuntu/Debian: curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs"
    echo "  CentOS/RHEL: curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo -E bash - && sudo yum install -y nodejs"
    echo "  macOS: brew install node"
    echo "  Or visit: https://nodejs.org/"
    exit 1
fi

# Check if npm is available
if ! command -v npm &> /dev/null; then
    echo "❌ Error: npm is required but not installed."
    echo "npm should come with Node.js installation."
    exit 1
fi

# Display current Node.js and npm versions
echo "📋 Current versions:"
echo "  Node.js: $(node --version)"
echo "  npm: $(npm --version)"
echo ""

# Install Google Gemini CLI globally
echo "📥 Installing @google/gemini-cli globally..."
npm install -g @google/gemini-cli

echo ""
echo "✅ Google Gemini CLI installation completed!"
echo ""
echo "📋 Next steps:"
echo "1. Verify installation: gemini --version"
echo "2. Configure your Google API key: gemini config"
echo "3. Start using Gemini: gemini"
echo ""
echo "🔑 Don't forget to set up your Google API key!"
echo "   Get your API key from: https://aistudio.google.com/app/apikey"
echo ""
echo "🎉 Happy coding with Google Gemini!"

#!/bin/bash

# Qwen Code CLI Installation Script
# This script installs Qwen Code CLI tool globally using npm

set -euo pipefail  # Exit on any error, undefined vars, pipe failures

echo "🤖 Installing Qwen Code CLI..."
echo "==============================="

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

# Install Qwen Code CLI globally
echo "📥 Installing @qwen-code/qwen-code@latest globally..."
npm install -g @qwen-code/qwen-code@latest

echo ""
echo "✅ Qwen Code CLI installation completed!"
echo ""
echo "📋 Next steps:"
echo "1. Verify installation: qwen-code --version"
echo "2. Configure your API settings: qwen-code config"
echo "3. Start using Qwen Code: qwen-code"
echo ""
echo "🔑 Don't forget to set up your API configuration!"
echo "   Visit: https://github.com/QwenLM/Qwen-Code for more information"
echo ""
echo "🎉 Happy coding with Qwen Code!"

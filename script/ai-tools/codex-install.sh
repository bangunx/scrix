#!/bin/bash

# OpenAI Codex Installation Script
# This script installs OpenAI Codex CLI tool globally using npm

set -euo pipefail  # Exit on any error, undefined vars, pipe failures

echo "🤖 Installing OpenAI Codex CLI..."
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

# Install OpenAI Codex globally
echo "📥 Installing @openai/codex globally..."
if npm install -g @openai/codex; then
    echo ""
    echo "✅ OpenAI Codex installation completed!"
    
    # Try to verify installation
    echo "🔍 Verifying installation..."
    if command -v codex &> /dev/null; then
        echo "✅ Codex command found: $(which codex)"
        if codex --version &> /dev/null; then
            echo "✅ Codex version: $(codex --version)"
        else
            echo "⚠️  Codex installed but version check failed"
        fi
    else
        echo "⚠️  Codex installed but command not found in PATH"
        echo "   You may need to restart your terminal or run: source ~/.bashrc"
    fi
    
    echo ""
    echo "📋 Next steps:"
    echo "1. Restart your terminal or run: source ~/.bashrc"
    echo "2. Verify installation: codex --version"
    echo "3. Configure your OpenAI API key: codex config"
    echo "4. Start using Codex: codex"
    echo ""
    echo "🔑 Don't forget to set up your OpenAI API key!"
    echo "   Get your API key from: https://platform.openai.com/api-keys"
    echo ""
    echo "🎉 Happy coding with OpenAI Codex!"
else
    echo ""
    echo "❌ OpenAI Codex installation failed!"
    echo "Please check your internet connection and npm configuration."
    echo "You can also try: npm install -g @openai/codex"
    exit 1
fi

#!/bin/bash

# OpenCode AI Installation Script
# This script installs OpenCode AI using the official installation method

set -e  # Exit on any error

echo "🚀 Installing OpenCode AI..."
echo "================================"

# Check if curl is available
if ! command -v curl &> /dev/null; then
    echo "❌ Error: curl is required but not installed."
    echo "Please install curl first:"
    echo "  Ubuntu/Debian: sudo apt update && sudo apt install curl"
    echo "  CentOS/RHEL: sudo yum install curl"
    echo "  macOS: curl should be pre-installed"
    exit 1
fi

# Run the official OpenCode AI installation command
echo "📥 Downloading and installing OpenCode AI..."
curl -fsSL https://opencode.ai/install | bash opencodeai

echo ""
echo "✅ OpenCode AI installation completed!"
echo ""
echo "📋 Next steps:"
echo "1. Restart your terminal or run: source ~/.bashrc"
echo "2. Verify installation: opencodeai --version"
echo "3. Start using OpenCode AI: opencodeai"
echo ""
echo "🎉 Happy coding with OpenCode AI!"

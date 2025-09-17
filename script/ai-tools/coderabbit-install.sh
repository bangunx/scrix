#!/bin/bash

# CodeRabbit CLI Installation Script
# This script installs CodeRabbit CLI tool using the official installation method

set -euo pipefail  # Exit on any error, undefined vars, pipe failures

echo "🐰 Installing CodeRabbit CLI..."
echo "==============================="

# Check if curl is available
if ! command -v curl &> /dev/null; then
    echo "❌ Error: curl is required but not installed."
    echo "Please install curl first:"
    echo "  Ubuntu/Debian: sudo apt update && sudo apt install curl"
    echo "  CentOS/RHEL: sudo yum install curl"
    echo "  macOS: curl should be pre-installed"
    exit 1
fi

# Run the official CodeRabbit CLI installation command
echo "📥 Downloading and installing CodeRabbit CLI..."
if curl -fsSL https://cli.coderabbit.ai/install.sh | sh; then
    echo ""
    echo "✅ CodeRabbit CLI installation completed!"
    
    # Try to verify installation
    echo "🔍 Verifying installation..."
    if command -v coderabbit &> /dev/null; then
        echo "✅ CodeRabbit command found: $(which coderabbit)"
        if coderabbit --version &> /dev/null; then
            echo "✅ CodeRabbit version: $(coderabbit --version)"
        else
            echo "⚠️  CodeRabbit installed but version check failed"
        fi
    else
        echo "⚠️  CodeRabbit installed but command not found in PATH"
        echo "   You may need to restart your terminal or run: source ~/.bashrc"
    fi
    
    echo ""
    echo "📋 Next steps:"
    echo "1. Restart your terminal or run: source ~/.bashrc"
    echo "2. Verify installation: coderabbit --version"
    echo "3. Configure your API key: coderabbit auth"
    echo "4. Start using CodeRabbit: coderabbit"
    echo ""
    echo "🔑 Don't forget to authenticate with CodeRabbit!"
    echo "   Visit: https://coderabbit.ai for more information"
    echo ""
    echo "🎉 Happy coding with CodeRabbit!"
else
    echo ""
    echo "❌ CodeRabbit CLI installation failed!"
    echo "Please check your internet connection and try again."
    echo "You can also visit: https://coderabbit.ai for manual installation"
    exit 1
fi

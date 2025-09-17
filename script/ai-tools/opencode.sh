#!/bin/bash

# OpenCode AI Installation Script
# This script installs OpenCode AI using the official installation method

set -euo pipefail  # Exit on any error, undefined vars, pipe failures

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
echo "⚠️  Note: This may prompt to replace existing files. Choose 'y' or 'A' to continue."

# Try to run installation with automatic yes responses
if curl -fsSL https://opencode.ai/install | bash -s -- --yes; then
    echo "✅ Installation completed with automatic responses"
elif curl -fsSL https://opencode.ai/install | bash; then
    echo "✅ Installation completed with manual responses"
else
    echo "❌ Installation failed"
    exit 1
fi

echo ""
echo "✅ OpenCode AI installation completed!"

# Try to verify installation
echo "🔍 Verifying installation..."

# Check if opencode binary exists
if [[ -f "/home/$USER/.opencode/bin/opencode" ]]; then
    echo "✅ OpenCode AI binary found: /home/$USER/.opencode/bin/opencode"
    
    # Try to add to PATH temporarily for verification
    export PATH="/home/$USER/.opencode/bin:$PATH"
    
    if command -v opencode &> /dev/null; then
        echo "✅ OpenCode AI command accessible: $(which opencode)"
        if opencode --version &> /dev/null; then
            echo "✅ OpenCode AI version: $(opencode --version)"
        else
            echo "⚠️  OpenCode AI installed but version check failed"
        fi
    else
        echo "⚠️  OpenCode AI binary exists but not in PATH"
    fi
    
    # Check if PATH is configured in bashrc
    if grep -q "opencode/bin" ~/.bashrc; then
        echo "✅ PATH configuration found in ~/.bashrc"
    else
        echo "⚠️  PATH not configured in ~/.bashrc"
        echo "   Adding PATH configuration..."
        echo "" >> ~/.bashrc
        echo "# OpenCode AI" >> ~/.bashrc
        echo "export PATH=\"/home/$USER/.opencode/bin:\$PATH\"" >> ~/.bashrc
        echo "✅ PATH configuration added to ~/.bashrc"
    fi
else
    echo "❌ OpenCode AI binary not found"
    echo "   Installation may have failed"
fi

echo ""
echo "📋 Next steps:"
echo "1. Restart your terminal or run: source ~/.bashrc"
echo "2. Verify installation: opencode --version"
echo "3. Start using OpenCode AI: opencode"
echo "4. For help: opencode --help"
echo ""
echo "🎉 Happy coding with OpenCode AI!"

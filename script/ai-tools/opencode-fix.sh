#!/bin/bash

# OpenCode AI PATH Fix Script
# This script fixes PATH issues and ensures OpenCode AI is accessible

set -euo pipefail  # Exit on any error, undefined vars, pipe failures

echo "🔧 Fixing OpenCode AI PATH configuration..."
echo "=========================================="

# Check if opencode binary exists
if [[ -f "/home/$USER/.opencode/bin/opencode" ]]; then
    echo "✅ OpenCode AI binary found: /home/$USER/.opencode/bin/opencode"
    
    # Add to current session PATH
    export PATH="/home/$USER/.opencode/bin:$PATH"
    echo "✅ Added OpenCode AI to current session PATH"
    
    # Check if PATH is configured in bashrc
    if grep -q "opencode/bin" ~/.bashrc; then
        echo "✅ PATH configuration already exists in ~/.bashrc"
    else
        echo "⚠️  Adding PATH configuration to ~/.bashrc..."
        echo "" >> ~/.bashrc
        echo "# OpenCode AI" >> ~/.bashrc
        echo "export PATH=\"/home/$USER/.opencode/bin:\$PATH\"" >> ~/.bashrc
        echo "✅ PATH configuration added to ~/.bashrc"
    fi
    
    # Verify installation
    echo ""
    echo "🔍 Verifying OpenCode AI..."
    if command -v opencode &> /dev/null; then
        echo "✅ OpenCode AI command accessible: $(which opencode)"
        echo "✅ OpenCode AI version: $(opencode --version)"
        echo ""
        echo "🎉 OpenCode AI is ready to use!"
        echo ""
        echo "📋 Usage examples:"
        echo "  opencode                    # Start OpenCode AI TUI"
        echo "  opencode --help            # Show help"
        echo "  opencode run 'hello world' # Run with message"
        echo "  opencode auth              # Manage credentials"
    else
        echo "❌ OpenCode AI command not accessible"
        echo "   Please restart your terminal or run: source ~/.bashrc"
    fi
    
else
    echo "❌ OpenCode AI binary not found at /home/$USER/.opencode/bin/opencode"
    echo "   Please run the installation script first:"
    echo "   bash script/ai-tools/opencode.sh"
    exit 1
fi

echo ""
echo "✅ OpenCode AI PATH fix completed!"
echo "   Restart your terminal or run 'source ~/.bashrc' to apply changes"

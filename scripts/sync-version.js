#!/usr/bin/env node

/**
 * Sync Version Script for Scrix
 * This script ensures package.json version matches VERSION file
 * Can be run manually or as part of npm scripts
 */

const fs = require('fs');
const path = require('path');

function syncVersion() {
    try {
        // Read VERSION file
        const versionPath = path.join(__dirname, '..', 'VERSION');
        const version = fs.readFileSync(versionPath, 'utf8').trim();
        
        if (!version) {
            console.error('❌ Error: VERSION file is empty');
            process.exit(1);
        }
        
        // Validate version format (semantic versioning)
        const versionRegex = /^\d+\.\d+\.\d+$/;
        if (!versionRegex.test(version)) {
            console.error(`❌ Error: Invalid version format: ${version}`);
            console.error('Version must be in format: X.Y.Z (e.g., 2.0.7)');
            process.exit(1);
        }
        
        // Read package.json
        const packagePath = path.join(__dirname, '..', 'package.json');
        const packageData = JSON.parse(fs.readFileSync(packagePath, 'utf8'));
        
        // Check if version is already correct
        if (packageData.version === version) {
            console.log(`✅ Version already synced: ${version}`);
            return version;
        }
        
        // Update version
        packageData.version = version;
        
        // Write back to package.json with proper formatting
        fs.writeFileSync(packagePath, JSON.stringify(packageData, null, 2) + '\n');
        
        console.log(`✅ Updated package.json version to ${version}`);
        return version;
        
    } catch (error) {
        console.error('❌ Error syncing version:', error.message);
        process.exit(1);
    }
}

// Function to validate sync
function validateSync() {
    try {
        const versionPath = path.join(__dirname, '..', 'VERSION');
        const packagePath = path.join(__dirname, '..', 'package.json');
        
        const version = fs.readFileSync(versionPath, 'utf8').trim();
        const packageData = JSON.parse(fs.readFileSync(packagePath, 'utf8'));
        
        if (packageData.version !== version) {
            console.error(`❌ Version mismatch!`);
            console.error(`VERSION file: ${version}`);
            console.error(`package.json: ${packageData.version}`);
            return false;
        }
        
        console.log(`✅ Version sync validated: ${version}`);
        return true;
        
    } catch (error) {
        console.error('❌ Error validating sync:', error.message);
        return false;
    }
}

// Main execution
if (require.main === module) {
    const command = process.argv[2];
    
    switch (command) {
        case 'sync':
            syncVersion();
            break;
        case 'validate':
            if (!validateSync()) {
                process.exit(1);
            }
            break;
        case 'check':
            validateSync();
            break;
        default:
            // Default behavior: sync version
            syncVersion();
            break;
    }
}

module.exports = { syncVersion, validateSync };

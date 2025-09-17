#!/usr/bin/env node

/**
 * Update package.json version from VERSION file
 * This script is used by GitHub Actions to sync version
 */

const fs = require('fs');
const path = require('path');

function updatePackageVersion() {
    try {
        // Read VERSION file
        const versionPath = path.join(__dirname, '..', 'VERSION');
        const version = fs.readFileSync(versionPath, 'utf8').trim();
        
        // Read package.json
        const packagePath = path.join(__dirname, '..', 'package.json');
        const packageData = JSON.parse(fs.readFileSync(packagePath, 'utf8'));
        
        // Update version
        packageData.version = version;
        
        // Write back to package.json
        fs.writeFileSync(packagePath, JSON.stringify(packageData, null, 2) + '\n');
        
        console.log(`✅ Updated package.json version to ${version}`);
        return version;
    } catch (error) {
        console.error('❌ Error updating package.json:', error.message);
        process.exit(1);
    }
}

// Run if called directly
if (require.main === module) {
    updatePackageVersion();
}

module.exports = updatePackageVersion;

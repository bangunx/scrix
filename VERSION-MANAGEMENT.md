# Version Management Guide for Scrix

## 📋 Overview

Scrix menggunakan sistem version management yang memastikan file `VERSION` dan `package.json` selalu sinkron. File `VERSION` adalah sumber kebenaran untuk versi, dan `package.json` akan otomatis mengikuti.

## 🔧 Scripts Available

### 1. Sync Version Script (`scripts/sync-version.js`)

Script utama untuk sinkronisasi versi antara VERSION file dan package.json.

```bash
# Sync version (default behavior)
node scripts/sync-version.js
node scripts/sync-version.js sync

# Validate version sync
node scripts/sync-version.js validate

# Check version sync status
node scripts/sync-version.js check
```

### 2. Bump and Sync Script (`scripts/bump-and-sync.sh`)

Script untuk bump version dan otomatis sync dengan package.json.

```bash
# Bump patch version (2.0.9 → 2.0.10)
./scripts/bump-and-sync.sh patch

# Bump minor version (2.0.9 → 2.1.0)
./scripts/bump-and-sync.sh minor

# Bump major version (2.0.9 → 3.0.0)
./scripts/bump-and-sync.sh major
```

### 3. NPM Scripts

Package.json menyediakan script npm untuk version management:

```bash
# Sync version manually
npm run sync-version

# Validate version sync
npm run validate-version

# Install globally for testing
npm run install-global
```

## 🔄 Automatic Sync

Version sync otomatis terjadi pada:

- **prepublishOnly**: Sebelum npm publish
- **prepack**: Sebelum npm pack
- **version**: Saat npm version command

## 📝 Workflow Examples

### Manual Version Update

```bash
# 1. Update VERSION file
echo "2.1.0" > VERSION

# 2. Sync with package.json
npm run sync-version

# 3. Validate sync
npm run validate-version

# 4. Commit changes
git add VERSION package.json
git commit -m "chore: bump version to 2.1.0"

# 5. Publish
npm publish
```

### Automated Version Bump

```bash
# 1. Bump and sync automatically
./scripts/bump-and-sync.sh patch

# 2. Commit and push (script will show instructions)
git add VERSION package.json
git commit -m "chore: bump version to 2.0.10"
git push

# 3. Publish
npm publish
```

### GitHub Actions Integration

Workflow GitHub Actions otomatis menggunakan script sync-version.js:

```yaml
- name: Check and bump version if needed
  run: |
    # Script akan otomatis sync versi
    node scripts/sync-version.js sync
```

## 🛠️ Development Workflow

### 1. Development Phase

```bash
# Work on features
git checkout -b feature/new-feature

# Make changes
# ...

# Before committing, ensure version is synced
npm run validate-version
```

### 2. Release Phase

```bash
# Bump version
./scripts/bump-and-sync.sh patch

# Commit version bump
git add VERSION package.json
git commit -m "chore: bump version to 2.0.10"

# Push to trigger GitHub Actions
git push

# Or publish manually
npm publish
```

### 3. Post-Release

```bash
# Verify published version
npm view scrix version

# Check if sync is working
npm run validate-version
```

## 🔍 Troubleshooting

### Version Mismatch

Jika ada mismatch antara VERSION file dan package.json:

```bash
# Check current status
npm run validate-version

# Fix by syncing
npm run sync-version

# Verify fix
npm run validate-version
```

### Invalid Version Format

Script akan memvalidasi format versi (semantic versioning):

```bash
# Valid formats
2.0.9
1.0.0
10.5.2

# Invalid formats
2.0.9-beta
v2.0.9
2.0
```

### NPM Publish Issues

Jika ada masalah saat publish:

```bash
# Check if version exists on NPM
npm view scrix@2.0.9 version

# If exists, bump to next version
./scripts/bump-and-sync.sh patch

# Then publish
npm publish
```

## 📊 Version History

Track semua perubahan versi:

```bash
# View VERSION file history
git log --oneline VERSION

# View package.json version history
git log --oneline package.json

# View NPM published versions
npm view scrix versions --json
```

## 🎯 Best Practices

1. **Always use VERSION file** sebagai sumber kebenaran
2. **Run validate-version** sebelum commit
3. **Use bump-and-sync.sh** untuk perubahan versi
4. **Test locally** sebelum publish
5. **Keep versions semantic** (major.minor.patch)

## 🔗 Related Files

- `VERSION` - Source of truth for version
- `package.json` - NPM package configuration
- `scripts/sync-version.js` - Version sync script
- `scripts/bump-and-sync.sh` - Version bump script
- `.github/workflows/npm-publish.yml` - GitHub Actions workflow

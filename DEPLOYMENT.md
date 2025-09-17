# Deployment Guide for Scrix

## 🚀 Automated NPM Deployment

Scrix menggunakan GitHub Actions untuk deployment otomatis ke NPM berdasarkan file `VERSION`.

### 📋 Prerequisites

1. **NPM Account**: Buat akun di [npmjs.com](https://www.npmjs.com/)
2. **NPM Token**: Generate access token di NPM
3. **GitHub Secrets**: Tambahkan `NPM_TOKEN` di GitHub repository settings

### 🔧 Setup GitHub Secrets

1. Pergi ke repository GitHub → Settings → Secrets and variables → Actions
2. Klik "New repository secret"
3. Name: `NPM_TOKEN`
4. Value: Token NPM Anda
5. Klik "Add secret"

### 📦 Version Management

#### File VERSION
Versi dikelola melalui file `VERSION` di root repository:
```
2.0.0
```

#### Bump Version
Gunakan script untuk update version:

```bash
# Patch version (2.0.0 → 2.0.1)
./scripts/bump-version.sh patch

# Minor version (2.0.0 → 2.1.0)
./scripts/bump-version.sh minor

# Major version (2.0.0 → 3.0.0)
./scripts/bump-version.sh major
```

### 🔄 Deployment Process

#### Automatic Deployment
Deployment otomatis terjadi ketika:

1. **Push ke main branch** dengan perubahan di:
   - `VERSION` file
   - `package.json`
   - `install.sh`
   - `bin/` directory
   - `script/` directory

2. **Manual trigger** via GitHub Actions tab

#### Manual Deployment
```bash
# Update version
./scripts/bump-version.sh patch

# Push changes
git push && git push --tags

# GitHub Actions akan otomatis deploy ke NPM
```

### 📝 Workflow Steps

1. **Checkout code**
2. **Setup Node.js**
3. **Read version** dari VERSION file
4. **Update package.json** dengan version baru
5. **Validate package**
6. **Run tests**
7. **Publish to NPM**
8. **Create GitHub Release**
9. **Update VERSION** untuk next release

### 🧪 Testing Deployment

#### Local Testing
```bash
# Test package validation
npm pack --dry-run

# Test local installation
npm install -g .

# Test command
scrix --help
```

#### Pre-deployment Checklist
- [ ] VERSION file updated
- [ ] All tests passing
- [ ] package.json valid
- [ ] NPM_TOKEN configured
- [ ] Changes committed and pushed

### 🐛 Troubleshooting

#### Common Issues

1. **NPM_TOKEN not found**
   - Pastikan secret `NPM_TOKEN` sudah ditambahkan di GitHub
   - Token harus memiliki permission `publish`

2. **Version already exists**
   - Update VERSION file dengan version baru
   - Pastikan version belum pernah dipublish

3. **Package validation failed**
   - Check package.json syntax
   - Pastikan semua file required ada di package

4. **Tests failing**
   - Fix test issues sebelum deployment
   - Check test-install.sh script

### 📊 Monitoring

- **GitHub Actions**: Check workflow status di Actions tab
- **NPM Package**: Monitor di [npmjs.com/package/scrix](https://www.npmjs.com/package/scrix)
- **GitHub Releases**: Check releases di repository

### 🔒 Security

- NPM_TOKEN disimpan sebagai GitHub Secret
- Token hanya digunakan untuk publish, tidak untuk read
- Workflow hanya berjalan di main branch
- Semua dependencies menggunakan versi yang ditentukan

### 📈 Best Practices

1. **Semantic Versioning**: Gunakan semver (major.minor.patch)
2. **Changelog**: Update CHANGELOG.md untuk setiap release
3. **Testing**: Pastikan semua test pass sebelum deployment
4. **Documentation**: Update README jika ada perubahan signifikan
5. **Rollback**: Siapkan plan untuk rollback jika ada issue

### 🎯 Quick Commands

```bash
# Bump patch version and deploy
./scripts/bump-version.sh patch && git push && git push --tags

# Check current version
cat VERSION

# Test package locally
npm pack --dry-run

# Install locally for testing
npm install -g .
```

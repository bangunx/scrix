# Scrix - HADES Script Collection Management System

🚀 **Scrix** adalah sistem manajemen koleksi skrip interaktif yang memungkinkan Anda mengelola dan menjalankan berbagai skrip development, AI tools, git tools, dan security tools dengan mudah.

Repo: [bangunx/scrix](https://github.com/bangunx/scrix)

## 🎯 Fitur Utama

- **Interactive Menu System** - Interface yang user-friendly dengan kategori terorganisir
- **AI Tools** - OpenCode AI, OpenAI Codex, Google Gemini, Qwen Code, CodeRabbit
- **Development Tools** - Docker, Tmux, Zsh, GitHub integration
- **Git Tools** - Git configuration, GitHub connection utilities
- **VM Security** - Server hardening, security audits, SSH configuration
- **Cross-platform** - Support Linux dan macOS
- **Idempotent** - Aman dijalankan berulang kali

## 📦 Instalasi

### 🚀 Cara Tercepat - NPM Global Install

```bash
npm install -g scrix
```

Setelah instalasi, jalankan:
```bash
scrix
```

### 📥 Cara Manual - One-liner

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/bangunx/scrix/main/install.sh)
```

### 🛠️ Cara Lokal

```bash
git clone https://github.com/bangunx/scrix.git
cd scrix
chmod +x install.sh
./install.sh
```

## 📋 Prasyarat

- **Node.js** (untuk instalasi npm) - [Download](https://nodejs.org/)
- **bash** - Terminal shell
- **git** - Version control
- **curl** - Download utility

### Cara Lokal
1) Clone repo (jika belum):
```bash
git clone https://github.com/localan/my-script "$HOME/my-script"
```
2) Jalankan installer:
```bash
cd "$HOME/my-script"
./install.sh
```

### Cara Kerja
- Jika dijalankan via curl, skrip akan:
  - Clone ke `MY_SCRIPT_DIR` (default: `$HOME/my-script`) bila belum ada, atau `git pull` bila sudah ada.
  - Menjalankan `install.sh` lokal dengan mode interaktif.
- Installer menampilkan daftar skrip `.sh` di `script/` dan mendukung:
  - Memilih beberapa nomor sekaligus (mis. `1 3 5`)
  - Memilih semua (`a`)
  - Keluar (`q`)
  - Konfirmasi sebelum eksekusi dan opsi lanjut/berhenti jika ada error per skrip

### Variabel Lingkungan
- `MY_SCRIPT_REPO_URL`: URL git repo (default: `https://github.com/localan/my-script`).
- `MY_SCRIPT_DIR`: Lokasi direktori repo lokal (default: `$HOME/my-script`).

Contoh:
```bash
MY_SCRIPT_DIR="/opt/my-script" bash <(curl -L link.dwx.my.id/my-script)
```

### Troubleshooting
- "command not found: git" → install `git` terlebih dahulu.
- "command not found: curl" → install `curl` terlebih dahulu.
- "Permission denied" saat menjalankan lokal → pastikan executable:
  ```bash
  chmod +x ./install.sh
  ```
- Koneksi lambat/gagal → coba ulang beberapa saat kemudian atau periksa koneksi/Firewall/Proxy.

### Lisensi
Gunakan sesuai kebutuhan Anda. Jika ingin menambah skrip, letakkan file `.sh` baru di folder `script/`.

### Microsoft Activation
```bash
irm https://link.dwx.my.id/mas | iex
```
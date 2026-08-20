
<p align="center">
  <img src="icon.jpeg" alt="tg-sync logo" width="150px"/>
</p>


# tg-sync: Telegram Git Sync

`tg-sync` is a CLI tool designed to automatically package your modified, staged, and untracked files into a ZIP archive and send it to a designated Telegram chat or channel via a Telegram Bot. It is perfect for backing up code on the go, sharing quick diffs, or logging updates.

## Features

- **Automated Packaging:** Automatically detects unstaged, staged, and untracked files (excluding `.env`, zip files, and `venv` files), zipping them while preserving their directory structure.
- **Debian Support:** Build a native `.deb` package to install `tg-sync` globally using your package manager, which manages all dependencies automatically.
- **Telegram Integration:** Sends the ZIP archive as a document directly to your Telegram chat.
- **Cleanup:** Automatically deletes the temporary local archive after a successful upload.
- **Flexible Options:** Supports sending custom messages with the upload and syncing all tracked files instead of just modifications.
- **Interactive Configuration:** Simple configuration wizard that prompts you for your token and chat ID if missing, ensuring credentials are saved securely.

## Prerequisites

- Python 3.x
- Git
- A Telegram Bot token (from [@BotFather](https://t.me/BotFather))
- Your Telegram Chat ID (you can get this from bots like [@userinfobot](https://t.me/userinfobot))

## Installation

### Option 1: Native Debian Package Installation (Recommended)

1. Build the Debian package:
   ```bash
   ./build_deb.sh
   ```
2. Install the generated `.deb` package via `apt`:
   ```bash
   sudo apt install ./tele-git_1.0.0_all.deb
   ```

### Option 2: Script-based Global Installation

1. Clone this repository to your local system:
   ```bash
   git clone <your-repository-url>
   ```
2. Set up a Python virtual environment and install dependencies:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```
3. Install the tool globally (creates a wrapper in `~/.local/bin/tg-sync`):
   ```bash
   ./setup.sh
   ```
   *Make sure `~/.local/bin` is in your system's `PATH`.*

## Configuration

`tg-sync` features a built-in interactive configuration wizard that will run **exactly once** on your first execution if credentials are not already set.

Alternatively, you can manually trigger the wizard or check status:
```bash
# Start configuration wizard
tg-sync config   # or: tg-sync init

# Show the version of tg-sync
tg-sync --version
```

You can also use environment variables (`TELEGRAM_BOT_TOKEN` and `CHAT_ID`) or a `.env` file directly.

## Usage

Run `tg-sync` from anywhere in your git repository:

```bash
# Sync modified, staged, and untracked files with a default message
tg-sync

# Sync files with a custom message
tg-sync -m "Refactoring core architecture"

# Sync all tracked files in the repository
tg-sync --all
```

## Security

The `.env` file containing your Telegram Bot Token and Chat ID is listed in `.gitignore` to prevent you from accidentally committing credentials to public repositories. Never commit your active `.env` file. If using the Debian package, the configuration is stored securely at `/etc/tele-git/.env`.

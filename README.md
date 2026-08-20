
<p align="center">
  <img src="icon.jpeg" alt="tg-sync logo" width="150px"/>
</p>


# tg-sync: Telegram Git Sync

`tg-sync` is a CLI tool designed to automatically package your modified, staged, and untracked files into a ZIP archive and send it to a designated Telegram chat or channel via a Telegram Bot. It is perfect for backing up code on the go, sharing quick diffs, or logging updates.

## Features

- **Automated Packaging:** Automatically detects unstaged, staged, and untracked files (excluding `.env`, zip files, and `venv` files), zipping them while preserving their directory structure.
- **Telegram Integration:** Sends the ZIP archive as a document directly to your Telegram chat.
- **Cleanup:** Automatically deletes the temporary local archive after a successful upload.
- **Flexible Options:** Supports sending custom messages with the upload and syncing all tracked files instead of just modifications.
- **Private Configuration:** Uses a Git-ignored `.env` file for credentials to keep them secure.

## Prerequisites

- Python 3.x
- A Telegram Bot token (from [@BotFather](https://t.me/BotFather))
- Your Telegram Chat ID (you can get this from bots like [@userinfobot](https://t.me/userinfobot))

## Installation

1. Clone this repository to your local system:
   ```bash
   git clone <your-repository-url>
   cd tele_git-
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

1. Copy the template configuration file:
   ```bash
   cp .env.example .env
   ```
2. Open `.env` and replace the placeholder credentials with your actual Telegram bot token and chat ID:
   ```env
   TELEGRAM_BOT_TOKEN=your_real_bot_token_here
   CHAT_ID=your_real_chat_id_here
   ```

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

The `.env` file containing your Telegram Bot Token and Chat ID is listed in `.gitignore` to prevent you from accidentally committing credentials to public repositories. Never commit your active `.env` file.

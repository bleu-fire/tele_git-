#!/bin/bash
# setup.sh: Installs tg-sync as a global command in ~/.local/bin/tg-sync

INSTALL_DIR="$HOME/.local/bin"
# Get the absolute path of the directory containing this script
REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_PATH="$REPO_DIR/main.py"

# Ensure target directory exists
mkdir -p "$INSTALL_DIR"

# Create the wrapper script
cat << EOF > "$INSTALL_DIR/tg-sync"
#!/bin/bash
ENV_FILE="$REPO_DIR/.env"

configure_env() {
    echo "==========================================="
    echo "       tg-sync Configuration Wizard        "
    echo "==========================================="
    read -p "Enter your Telegram Bot Token: " bot_token
    read -p "Enter your Telegram Chat ID: " chat_id
    
    echo "TELEGRAM_BOT_TOKEN=\$bot_token" > "\$ENV_FILE"
    echo "CHAT_ID=\$chat_id" >> "\$ENV_FILE"
    echo "Configuration saved to \$ENV_FILE!"
    echo "==========================================="
}

if [ "\$1" = "--version" ] || [ "\$1" = "-v" ]; then
    echo "tg-sync version 1.0.0"
    exit 0
fi

if [ "\$1" = "config" ] || [ "\$1" = "configure" ] || [ "\$1" = "init" ]; then
    configure_env
    exit 0
fi

if [ -n "\$TELEGRAM_BOT_TOKEN" ] && [ -n "\$CHAT_ID" ]; then
    :
else
    if [ -f "\$ENV_FILE" ]; then
        export \$(grep -v '^#' "\$ENV_FILE" | xargs 2>/dev/null)
    fi

    if [ -z "\$TELEGRAM_BOT_TOKEN" ] || [ -z "\$CHAT_ID" ] || [ "\$TELEGRAM_BOT_TOKEN" = "your_telegram_bot_token_here" ] || [ "\$CHAT_ID" = "your_chat_id_here" ]; then
        echo "tg-sync credentials are not configured."
        configure_env
    fi
fi

VENV_PYTHON="$REPO_DIR/venv/bin/python"
SCRIPT_PATH="$REPO_DIR/main.py"
"\$VENV_PYTHON" "\$SCRIPT_PATH" "\$@"
EOF

# Make executable
chmod +x "$INSTALL_DIR/tg-sync"
chmod +x "$SCRIPT_PATH"

echo "tg-sync has been successfully installed to $INSTALL_DIR/tg-sync"
echo "Please ensure $INSTALL_DIR is in your system PATH."

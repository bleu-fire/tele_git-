#!/bin/bash
# build_deb.sh: Script to build a Debian package (.deb) for tele-git / tg-sync

set -e

PKG_DIR="tele-git_1.0.0_all"
rm -rf "$PKG_DIR"

echo "Creating package directory structure..."
mkdir -p "$PKG_DIR/DEBIAN"
mkdir -p "$PKG_DIR/usr/bin"
mkdir -p "$PKG_DIR/usr/share/tele-git/core"

# Copy python files
echo "Copying application source files..."
cp main.py "$PKG_DIR/usr/share/tele-git/"
cp core/*.py "$PKG_DIR/usr/share/tele-git/core/"

# Write control file
echo "Writing DEBIAN/control file..."
cat << 'EOF' > "$PKG_DIR/DEBIAN/control"
Package: tele-git
Version: 1.0.0
Section: utils
Priority: optional
Architecture: all
Depends: python3, python3-requests, python3-dotenv, git
Maintainer: bluefire <mohamed.harbouli.hb@gmail.com>
Description: Automatically package and sync modified git files to Telegram.
EOF

# Write bin wrapper
echo "Writing usr/bin/tg-sync wrapper..."
cat << 'EOF' > "$PKG_DIR/usr/bin/tg-sync"
#!/bin/bash
ENV_FILE="/etc/tele-git/.env"

configure_env() {
    echo "==========================================="
    echo "       tg-sync Configuration Wizard        "
    echo "==========================================="
    read -p "Enter your Telegram Bot Token: " bot_token
    read -p "Enter your Telegram Chat ID: " chat_id
    
    sudo mkdir -p /etc/tele-git
    echo "TELEGRAM_BOT_TOKEN=$bot_token" | sudo tee "$ENV_FILE" > /dev/null
    echo "CHAT_ID=$chat_id" | sudo tee -a "$ENV_FILE" > /dev/null
    sudo chmod 600 "$ENV_FILE"
    echo "Configuration saved to $ENV_FILE!"
    echo "==========================================="
}

if [ "$1" = "--version" ] || [ "$1" = "-v" ]; then
    echo "tg-sync version 1.0.0"
    exit 0
fi

if [ "$1" = "config" ] || [ "$1" = "configure" ] || [ "$1" = "init" ]; then
    configure_env
    exit 0
fi

if [ -n "$TELEGRAM_BOT_TOKEN" ] && [ -n "$CHAT_ID" ]; then
    :
else
    if [ -f "$ENV_FILE" ]; then
        export $(grep -v '^#' "$ENV_FILE" | xargs 2>/dev/null)
    fi

    if [ -z "$TELEGRAM_BOT_TOKEN" ] || [ -z "$CHAT_ID" ] || [ "$TELEGRAM_BOT_TOKEN" = "your_telegram_bot_token_here" ] || [ "$CHAT_ID" = "your_chat_id_here" ]; then
        if [ -f "./.env" ]; then
            export $(grep -v '^#' "./.env" | xargs 2>/dev/null)
        fi
        
        if [ -z "$TELEGRAM_BOT_TOKEN" ] || [ -z "$CHAT_ID" ] || [ "$TELEGRAM_BOT_TOKEN" = "your_telegram_bot_token_here" ] || [ "$CHAT_ID" = "your_chat_id_here" ]; then
            echo "tg-sync credentials are not configured."
            configure_env
        fi
    fi
fi

python3 /usr/share/tele-git/main.py "$@"
EOF

chmod +x "$PKG_DIR/usr/bin/tg-sync"

# Build package
echo "Building Debian package..."
dpkg-deb --root-owner-group --build "$PKG_DIR"

# Clean up
rm -rf "$PKG_DIR"

echo "Successfully built tele-git_1.0.0_all.deb!"

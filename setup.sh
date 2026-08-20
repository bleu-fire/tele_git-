#!/bin/bash
# setup.sh: Installs tg-sync as a global command in ~/.local/bin/tg-sync

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_PATH="$HOME/tele_git-/main.py"

# Ensure target directory exists
mkdir -p "$INSTALL_DIR"

# Create the wrapper script
cat << 'EOF' > "$INSTALL_DIR/tg-sync"
#!/bin/bash
VENV_PYTHON="$HOME/tele_git-/venv/bin/python"
SCRIPT_PATH="$HOME/tele_git-/main.py"
"$VENV_PYTHON" "$SCRIPT_PATH" "$@"
EOF

# Make executable
chmod +x "$INSTALL_DIR/tg-sync"
chmod +x "$SCRIPT_PATH"

echo "tg-sync has been successfully installed to $INSTALL_DIR/tg-sync"
echo "Please ensure $INSTALL_DIR is in your system PATH."

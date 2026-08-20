import os
import sys
from dotenv import load_dotenv

from core.cli import parse_args
from core.git_handler import get_files_to_sync
from core.archiver import create_archive
from core.telegram_api import send_to_telegram

def main():
    # Load .env file configurations
    load_dotenv()

    # Fallback to tool directory .env if credentials are not found in CWD
    if not os.getenv("TELEGRAM_BOT_TOKEN") or not os.getenv("CHAT_ID"):
        script_dir = os.path.dirname(os.path.abspath(__file__))
        fallback_env = os.path.join(script_dir, ".env")
        if os.path.exists(fallback_env):
            load_dotenv(fallback_env)

    args = parse_args()

    token = os.getenv("TELEGRAM_BOT_TOKEN")
    chat_id = os.getenv("CHAT_ID")

    try:
        # Fetch file list
        files = get_files_to_sync(sync_all=args.all)

        if not files:
            print("No modified or untracked files found to sync.")
            return

        print(f"Found {len(files)} file(s) to sync:")
        for file in files:
            print(f"  - {file}")

        # Archive files
        print("\nCreating archive...")
        archive_path = create_archive(files)
        if not archive_path:
            print("Error: Failed to create archive.")
            return

        print(f"Created archive: {archive_path}")

        # Prepare description message
        caption = args.message if args.message else f"tg-sync: Syncing {len(files)} file(s)"

        # Send to Telegram
        print("Uploading archive to Telegram...")
        send_to_telegram(token, chat_id, archive_path, caption=caption)
        print("Successfully synced with Telegram!")

        # Clean up local archive to keep workspace clean 
        if os.path.exists(archive_path):
            os.remove(archive_path)
            print("Cleaned up temporary archive.")

    except Exception as e:
        print(f"\nExecution failed: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()

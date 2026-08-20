import argparse

def parse_args():
    parser = argparse.ArgumentParser(
        description="tg-sync: Automatically package and sync modified git files to Telegram."
    )
    parser.add_argument(
        "-m", "--message",
        type=str,
        default="",
        help="Commit-style message to accompany the files sent to Telegram."
    )
    parser.add_argument(
        "-a", "--all",
        action="store_true",
        help="Sync all files tracked by git, rather than only modified/untracked ones."
    )
    return parser.parse_args()

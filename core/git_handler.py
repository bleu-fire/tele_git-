import subprocess
import os

def get_files_to_sync(sync_all=False):
    """
    Retrieves a list of files to sync.
    If sync_all is True, returns all tracked files in the repository.
    Otherwise, returns modified, staged, and untracked files.
    """
    if not os.path.exists(".git"):
        raise RuntimeError("Error: Current directory is not a git repository.")

    if sync_all:
        cmd = ["git", "ls-files"]
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        files = result.stdout.splitlines()
        return sorted([f for f in files if os.path.exists(f) and os.path.isfile(f)])

    files = set()

    # 1. Unstaged changes (modified files)
    res_unstaged = subprocess.run(["git", "diff", "--name-only"], capture_output=True, text=True, check=True)
    files.update(res_unstaged.stdout.splitlines())

    # 2. Staged changes
    res_staged = subprocess.run(["git", "diff", "--cached", "--name-only"], capture_output=True, text=True, check=True)
    files.update(res_staged.stdout.splitlines())

    # 3. Untracked files (respecting .gitignore)
    res_untracked = subprocess.run(["git", "ls-files", "--others", "--exclude-standard"], capture_output=True, text=True, check=True)
    files.update(res_untracked.stdout.splitlines())

    # Ensure all paths exist and are files (exclude directories, venv files, and self-generated zip/env if not gitignored)
    clean_files = []
    for f in files:
        if os.path.exists(f) and os.path.isfile(f):
            # Explicit safety checks just in case
            base = os.path.basename(f)
            if base == ".env" or f.startswith("venv/") or f.endswith(".zip"):
                continue
            clean_files.append(f)

    return sorted(clean_files)

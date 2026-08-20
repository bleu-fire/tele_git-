import zipfile
import os
from datetime import datetime

def create_archive(files, output_dir="."):
    """
    Zips the provided list of files into a single archive file, maintaining directory structures.
    Returns the path of the generated ZIP file, or None if the list is empty.
    """
    if not files:
        return None

    # Get project name from the repository root directory
    repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    project_name = os.path.basename(repo_root) or "sync"

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    zip_name = f"{project_name}_{timestamp}.zip"
    zip_path = os.path.join(output_dir, zip_name)

    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zipf:
        for file_path in files:
            zipf.write(file_path, arcname=file_path)

    return zip_path

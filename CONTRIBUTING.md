# Contributing to tg-sync

First off, thank you for taking the time to contribute! Contributions from the open-source community are what make tools like `tg-sync` great.

Here is a guide on how you can get started and contribute to this project.

## How Can I Contribute?

### 1. Reporting Bugs & Feature Requests
* Search the existing Issues on GitHub before opening a new one.
* If you find a new bug, please file a detailed Issue containing:
  * Your operating system and Python version.
  * Clear steps to reproduce the bug.
  * Expected vs. actual behavior.
  * Relevant logs or error traces.

### 2. Suggesting Enhancements
* Open an Issue detailing the enhancement, why it is useful, and how it might be implemented.

### 3. Submitting Pull Requests (PRs)
* Fork the repository and create your branch from `main`.
* If you've added code that should be tested, add tests.
* Ensure the code conforms to standard Python code style conventions (PEP 8).
* Write clear, descriptive commit messages.
* Submit the PR and wait for a review!

---

## Development Setup

1. **Clone your fork:**
   ```bash
   git clone https://github.com/bleu-fire/tele_git-.git
   cd tele_git-
   ```

2. **Set up a virtual environment:**
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

3. **Verify the installation globally:**
   ```bash
   ./setup.sh
   ```

4. **Testing Debian packaging:**
   Make sure you are on a Debian-based system (Debian, Ubuntu, Mint, etc.) and run:
   ```bash
   ./build_deb.sh
   sudo apt install ./tele-git_1.0.0_all.deb
   ```

## Code of Conduct

Please be respectful, kind, and collaborative in all communication channels. We aim to keep this community open and welcoming to everyone.

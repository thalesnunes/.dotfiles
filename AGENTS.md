# AI Agent Guidelines for `.dotfiles`

Welcome, AI agent! This repository contains system dotfiles and configuration scripts. To ensure you do not break user configurations, compromise sensitive information, or violate repository design patterns, follow these rules strictly.

---

## 🔒 Security & Privacy Boundaries
> [!IMPORTANT]
> **NEVER read, view, list, grep, or search files/directories under `private/`** unless the user has explicitly requested or allowed it in the current conversation.
>
> Avoid executing commands that could leak details from the `private/` directory. Always respect the privacy boundary of user secrets, tokens, and personal configuration files stored there.

---

## 📦 Package Management & Symlinks (GNU Stow)

This repository uses [GNU Stow](https://www.gnu.org/software/stow/) to manage symlinks to the user's home directory (and optionally `/` root directory).

### 1. Repository Structure
Each top-level directory (except for system directories like `.git`, `private`, `root`) represents a "package" or "profile" containing the configuration files mirroring the structure of the user's home directory.

For example:
- `nvim/.config/nvim/init.lua` symlinks to `~/.config/nvim/init.lua`
- `tmux/.config/tmux/tmux.conf` symlinks to `~/.config/tmux/tmux.conf`
- `bin/.local/bin/custom-script` symlinks to `~/.local/bin/custom-script`

### 2. Modifying Dotfiles
- **Do NOT write files directly to the user's `~` (home) or `~/.config/` directories.**
- If you need to edit or create a configuration file:
  1. Locate the corresponding package folder in this repository (e.g., `nvim/`, `sway/`, `zsh/`).
  2. Perform the edit or create the file within the package folder, mirroring the path relative to home.
  3. If you create a brand new package, place it in the root of the repository following the Stow directory structure.

### 3. Applying Changes
- After updating or adding configuration files within the repository, the symlinks must be updated.
- Instruct the user to run the installation script to safely resolve conflicts and apply the updates:
  ```bash
  ./install_dotfiles.sh
  ```
- **Do not** invoke `stow` or `./install_dotfiles.sh` automatically in the background unless explicitly requested, as it prompts the user for conflict resolution and confirmation.

---

## 🛠️ System Packages & Setup Scripts
If the user requests to add, remove, or modify default system packages, modify the appropriate package list:
- [packages_arch](file:///home/thales/projects/dotfiles/packages_arch)
- [packages_ubuntu](file:///home/thales/projects/dotfiles/packages_ubuntu)
- [pipx_packages](file:///home/thales/projects/dotfiles/pipx_packages)
- [python_packages](file:///home/thales/projects/dotfiles/python_packages)

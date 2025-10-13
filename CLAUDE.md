# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that uses [rcm](https://github.com/thoughtbot/rcm) for managing configuration files across Linux, macOS (Darwin), and Windows (WSL2/MSYS2/Cygwin) environments. The repository contains shell configurations, Neovim setup (using LazyVim), tmux settings, git configurations, and various utility scripts.

## Setup and Installation

### Initial Setup
```bash
./setup
```

This script handles the complete setup process:
1. Installs and configures `rcm` (if not present)
2. Symlinks dotfiles using `rcup` with platform-specific tags (Linux/Darwin)
3. Installs `nvm` and Node.js LTS
4. Installs `rvm` and Ruby 3.4.4
5. Initializes Neovim configuration

### Updating Dotfiles
After making changes to dotfiles, use rcm to update symlinks:
```bash
# Update with verbose output for current platform
RCRC=./rcrc rcup -v

# Platform-specific updates
RCRC=./rcrc rcup -t Linux -v    # For Linux
RCRC=./rcrc rcup -t Darwin -v   # For macOS
```

### Neovim Setup
Neovim configuration lives in `config/nvim/`:
```bash
# Initialize/update Neovim setup
. "$HOME/.config/nvim/setup"
```

## Architecture

### RCM Configuration Structure
The `rcrc` file defines how dotfiles are managed:
- **DOTFILES_DIRS**: `$HOME/src/dotfiles`
- **TAGS**: Platform-specific configs (Linux, Darwin, MSYS, Cygwin)
- **SYMLINK_DIRS**: Directories symlinked wholesale (e.g., `config/nvim`)
- **EXCLUDES**: Files not symlinked (README.md, setup scripts, etc.)
- **UNDOTTED**: Directories copied without dot prefix (e.g., `bin/`)

### Bash Configuration Loading Order
The `bashrc` uses a multi-stage loading system via `_source_dir()` that sources files from `~/.bash/` in a specific order:

1. **bash.1.d/**: Early initialization (TERM, LANG, XDG settings) - must run before tmux
2. **bash.2.d/**: Main configuration (aliases, environment, language runtimes, prompt, fzf, etc.)
3. **bash.3.d/**: Path reordering and final adjustments
4. **bash.4.d/**: Late-stage configurations
5. **bash_completion.d/**: Bash completion scripts (sourced separately via bash_completion system)

Critical: Scripts in `bash.1.d/` set terminal and locale settings required before tmux starts.

### Neovim Configuration
Uses **LazyVim** as the base configuration:
- **Entry point**: `config/nvim/init.lua` → `config/nvim/lua/config/lazy.lua`
- **Plugin management**: lazy.nvim with LazyVim as base
- **Custom plugins**: Located in `config/nvim/lua/plugins/`
- **Custom keymaps**: `config/nvim/lua/config/keymaps.lua`
- **Custom autocommands**: `config/nvim/lua/config/autocmds.lua`
- **Colorscheme**: Solarized (configured in plugins)

Notable plugins:
- blink-cmp (completion)
- neo-tree (file explorer)
- treesitter (syntax highlighting)
- fzf (fuzzy finder)
- fugitive (git integration)
- conform (formatting)
- Various LSP configurations

### Git Configuration
The `gitconfig` uses conditional includes for different contexts:
- **~/.gitconfig_local**: Include local overrides
- **~/.gitconfig_github**: Settings for personal GitHub projects (via includeIf)
- **~/.gitconfig_work**: Settings for work projects (via includeIf)

This allows different user.name/user.email per directory.

### Tmux Configuration
- **Main config**: `tmux.conf`
- **Platform-specific**: Sources `~/.tmux.platform.conf` at end
- **Color scheme**: Sources `~/.tmux.solarizeddark.conf`
- **Prefix**: Ctrl-a (not default Ctrl-b)
- **Vi mode**: Uses vi keybindings for copy mode and status line
- **Pane navigation**: h/j/k/l for movement, H/J/K/L for resizing
- **Modern terminal features**: Supports 256 color, true color, cursor shapes

### Utility Scripts (bin/)
The `bin/` directory contains various utility scripts including:
- Git utilities: `gitgrepall`, `gitdiffbinstat`, `git-file-size-diff`, `sepCommits.sh`
- Editor helpers: `vimFind`, `markdown2ctags`
- Local tool wrappers: `tscLocal.sh`, `sassLocal.sh`, `eslintLocal.sh` (run locally installed tools)
- Media utilities: `rotateImage.sh`, `rotatePDF.sh`, `removeVideoMetaData.sh`
- Development: `httphere` (simple HTTP server), `curltime` (curl with timing)
- Fun: `weather`, `pipes.sh`, `rain.sh`

## Platform-Specific Notes

### WSL2 (Windows Subsystem for Linux)
The `bashrc` detects WSL2 (`/etc/wsl.conf`) and configures:
- `$DISPLAY` for X server support (reads from `/etc/resolv.conf`)
- `LIBGL_ALWAYS_INDIRECT=0` for direct rendering

### macOS (Darwin)
- Homebrew initialization: Checks `/opt/homebrew/bin/brew` (Apple Silicon) first
- Different package management in setup script (brew vs apt-get)

### Cygwin/MSYS2
- Specific mount configurations documented in README.md
- Symbolic link creation requires admin privileges on older Windows versions

## Development Environment Tools

### Node.js
- Managed via nvm in `$HOME/.config/nvm`
- LTS version installed by default

### Ruby
- Managed via rvm
- Default: Ruby 3.4.4

### Python
- Neovim Python venv: `config/nvim/pynvim-venv/`

### Shell
- Default: bash with vi mode (`set -o vi`)
- Auto-starts tmux on xterm-based terminals (non-SSH)

## Git Workflow

### Common Aliases
The gitconfig provides many aliases:
- `st` - status in short format
- `co` - checkout
- `ci` - commit
- `br` - branch
- `ls` - pretty log with colors
- `ll` - log with changed files
- `f` - find files by name
- `gr` - grep case-insensitive
- `la` - list all git aliases

### Delta Integration
Uses [delta](https://github.com/dandavison/delta) as the pager for better diff viewing with syntax highlighting and navigation (n/N keys).

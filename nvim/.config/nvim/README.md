# Neovim Config
<a href="https://dotfyle.com/whleucka/stow-dotfiles-nvim-config-nvim"><img src="https://dotfyle.com/whleucka/stow-dotfiles-nvim-config-nvim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/whleucka/stow-dotfiles-nvim-config-nvim"><img src="https://dotfyle.com/whleucka/stow-dotfiles-nvim-config-nvim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/whleucka/stow-dotfiles-nvim-config-nvim"><img src="https://dotfyle.com/whleucka/stow-dotfiles-nvim-config-nvim/badges/plugin-manager?style=flat" /></a>

Welcome to my Neovim configuration! This repository contains my personal Neovim setup, which I've fine-tuned for a smooth and productive editing experience using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

## Features

- Fast and responsive editing.
- Syntax highlighting and code completion.
- Keybindings for quick navigation and editing.
- A collection of carefully selected plugins for enhanced functionality.

## Screenshots
![image](https://github.com/user-attachments/assets/7d94d873-c965-43d2-8227-e60e85600ece)

## Installation

To use my Neovim configuration with lazy.nvim, follow these simple steps:

1. Ensure you have Neovim installed on your system.

2. Clone this repository

   ```shell
   git clone https://github.com/whleucka/stow-dotfiles.git
   ```

3. Use GNU `stow` to symlink configuration.

   ```shell
   cd stow-dotfiles
   stow nvim
   ```

3. Start Neovim, and lazy.nvim will automatically install and manage the plugins defined in your `init.lua` file.

## Usage

Once you've installed my Neovim configuration, you can start using it right away. Some keybindings you might find useful include:

(spacebar is the leader key)

- `<leader>ff` for finding files with fzf-lua.
- `<C-p>` for finding git files.
- `<leader><space>` to show dashboard.
- `<leader>w` to save the current file.
- `<leader>o` to open Neotree file explorer.
- `<leader>c` to close buffer.
- `<leader>q` to close window (or exit Neovim).
- `<F5>` start debugging session.
- `<leader>du` to show debugging UI.
- `<leader>p` to show Lazy.
- `<leader>m` to show Mason.
- `<leader>h` to navigate to (or create) split on left.
- `<leader>j` to navigate to (or create) split on bottom.
- `<leader>k` to navigate to (or create) split on top.
- `<leader>l` to navigate to (or create) split on right.
- `<C-t>` to open terminal (floating).

## Customization

You can customize this configuration to fit your own preferences.

## Acknowledgments

I want to thank the Neovim community and the creators of the plugins I use. Their work has greatly contributed to this configuration.

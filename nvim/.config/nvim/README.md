# My Neovim Configuration

Welcome to my Neovim configuration! This repository contains my personal Neovim setup, which I've fine-tuned for a smooth and productive editing experience using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

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

## Features

- Fast and responsive editing.
- Syntax highlighting and code completion.
- Keybindings for quick navigation and editing.
- A collection of carefully selected plugins for enhanced functionality.

## Screenshots

![My Neovim Setup](screenshots/screenshot.png)

## Usage

Once you've installed my Neovim configuration, you can start using it right away. Some keybindings you might find useful include:

- `<Leader>` key is set to the space bar.
- `<leader>ff` for opening files with Telescope.
- `<leader>w` to save the current file.
- `<leader>q` to quit Neovim.

## Customization

You can customize this configuration to fit your own preferences. 

## License

This project is licensed under the MIT License

## Acknowledgments

I want to thank the Neovim community and the creators of the plugins I use. Their work has greatly contributed to this configuration.

Happy coding with Neovim!

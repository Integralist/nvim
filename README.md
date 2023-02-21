<img width="2032" alt="Example Neovim Experience" src="https://user-images.githubusercontent.com/180050/207120938-e78f6ca4-75dd-4097-a7f8-f702e60cd630.png">

- LSP configured for different languages (e.g. Go, Rust).
- LSP provides contextual information (e.g. see popup context window).
- The winbar displays the current LSP symbol structure (e.g. where my cursor is).
- Top of the buffer uses TreeSitter to show the current function †.

> † **NOTE**: Not visible in screenshot as this only shows when the function is so long the signature isn't visible to the buffer viewport.
- Right side of the main window is a 'mini map' of the file content (uses TreeSitter to add colour).
  - This isn't visible by default but I define a mapping for easy toggling.
- The statusline bar displays:
  - Neovim current 'mode'
  - The current git branch
  - LSP diagnostics
  - Relative file path
  - File encoding
  - The filetype
  - The scroll percentage
  - The line:column
- Bottom window contains LSP diagnostics.
- Left window is a symbols abstract tree view of the code file open.
- Far Left window is a file tree view of my project.
- Top of the Neovim editor shows tabs with a corresponding filetype icon.
  - e.g. gopher icon for the `.go` file open in the screenshot.

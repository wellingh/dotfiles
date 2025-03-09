" Set up general UI improvements
set number               " Show line numbers
set background=dark      " Use dark mode (good for NvChad themes)

colorscheme codedark

" Indentation and Formatting
set tabstop=2           " Number of spaces that a <Tab> counts for
set shiftwidth=2        " Spaces used for autoindent
set expandtab           " Convert tabs to spaces
set smartindent         " Enable smart indentation

" Better Navigation & Editing
set clipboard=unnamedplus " Use system clipboard
set scrolloff=8         " Keep 8 lines visible above/below cursor
set sidescrolloff=8     " Keep 8 columns visible on the sides
set wrap!               " Disable line wrapping

" Searching
set ignorecase          " Ignore case in searches
set smartcase           " But make it case-sensitive if uppercase letters are used
set incsearch           " Show search results as you type
set hlsearch            " Highlight search results

" Splits
set splitbelow          " Open new horizontal splits below
set splitright          " Open new vertical splits to the right

" Unmap Space key to prevent conflicts
nnoremap <Space> <Nop>

" Set the Leader key to Space
let mapleader = " "

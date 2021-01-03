# vim-cbrief
BRIEF emulation for VIM (vim, neovim, gvim)

This module extents the BRIEF emulation of Yegappan Lakshmanan: [brief.vim](https://www.vim.org/scripts/script.php?script_id=265)

VIM has popup-window's NeoVIM has not... This nice plugin [vim-quickui](https://github.com/skywind3000/vim-quickui), solves it and adds more functionality. It is **required** for now, I intent to be *optional* in the future. 

This is still alpha version; it is not tested enough.

## new keys

```
F10 command line
F11 toggles insert/normal mode
F12 changes color scheme, Shift-F12 previous color scheme
Alt+F12 color select from listbox, the list can be reduced to your selections.
```

# Installation
Using your package manager as usual or try this for vanilla.

```
mkdir -p ~/.vim/pack/opt
cd ~/.vim/pack/opt
git clone https://github.com/nereusx/vim-cbrief 
vim -u NONE -c "helptags vim-cbrief/doc" -c q
echo 'packadd vim-cbrief' >> ~/.vimrc
```

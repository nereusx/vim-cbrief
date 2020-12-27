# vim-cbrief
BRIEF emulation for VIM (vim, neovim, gvim)

VIM has popup-window's NeoVIM has not... This nice plugin [vim-quickui](https://github.com/skywind3000/vim-quickui), solves it and adds more functionality. It is **required** for now, I intent to be *optional* in the future. 

```
mkdir -p ~/.vim/pack/opt
cd ~/.vim/pack/opt
git clone https://github.com/nereusx/vim-cbrief 
vim -u NONE -c "helptags vim-cbrief/doc" -c q
echo 'packadd vim-cbrief' >> ~/.vimrc
```

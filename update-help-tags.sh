#!/bin/sh
rm -f doc/tags
vim -u NONE -c "helptags vim-cbrief/doc" -c q

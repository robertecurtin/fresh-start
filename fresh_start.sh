#!/bin/bash
if ! [ $(id -u) = 0 ]; then
  echo "Please run as root"
  exit 1
fi

./copy_aliases.sh

if ! [ -x "$(command -v vim)" ]; then
  ./install_vim.sh
fi

if ! [ -x "$(command -v atom)" ]; then
  ./install_atom.sh
fi

if ! [ -x "$(command -v lenv)" ]; then
  echo "Lenv"
  ./install_lua.sh
fi

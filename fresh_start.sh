#!/bin/bash
if ! [ $(id -u) = 0 ]; then
  echo "Please run as root"
  exit 1
fi

./copy_aliases.sh
./install_vim.sh
./install_atom.sh
./install_lua.sh

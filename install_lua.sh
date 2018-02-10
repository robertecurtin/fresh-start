#!/bin/bash
apt install libreadline-dev
apt install curl
curl -L http://git.io/lenv | perl
source ~/.bash_aliases
lenv fetch
lenv install 5.3.4
lenv use 5.3.4
luarocks install busted
luarocks install luacov

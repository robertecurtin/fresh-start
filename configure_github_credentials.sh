#!/bin/bash
# Source: https://help.github.com/articles/caching-your-github-password-in-git/
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

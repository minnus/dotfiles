#!/bin/bash

set -e
set -u
set -o pipefail

# Git
if [ -x "$(command -v git)" ]; then
  git config --global user.name "Martins Innus"
  git config --global user.email "minnus@buffalo.edu"
  git config --global push.default current
else
  echo "Install Git before running"
  exit 1
fi

# VIM
/bin/cp -f vim.rc ~/.vimrc

# SSH
/bin/cp -f ssh.config ~/.ssh/config
chmod 600 ~/.ssh/config

# BASH
/bin/cp -f bash.rc ~/.bashrc

# python
if ! [ -x "$(command -v pygmentize)" ]; then
  echo "sudo yum install python-pygments"
fi

if ! [ -x "$(command -v pip)" ]; then
  echo "sudo yum install python-pip"
  echo "sudo pip install --upgrade pip"
fi

if ! [ -x "$(command -v virtualenv)" ]; then
  echo "sudo pip install virtualenv"
fi

echo "Logout and log back in to see the changes"

#!/bin/bash

set -e
set -u
set -o pipefail

confirm () {
  echo "run ?: $@"
  select choice in yes no
  do
    if [ "$choice" = "yes" ]; then
      break
    elif [ "$choice" = "no" ]; then
      return 0
    fi
  done
  $@
}

# Git

if ! [ -x "$(command -v git)" ]; then
    confirm "sudo yum install git"
fi

if [ -x "$(command -v git)" ]; then
  git config --global user.name "Martins Innus"
  git config --global user.email "minnus@buffalo.edu"
  git config --global push.default current
else
  echo "Git not installed"
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
  confirm "sudo yum install python-pygments"
fi

if ! [ -x "$(command -v pip)" ]; then
  confirm "sudo yum install python-pip"
  confirm "sudo pip install --upgrade pip"
fi

if ! [ -x "$(command -v virtualenv)" ]; then
  confirm "sudo pip install virtualenv"
fi

echo "Logout and log back in to see the changes"

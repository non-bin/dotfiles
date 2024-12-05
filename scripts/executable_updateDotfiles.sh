#!/bin/bash
chezmoi apply
sudo stow etc -t /etc -d $HOME/.config

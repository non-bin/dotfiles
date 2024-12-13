#!/bin/bash
sudo stow etc -t /etc -d $HOME/.config # Update /etc symlinks
sudo find /etc/ -xtype l -delete # Remove broken symlinks

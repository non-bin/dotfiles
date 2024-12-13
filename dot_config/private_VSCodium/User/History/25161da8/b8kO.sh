#!/bin/bash
sudo stow etc -t /etc -d $HOME/.config
sudo find /etc/ -xtype l -delete

#!/usr/bin/env bash
sudo adb start-server
adb forward tcp:6000 localfilesystem:/data/data/org.mozilla.firefox/firefox-debugger-socket
adb forward tcp:8080 tcp:8080

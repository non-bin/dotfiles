#!/usr/bin/env bash
kill $(pidof hyprlock)
hyprctl --instance 0 eval 'hl.config({misc={allow_session_lock_restore=true}})'
hyprctl --instance 0 dispatch 'hl.dsp.exec_cmd("hyprlock")'

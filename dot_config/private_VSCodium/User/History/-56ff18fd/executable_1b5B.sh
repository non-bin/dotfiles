# https://docs.micropython.org/en/latest/reference/mpremote.html
pkill mpremote
pkill minicom
mpremote reset
mpremote fs cp hardware/src/main.py :main.py
mpremote reset

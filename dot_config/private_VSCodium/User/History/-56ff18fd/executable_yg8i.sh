# https://docs.micropython.org/en/latest/reference/mpremote.html
pkill mpremote
mpremote fs cp hardware/src/main.py :main.py
mpremote reset

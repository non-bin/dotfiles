print("Hello, world!")
while rp2.bootsel_button() == 0:
  pass
print("Bootsel button pressed")

import usb.device
from usb.device.keyboard import KeyboardInterface, KeyCode, LEDCode
from machine import Pin
import time

def keyboard_example():
  # Register the keyboard interface and re-enumerate
  k = KeyboardInterface()
  usb.device.get().init(k, builtin_driver=True)

  while not k.is_open():
    time.sleep_ms(100)

  print("Entering keyboard loop...")

  while True:
    k.send_keys([KeyCode.A])
    time.sleep_ms(500)
    k.send_keys([])
    time.sleep_ms(500)


keyboard_example()

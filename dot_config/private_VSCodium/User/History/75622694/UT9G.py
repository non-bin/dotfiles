print("Hello, world!")
while rp2.bootsel_button() == 0:
  pass
print("Bootsel button pressed")

import usb.device
from usb.device.keyboard import KeyboardInterface, KeyCode, LEDCode
from machine import Pin
import time

k = KeyboardInterface()
usb.device.get().init(k, builtin_driver=True)

def release_all_keys(timer):
  k.send_keys([])

key_press_timer = Timer(mode=Timer.ONE_SHOT, period=100, callback=release_all_keys)

def press_key(key):
  release_all_keys(None)
  k.send_keys([key])
  led_timer.init(period=period, mode=Timer.ONE_SHOT, callback=release_all_keys)

while not k.is_open():
  time.sleep_ms(100)

print("Entering keyboard loop...")

while True:
  press_key(KeyCode.A)
  time.sleep_ms(1000)

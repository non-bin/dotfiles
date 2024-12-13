import time, utime, usb.device
from machine import Pin, Timer
from neopixel import NeoPixel
from micropython import const
from usb.device.keyboard import KeyboardInterface, KeyCode, LEDCode

# LED
np = NeoPixel(Pin(16), 1)
def write_color(color):
  np[0] = color
  np.write()

def led_off(timer):
  write_color((0, 0, 0))

led_timer = Timer()

def led_flash(color = (0, 255, 0), period = 100):
  global led_timer
  write_color(color)
  led_timer.init(period=period, mode=Timer.ONE_SHOT, callback=led_off)

write_color((255, 128, 0))
print("Waiting for bootsel button press...")
while rp2.bootsel_button() == 0:
  pass
print("Entering main loop...")
# led_flash((0, 255, 0), 500)

# Keyboard
k = KeyboardInterface()
usb.device.get().init(k, builtin_driver=True)

def release_all_keys(timer):
  k.send_keys([])

def press_key(key):
  global key_press_timer
  global k

  # release_all_keys(None)
  k.send_keys([key])
  write_color((0, 0, 255))
  Timer(period=period, mode=Timer.ONE_SHOT, callback=release_all_keys)
  write_color((0, 255, 0))

while not k.is_open():
  time.sleep_ms(100)

while True:
  press_key(KeyCode.A)
  time.sleep_ms(1000)
  write_color((255, 0, 0))
  time.sleep_ms(1000)

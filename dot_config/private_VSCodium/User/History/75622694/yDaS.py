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
write_color((0, 0, 255))

# Keyboard
k = KeyboardInterface()
usb.device.get().init(k, builtin_driver=True)

def release_all_keys(timer):
  k.send_keys([])

key_press_timer = Timer()

def press_key(key, period = 10):
  global key_press_timer
  global k

  k.send_keys([key])
  key_press_timer.init(period=period, mode=Timer.ONE_SHOT, callback=release_all_keys)

while not k.is_open():
  time.sleep_ms(100)

def send_signal():
  press_key(KeyCode.SPACE)
  led_flash((0, 255, 0), 100)

# Magnet
magnet_last_value = 0
magnet_last_value_changed = 0

def magnet_callback(p):
  global magnet_last_value
  global magnet_last_value_changed
  global i

  pin_state = p.value()
  cur_time = utime.ticks_ms()
  diff = cur_time - magnet_last_value_changed

  if pin_state == magnet_last_value and diff < 10:
    return

  if diff < 10:
    return

  if pin_state == 0:
    return

  magnet_last_value = pin_state
  magnet_last_value_changed = cur_time

  send_key(KeyCode.SPACE)

magnet_pin = Pin(29, Pin.IN, Pin.PULL_DOWN)
magnet_pin.irq(lambda p:magnet_callback(p))

# Button
def wait_for_button():
  while rp2.bootsel_button() == 1:
    pass

  send_signal()

  while rp2.bootsel_button() == 0:
    pass

while True:
  wait_for_button()

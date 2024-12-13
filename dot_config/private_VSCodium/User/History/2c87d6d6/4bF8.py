import machine, neopixel, time
import time

def waitForButton(value = 1):
  while True:
    if rp2.bootsel_button() == value: return True
    time.sleep(0.01)

np = neopixel.NeoPixel(machine.Pin(16), 1)

while True:
  np[0] = (255, 0, 0)
  np.write()
  waitForButton(1)
  waitForButton(0)

  np[0] = (255, 255, 0)
  np.write()
  waitForButton(1)
  waitForButton(0)

  np[0] = (0, 255, 0)
  np.write()
  waitForButton(1)
  waitForButton(0)

  np[0] = (0, 255, 255)
  np.write()
  waitForButton(1)
  waitForButton(0)

  np[0] = (0, 0, 255)
  np.write()
  waitForButton(1)
  waitForButton(0)

  np[0] = (255, 0, 255)
  np.write()
  waitForButton(1)
  waitForButton(0)

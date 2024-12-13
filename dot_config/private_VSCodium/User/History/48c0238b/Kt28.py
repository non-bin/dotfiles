import board
from neopixel import NeoPixel

led = NeoPixel(board.GP16, 1)
led.fill((0, 0, 255))

print("Hello from CircuitPython!")

import random
import threading
import time

import pyautogui
from pynput import keyboard, mouse

SAFE_KEY = keyboard.Key.shift # key pressed to avoid computer from sleeping
LOCK_POS = (1810, 15) # position of lock button: (x, y)
TICK_DELAY = 2 # seconds between each tick

screen_size = pyautogui.size() # (w, h)
mouse_pos = (0, 0) # (x, y)
mouse_ctrl = mouse.Controller()
key_ctrl = keyboard.Controller()
mouse_lstn = None
key_lstn = None
is_locked = False
exit = threading.Event()

def lock():
    # Press lock button to lock the computer
    x, y = LOCK_POS
    pyautogui.click(x, y)
    exit.set()

def on_mouse_move(x, y):
    if mouse_pos != (x, y):
        lock()

def on_key_press(key):
    if key != SAFE_KEY:
        lock()

def init():
    global mouse_lstn, key_lstn
    # Disable failsafe mouse corner
    pyautogui.FAILSAFE = True
    # Create listeners
    mouse_lstn = mouse.Listener(on_move=on_mouse_move)
    key_lstn = keyboard.Listener(on_press=on_key_press)
    # Start listeners
    mouse_lstn.start()
    key_lstn.start()

def tick():
    global mouse_pos
    # Generate random mouse position based on screen size
    w, h = screen_size
    mouse_pos = (random.randint(0, w), random.randint(0, h))
    # Move mouse and press key
    mouse_ctrl.position = mouse_pos
    key_ctrl.press(SAFE_KEY)

def cleanup():
    # Stop listeners
    mouse_lstn.stop()
    key_lstn.stop()

def main():
    init()
    while not exit.is_set():
      tick()
      exit.wait(TICK_DELAY)
    cleanup()

if __name__ == "__main__":
    main()

from gpiozero import Button
from time import sleep
import gpiozero
from gpiozero.pins.pigpio import PiGPIOFactory

gpiozero.Device.pin_factory = PiGPIOFactory()
from pythonosc import udp_client

print("Starting GPIO -> OSC program")
# setup osc
ip = "127.0.0.1"    # Companion localhost
port = 12321        # default Companion OSC API port
client = udp_client.SimpleUDPClient(ip, port)

# setup GPIO input pins
button16 = Button(16, bounce_time=0.05)
button20 = Button(20, bounce_time=0.05)
button21 = Button(21, bounce_time=0.05)
button26 = Button(26, bounce_time=0.05)

def button16_action():
    client.send_message("/location/1/0/1/press", None) # pink on
    print("button 16 pressed routine")

def button20_action():
    client.send_message("/location/1/1/1/press", None) # pink off
    print("button 20 pressed routine")

def button21_action():
    client.send_message("/location/1/2/1/press", None) # pink off
    print("button 21 pressed routine")

def button26_action():
    client.send_message("/location/1/3/1/press", None) # pink off
    print("button 26 pressed routine")

button16.when_pressed = button16_action
button20.when_pressed = button20_action
button21.when_pressed = button21_action
button26.when_pressed = button26_action


while True:
    pass

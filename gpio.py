from gpiozero import Button
from time import sleep
import gpiozero
from gpiozero.pins.pigpio import PiGPIOFactory

gpiozero.Device.pin_factory = PiGPIOFactory()
from pythonosc import udp_client

print("Starting GPIO -> OSC program")
#setup osc
ip = "127.0.0.1"  # The IP address of the OSC server
port = 12321       # The port number the OSC server is listening on
client = udp_client.SimpleUDPClient(ip, port)


button20 = Button(20, bounce_time=0.05)
button21 = Button(21, bounce_time=0.05)
def pink_on():
    client.send_message("/location/1/0/1/press", None) # pink on
    print("pink on")

def pink_off():
    client.send_message("/location/1/0/2/press", None) # pink off
    print("pink off")

def btn_3():
    print("button 3")

def btn4():
    print("btn3")

button20.when_pressed = pink_on
button21.when_pressed = pink_off

while True:
    pass

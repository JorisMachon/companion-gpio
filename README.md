# companion-gpio
## How it works
This software sends the signals from 4 GPIO input pins on a Raspberry Pi to Companion via OSC commands. Below table shows which physical pins correspond to which buttons in the Companion UI.
| RPi Pin | Companion button |
|----------|----------|
| 16 | 1-0-1 |
| 20 | 1-1-1 |
| 21 | 1-2-1 |
| 26 | 1-3-1 |

The input pins are hard-coded to trigger the first 4 buttons in Companion (the top 4 buttons from the leftmost column). To make other pin-button combinations, the code has to be adapted.
GPIO layout: <https://technicalustad.com/wp-content/uploads/2018/02/Raspberry-Pi-GPIO-Explained-640x455.png>

## How to install
First install Companion on a Raspberry Pi and set it up. Certainly enable OSC on the default port 12321. Connect to the Pi via ssh and follow below steps:
1. Perform updates via ```sudo apt update``` followed by ```sudo apt upgrade```
2. Install Python development environment: ```sudo apt-get install python3.11-dev```
3. Clone this project repository by using command ```git clone https://github.com/JorisMachon/companion-gpio.git```
4. Move into the newly created folder: ```cd companion-gpio```
5. Run the installer script: ```./install_script.sh```
6. If the script ran without throwing errors, the software should work and can be tested in Companion.
7. Verify functionality by rebooting/repowering the Pi.

## Tested with
* Raspberry Pi 4B 2GB RAM
* Companion Pi version companion-pi-stable-v3.3.1-05-06-24

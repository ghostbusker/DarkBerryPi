# DarkBerryPi
For the Pi Zero W. Does Tor stuff.

#Concept:
This goal of this project is to create an inexpensive and easy to use USB device that anonymizes web browsing, without the need to install Tor on your main device. The Raspberry Pi Zero W is a single board computer (about the size of a stick of gum) with built-in WiFi and USB OTG. It provides an ideal platform for hosting a disposable environment to run Tor and connect to wireless networks while being controlled (and powered) from another device over USB. The end result should be a device that plugs into a laptop, tablet, or phone with a single cable and provides an anonymous pass-through to a Tor routed browser. This project is also intended as a learning opportunity for beginners to use, understand, and explore new hardware and software.

#Method:
Install Tor and its dependencies. Install MacChanger and configure to randomize MAC address of WLAN0 on each reboot. Configure Tor daemon to run a socks proxy on port 9050. Customize Chromium-browser desktop shortcut to use the proxy and reduce uniqueness of fingerprint. Configure USB Ethernet Gadget OTG overlay to make the Pi Zero appear as a common ethernet adapter. Once connected to a host device, the user can connect to "raspberrypi.local" using VNC. This encrypted tunnel displays and controls what is happening on the Raspberry Pi desktop environment, leaving little to no record of the connection and none of its content. The user can now connect to a wireless access point using the spoofed MAC address and open the Tor browser.

#Usage:
Burn the latest (full) Raspbian img to a microSD card. Insert the card into a Raspberry Pi Zero W and boot to the desktop. Connect to a WiFi network and download this project with the following command: "sudo git clone https://github.com/ghostbusker/DarkBerryPi". Then use the following command to make the installer executable and run it: "cd DarkBerryPi | sudo chmod 577 installer.sh | sudo installer.sh". After this, the installer will run and you should be prompted a few times to continue. MacChanger will ask if you want to run at boot, either answer will work as this is configured later (I would like to bypass this screen but nothing I have tried prevents this prompt!). Finally, the installer will ask to shut down the Pi, answer Yes and wait for the green light to stop blinking. At this point, you can plug your Pi into a laptop (turn off the laptop's WiFi!) using the port labeled "USB" and connect to "raspberrypi.local" using the VNC Viewer client found here https://www.realvnc.com/en/raspberrypi/. You should be looking at the Raspbian desktop you saw during setup, but now there is a desktop icon called "Tor Browse". Connect to a hotspot and double-click the "Tor Browse" link. This should open two tabs in a new chromium-browser and you should see a page confirming that you are connected to the Tor network!

#Notes:
This project is under development and should not be taken as a guaranteed platform or solution for anonymity! Please Internet responsibly.
This script has gone through several revisions and may continue to change in scope.
Early attempts were made to download and install chromium-browser plugins, but version changes kept breaking them so they are omitted. Even though the plugins chosen were designed to reduce malicious scripts and improve anonymity, there were indications that they were having the opposite effect.
I want this to be a community effort so please feel free to comment, contribute, and improve!

!Quick install command!
curl ghstbskr.com/DarkBerryPi | bash

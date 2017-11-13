# DarkBerryPi
For the Pi Zero W. Does Tor stuff.

#Concept:
This goal of this project is to create an inexpensive and easy to use USB device that anonymizes web browsing, without the need to install Tor on your main device. The Raspberry Pi Zero W is a single board computer (about the size of a stick of gum) with built-in WiFi and USB OTG. It provides an ideal platform for hosting a disposable environment to run Tor and connect to wireless networks while being controlled (and powered) from another device over USB. The end result should be a device that plugs into a laptop, tablet, or phone with a single cable and provides an anonymous pass-through to a Tor routed browser.

#Method:
Install Tor and its dependencies. Install MacChanger and configure to randomize MAC address of WLAN0 on each reboot. Configure Tor daemon to run a socks proxy on port 9050. Customize Chromium-browser desktop shortcut to use the proxy and reduce uniqueness of fingerprint. Configure USB Ethernet Gadget OTG overlay to make the Pi Zero appear as a common ethernet adapter. Once connected to a host device, the user can connect to "raspberrypi.local" using VNC. This encrypted tunnel displays and controls what is happening on the Raspberry Pi desktop environment, leaving little to no record of the connection and none of its content. The user can now connect to a wireless access point using the spoofed MAC address and open the Tor browser.

#Notes:
This project is under development and should not be taken as a guaranteed platform or solution for anonymity! Please Internet responsibly.
This script has gone through several revisions and may continue to change in scope.
Early attempts were made to download and install chromium-browser plugins, but version changes kept breaking them so they are omitted. Even though the plugins chosen were designed to reduce malicious scripts and improve anonymity, there were indications that they were having the opposite effect.
I want this to be a community effort so please feel free to comment, contribute, and improve!

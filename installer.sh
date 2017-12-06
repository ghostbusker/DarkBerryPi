#!/bin/bash
APPLIST="tor tor-arm macchanger netatalk"
CMDLINE="/boot/cmdline.txt"
CONFIG="/boot/config.txt"
RCLOCAL="/etc/rc.local"
sudo apt-get update
sudo apt-get -y install $APPLIST
raspi-config nonint do_ssh 1
raspi-config nonint do_vnc 0
if grep -Fq "macchanger" $RCLOCAL
then
	echo "macchanger already set to run at login"
else
	echo "Modifying /etc/rc.local to randomize wlan0 at login"
	sed -i "/exit 0/c\sudo ifconfig wlan0 down" $RCLOCAL
	echo "sudo macchanger -r wlan0" >> $RCLOCAL
	echo "sudo ifconfig wlan0 up" >> $RCLOCAL
	echo "exit 0" >> $RCLOCAL
fi
if grep -Fq "modules-load=dwc2,g_ether" $CMDLINE
then
	echo "USB Ethernet already enabled"
else
	sed -i "s/rootwait/rootwait modules-load=dwc2,g_ether/" $CMDLINE
fi
if grep -Fq "dtoverlay=dwc2" $CONFIG
then
	echo "dtoverlay already enabled"
else
	echo "dtoverlay not defined. Creating definition"
	echo "dtoverlay=dwc2" >> $CONFIG
fi
if grep -Fq "framebuffer_width" $CONFIG
then
	echo "Modifying framebuffer_width"
	sed -i "/framebuffer_width/c\framebuffer_width=1366" $CONFIG
else
	echo "framebuffer_width not defined. Creating definition"
	echo "framebuffer_width=1366" >> $CONFIG
fi
if grep -Fq "framebuffer_height" $CONFIG
then
	echo "Modifying framebuffer_height"
	sed -i "/framebuffer_height/c\framebuffer_height=768" $CONFIG
else
	echo "framebuffer_height not defined. Creating definition"
	echo "framebuffer_height=768" >> $CONFIG
fi
printf "[Desktop Entry]\nName=TorBrowse\nComment=Tor thru Chrome\nIcon=/usr/share/pixmaps/chromium-browser.png\nExec=sudo chromium-browser --no-sandbox --disable-background-networking --system-developer-mode --disable-reading-from-canvas --aggressive-cache-discard --disable-cache --disable-application-cache --disable-offline-load-stale-cache --disk-cache-size=0 --no-default-browser-check --no-referrers --enable-low-res-tiling --enable-low-end-device-mode --use-fake-device-for-media-stream --use-mock-keychain --enable-native-gpu-memory-buffers --enable-zero-copy --disable-gpu-vsync --window-size="1024,768" --proxy-server=socks5://127.0.0.1:9050 --user-agent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36' https://check.torproject.org https://panopticlick.eff.org/tracker https://www.dnsleaktest.com/ \nType=Application\nEncoding=UTF-8\nTerminal=True\nCategories=None;\n" > /home/pi/Desktop/TorBrowse.desktop
echo "Install complete."
echo -n "Shutdown Now? (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
    echo "shutting down..."
	sudo shutdown now
fi

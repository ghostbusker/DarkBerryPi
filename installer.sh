#!/bin/bash
APPLIST="tor tor-arm macchanger netatalk avahi-daemon"
CMDLINE="/boot/cmdline.txt"
CONFIG="/boot/config.txt"
RCLOCAL="/etc/rc.local"
PANEL="/home/pi/.config/lxpanel/LXDE-pi/panels/panel"
sudo apt-get update
sudo apt-get -y install $APPLIST
sudo apt-get -y dist-upgrade
raspi-config nonint do_ssh 1
raspi-config nonint do_vnc 0
if grep -Fq "arm_freq" $CONFIG
then
	echo "Modifying arm_freq"
	sed -i "/arm_freq/c\arm_freq=1100" $CONFIG
else
	echo "arm_freq not defined. Creating definition"
	echo "arm_freq=1100" >> $CONFIG
fi
if grep -Fq "gpu_freq" $CONFIG
then
	echo "Modifying gpu_freq"
	sed -i "/gpu_freq/c\gpu_freq=500" $CONFIG
else
	echo "gpu_freq not defined. Creating definition"
	echo "gpu_freq=500" >> $CONFIG
fi
if grep -Fq "gpu_mem" $CONFIG
then
	echo "Modifying gpu_mem"
	sed -i "/gpu_mem/c\gpu_mem=128" $CONFIG
else
	echo "gpu_mem not defined. Creating definition"
	echo "gpu_mem=128" >> $CONFIG
fi
if grep -Fq "core_freq" $CONFIG
then
	echo "Modifying core_freq"
	sed -i "/core_freq/c\core_freq=500" $CONFIG
else
	echo "core_freq not defined. Creating definition"
	echo "core_freq=500" >> $CONFIG
fi
if grep -Fq "sdram_freq" $CONFIG
then
	echo "Modifying sdram_freq"
	sed -i "/sdram_freq/c\sdram_freq=500" $CONFIG
else
	echo "sdram_freq not defined. Creating definition"
	echo "sdram_freq=500" >> $CONFIG
fi
if grep -Fq "sdram_schmoo" $CONFIG
then
	echo "Modifying sdram_schmoo"
	sed -i "/sdram_schmoo/c\sdram_schmoo=0x02000020" $CONFIG
else
	echo "sdram_schmoo not defined. Creating definition"
	echo "sdram_schmoo=0x02000020" >> $CONFIG
fi
if grep -Fq "over_voltage" $CONFIG
then
	echo "Modifying over_voltage amd sdram_over_voltage"
	sed -i "/over_voltage/d" $CONFIG
	echo "over_voltage=3" >> $CONFIG
	echo "sdram_over_voltage=2" >> $CONFIG
else
	echo "over_voltage not defined. Creating definition"
	echo "over_voltage=3" >> $CONFIG
	echo "sdram_over_voltage not defined. Creating definition"
	echo "sdram_over_voltage=2" >> $CONFIG
fi
if grep -Fq "dtparam=sd_overclock" $CONFIG
then
	echo "Modifying dtparam=sd_overclock"
	sed -i "/dtparam=sd_overclock/c\dtparam=sd_overclock=100" $CONFIG
else
	echo "dtparam=sd_overclock not defined. Creating definition"
	echo "dtparam=sd_overclock=100" >> $CONFIG
fi
if grep -Fq "force_turbo=1" $CONFIG
then
	echo "CPU Turbo already enabled"
else
	echo "Force Turbo on CPU?"
	echo "THIS VOIDS THE WARRANTY on your $10 investment"
	echo "MUST have a heatsink for this one!"
	echo -n "set 'force_turbo=1'? (y/n)? "
	read answer
	if echo "$answer" | grep -iq "^y" ;
	then
		echo "force_turbo=1" >> $CONFIG
	else
		echo "CPU Turbo NOT enabled at this time"
	fi
fi
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
printf "[Desktop Entry]\nName=TorBrowse\nComment=Tor thru Chrome\nIcon=/usr/share/pixmaps/chromium-browser.png\nExec=sudo chromium-browser --no-sandbox --disable-background-networking --system-developer-mode --disable-reading-from-canvas --aggressive-cache-discard --disable-cache --disable-application-cache --disable-offline-load-stale-cache --disk-cache-size=0 --no-default-browser-check --no-referrers --enable-low-res-tiling --enable-low-end-device-mode --use-fake-device-for-media-stream --use-mock-keychain --window-size="1024,768" --proxy-server=socks5://127.0.0.1:9050 --user-agent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36' https://check.torproject.org https://panopticlick.eff.org/tracker \nType=Application\nEncoding=UTF-8\nTerminal=True\nCategories=None;\n" > /home/pi/Desktop/TorBrowse.desktop
printf "[Desktop Entry]\nName=TorBrowseIncognito\nComment=Tor thru Chrome Incognito\nIcon=/usr/share/pixmaps/chromium-browser.png\nExec=sudo chromium-browser --incognito --no-sandbox --disable-background-networking --system-developer-mode --disable-reading-from-canvas --aggressive-cache-discard --disable-cache --disable-application-cache --disable-offline-load-stale-cache --disk-cache-size=0 --no-default-browser-check --no-referrers --enable-low-res-tiling --enable-low-end-device-mode --use-fake-device-for-media-stream --use-mock-keychain --window-size="1024,768" --proxy-server=socks5://127.0.0.1:9050 --user-agent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36' https://check.torproject.org https://panopticlick.eff.org/tracker \nType=Application\nEncoding=UTF-8\nTerminal=True\nCategories=None;\n" > /home/pi/Desktop/TorBrowseIncognito.desktop
printf "[Desktop Entry]\nName=TorMonitor\nComment=Tor-arm monitor\nIcon=/usr/share/pixmaps/chromium-browser.png\nExec=lxterminal -e 'sudo arm'\nType=Application\nEncoding=UTF-8\nTerminal=True\nCategories=None;\n" > /home/pi/Desktop/TorMonitor.desktop
printf "[Desktop Entry]\nName=MacChangerConfirm\nComment=Did macchanger spoof mac?\nIcon=/usr/share/pixmaps/chromium-browser.png\nExec=lxterminal -e 'sudo macchanger wlan0'\nType=Application\nEncoding=UTF-8\nTerminal=True\nCategories=None;\n" > /home/pi/Desktop/MacChangerConfirm.desktop
if grep -Fq "type=cpu" $PANEL
then
	echo "CPU panel already present"
else
	echo "Adding CPU panel"
	printf "Plugin {\n  type=cpu\n  Config {\n    ShowPercent=1\n    Foreground=#ffff00000000\n    Background=#d3d3d3d3d3d3\n  }\n}" >> $PANEL
fi
if grep -Fq "type=thermal" $PANEL
then
	echo "Thermal panel already present"
else		
	echo "Adding Thermal panel"
	printf "Plugin {\n  type=thermal\n  Config {\n    NormalColor=#00ff00\n    Warning1Color=#FF8C00\n    Warning2Color=#ff0000\n    AutomaticLevels=0\n    Warning1Temp=45\n    Warning2Temp=50\n    AutomaticSensor=1\n  }\n}" >> $PANEL
fi
if grep -Fq "type=monitors" $PANEL
then
	echo "Monitor panel already present"
else
	echo "Adding Monitor panel"
	printf "Plugin {\n  type=monitors\n  Config {\n    DisplayCPU=0\n    DisplayRAM=1\n    RAMColor=#0000FF\n  }\n}" >> $PANEL
fi
if grep -Fq "type=netstatus" $PANEL
then
	echo "NetStatus panel already present"
else
	echo "Adding NetStatus panel"
	printf "Plugin {\n  type=netstatus\n  Config {\n  }\n}" >> $PANEL
fi
echo "Install complete."
echo -n "Shutdown Now? (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
    echo "shutting down..."
	sudo shutdown now
fi

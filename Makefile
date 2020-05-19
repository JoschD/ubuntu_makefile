#
# Ubuntu 20.04
#
# Basic packages I usually install.
#

.PHONY:	all preparations update upgrade atom fonts cyberduck python graphics google_chrome media latex harddisk filesystem tools nautilus kdenlive gitkraken skype spotify driverppa pycharm masterpdf eurkey behaviour conky

all:
	@echo "Installation of ALL targets"
	make preparations
	make upgrade
	make eurkey 
	make fonts
	make python java
	make graphics 
	make google_chrome google_drive
	make media media_extra
	make latex zotero
	make archives harddisk filesystem tools nautilus
	make code
	make gitkraken
	make messenger spotify
	make nvidia
	make masterpdf
	make behaviour

thinky:
	@echo "Installation of relevant targets for Thinky"
	make preparations
	make upgrade
	make eurkey
	make archives harddisk filesystem tools nautilus
	make fonts latex
	make zotero
	make code python java
	make gitkraken
	make media graphics
	make google_chrome google_drive
	make messenger spotify
	make masterpdf
	make behaviour
	make afs
	
surfy:


hurley:
	@echo "Installation of Hurley targets"
	make preparations
	make upgrade
	make eurkey 
	make fonts
	make python java
	make graphics 
	make google_chrome google_drive
	make media media_extra
	make latex zotero
	make archives harddisk filesystem tools nautilus
	make code
	make gitkraken
	make skype spotify mattermost
	make nvidia
	make masterpdf
	make behaviour

preparations:
	sudo apt-add-repository universe
	sudo apt-add-repository multiverse
	sudo apt-add-repository restricted
	make update
	sudo apt -y install wget curl git

update:
	sudo apt update

upgrade:
	sudo apt -y upgrade

fonts:	
	sudo DEBIAN_FRONTEND=noninteractive apt -y install ttf-mscorefonts-installer # Install Microsoft fonts.
	mkdir -p ~/.fonts/
	sudo apt -y install fonts-firacode fonts-cantarell lmodern ttf-aenigma ttf-georgewilliams ttf-bitstream-vera ttf-sjfonts tv-fonts
	# Install all the google fonts
	curl https://raw.githubusercontent.com/dylanmtaylor/Web-Font-Load/master/install.sh | sudo bash
	# Refresh font cache
	fc-cache -v

python:
	make preparations
	#sudo -H apt -y install python3.7
	#sudo -H apt -y install python3.6
	sudo -H apt -y install python3-pip
	sudo -H pip3 install --upgrade pip
	sudo -H apt -y install python2.7
	curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
	python2.7 get-pip.py
	rm -f get-pip.py

pythonsrc:
	sudo apt-get install -y build-essential checkinstall
	sudo apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev	
	sudo apt-get install -y libffi-dev liblzma-dev
	read -p "Enter full python version number: " pyversion; \
	sudo wget https://www.python.org/ftp/python/$${pyversion}/Python-$${pyversion}.tgz; \
	sudo tar xzf Python-$${pyversion}.tgz; \
	cd Python-$${pyversion};
	sudo ./configure --enable-optimizations
	sudo make altinstall
	cd ..

graphics:
	# Remove apt package if installed and install snap (more up-to-date) 
	sudo apt -y remove gimp
	sudo snap install gimp
	sudo chown -R $$USER:$$USER /home/$$USER # Fix permissions of /home
	# The latest Krita is installed using the Krita Lime ppa
	sudo add-apt-repository -y ppa:kritalime/ppa
	sudo apt -y install krita
	# Inkscape's latest supported release is officially released as a PPA package.
	sudo add-apt-repository -y ppa:inkscape.dev/stable
	sudo apt -y install inkscape
	# Install additional graphics packages
	sudo apt -y install graphviz dia jpegoptim mesa-utils darktable
	sudo apt -y install ffmpeg x264 x265

google_chrome:
	rm -f google-chrome-stable_current_amd64.deb
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt -y install libappindicator1 libindicator7
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm -f google-chrome-stable_current_amd64.deb
	# install plugin to get gnome-plugins directly from webpages
	sudo apt-get install chrome-gnome-shell

google_drive:
	sudo snap install drive
	# https://github.com/odeke-em/drive
	# sudo add-apt-repository ppa:twodopeshaggy/drive
	# sudo apt-get update
	# sudo apt-get install drive

archives:
	sudo apt -y install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller

media:
	sudo add-apt-repository ppa:mc3man/mpv-tests
	sudo apt -y install mpv vlc ubuntu-restricted-extras libavcodec-extra #libdvdread4
    # DVD Playback
	sudo apt -y install libdvd-pkg
	sudo dpkg-reconfigure libdvd-pkg

media_extra:
	sudo snap install kdenlive
    #  Settings->Configure Kdenlive->Playback and in the window, enable "Use GPU processing (Movit Library) -- restart Kdenlive to apply"
	sudo snap install handbrake-jz

latex:
	sudo apt -y install pandoc pandoc-citeproc 
	sudo apt -y install texlive texlive-latex-extra texlive-latex-base texlive-science texlive-fonts-recommended texlive-latex-recommended texlive-lang-german texlive-xetex 
	sudo apt -y install preview-latex-style dvipng nbibtex latexmk

harddisk:
	sudo apt -y install smartmontools gsmartcontrol smart-notifier
	
filesystem:
	sudo apt -y install ntfs-3g

tools:
	sudo apt -y install htop password-gorilla gnome-tweaks dconf-editor
	sudo apt -y install rabbitvcs-nautilus git curl vim gparted gnome-disk-utility baobab

java:
	sudo apt -y install openjdk-11-jdk 
	sudo apt -y install openjdk-8-jdk
	#sudo apt -y install openjdk-11-jre

nodejs:
	curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
	sudo apt-get install -y nodejs
	rm -f setup_10.x
	
popos:
	make preparations
	make nodejs
	sudo npm install -g typescript
	git clone https://github.com/pop-os/shell.git
	cd shell
	sh rebuild.sh
	cd ..

nautilus:
	sudo apt -y install nautilus-image-converter nautilus-wipe
	#sudo apt -y install nautilus-compare # not yet in 20.04
	
gitkraken:
	sudo snap install gitkraken

messenger:
	sudo snap install skype --classic
	sudo snap install mattermost-desktop
	sudo snap install telegram-desktop

nvidia:
	# adds ppa for nvidia more updated drivers, you still have to find out which is the version you want
	sudo add-apt-repository -y ppa:graphics-drivers/ppa
	sudo apt update
	read -p "Which nvidia driver version would you like: " nvidiaversion; \
	sudo apt install -y nvidia-graphics-drivers-$${nvidiaversion};
	sudo apt install nvidia-settings
	
spotify:
	sudo snap install spotify

code:
	sudo snap install code --classic
	sudo snap install pycharm-community --classic
	# vscode swapescape problem: file>Preferences>Settings  >keyboard.dispatch >keyCode >restart vscode
	# pycharm colorful terminal: 
	# echo "-Dspring.output.ansi.enabled=ALWAYS" >> ~/.config/JetBrains/PyCharmCE2020.1/pycharm64.vmoptions

masterpdf:
	wget https://code-industry.net/public/master-pdf-editor-4.3.89_qt5.amd64.deb
	sudo dpkg -i master-pdf-editor-4.3.89_qt5.amd64.deb
	rm -f master-pdf-editor-4.3.89_qt5.amd64.deb

eurkey:
	setxkbmap eu
	dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'eu')]"
	setxkbmap eu -option "caps:swapescape"
	echo "setxkbmap eu -option \"caps:swapescape\"" >> ~/.profile
	dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"  # swap escape and capslock	
	gsettings set org.gnome.settings-daemon.plugins.keyboard active false  # prevent from overwriting (hopefully)

zotero:
	wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | sudo bash
	sudo apt update
	sudo apt install zotero
	rm -f install.sh
	# Fix permissons to allow auto-updates
	sudo chmod -R a+rwx /usr/local/bin/zotero
	#sudo chmod -R a+rwx /opt/zotero
	# Download .xpi's
	# https://github.com/retorquere/zotero-better-bibtex/releases/latest
	# https://github.com/jlegewie/zotfile/releases
	# go to zotero Tools > Add-ons > Extensions > 'Install Add-on From File'
	

behaviour:
	gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews' # minimize windows on dash click


afs:
	# use non-standard openafs-client as ubuntu might throw 'aklog: a pioctl failed while obtaining tokens for cell cern.ch'
	sudo add-apt-repository ppa:openafs/stable
	sudo apt update
	sudo apt install openafs-client openafs-modules-dkms openafs-krb5 krb5-user krb5-config
	wget http://linux.web.cern.ch/linux/docs/krb5.conf
	sudo mv -f ./krb5.conf /etc/krb5.conf
	# https://gist.github.com/OmeGak/9530124
	# https://twiki.cern.ch/twiki/bin/view/ABPComputing/AFSDebian
	
afsssh:
	# add authentication forwarding to ssh config 
	echo "" >> ~/.ssh/config
	echo "HOST lxplus.cern.ch" >> ~/.ssh/config
	echo "    GSSAPITrustDns yes" >> ~/.ssh/config
	echo "    GSSAPIAuthentication yes" >> ~/.ssh/config
	echo "    GSSAPIDelegateCredentials yes" >> ~/.ssh/config
	
surfacekernel:
	# https://github.com/linux-surface/linux-surface/wiki/Installation-and-Setup
	wget -qO - https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc | sudo apt-key add -
	echo "deb [arch=amd64] https://pkg.surfacelinux.com/debian release main" | sudo tee /etc/apt/sources.list.d/linux-surface.list
	sudo apt-get update
	sudo apt-get install linux-headers-surface linux-image-surface linux-libc-dev-surface surface-ipts-firmware libwacom-surface
	sudo apt-get install linux-surface-secureboot-mok  # only if secure boot is still enabled!!!
	sudo update-grub
	echo "Please reboot system and enroll certificate. Password: surface"
	echo "Hint: to fix grub not responding problems, set USB as first boot device in UEFI"
	echo "Possibly add 'reboot=pci' to kernel parameters"
	# sudo gedit /etc/default/grub
	# add 'reboot=pci' into GRUB_CMDLINE_LINUX_DEFAULT after splash
	# sudo update-grub


fixdualboot:
	# Make ubuntu use local time
	sudo timedatectl set-local-rtc 1
	sudo hwclock --systohc --localtime
	
historysearch:
	echo "## arrow up" >> ~/.inputrc
	echo "\"\\e[A\":history-search-backward" >> ~/.inputrc
	echo "## arrow down" >> ~/.inputrc
	echo "\"\\e[B\":history-search-forward" >> ~/.inputrc


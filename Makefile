#
# Ubuntu 18.04 (Bionic Beaver)
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
	make python
	make graphics 
	make google_chrome google_drive
	make media media_extra
	make latex zotero
	make archives harddisk filesystem tools nautilus
	make code
	make gitkraken
	make skype spotify mattermost
	make driverppa
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
	make code python
	make gitkraken
	make media graphics
	make google_chrome google_drive
	make skype spotify mattermost
	make driverppa
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
	sudo apt -y install fonts-firacode fonts-hack\* fonts-cantarell lmodern ttf-aenigma ttf-georgewilliams ttf-bitstream-vera ttf-sjfonts tv-fonts
	# Install all the google fonts
	curl https://raw.githubusercontent.com/dylanmtaylor/Web-Font-Load/master/install.sh | sudo bash
	# Refresh font cache
	fc-cache -v

python:
	make preparations
	sudo -H apt -y install python-pip
	sudo -H pip install --upgrade pip

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

google_drive:
	# https://github.com/odeke-em/drive
	sudo add-apt-repository ppa:twodopeshaggy/drive
	sudo apt-get update
	sudo apt-get install drive

archives:
	sudo apt -y install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller

media:
	sudo add-apt-repository ppa:mc3man/mpv-tests
	sudo apt -y install mpv vlc ubuntu-restricted-extras libavcodec-extra libdvdread4
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
	sudo apt -y install icedtea-8-plugin openjdk-11-jre rabbitvcs-nautilus git curl vim gparted gnome-disk-utility usb-creator-gtk baobab

nautilus:
	sudo apt -y install nautilus-image-converter nautilus-compare nautilus-wipe
	
gitkraken:
	sudo snap install gitkraken

skype:
	sudo snap install skype

mattermost:
	sudo snap install mattermost

driverppa:
	sudo add-apt-repository -y ppa:graphics-drivers/ppa

spotify:
	sudo snap install spotify

code:
	sudo snap install code --classic
	sudo snap install pycharm-community --classic

masterpdf:
	wget https://code-industry.net/public/master-pdf-editor-4.3.89_qt5.amd64.deb
	sudo dpkg -i master-pdf-editor-4.3.89_qt5.amd64.deb
	rm -f master-pdf-editor-4.3.89_qt5.amd64.deb

eurkey:
	setxkbmap eu
	dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'eu')]"
	echo "setxkbmap eu" >> ~/.profile
	gsettings set org.gnome.settings-daemon.plugins.keyboard active false

zotero:
	wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | sudo bash
	sudo apt update
	sudo apt install zotero
	# Fix permissons to allow auto-updates
	sudo chmod -R a+rwx /usr/bin/zotero
	sudo chmod -R a+rwx /opt/zotero
	# Download .xpi's
	# https://github.com/retorquere/zotero-better-bibtex/releases/latest
	# https://github.com/jlegewie/zotfile/releases
	# go to zotero Tools > Add-ons > Extensions > 'Install Add-on From File'

behaviour:
	gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-overview' # minimize windows on dash click
	dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']" # swap escape and capslock	




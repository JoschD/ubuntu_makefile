
#
# Ubuntu 18.04 (Bionic Beaver)
#
# Basic packages i usually install.
#


.PHONY:	all preparations update upgrade flatpak atom fonts cyberduck python graphics google_chrome media latex harddisk filesystem tools nautilus kdenlive gitkraken skype spotify driverppa pycharm masterpdf eurkey behaviour conky

all:
	@echo "Installation of ALL targets"
	make preparations
	make upgrade
	make eurkey 
	make fonts
	make python
	make graphics kdenlive
	make google_chrome
	make media latex
	make archives harddisk filesystem tools nautilus
	make code
	make cyberduck gitkraken
	make skype spotify
	make driverppa
	make masterpdf
	make behaviour
	#make conky

preparations:
	sudo apt-add-repository universe
	sudo apt-add-repository multiverse
	sudo apt-add-repository restricted
	make update
	make flatpak
	sudo apt -y install wget curl git

update:
	sudo apt update

upgrade:
	sudo apt -y upgrade

flatpak:
	sudo add-apt-repository -y ppa:alexlarsson/flatpak
	sudo apt -y install flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

fonts:	
	sudo DEBIAN_FRONTEND=noninteractive apt -y install ttf-mscorefonts-installer # Install Microsoft fonts.
	mkdir -p ~/.fonts/
	sudo apt -y install fonts-firacode fonts-hack\* fonts-cantarell lmodern ttf-aenigma ttf-georgewilliams ttf-bitstream-vera ttf-sjfonts tv-fonts
	# Install all the google fonts
	curl https://raw.githubusercontent.com/dylanmtaylor/Web-Font-Load/master/install.sh | sudo bash
	# Refresh font cache
	fc-cache -v

cyberduck:
	deb https://s3.amazonaws.com/repo.deb.cyberduck.io stable main
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FE7097963FEFBE72
	sudo apt-get update
	sudo apt -y install duck

python:
	make preparations
	sudo -H apt -y install python-pip
	sudo -H pip install --upgrade pip

graphics:
	# Remove apt package if installed and install the official flatpak version of GIMP as it more closely follows upstream GIMP vesrions
	sudo apt -y remove gimp
	if sudo flatpak list | grep org.gimp.GIMP/x86_64/stable; then echo GIMP is already installed; else sudo flatpak -y install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref; fi
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

archives:
	sudo apt -y install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller

media:
	sudo add-apt-repository ppa:mc3man/mpv-tests
	sudo apt -y install mpv vlc ubuntu-restricted-extras libavcodec-extra libdvdread4
	sudo flatpak -y install flathub fr.handbrake.ghb
    # DVD Playback
	sudo apt -y install libdvd-pkg
	sudo dpkg-reconfigure libdvd-pkg

latex:
	sudo apt -y install pandoc pandoc-citeproc texlive texlive-latex-extra texlive-latex-base texlive-science texlive-fonts-recommended texlive-latex-recommended texlive-lang-german texlive-xetex preview-latex-style dvipng nbibtex

harddisk:
	sudo apt -y install smartmontools gsmartcontrol smart-notifier
	
filesystem:
	sudo apt -y install ntfs-3g

tools:
	sudo apt -y install htop password-gorilla gnome-tweaks dconf-editor
	sudo apt -y install icedtea-8-plugin openjdk-11-jre rabbitvcs-nautilus git curl vim gparted gnome-disk-utility usb-creator-gtk baobab

nautilus:
	sudo apt -y install nautilus-image-converter nautilus-compare nautilus-wipe
	
kdenlive:
	if sudo flatpak list | grep org.kde.kdenlive/x86_64/stable; then echo kdenlive is already installed; else sudo flatpak -y install https://flathub.org/repo/appstream/org.kde.kdenlive.flatpakref; fi
	sudo chown -R $$USER:$$USER /home/$$USER # Fix permissions of /home
    #  Settings->Configure Kdenlive->Playback and in the window, enable "Use GPU processing (Movit Library) -- restart Kdenlive to apply"
  
gitkraken:
	sudo snap install gitkraken

skype:
	if sudo flatpak list | grep com.skype.Client/x86_64/stable; then echo Skype is already installed; else sudo flatpak -y install https://flathub.org/repo/appstream/com.skype.Client.flatpakref; fi
	sudo chown -R $$USER:$$USER /home/$$USER # Fix permissions of /home

driverppa:
	sudo add-apt-repository -y ppa:graphics-drivers/ppa

spotify:
	if sudo flatpak list | grep com.spotify.Client/x86_64/stable; then echo Spotify is already installed; else sudo flatpak -y install https://flathub.org/repo/appstream/com.spotify.Client.flatpakref; fi
	sudo chown -R $$USER:$$USER /home/$$USER # Fix permissions of /home

code:
	sudo snap install code --classic
	sudo snap install pycharm-community --classic

masterpdf:
	wget https://code-industry.net/public/master-pdf-editor-4.3.89_qt5.amd64.deb
	sudo dpkg -i master-pdf-editor-4.3.89_qt5.amd64.deb
	rm -f master-pdf-editor-4.3.89_qt5.amd64.deb

eurkey:
	#wget https://eurkey.steffen.bruentjen.eu/download/debian/eurkey.deb
	#sudo dpkg -i eurkey.deb
	#rm -f eurkey.deb
	# already installed with newer ubuntus
	# setxkbmap eurkey  # does not change permanently
	dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'eurkey')]" # should set it permanently

behaviour:	
	gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-overview' # minimize windows on dash click
	dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']" # swap escape and capslock	

conky:
	sudo apt install conky conky-all
	# sudo apt install libimlib2-dev  # I think not neccessary


#!/bin/bash
# modified TM 2021, smb mount, gksu, sysinfo disabled

# anzeigen der systemparameter

#zenity --info --text "$(lshw -C memory)\n------------------------------------\nAnzahl Kerne: $(nproc)\n------------------------------------\n$(lshw -C cpu)" --width 1024

# Rechte der kopierten Dateien fixen
gnome-terminal --wait -- bash -c "/opt/setup/setuproot.sh"

# einstellen der favoriten
dconf write /org/gnome/shell/favorite-apps "['chromium_chromium.desktop', 'thunderbird.desktop', 'org.gnome.Nautilus.desktop', 'libreoffice-writer.desktop', 'libreoffice-calc.desktop', 'libreoffice-impress.desktop', 'org.gnome.Software.desktop']"

# zeige nach reboot bei erster verbindung die wilkommen-seite
systemctl enable --user heyalter.service

# richte das hintergrundbild ein
gsettings set org.gnome.desktop.background picture-uri 'file:///home/schule/Bilder/los_gehts.png'

#cheese

# mount staging smb share
# ip anpassen!
gio mount -a smb://192.168.10.20/transfer
# TM 11-05-2021
ln -si /run/user/1000/gvfs/smb-share\:server\=192.168.10.20\,share\=transfer/ $HOME/smb
cd $HOME/smb
gnome-terminal -- bash -c "sh ubuntu-post.sh; exec bash"
#
eject

#chromium

#zenity --ellipsize --info --text="Nun ubuntu-post.sh starten (Filemanager -> Transfer -> Terminal -> sh ubuntu-post.sh)"

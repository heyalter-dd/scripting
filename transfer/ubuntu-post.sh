#!/bin/sh
#install hardinfo and create benchmark report to CIFS share
#(c) TM 2021
#
zenity --timeout 1 --info --text="Installation wird finalisiert..."
clear
vendor=`sudo dmidecode -s system-manufacturer | sed 's/\ //g'`
model=`sudo dmidecode -s system-product-name | sed 's/\ //g'`
serial=`sudo dmidecode -s system-serial-number | sed 's/\ //g'`
datum=`date +%d-%m-%Y`
folder=`echo $vendor"_"$model"_"$serial"-"$datum`
#sudo chmod -R a+rw reports/
if test ! -e reports/$folder; then 
 echo "directory not existing, creating it"
 sudo mkdir -p reports/$folder
 sudo chmod -R a+rw reports/$folder
fi
#sudo apt update -y
sudo apt install hardinfo -y
zenity --timeout 1 --info --text="Benchmark wird erstellt..."
hardinfo -r -f html > /tmp/sysreport.html
sudo cat /tmp/sysreport.html | sed -n '/\<html/,/\<\/html/p' > reports/$folder/sysreport.html
rm /tmp/sysreport.html
zenity --timeout 1 --info --text="Systemreport wurde erstellt"
#zenity --info --text "Systemreport auf dem Staging Server unter "$folder" abgelegt" --title="Systemreport"
# updates 
zenity --timeout 1 --info --text="Updates werden installiert, bitte warten..."
# packages
sudo apt upgrade -y
# snap
zenity --timeout 1 --info --text="Snaps werden aktualisiert, bitte warten..."
sudo snap refresh
#
# TM 11-05-21 SN dazu
if zenity --question --ellipsize --text="Finalisierung beendet. S/N :"$serial" notieren! Cleanup-Script jetzt starten?"; then
 zenity --timeout 2 --info --text="Cleanup ..."
 /home/schule/Schreibtisch/./cleanup.sh
 pkill update-manager
 /snap/bin/chromium https://www.heyalter.com/dresden &
else
 zenity --info --text="Cleanup nicht vergessen!"
 pkill gnome-terminal
fi
pkill gnome-terminal

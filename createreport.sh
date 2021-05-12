#!/usr/bin/env bash
#create reports from pmagic to CIFS share
#(c) TM 2021
#
clear
vendor=`dmidecode -s system-manufacturer | sed 's/\ //g'`
model=`dmidecode -s system-product-name | sed 's/\ //g'`
serial=`dmidecode -s system-serial-number | sed 's/\ //g'`
datum=`date +%d-%m-%Y`
folder=`echo $vendor"_"$model"_"$serial"-"$datum`
mkdir -p reports/$folder
if [ ! -d /home/partedmagic/diskveri* ]; then
zenity --error --text "Loeschvorgang wirklich erledigt?" --title="Keine Reports vorhanden"
exit 0
else
cp /home/partedmagic/Secure-* reports/$folder
cp /home/partedmagic/diskveri* reports/$folder
fi
#errorhandling here
zenity --info --text "Report auf dem Staging Server unter "$folder" abgelegt" --title="Loeschreport"


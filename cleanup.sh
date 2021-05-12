#!/bin/bash
# modified TM 2021, umount smb
if [ ! -f /opt/setup/setup_done ]
then
zenity --warning --text "Erst setup.sh ausführen!" --width 512
exit 2
fi

find /home -lname '/opt/setup/*' -delete
cp /opt/setup/heyalterhelp.desktop ~/Schreibtisch
gio set ~/Schreibtisch/heyalterhelp.desktop "metadata::trusted" true

# umount smb share
# ip anpassen!
gio mount -u smb://192.168.10.20/transfer

/opt/setup/cleanuproot.sh

notify-send -t 1 "Finalisierung abgeschlossen!"
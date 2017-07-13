#!/bin/bash
# This is a work in progress. Please feel free to contribute at https://github.com/SDGoodwin/PCI_Scripts with either PR or Issues.
#
# This is being written for PCI DSS v3.2


# Variables to be used later
filedate=`date +%m.%d.%y-%H.%M`
host = hostname



rootdir=~/Desktop/PCI_Script_Out
tempdir=$filedate_$HOSTNAME

# Check to see if your $rootdir exists
if [ ! -d "$rootdir" ]; then
        mkdir "$rootdir"
fi

cd $rootdir

# Warning message that the $tempdir already exists
if [ -d "$tempdir" ]; then
	echo *****WARNING: $rootdir/$tempdir already exists rename the folder to prevent data loss*****
  exit 1
fi

mkdir "$tempdir"


# Grab NTP Configurations for Req: 10.4, 10.4.1, 10.4.2. 10.4.3
cat /etc/ntp.conf >> "$tempdir/ntp_config.log"
cat /etc/xntp.conf >> "$tempdir/xntp_config.log"
cat /var/lib/ntp/ntp.conf.dhcp >> "$tempdir/dhcp_ntp.log"

# Grab a list of all local users
cat  /etc/passwd >> "$tempdir/passwd.log"
echo #####################################
getent passwd >>"$tempdir/passwd.log"

cat /etc/shadow >> "$tempdir/shadow.log"

# List users with rights to sudo
getent group sudo | cut -d: -f4 >> "$tempdir/sudoers.log"

# Grab the Login.defs file
cat /etc/login.defs >> "$tempdir/login_defs.log"


# List all installed packages
dpkg-query -l >> "$tempdir/all_packages.log"


# Services and status codes
service --status-all >> "$tempdir/service_status.log"

# List Cron job files
ls /etc/cron.* >> "$tempdir/cron_files.log"

exit 
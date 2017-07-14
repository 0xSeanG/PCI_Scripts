#!/bin/bash
# This is a work in progress. Please feel free to contribute at https://github.com/SDGoodwin/PCI_Scripts with either PR or Issues.
#
# This is being written for PCI DSS v3.2
# Some of these commands will require elevated privleges 


# Variables to be used later
filedate=`date +%m.%d.%y-%H.%M`
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
echo ******************************** >>"$tempdir/passwd.log"
echo ******************************** >>"$tempdir/passwd.log"
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

ps aux >> "$tempdir/ps_aux.log"
ps -ef >> "$tempdir/ps_ef.log"
cat /etc/services >> "$tempdir/services.log"

# List Cron job files
ls /etc/cron.* >> "$tempdir/cron_files.log"

# Network Configurations
ifconfig >> "$tempdir/ifconfig.log"

# Local Firewall config
iptables -L -v -n --line-numbers >> "$tempdir/iptables.log"

# Rsyslog.conf
cat /etc/rsyslog.conf >> "$tempdir/Rsyslog_conf.log"

# Rsyslog.d Contents
ls /etc/rsyslog.d/ >> "$tempdir/Rsyslog_d_contents.log"
cat /etc/rsyslog.d/* >> "$tempdir/Rsyslog_d_contents_detail.log"

# Distro Info
cat /etc/issue >> "$tempdir/Distro_Info.log"
echo ******************************** >> "$tempdir/Distro_Info.log"
echo ******************************** >> "$tempdir/Distro_Info.log"
cat /etc/*-release >> "$tempdir/Distro_Info.log"
echo ******************************** >> "$tempdir/Distro_Info.log"
echo ******************************** >> "$tempdir/Distro_Info.log"
cat /etc/lsb-release >> "$tempdir/Distro_Info.log"

# Kernel info
cat /proc/version >> "$tempdir/kernel.log"
echo ******************************** >> "$tempdir/kernel.log"
echo ******************************** >> "$tempdir/kernel.log"
uname -a >> "$tempdir/kernel.log"
echo ******************************** >> "$tempdir/kernel.log"
echo ******************************** >> "$tempdir/kernel.log"
uname -mrs >> "$tempdir/kernel.log"
echo ******************************** >> "$tempdir/kernel.log"
echo ******************************** >> "$tempdir/kernel.log"
dmesg | grep Linux >> "$tempdir/kernel.log"
echo ******************************** >> "$tempdir/kernel.log"
echo ******************************** >> "$tempdir/kernel.log"
ls /boot | grep vmlinuz >> "$tempdir/kernel.log"

exit 
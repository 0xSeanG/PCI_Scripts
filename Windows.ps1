# This is a work in progress. Please feel free to contribute at https://github.com/SDGoodwin/PCI_Scripts with either PR or Issues.
#
# This is being written for PCI DSS v3.2
# Credit to https://github.com/jbarcia/PCI-Audit-Script

# Timestamp data collection
Get-Date >> timestamp.log

#System Overview
systeminfo >> systeminfo.log

#Group Policy Results (Super-Verbose)
gpresult /z >> gpresult.log

# Active connections
netstat -an >> netstat.log

# Active Routes
netstat -r >> netstat_routes.log

# NTP Config
w32tm /query /peers >> ntp_peers.log

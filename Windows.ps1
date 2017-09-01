# This is a work in progress. Please feel free to contribute at https://github.com/SDGoodwin/PCI_Scripts with either PR or Issues.
#
# This is being written for PCI DSS v3.2
# Credit to https://github.com/jbarcia/PCI-Audit-Script

# Timestamp data collection
echo %date% %time% >> 

#System Overview
systeminfo >>

#Group Policy Results (Super-Verbose)
gpresult /z >> 

# Active connections
netstat -an >>  

# Active Routes
netstat -r
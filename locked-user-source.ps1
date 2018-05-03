# Script Name: Locked-User-Source.ps1
# Author: Nathan S
# Version: 1.0
# Release Date: November 16, 2016


# This script will provide the source host
# Username and the time created for locked events

Import-Module ActiveDirectory

$user = Read-Host "Username"

$PDC = Get-ADDomainController -Discover -Service PrimaryDC

Get-WinEvent -ComputerName $PDC -Logname Security -FilterXPath "*[System[EventID=4740] and EventData[Data[@Name='TargetUserName']='$user']]" | Select-Object TimeCreated,@{Name='$user';Expression={$_.Properties[0].Value}},@{Name='Source Host'; Expression={$_.Properties[1].Value}}


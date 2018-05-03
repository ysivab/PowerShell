# Script Name: Get-Staff-Directory.ps1
# Author: Nathan S
# Version: 1.0
# Release Date: October 2, 2013


# This script will provides a list of extension, surname, full name, 
# department of people in ActiveDirectory who meets the following criteria
#		-> User account not 'Disabled'
#		-> Department is not empty
#		-> Surname is not empty
# 		-> GivenName is not empty
#

param
(
	[String] $fileName,
    [String] $searchBase,
	[switch] $help,
	[switch] $version
)

$help_ver_trigger = 0
$user_count = 0
if($help){
	Write-Host "Use:`n`tGet-Staff-Directory -fileName {path} -searchBase {dc=company,dc=com}`n"
	$help_ver_trigger = 1
}

if($version){
	Write-Host "`n`tScript Version: 1.0`n"
	$help_ver_trigger = 1
}

if($help_ver_trigger -eq 0){
	if($fileName -eq ""){
		Write-Host "`n[Warning] Please enter a file name for me to save the results. Exiting now.`n"
		Write-Host "`n[Use:`n`tGet-Staff-Directory -fileName {path}`n"
	}
	else{
		Write-Progress -Activity "Preparing output file" -Status "Purging old data, and creating new file" -percentComplete (1/8 * 100)
		if(Test-Path $fileName){
			Remove-Item $fileName
		}
	
		Write-Progress -Activity "Importing AD module" -Status "In Progress" -percentComplete (2/8 * 100)
		Import-Module ActiveDirectory
		
		Write-Progress -Activity "Querying ActiveDirectory" -Status "Downloading data" -percentComplete (3/8 * 100)
		$AD_Users = Get-ADUser -Filter * -SearchBase $searchBase -Properties *

		"First name|Last Name|Job Title|Division|Department|office Phone|Office|Floor|Email" | Out-file $fileName
		
		Write-Progress -Activity "Filtering Users" -Status "Starting" -percentComplete (4/8 * 100)
		foreach ($user in $AD_Users){
			$user_count = $user_count + 1
			$status_string = "$user_count of " + $AD_Users.Count
			Write-Progress -Activity "Filter users" -Status "$status_string" -percentComplete ( (($user_count/$AD_Users.Count) * 100 * 0.375) + (5/8 *100) )
			if($user.Surname -ne "" -and $user.GivenName -ne "" -and $user.GivenName -ne $null -and $user.Surname -ne $null -and $user.CanonicalName -notmatch "Disabled" -and $user.Enabled -eq $True -and $user.Department -ne "" -and $user.Department -ne $null){
				#$user.OfficePhone + "|" + $user.Surname + "|" + $user.GivenName + "|" + $user.Title + "|" + $user.Department + "|" + $user.Office | Out-File $fileName -Append
				$user.GivenName + "|" + $user.Surname + "|" + $user.Title + "|" + $user.Division + "|" + $user.Department + "|" + $user.OfficePhone + "|" + $user.Office + "|" + $user.floor + "|" + $user.emailAddress | Out-File $fileName -Append
			}
		}
	}
}

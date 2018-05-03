$computer_name = Read-Host "Computer"
$user_name = Read-Host "Enter the username"

# continously ask the user to re-enter the password until the passwords match
$pword_accepted = 0;
while($pword_accepted -eq 0){
	$password = Read-Host "Enter the password" -AsSecureString
	$confirmpassword = Read-Host "Confirm the password" -AsSecureString
	
	$pwd1_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
	$pwd2_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($confirmpassword))
	
	if($pwd1_text -ne $pwd2_text){
		Write-Verbose "`nThe password doesn't match. Please re-enter.`n`n"
	}
	else{
		$pword_accepted = 1;
	}
}


if((Test-Connection -ComputerName $computer_name -count 1 -ErrorAction 0)){
	try{
		# Get the members belonging to the "Administrators" group
		$group = [ADSI]("WinNT://$computer_name/$user_name,user")
		$group_members = $group.psbase.invoke("setpassword", $pwd1_text)
		$result_string += "Success|"
	}
	catch [Exception] {
		$error_msg = $_
	}
		
	# if an error is encountered, then format the error message for output
	if($error_msg -ne 0){
		$error_msg = $error_msg -Replace ("`n","")
		$error_msg = $error_msg -Replace ("`r","")
		$result_string += "Fail|"
	}
} else{
    write-verbose "Computer is offline"
}







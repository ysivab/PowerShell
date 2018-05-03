$file_server_list = read-host "Enter the file for server list"
$server_list = get-content $file_server_list

# get all the services running on the servers from the file and save it into individual files
foreach ($server in $server_list){	
	write-host "PROCESSING - $server"
	# get all the services running on the server
	$services = get-wmiobject -class Win32_Service -computerName $server
	
	# if there's a server file already exist, then remove that file first
	if(Test-Path $server){
		Remove-Item working\$server
	}
	
	# parse and save the services into the server
	"ServiceName,Status" | out-file $server -Append
	$services | foreach {
		$_.name + "," + $_.state | out-file working\$server -Append
	}
}




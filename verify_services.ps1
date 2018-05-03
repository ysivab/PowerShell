$file_server_list = read-host "Enter the server list file"
$server_list = get-content $file_server_list

foreach($server in $server_list){
	write-host "`n`n====================================================`nChecking server - $server"

	# get the previous services and status
	$prev_service_stats = import-csv working\$server
	
	# query for the current service status
	$curr_service_stats = get-wmiobject -class Win32_Service -computerName $server
	
	if($curr_service_status.count -ge $prev_service_status.cout){
		$curr_superseed = 1
	}
	else{
		$curr_superseed = 0
	}
	
	if($curr_superseed){
		foreach($curr_service in $curr_service_stats){
			foreach($prev_service in $prev_service_stats){
				if($curr_service.name -eq $prev_service.ServiceName){
					if($curr_service.state -eq $prev_service.Status){
						# everything is good
						
					}
					else{
						# something is messed
						write-host $curr_service.name "PREV_STAT: " $prev_service.Status "|| CURR_STAT:" $curr_service.state
					}
				}
			}
		}
	}
	else{
		
	}
	
	write-host "===================================================="
}


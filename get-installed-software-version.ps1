# variables
$req_vendor = read-host("Vendor name");
$computer = read-host("computer");


# Get all the services that are running on the system into an array
$all_programs = Get-WmiObject -Class "Win32_Product" -Namespace "root\CIMV2"




foreach ($program in $all_programs){
	if($program.vendor -match "*$req_vendor"){
		$out_data = $program.vendor + ";" + $program.version
		write-verbose $out_data;
	}
}


## TEMP
#move PVR from D:\ to C:\
#move SDK "D:\Program Files\Microsoft Visual Studio 8" to "C:\Program Files\Microsoft Visual Studio 8"


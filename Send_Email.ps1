$from_addr = read-host "From address"
$message_body = read-host "Send Message"
$subject = read-host "Subject"
$email_address_file = read-host ("Path to the file with email addresses");
$email_addresses = import-csv $email_address_file;

foreach($email in $email_addresses){
	$send_from = $from_addr;				 	# needs to be changed
	$send_to = $email.EmailAdddress;
	$send_message = $message_body;	# needs to be changed
	$send_subject = $subject;						# needs to be changed

	$username = read-host("Enter the username");
	$password = read-host -assecurestring ("Enter the password");

	$mailmessage = New-Object system.net.mail.mailmessage
	$mailmessage.From = $send_from;
	$mailmessage.To.add($send_to);
	$mailmessage.Subject = $send_subject;
	$mailmessage.Body = $send_message;
	$mailmessage.Attachments.Add("C:\exchange_script\data.txt");		# needs to be changed
	$mailmessage.Attachments.Add("C:\exchange_script\multi.txt");		# needs to be changed

	$SMTPClient = New-Object Net.Mail.SmtpClient("bering", 25);
	$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($username, $password);
	$SMTPClient.Send($mailmessage);
}



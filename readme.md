<h1>System admin tools</h1>
<p>These are some of the scripts I've used throughout my Windows 2003, 2008, 2012 part of my life. They are very useful and most of them should be compatible with PowerShell V2</p>

<h4>Change-Local-Password.ps1</h4>
An easier way to bulk change local admin password would be use a GPO. But sometimes, you would have to change the password to one or two machines to be different and having a GPO for that would be bit of waste. This is an instant way to quickly change it remotely. To do a bulk, wrap this around a csv imported for-loop.


<h4>Get-Staff-Directory.ps1</h4>
This one is my favourite when asked to get active users from an AD and some useful parameters. Script will try it's best to avoid taking in service accounts, and disabled users. If you have a very organized OU structure, then in your searchBase pass the OU you need.


<h4>locked-user-sources.ps1</h4>
I wrote this prevent my manager from buying a tool to just do exactly this. Script will parse through AD event logs for a specific user that is having a constant lock-out from AD to let you knwo the past 5 sources that is causing invalid password.


<h4>verify_services.ps1    get_services.ps1</h4>
Never got around properly finishing this. This was for old servers for which we need to check after a restart/update that all services are running especially during maintenance when you have your monitoring turned off, this might comes in handy. First run <strong>get_services.ps1</strong> - give it a list of servers in plain text, it will grab all the service states and save it in the running directory. After the maintenance, you can run <strong>verify_services.ps1</strong> to run a sanity check to make sure all the services that were running are still in the running state.


<h4>Send_Email.ps1</h4>
If you want ot massively send emails with just using powershell. You need to make sure IP of your server is in your SPF record if you have an external mail routing host, or if you have an internal relay host, then white list the IP of the server. Otherwise, you might get rejected, or end in spam


<h4>get-installed-software-version.ps1</h4>
If you don't have an asset management software, this should come in handy to grab a vendor installed software and version. You can modify and get more info, or wrap it in a for-loop powered csv import to do a bulk.



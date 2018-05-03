<h1>System admin tools</h1>
<p>These are some of the scripts I've used throughout my Windows 2003, 2008, 2012 part of my life. They are very useful and most of them should be compatible with PowerShell V2</p>

<h3>Change-Local-Password.ps1</h3>
An easier way to bulk change local admin password would be use a GPO. But sometimes, you would have to change the password to one or two machines to be different and having a GPO for that would be bit of waste. This is an instant way to quickly change it remotely. To do a bulk, wrap this around a csv imported for-loop.

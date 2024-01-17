#Set up firewall
Write-Host "Setting Firewall rules"
if(!(Get-NetFirewallRule -Name "Allow Node HTTP/HTTPS" -ErrorAction Ignore)){
    New-NetFirewallRule -Name "Allow Node HTTP/HTTPS" -DisplayName "Allow Node HTTP/HTTPS" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 80,443 -Program "C:\Program Files\nodejs\node.exe"
}
if(!(Get-NetFirewallRule -Name "Allow Node matchmaker-communications in" -ErrorAction Ignore)){
    New-NetFirewallRule -Name "Allow Node matchmaker-communications in" -DisplayName "Allow Node matchmaker-communications in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9999 -Program "C:\Program Files\nodejs\node.exe"
}
if(!(Get-NetFirewallRule -Name "Allow Node tcp out" -ErrorAction Ignore)){
    New-NetFirewallRule -Name "Allow Node tcp out" -DisplayName "Allow Node tcp out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Program Files\nodejs\node.exe"
}

if(!(New-NetFirewallRule -Name "Allow Local Node ss-mm-streamer-communications in" -DisplayName "Allow Local Node ss-mm-streamer-communications in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Program Files\nodejs\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node ss-mm-streamer-communications in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Program Files\nodejs\node.exe"
}

if(!(New-NetFirewallRule -Name "Allow Local Node ss-mm-streamer-communications out" -DisplayName "Allow Local Node ss-mm-streamer-communications out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Program Files\nodejs\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node ss-mm-streamer-communications out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Program Files\nodejs\node.exe"
}

if(!(New-NetFirewallRule -Name "Allow Local Node HTTP/HTTPS in" -DisplayName "Allow Local Node HTTP/HTTPS in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 80, 443 -Program "C:\Watchmaker\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node HTTP/HTTPS in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 80, 443 -Program "C:\Watchmaker\platform_scripts\cmd\node\node.exe"
}

if(!(New-NetFirewallRule -Name "Allow Local Node matchmaker in" -DisplayName "Allow Local Node matchmaker in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9999 -Program "C:\Watchmaker\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node matchmaker in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9999 -Program "C:\Watchmaker\platform_scripts\cmd\node\node.exe"
}






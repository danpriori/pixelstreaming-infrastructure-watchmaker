#Set up firewall
Write-Host "Setting Firewall rules"
# For Watchmaker Unreal Engine plugin in builds where it is named WatchmakerFakeApp.exe
if(!(New-NetFirewallRule -Name "Allow WatchmakerFake-App Binary WebRTC in" -DisplayName "Allow WatchmakerFake-App Binary WebRTC in" -Action "Allow" -Direction "Inbound" -Protocol "udp" -LocalPort 49152-65535 -Program "C:\Watchmaker\application\WatchmakerFakeApp\Binaries\Win64\WatchmakerFakeApp.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow WatchmakerFake-App Binary WebRTC in" -Action "Allow" -Direction "Inbound" -Protocol "udp" -LocalPort 49152-65535 -Program "C:\Watchmaker\application\WatchmakerFakeApp\Binaries\Win64\WatchmakerFakeApp.exe"
}
if(!(New-NetFirewallRule -Name "Allow WatchmakerFake-App Binary WebRTC out" -DisplayName "Allow WatchmakerFake-App WebRTC Binary WebRTC out" -Action "Allow" -Direction "Outbound" -Protocol "udp" -LocalPort 49152-65535 -Program "C:\Watchmaker\application\WatchmakerFakeApp\Binaries\Win64\WatchmakerFakeApp.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow WatchmakerFake-App Binary WebRTC out" -Action "Allow" -Direction "Outbound" -Protocol "udp" -LocalPort 49152-65535 -Program "C:\Watchmaker\application\WatchmakerFakeApp\Binaries\Win64\WatchmakerFakeApp.exe"
}
# For Watchmaker Unreal Engine plugin in builds where it is named WatchmakerFakeApp.exe
if(!(New-NetFirewallRule -Name "Allow WatchmakerFake-App WebRTC in" -DisplayName "Allow WatchmakerFake-App WebRTC in" -Action "Allow" -Direction "Inbound" -Protocol "udp" -LocalPort 49152-65535 -Program "C:\Watchmaker\application\WatchmakerFakeApp.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow WatchmakerFake-App WebRTC in" -Action "Allow" -Direction "Inbound" -Protocol "udp" -LocalPort 49152-65535 -Program "C:\Watchmaker\application\WatchmakerFakeApp.exe"
}
if(!(New-NetFirewallRule -Name "Allow WatchmakerFake-App WebRTC out" -DisplayName "Allow WatchmakerFake-App WebRTC out" -Action "Allow" -Direction "Outbound" -Protocol "udp" -LocalPort 49152-65535 -Program "C:\Watchmaker\application\WatchmakerFakeApp.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow WatchmakerFake-App WebRTC out" -Action "Allow" -Direction "Outbound" -Protocol "udp" -LocalPort 49152-65535 -Program "C:\Watchmaker\application\WatchmakerFakeApp.exe"
}
# For Watchmaker.exe loader
if(!(New-NetFirewallRule -Name "Allow WatchmakerFake-App TCP" -DisplayName "Allow WatchmakerFake-App TCP" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Watchmaker\application\WatchmakerFakeApp.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow WatchmakerFake-App TCP" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Watchmaker\application\WatchmakerFakeApp.exe"
}
if(!(New-NetFirewallRule -Name "Allow WatchmakerFake-App TCP out" -DisplayName "Allow WatchmakerFake-App TCP out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Watchmaker\application\WatchmakerFakeApp.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow WatchmakerFake-App TCP out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Watchmaker\application\WatchmakerFakeApp.exe"
}



if(!(New-NetFirewallRule -Name "Allow WatchmakerFake-App frontend-streamer in" -DisplayName "Allow WatchmakerFake-App frontend-streamer in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Watchmaker\application\WatchmakerFakeApp.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow WatchmakerFake-App frontend-streamer in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Watchmaker\application\WatchmakerFakeApp.exe"
}
if(!(New-NetFirewallRule -Name "Allow WatchmakerFake-App Binary frontend-streamer in" -DisplayName "Allow WatchmakerFake-App frontend-streamer in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Watchmaker\application\WatchmakerFakeApp\Binaries\Win64\WatchmakerFakeApp.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow WatchmakerFake-App Binary frontend-streamer in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Watchmaker\application\WatchmakerFakeApp\Binaries\Win64\WatchmakerFakeApp.exe"
}


if(!(New-NetFirewallRule -Name "Allow WatchmakerFake-App frontend-streamer out" -DisplayName "Allow WatchmakerFake-App frontend-streamer out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Watchmaker\application\WatchmakerFakeApp.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow WatchmakerFake-App frontend-streamer out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Watchmaker\application\WatchmakerFakeApp.exe"
}
if(!(New-NetFirewallRule -Name "Allow WatchmakerFake-App Binary frontend-streamer out" -DisplayName "Allow WatchmakerFake-App frontend-streamer out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Watchmaker\application\WatchmakerFakeApp\Binaries\Win64\WatchmakerFakeApp.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow WatchmakerFake-App Binary frontend-streamer out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Watchmaker\application\WatchmakerFakeApp\Binaries\Win64\WatchmakerFakeApp.exe"
}



if(!(New-NetFirewallRule -Name "Allow Node HTTP/HTTPS" -DisplayName "Allow Node HTTP/HTTPS" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 80,443 -Program "C:\Program Files\nodejs\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Node HTTP/HTTPS" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 80,443 -Program "C:\Program Files\nodejs\node.exe"
}
if(!(New-NetFirewallRule -Name "Allow Node matchmaker-communications out" -DisplayName "Allow Node matchmaker-communications out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9999 -Program "C:\Program Files\nodejs\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Node matchmaker-communications out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9999 -Program "C:\Program Files\nodejs\node.exe"
}
if(!(New-NetFirewallRule -Name "Allow Node tcp out" -DisplayName "Allow Node tcp out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Program Files\nodejs\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Node tcp out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Program Files\nodejs\node.exe"
}
if(!(New-NetFirewallRule -Name "Allow Node tcp in" -DisplayName "Allow Node tcp in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Program Files\nodejs\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Node tcp in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Program Files\nodejs\node.exe"
}

if(!(New-NetFirewallRule -Name "Allow Local Node HTTP/HTTPS" -DisplayName "Allow Local Node HTTP/HTTPS" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 80,443 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node HTTP/HTTPS" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 80,443 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe"
}
if(!(New-NetFirewallRule -Name "Allow Local Node matchmaker-communications out" -DisplayName "Allow Local Node matchmaker-communications out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9999 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node matchmaker-communications out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9999 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe"
}
if(!(New-NetFirewallRule -Name "Allow Local Node tcp out" -DisplayName "Allow Local Node tcp out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node tcp out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe"
}
if(!(New-NetFirewallRule -Name "Allow Local Node tcp in" -DisplayName "Allow Local Node tcp in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node tcp in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe"
}
if(!(New-NetFirewallRule -Name "Allow Local Node WebRTC out" -DisplayName "Allow Local Node WebRTC out" -Action "Allow" -Direction "Outbound" -Protocol "udp" -LocalPort 49152-65535 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node WebRTC out" -Action "Allow" -Direction "Outbound" -Protocol "udp" -LocalPort 49152-65535 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe"
}
if(!(New-NetFirewallRule -Name "Allow Local Node WebRTC in" -DisplayName "Allow Local Node WebRTC in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node WebRTC in" -Action "Allow" -Direction "Inbound" -Protocol "udp" -LocalPort 49152-65535 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe"
}

if(!(New-NetFirewallRule -Name "Allow Local Node ss-mm-streamer-communications in" -DisplayName "Allow Local Node ss-mm-streamer-communications in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node ss-mm-streamer-communications in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe"
}

if(!(New-NetFirewallRule -Name "Allow Local Node ss-mm-streamer-communications out" -DisplayName "Allow Local Node ss-mm-streamer-communications out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node ss-mm-streamer-communications out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "C:\Watchmaker\pixelstreaming\platform_scripts\cmd\node\node.exe"
}
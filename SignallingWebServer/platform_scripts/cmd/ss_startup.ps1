
$SignallingServerFolder = "C:\Watchmaker\pixelstreaming"
$ApplicationFolder = "C:\Watchmaker\application"

#Set up firewall
Write-Host "Setting Firewall rules"
# For Watchmaker Unreal Engine plugin in builds where it is named Watch_France.exe
if(!(New-NetFirewallRule -Name "Allow Watch_France-App Binary WebRTC in" -DisplayName "Allow Watch_France Binary WebRTC in" -Action "Allow" -Direction "Inbound" -Protocol "udp" -LocalPort 49152-65535 -Program "$ApplicationFolder\Watch_France\Binaries\Win64\Watch_France.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Watch_France Binary WebRTC in" -Action "Allow" -Direction "Inbound" -Protocol "udp" -LocalPort 49152-65535 -Program "$ApplicationFolder\Watch_France\Binaries\Win64\Watch_France.exe"
}
if(!(New-NetFirewallRule -Name "Allow Watch_France Binary WebRTC out" -DisplayName "Allow Watch_France WebRTC Binary WebRTC out" -Action "Allow" -Direction "Outbound" -Protocol "udp" -LocalPort 49152-65535 -Program "$ApplicationFolder\Watch_France\Binaries\Win64\Watch_France.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Watch_France Binary WebRTC out" -Action "Allow" -Direction "Outbound" -Protocol "udp" -LocalPort 49152-65535 -Program "$ApplicationFolder\Watch_France\Binaries\Win64\Watch_France.exe"
}
# For Watchmaker Unreal Engine plugin in builds where it is named Watch_France.exe
if(!(New-NetFirewallRule -Name "Allow Watch_France WebRTC in" -DisplayName "Allow Watch_France WebRTC in" -Action "Allow" -Direction "Inbound" -Protocol "udp" -LocalPort 49152-65535 -Program "$ApplicationFolder\Watch_France.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Watch_France WebRTC in" -Action "Allow" -Direction "Inbound" -Protocol "udp" -LocalPort 49152-65535 -Program "$ApplicationFolder\Watch_France.exe"
}
if(!(New-NetFirewallRule -Name "Allow Watch_France WebRTC out" -DisplayName "Allow Watch_France WebRTC out" -Action "Allow" -Direction "Outbound" -Protocol "udp" -LocalPort 49152-65535 -Program "$ApplicationFolder\Watch_France.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Watch_France WebRTC out" -Action "Allow" -Direction "Outbound" -Protocol "udp" -LocalPort 49152-65535 -Program "$ApplicationFolder\Watch_France.exe"
}
# For Watchmaker.exe loader
if(!(New-NetFirewallRule -Name "Allow Watch_France TCP" -DisplayName "Allow Watch_France TCP" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "$ApplicationFolder\Watch_France.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Watch_France TCP" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "$ApplicationFolder\Watch_France.exe"
}
if(!(New-NetFirewallRule -Name "Allow Watch_France TCP out" -DisplayName "Allow Watch_France TCP out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "$ApplicationFolder\Watch_France.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Watch_France TCP out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "$ApplicationFolder\Watch_France.exe"
}



if(!(New-NetFirewallRule -Name "Allow Watch_France frontend-streamer in" -DisplayName "Allow Watch_France frontend-streamer in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "$ApplicationFolder\Watch_France.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Watch_France frontend-streamer in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "$ApplicationFolder\Watch_France.exe"
}
if(!(New-NetFirewallRule -Name "Allow Watch_France Binary frontend-streamer in" -DisplayName "Allow Watch_France Binary frontend-streamer in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "$ApplicationFolder\Watch_France\Binaries\Win64\Watch_France.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Watch_France Binary frontend-streamer in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "$ApplicationFolder\Watch_France\Binaries\Win64\Watch_France.exe"
}


if(!(New-NetFirewallRule -Name "Allow Watch_France frontend-streamer out" -DisplayName "Allow Watch_France frontend-streamer out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "$ApplicationFolder\Watch_France.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Watch_France frontend-streamer out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "$ApplicationFolder\Watch_France.exe"
}
if(!(New-NetFirewallRule -Name "Allow Watch_France Binary frontend-streamer out" -DisplayName "Allow Watch_France frontend-streamer out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "$ApplicationFolder\Watch_France\Binaries\Win64\Watch_France.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Watch_France Binary frontend-streamer out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "$ApplicationFolder\Watch_France\Binaries\Win64\Watch_France.exe"
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

if(!(New-NetFirewallRule -Name "Allow Local Node HTTP/HTTPS" -DisplayName "Allow Local Node HTTP/HTTPS" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 80,443 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node HTTP/HTTPS" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 80,443 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe"
}
if(!(New-NetFirewallRule -Name "Allow Local Node matchmaker-communications out" -DisplayName "Allow Local Node matchmaker-communications out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9999 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node matchmaker-communications out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9999 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe"
}
if(!(New-NetFirewallRule -Name "Allow Local Node tcp out" -DisplayName "Allow Local Node tcp out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node tcp out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe"
}
if(!(New-NetFirewallRule -Name "Allow Local Node tcp in" -DisplayName "Allow Local Node tcp in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node tcp in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe"
}
if(!(New-NetFirewallRule -Name "Allow Local Node WebRTC out" -DisplayName "Allow Local Node WebRTC out" -Action "Allow" -Direction "Outbound" -Protocol "udp" -LocalPort 49152-65535 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node WebRTC out" -Action "Allow" -Direction "Outbound" -Protocol "udp" -LocalPort 49152-65535 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe"
}
if(!(New-NetFirewallRule -Name "Allow Local Node WebRTC in" -DisplayName "Allow Local Node WebRTC in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 49152-65535 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node WebRTC in" -Action "Allow" -Direction "Inbound" -Protocol "udp" -LocalPort 49152-65535 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe"
}

if(!(New-NetFirewallRule -Name "Allow Local Node ss-mm-streamer-communications in" -DisplayName "Allow Local Node ss-mm-streamer-communications in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node ss-mm-streamer-communications in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 9090 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe"
}

if(!(New-NetFirewallRule -Name "Allow Local Node ss-mm-streamer-communications out" -DisplayName "Allow Local Node ss-mm-streamer-communications out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node ss-mm-streamer-communications out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 9090 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe"
}

if(!(New-NetFirewallRule -Name "Allow Local Node STUN/TURN in" -DisplayName "Allow Local Node STUN/TURN in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 19302,3478,5349  -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node STUN/TURN in" -Action "Allow" -Direction "Inbound" -Protocol "tcp" -LocalPort 19302,3478,5349 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe"
}

if(!(New-NetFirewallRule -Name "Allow Local Node STUN/TURN out" -DisplayName "Allow Local Node STUN/TURN out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 19302,3478,5349 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe" -ErrorAction Ignore)){
    Set-NetFirewallRule -Name "Allow Local Node STUN/TURN out" -Action "Allow" -Direction "Outbound" -Protocol "tcp" -LocalPort 19302,3478,5349 -Program "$SignallingServerFolder\platform_scripts\cmd\node\node.exe"
}


Write-Host "Running Signalling Server"
Start-Process -FilePath "npm" -ArgumentList 'run','start:windows' -WorkingDirectory "$SignallingServerFolder" -Wait -NoNewWindow -ErrorAction Continue
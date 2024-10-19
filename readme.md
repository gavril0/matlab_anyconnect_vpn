```
Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
```

# Matlab API for Cisco AnyConnect VPN

This repository contains batch files and matlabs script manage **Cisco AnnyConnect** VPN from matlab.  The software is distributed with MIT license and copyrigth notice. The original version was developped at [San Raffaele University](www.unisr.it) for the [telecyclette project](www.telecyclette.eu) funded by the [Velux foundation](https://veluxstiftung.ch/).

The functions have been tested on Windows 10 and Windows 11 with Cisco AnyConnect client version 4.9 and should be compatible with any matlab version. 

# Installation 

In order to use these functions, it is necessary to 

1. Download and install Cisco AnyConnect client. This should install Cisco Any client in Windows 'PROGRAMFILES(x86)' directory.
2. Create a file with the credentials (see `vpn_login.txt` as template). This should be a text file with three lines:
```
     connect <hostname>
     <username>
     <password> 
```
  This file should be saved in MATLAB workding directory or in the directory of the "vpn_connect.m" script.

Then you can start to use the matlab functions to manage the VPN connection.

If you don't know or have a hostname defined, connect to VPN server using the interactive Cisco AnyConnect Secure Mobility Client App (`vpnui.exe`). Enter address of VPN Server (Host). This will create a hostname for the file with credentials.

# Matlab functions

- `vpn_connect`: connect to VPN  
- `vpn_disconnect`: disconnect from VPN 
- `vpn_test`: test VPN connection 
- `vpn_gui`: small matlab UI to connect, disconnect and test the VPN connection 

# Examples

```
vpn_credentials = 'vpn_login.txt'; % file with credentials
test_ip = 'XXX.XXX.XXX.XXX';       % IP of some server in the VPN

% kill VPN GUI  client (if it is started) because it prevents VPN CLI to run  
system('taskkill /f /im vpnui.exe');

% connect to VPN
[status, result] = vpn_connect(vpn_credentials, test_ip)

% test VPN
[status, result] = vpn_test(test_ip)

% disconnect from VPN
[status, result] = vpn_disconnect()

% connect, test and disconnet via GUI
vpngui(vpn_credentials, test_ip);
```

# Notes

- The matlab functions assume that Cisco AnyConnect client is installed in Windows in 'PROGRAMFILES(x86)\Cisco\Cisco AnyConnect Secure Mobility Client' directory
- Make sure that VPN GUI  client is not running when using `vpn_connect` and that the credentials are valid. The function `vpn_connect` will be "stuck" if there is a connection problem because the VPN client `vpncli.exe` does not return. 



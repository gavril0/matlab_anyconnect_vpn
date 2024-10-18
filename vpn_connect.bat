@echo on
:: Usage: vpn_connect <login.txt>
::
:: where <login.txt> is a file with three lines
::
::   connect <host>
::   <username>
::   <password>
::
:: (Attention: not trailing space at the end of the lines)

:: Path toward VPN client
SET path_vpn_client="%PROGRAMFILES(x86)%\Cisco\Cisco AnyConnect Secure Mobility Client"

:: Connect command
%path_vpn_client%\vpncli.exe -s < %1
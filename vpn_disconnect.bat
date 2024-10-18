@echo off
:: Usage: vpn_disconnect

SET path_vpn_client="%PROGRAMFILES(x86)%\Cisco\Cisco AnyConnect Secure Mobility Client"
:: Disconnect command
%path_vpn_client%\vpncli.exe disconnect
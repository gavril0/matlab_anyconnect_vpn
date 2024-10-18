% Disconnect from VPN
%
% Syntax
% ------
% [status, result] =  vpn_disconnect()
%
% Description
% -----------
% The `status` value is 0 when for success and `
% 1 for error. The `result` contains a string with 
% the command output. 
%
% Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function [status, result] = vpn_disconnect();
  path_vpn_client = ['"' getenv('PROGRAMFILES(x86)')...
      '\Cisco\Cisco AnyConnect Secure Mobility Client"'];
  cmd = [path_vpn_client '\vpncli.exe disconnect'];
  [status, result] = system(cmd);
end
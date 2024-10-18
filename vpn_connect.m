% vpn_connect - Connect to AnyConnect VPN
%
% Syntax
% ------
% [status, result] = vpn_connect(vpn_credentials)
% [status, result] = vpn_connect(vpn_credentials, test_ip)
%
% Description
% -----------
% `vpn_connect` establishes a connection to a vpn server specified
% in the `vpn_credential` text file. This file also contains the 
% credential of the user. The `test_ip` address must corresponds
% to some server in the VPN able to response to a `ping` request.
% It is used to test the if the VPN connection already exists.  
% This will avoid vpn_connect to be stuck if the connection
% is already established. 
%
% The `status` value is 0 when for success and 1 for error. 
% The `result` contains a string with the command output.
% 
% Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function [status, result] = vpn_connect(vpn_credentials, test_ip)

if nargin == 2
  % test if a connection exists
  [status, result] = system(['ping -n 1 ' test_ip]);
  if status == 0
    result = 'Already connected';
    return;
  end
end

% test if credentials are in the current directoy 
status = system(['IF EXIST ' vpn_credentials ' (EXIT /B 0) ELSE (EXIT /B 1)']);
if status==1
    % test if credentials are in the same dirctory as the function 
    p = mfilename('fullpath');
    path_vpn_credentials = p(1:find(p == '\', 1, 'last'));
    status = system(['IF EXIST ' path_vpn_credentials vpn_credentials ...
        ' (EXIT /B 0) ELSE (EXIT /B 1)']);
    if status==1
        result = ['Error - Cannot find file ' vpn_credentials]; 
        return;
    end 
else
    path_vpn_credentials ='';
end

% start VPN client
path_vpn_client = ['"' getenv('PROGRAMFILES(x86)') ...    
    '\Cisco\Cisco AnyConnect Secure Mobility Client"'];
cmd = [path_vpn_client '\vpncli.exe -s < ' path_vpn_credentials vpn_credentials];
[status, result] = system(cmd);

end % function

% vpn_test - Test VPN connection
%
% Syntax
% -------
% [status, result] = vpn_test(test_ip)
%
% Description
% -----------
% Test if a VPN connection by pinging the address `test_ip` 
% assuming that this address is accessible only via VPN.
%
% The `status` value is 0 when for success and 1 for error. 
% The `result` contains a string with the command output.
%
% Copyright 2024 Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function [status, result] = vpn_test(test_ip)
  % vpn_connect - Connect to AnyConnect VPN
  [status, result] = system(['ping -n 1 ' test_ip]);
end
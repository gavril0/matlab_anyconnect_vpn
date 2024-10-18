% vpn_gui - Matlab UI for Cisco AnyConnect VPN
%
% Syntax
% ------
% vpn_ui(vpn_credentials, test_ip)
%
% Desription
% ----------
% Create a matlab UI with buttons to connect to, test and
% disconnect from a VPN.
%
% `vpn_credentials` is a text file with Cisco AnyConnect
% VPN credential and `test_ip` is IP of a a server
% accesssible only with VPN that can be used to test The
% connection (via `ping`).
%
% Copyright 2024 UniSR, Gabriel Baud-Bovy <gbaudbovy@gmail.com>
function vpn_ui(vpn_credentials, test_ip)
  % create figure with buttons to control VPN connection
  fig = uifigure( ...
    'Name','San Raffaele VPN', ...
    'Position',[100 100 300 200] ...
    );
    % application information
    fig.UserData = struct( ...
    'vpn_credentials', vpn_credentials,...
    'test_ip', test_ip);

  g = uigridlayout(fig, [3 3]);
  b = uibutton(g, ...
    'Text', 'Connect', ...
    'ButtonPushedFcn', @(src,event) vpngui_connect_cb(fig.UserData));
  b.Layout.Row=1; b.Layout.Column=1;
  b = uibutton(g, ...
    "Text", "Test", ...
    "ButtonPushedFcn", @(src,event) vpngui_test_cb(fig.UserData));
  b.Layout.Row=1; b.Layout.Column=2;
  b = uibutton(g, ...
    "Text", "Disconnect", ...
    "ButtonPushedFcn", @(src,event) vpngui_disconnect_cb(fig.UserData));
  b.Layout.Row=1; b.Layout.Column=3;
  % text are for output
  txa = uitextarea(g, ...
    'Placeholder', 'Output');
  txa.Layout.Row=[2 3]; txa.Layout.Column=[1 3];

  % check vpn connection state
  status = vpn_test(test_ip)
  if status==0
    txa.Value = [['Status: ' num2str(status)]; "VPN connected"];
  else
    txa.Value = [['Status: ' num2str(status)]; "VPN not connected"];
  end

  fig.UserData.txa = txa;
  % fig.UserData = app_data;
end

%
% Callback functions
%

function vpngui_connect_cb(app_data)
  app_data.txa.Value = 'Connecting...';
  [status, result] = vpn_connect(app_data.vpn_credentials, app_data.test_ip);
  app_data.txa.Value = [['Status: ' num2str(status)], newline, result];
end

function vpngui_test_cb(app_data)
  app_data.txa.Value = 'Testing...';
  [status, result] = vpn_test(app_data.test_ip);
  app_data.txa.Value = [['Status: ' num2str(status)], newline, result];
end

function vpngui_disconnect_cb(app_data)
  app_data.txa.Value = 'Disconnecting...';
  [status, result] = vpn_disconnect();
  app_data.txa.Value = [['Status: ' num2str(status)], newline, result];
end


{ config, lib, pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      left  = "h";
      down  = "j";
      up    = "k";
      right = "l";
      terminal = "alacritty";
      menu = "wofi --show drun";
      output = {
        Virtual-1 = {
          resolution = "3440x1440";
          bg = "~/wallpaper.jpg fill";
        };
      };
      bars = [
        {
          position = "top";
          statusCommand = "i3status";
          colors = {
            statusline = "#ffffff";
            background = "#323232";
            inactiveWorkspace = {
              background = "#323232";
              border = "#323232";
              text = "5c5c5c";
            };
          };
        }
      ];
      gaps.inner = 15;
    };
  };

  home.file.".config/sway/config".source = ./config;
  home.file.".config/systemd/user/sway-session.target".source = ./sway-session.target;
  home.file.".config/systemd/user/sway.service".source = ./sway.service;

  home.packages = with pkgs; [
    # wayland packages
    mako
    # swaywm packages
    swaylock
    swayidle
    waybar
    wofi
    i3status
  ];
}

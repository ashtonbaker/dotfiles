{ pkgs, ... }:
{
  imports = [
    ./home-common.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ashton";
  home.homeDirectory = "/home/ashton";

  # Home Manager has an option to set some environment
  # variables that will ease usage of software installed with
  # nix on non-NixOS linux
  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
      wl-clipboard
      xclip
      ripgrep
  ];
}

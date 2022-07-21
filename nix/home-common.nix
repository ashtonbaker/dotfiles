{ config, pkgs, ... }:

{
  imports = [
    ./programs/dircolors.nix
    ./programs/git.nix
    ./programs/fish.nix
    ./programs/emacs.nix
    ./programs/vim.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Let Home Manager update fonts cache
  # (https://github.com/nix-community/home-manager/issues/520)
  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # packages
  home.packages = with pkgs; [
    jetbrains-mono
    htop
    tmux
  ];
}

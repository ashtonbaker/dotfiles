{ config, pkgs, ... }:

{
  imports = [
    ./dircolors/dircolors.nix
    ./git/git.nix
    ./fish/fish.nix
    ./emacs/emacs.nix
    ./tmux/tmux.nix
    ./vim/vim.nix
    ./bash/bash.nix
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
    htop
    xclip
  ];
}

{ config, lib, pkgs, ... }:

{
  programs.tmux.enable = true;
  home.file.".tmux.conf.local".source = ./.tmux.conf.local;
  home.file.".tmux.conf".source = ./.tmux.conf;
}

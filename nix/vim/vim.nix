{ config, lib, pkgs, ... }:

{
  programs.vim.enable = true;
  home.file.".vimrc".source = ./.vimrc;
  home.file.".vim" = {
    source = ./.vim;
    recursive = true;
  };
}

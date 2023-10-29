{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };

  home.file.".doom.d/init.el" = {
    source = ./.doom.d/init.el;
  };

  home.file.".doom.d/config.org" = {
    source = ./.doom.d/config.org;
  };

  # services.emacs = {
  #   enable = true;
  #   defaultEditor = true;
  #   client.enable = true;
  # };

  home.packages = with pkgs; [
    jetbrains-mono
    emacs-all-the-icons-fonts
    ripgrep
  ];
}

{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
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

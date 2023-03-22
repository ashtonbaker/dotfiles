{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };

  home.file.".doom.d" = {
    source = ./.doom.d;

    # this doesn't seem to be necessary at the moment
    #recursive = true;
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

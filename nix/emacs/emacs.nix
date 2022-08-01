{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };

  services.emacs.enable = true;

  home.file.".doom.d" = {
    source = ./.doom.d;

    # this doesn't seem to be necessary at the moment
    #recursive = true;
  };

  home.packages = with pkgs; [
    jetbrains-mono
    emacs-all-the-icons-fonts
  ];
}

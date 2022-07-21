{ config, pkgs, ... }:

{
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

  # Git Configuration
  programs.git.enable = true;

  home.packages = with pkgs; [
    jetbrains-mono
    htop
    tmux
  ];

  ### Terminal configuration
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "ls -aG";
      ll = "ls -laG";
    };
    shellAbbrs = {
      o = "open";
    };
    interactiveShellInit = "fish_add_path ~/.local/bin ~/bin ~/.nix-profile/bin";
    plugins = [{
        name="foreign-env";
        src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-foreign-env";
            rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
            sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
        };
    }];

    shellInit =
    ''
        # nix
        if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
            fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        end

        # home-manager
        #if test -e <nix_file_path_file>
        #    fenv source <nix_file_path_file>
        #end
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[x](bold red)";
        vicmd_symbol = "[<](bold green)";
      };
      git_commit = {
        tag_symbol = " tag ";
      };
      git_status = {
        ahead = ">";
        behind = "<";
        diverged = "<>";
        renamed = "r";
        deleted = "x";
      };
    };
    enableFishIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    font = {
      normal = {
        family = "JetBrains Mono";
        style = "Medium";
      };
      bold = {
        family = "JetBrains Mono";
        style = "Bold";
      };
      italic = {
        family = "JetBrains Mono";
        style = "Italic";
      };
      size = 10;
      offset = {
        x = 0;
        y = 0;
      };
      glyph_offset = {
        x = 0;
        y = 0;
      };
    };

    ## Nord Theme for Alacritty - Ported from:
    ## https://github.com/arcticicestudio/nord-alacritty
    colors = {
      primary = {
        background = "#2e3440";
        foreground = "#d8dee9";
        dim_foreground = "#a5abb6";
      };
      cursor = {
        text = "#2e3440";
        cursor = "#d8dee9";
      };
      vi_mode_cursor = {
        text = "#2e3440";
        cursor = "#d8dee9";
      };
      selection = {
        text = "CellForeground";
        background = "#4c566a";
      };
      search = {
        matches = {
          foreground = "CellBackground";
          background = "#88c0d0";
        };
        bar = {
          background = "#434c5e";
          foreground = "#d8dee9";
        };
      };
      normal = {
        black = "#3b4252";
        red = "#bf616a";
        green = "#a3be8c";
        yellow = "#ebcb8b";
        blue = "#81a1c1";
        magenta = "#b48ead";
        cyan = "#88c0d0";
        white = "#e5e9f0";
      };
      bright = {
        black = "#4c566a";
        red = "#bf616a";
        green = "#a3be8c";
        yellow = "#ebcb8b";
        blue = "#81a1c1";
        magenta = "#b48ead";
        cyan = "#8fbcbb";
        white = "#eceff4";
      };
      dim = {
        black = "#373e4d";
        red = "#94545d";
        green = "#809575";
        yellow = "#b29e75";
        blue = "#68809a";
        magenta = "#8c738c";
        cyan = "#6d96a5";
        white = "#aeb3bb";
      };
    };
    shell = {
      program = "fish";
    };
  };

  ### Emacs
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };
}

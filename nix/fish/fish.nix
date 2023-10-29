{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      o = "open";
    };
    plugins = [{
      name="foreign-env";
      src = pkgs.fetchFromGitHub {
        owner = "oh-my-fish";
        repo = "plugin-foreign-env";
        rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
        sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
      };
    }];

    functions = {
      vterm_printf =
        ''
        '';
    };

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

      if [ "$INSIDE_EMACS" = 'vterm' ]
          function clear
              vterm_printf "51;Evterm-clear-scrollback";
              tput clear;
          end
      end

      set -x SSH_AUTH_SOCK /Users/ashtonbaker/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

      set -x AWS_PROFILE vl-systemadministrator

      # VTERM STUFF
      function vterm_printf;
          if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end
              # tell tmux to pass the escape sequences through
              printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
          else if string match -q -- "screen*" "$TERM"
              # GNU screen (screen, screen-256color, screen-256color-bce)
              printf "\eP\e]%s\007\e\\" "$argv"
          else
              printf "\e]%s\e\\" "$argv"
          end
      end

      function vterm_prompt_end;
          vterm_printf '51;A'(whoami)'@'(hostname)':'(pwd)
      end

      function vterm_cmd --description 'Run an Emacs command among the ones been defined in vterm-eval-cmds.'
          set -l vterm_elisp ()
          for arg in $argv
              set -a vterm_elisp (printf '"%s" ' (string replace -a -r '([\\\\"])' '\\\\\\\\$1' $arg))
          end
          vterm_printf '51;E'(string join \'\' $vterm_elisp)
      end

      function find_file
          set -q argv[1]; or set argv[1] "."
          vterm_cmd find-file (realpath "$argv")
      end

      function say
          vterm_cmd message "%s" "$argv"
      end

      functions --copy fish_prompt vterm_old_fish_prompt
      function fish_prompt --description 'Write out the prompt; do not replace this. Instead, put this at end of your file.'
          # Remove the trailing newline from the original prompt. This is done
          # using the string builtin from fish, but to make sure any escape codes
          # are correctly interpreted, use %b for printf.
          printf "%b" (string join "\n" (vterm_old_fish_prompt))
          vterm_prompt_end
      end

      # END VTERM STUFF

      atuin init fish | source
      eval "$(/opt/homebrew/bin/brew shellenv)"
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
    settings = {
      search_mode = "fuzzy";
      filter_mode = "session";
    };
  };
}

{ ... }:
{
  imports = [ ./home-common.nix ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ashton";
  home.homeDirectory = "/Users/ashton";

  home.sessionPath = [
    "/opt/homebrew/bin"
  ];

  home.sessionVariables = {
    HOMEBREW_PREFIX = "/opt/homebrew";
  };

  launchd = {
    enable = true;
    agents = {
      emacsclient = {
        enable = false;
        config = {
          ProgramArguments = [
            "/users/ashton/.nix-profile/bin/emacs"
            "--daemon"
          ];
          RunAtLoad = true;
          KeepAlive = true;
          Label = "gnu.emacs.daemon";
        };
      };
    };
  };
}

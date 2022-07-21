{ ... }:
{
  imports = [ ./home-common.nix ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ashtonbaker";
  home.homeDirectory = "/Users/ashtonbaker";
}

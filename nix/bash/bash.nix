{ ... }:

{
  programs.bash.enable = true;
  home.file.".bash.d" = {
    source = ./.bash.d;
    recursive = true;
  };
  programs.bash.initExtra = "PATH=$PATH:~/bin/";
  #home.file.".profile".source = ./.profile;
  #home.file.".bash_profile".source = ./.bash_profile;
  #home.file.".bashrc".source = ./.bashrc;
  home.file.".bash_logout".source = ./.bash_logout;
}

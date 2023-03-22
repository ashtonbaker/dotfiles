{ ... }:
{
  # Git Configuration
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Ashton Baker";
    userEmail = "mail@ashtonbaker.com";
    aliases = {
      adog = "log --all --decorate --oneline --graph";
      unstage = "reset HEAD --";
      co = "checkout";
      s = "status";
      blu-clone = "\"!f() { git clone --recurse-submodules git@bitbucket.org:blumira/\${1}.git ~/blumira/\${1}; }; f\"";
      dno = "diff --name-only";
    };
    extraConfig = {
      core = {
        excludesFile = "~/.gitignore_global";
        editor = "vim";
      };
      github = {
        username = "ashtonbaker";
      };
      merge = {
        conflictstyle = "diff3";
        ours = { driver = true; };
      };
      url = {
        "git@bitbucket.org:" = {
          insteadOf = "https://bitbucket.org";
        };
      };
    };
    includes = [
      {
        condition = "gitdir:~/vl/";
        contents = {
          github.user = "ashtonbaker";
          user = {
            email = "ashton.baker@vannevarlabs.com";
            name = "Ashton Baker";
          };
        };
      }
    ];
    ignores = [
      # Compiled source #
      ###################
      "*.com"
      "*.class"
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"

      # Packages #
      ############
      # it's better to unpack these files and commit the raw source
      # git has its own built in compression methods
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.zip"

      # Logs and databases #
      ######################
      "*.log"
      "*.sql"
      "*.sqlite"

      # OS generated files #
      ######################
      ".DS_Store"
      ".DS_Store?"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"

      # IDE Config files #
      ####################
      ".idea/"

      # Per-Directory Environment Variables #
      #######################################
      ".envrc"

      # Whatever the fuck these are #
      ###############################
      ".tern-port"
    ];
  };
}

{ config, pkgs, lib, ... }:

{
  programs.nushell = {
    enable = true;
    
    # Shell options
    shellAliases = {
      # Add your custom aliases here
      la = "ls -la";
    };

    # Environment variables
    envFile.text = ''
      # Nushell environment configuration
      $env.EDITOR = "neovim"
    '';

    # Config file
    configFile.text = ''
      # Nushell configuration
      $env.config = {
        show_banner: false
        edit_mode: vi
        
        hooks: {
          pre_prompt: [
            {||
              if (which direnv | is-empty) {
                return
              }
              direnv export json | from json | default {} | load-env
            }
          ]
          
          env_change: {
            PWD: [
              {||
                if (which direnv | is-empty) {
                  return
                }
                direnv export json | from json | default {} | load-env
              }
            ]
          }
        }
      }
    '';
  };

  # Install direnv for the direnv hook to work
  home.packages = with pkgs; [
    direnv
  ];
}


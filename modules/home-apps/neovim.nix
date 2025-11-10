{ pkgs, ... }:

let
  neovimConfig = pkgs.fetchFromGitHub {
    owner = "shibahex";
    repo = "kickstart.nvim";
    sha256 = "1sbbdxrnsc67zqw6qkm2mahvlp6hvbld4rxbm2zqixf2diccb638";
    rev = "74292b85a2770545d1e5e17fcc2a903708af26d5";  
  };
in
{

  home.packages = [ 
  pkgs.neovim
  pkgs.gcc
  ];

  programs.neovim = {
    #enable = true;
    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/nvim" = {
    source = neovimConfig;
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}

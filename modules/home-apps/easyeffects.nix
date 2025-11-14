# The goal of this module is to add easyeffects presets from git into the .config file
{ pkgs, ... }:
let
  easyEffectsProfiles = pkgs.fetchFromGitHub {
    owner = "shibahex";
    repo = "easyeffects-presets";
    sha256 = "1q22z0q0pbp5j67aahxaf6byjfrzsv39szzbn7h3vmf77g10nb0v";
    rev = "54e3dde1eba2f8aaf97d85f80eb95bb72f2fcca8";
  };
in
{
  home.file.".config/easyeffects" = {
    source = easyEffectsProfiles;
    recursive = true;
  };
}

{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    librewolf
    _1password-gui
    pavucontrol
    easyeffects
    tree
    git

    vesktop
    nushell
    arduino
    spotify
    ungoogled-chromium
  ];
}

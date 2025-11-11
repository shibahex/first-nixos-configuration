{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    librewolf
    _1password-gui

    tree

    vesktop
    nushell
    arduino
    ungoogled-chromium
  ];
}

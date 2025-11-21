{ pkgs, ... }: {

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };
  services.flatpak.enable = true;

  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    librewolf
    _1password-gui

    tree

    obs-studio
    vesktop
    nushell
    arduino
    ungoogled-chromium

    flatpak
    # Screenshots
    flameshot
  ];
}

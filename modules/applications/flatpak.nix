{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    configPackages = [ pkgs.xdg-desktop-portal-gtk ];
  };
  services.flatpak.enable = true;
}

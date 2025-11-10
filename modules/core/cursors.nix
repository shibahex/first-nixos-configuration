{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libsForQt5.breeze-icons
    kdePackages.breeze-gtk

  ];

  # For cursor theme
  environment.variables = { XCURSOR_THEME = "breeze_cursors"; };
}

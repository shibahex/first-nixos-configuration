{ pkgs }: {
  # Git Configuration
  gitUsername = "shiba";
  gitEmail = "shiba@nixos-desktop";

  # For Nvidia Prime support
  # Run 'lspci | grep VGA' to find your actual GPU IDs
  intelID = "PCI:0:2:0"; # Update with your integrated GPU ID
  nvidiaID = "PCI:1:0:0"; # Update with your NVIDIA GPU ID

  # Startup Applications
  startupApps = [ ];

  defaultShell = "nushell";
  monitorRules = [{
    name = "Gaming monitors";
    outputs_connected = [ "HDMI-0" "DP-2" ];
    configure_single = "HDMI-0";
    primary = true;
    atomic = true;
    execute_after = [
      "${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --mode 2560x1440 --rate 143.91 --primary"
      "${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --mode 2560x1440 --rate 100 --right-of HDMI-0 --rotate right"
    ];
  }];

}

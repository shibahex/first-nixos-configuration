{ pkgs }: {
  #Mainly used for hardware.nix or etc, inital setup in flake.nix has your hostname
  hostName = "shiba";

  # Git Configuration
  gitUsername = "shiba";
  gitEmail = "shiba@nixos-desktop";
  timeZone = "America/New_York";

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
      "${pkgs.xorg.xrandr}/bin/xrandr --output DP-4 --mode 3840x2160 --rate 144 --primary"
      "${pkgs.xorg.xrandr}--output DP-2 --mode 2560x1440 --rate 100 --right-of DP-4 --rotate right"
    ];
  }];

  # Set network hostId if required (needed for zfs)
  hostId = "5ab03f50";

}

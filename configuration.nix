{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix"; 

  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";

  users.users.shiba = {
    isNormalUser = true;
    description = "brandon";
    extraGroups = [ "networkmanager" "wheel"];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
	  nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	neovim
	nushell
	direnv
	xclip
	wireguard-tools
	_1password
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
  #  # Certain features, including CLI integration and system authentication support,
  #  # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "shiba" ];
  };

  users.defaultUserShell = pkgs.nushell; 


  # Add your user to the vboxusers group
  #users.users.shiba.extraGroups = [ "vboxusers" ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}

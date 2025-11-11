{ ... }: {
  imports = [
    ./boot.nix
    ./home-manager.nix
    ./fonts.nix
    ./services.nix
    ./nix-system.nix
  ];
}

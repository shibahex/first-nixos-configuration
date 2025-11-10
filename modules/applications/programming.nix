{ pkgs, lib, ... }: {

  environment.systemPackages = with pkgs; [
    cargo # Rust
    lazygit # for committing on github
  ];
}

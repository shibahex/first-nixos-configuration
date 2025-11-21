{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    #Languages
    # cargo # Rust
    # rustup # rust (for rust-analyzer)
    # go # golang

    #git
    lazygit # for committing on github
    git
  ];
  # for Mason LSPs
  programs.nix-ld.enable = true;

}

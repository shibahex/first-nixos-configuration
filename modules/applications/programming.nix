{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    #Languages
    cargo # Rust
    go # golang

    #git
    lazygit # for committing on github
    git
  ];
}

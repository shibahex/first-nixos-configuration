# MY FIRST NIX SETUP!

> [!NOTE]
>Please copy you hardware-configuration from /etc/nixos/ into the root of this folder before trying to build.

the flake.nix automatically installs DWM & Neovim configurations from

- DWM: https://github.com/shibahex/DWMPC/tree/fresh-install
- NEOVIM: https://github.com/shibahex/kickstart.nvim

To add your own please change the URLs in the flake.nix file at the top.

> [!NOTE]
>The username set for this configuration is gecko.

# Building
to build go into the root directory of this repo with all the .nix files, then execute:
```
sudo nixos-rebuild switch --flake .#nixos-btw
```
It should build, unless hardware-configuration or the users are messed up.


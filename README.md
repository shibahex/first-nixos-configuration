After installing please clone the /etc/nixos/hardware-configuration to the repos root file and then "git add ./hardware-configuration" to make flakes track it.

Then you can build it by doing:
sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw

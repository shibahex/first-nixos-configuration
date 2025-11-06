{pkgs, ... }:
{
 imports = [
 ./hardware.nix
 ./host-packages.nix
 ];

 services.displayManager.ly.enable = true;

 services.xserver = {
	 enable = true;
	 autorun = false;
	 autoRepeatDelay = 200;
	 autoRepeatInterval = 35;
 };

}

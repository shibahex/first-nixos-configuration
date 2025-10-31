{config, pkgs,  ...}:
{
	imports = [
		./modules/neovim.nix
		./modules/nu.nix
	];
	home.username = "gecko";
	home.homeDirectory = "/home/gecko";

	home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink 
		"${config.home.homeDirectory}/nixos-dotfiles/config/nvim";

	programs.git = {
		enable = true;
		userEmail = "badamsva@gmail.com";
		userName = "Brandon";
	};


	home.stateVersion = "25.05";
	home.packages = with pkgs; [
			xwallpaper
			firefox
			kdePackages.dolphin
			nushell
			btop
			fastfetch
		easyeffects
		pavucontrol
			#_1password-gui
	];




}

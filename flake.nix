{
	description = "First NixOS";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	outputs = {self, nixpkgs, home-manager, ...}:let 
	 system = "x86_64-linux";
	 pkgs = import nixpkgs { inherit system; };
	 
	in {
	
		 # Suckless applications with local configs
		 dwm = packages.${system}.default = pkgs.dwm.overrideAttrs (oldAttrs: {
			postPatch = ''
				cp ${./config/dwm/config.h} config.h
			'';
		 });
		 
		 dmenu = pkgs.dmenu.overrideAttrs (oldAttrs: {
			postPatch = ''
				cp ${./config/dmenu/config.h} config.h
			'';
		 });
		 
		 st = pkgs.st.overrideAttrs (oldAttrs: {
			postPatch = ''
				cp ${./config/st/config.h} config.h
			'';
		 });
		 
		 slstatus = pkgs.slstatus.overrideAttrs (oldAttrs: {
			postPatch = ''
				cp ${./config/slstatus/config.h} config.h
			'';
		 });
		# Export the suckless packages
		#packages.${system} = {
		#	inherit dwm dmenu st slstatus;
		#};
		
		devShells.${system} = let
			# Base neovim packages
			neovimPackages = with pkgs; [
				# Tools required for Telescope
				ripgrep
				fd
				fzf

				# Language Servers
				lua-language-server
				nil # nix language server
				nixpkgs-fmt # nix formatter

				# Needed for lazy.nvim and treesitter
				nodejs
				gcc
			];
		in {
			# Suckless development shell
			suck = pkgs.mkShell {
				packages = with pkgs; [
					pkg-config
					xorg.libX11
					xorg.libXft
					xorg.libXinerama
					fontconfig
					freetype
					harfbuzz
					gcc
					gnumake
				];
			};
			
			# Neovim development shell
			neovim = pkgs.mkShell {
				packages = neovimPackages;
				
				shellHook = ''
					echo "Neovim development environment loaded"
					echo "Available tools: ripgrep, fd, fzf, lua-language-server, nil, nixpkgs-fmt, nodejs, gcc"
				'';
			};
			
			# Rust development shell
			rust = pkgs.mkShell {
				packages = with pkgs; [
					rustc
					cargo
	rustfmt
					clippy
					rust-analyzer
				];
				
				shellHook = ''
					echo "Rust development environment loaded"
				'';
			};
			
			# Combined Neovim + Rust shell
			rust-dev = pkgs.mkShell {
				packages = neovimPackages ++ (with pkgs; [
					rustc
					cargo
					rustfmt
					clippy
					rust-analyzer
				]);
				
				shellHook = ''
					echo "Rust + Neovim development environment loaded"
				'';
			};
			
			# Combined Neovim + C/C++ shell
			cpp-dev = pkgs.mkShell {
				packages = neovimPackages ++ (with pkgs; [
					clang
					clang-tools
					cmake
					gnumake
				]);
				
				shellHook = ''
					echo "C/C++ + Neovim development environment loaded"
				'';
			};
		};
		
		nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
					home-manager.nixosModules.home-manager
					{
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							users.gecko = import ./home.nix;
							backupFileExtension = "backup";
							#extraSpecialArgs = {
							#	inherit suckless dwm dmenu st slstatus;
							#};
						};
					}
			];
	
	#specialArgs = {
	#			inherit suckless dwm dmenu st slstatus;
	#		};

		};
	};
}

{
	description = "First NixOS";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		suckless = {
			url = "github:shibahex/DWMPC/fresh-install";
			flake = false;
		};
	};
	outputs = {self, nixpkgs, home-manager, suckless, ...}:let 
	 system = "x86_64-linux";
	 pkgs = import nixpkgs { inherit system; };
	in {
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
							extraSpecialArgs = {inherit suckless;};
						};
					}
			];
			specialArgs = {inherit suckless;};

		};
	};
}

{ pkgs, ... }:
{
	home.packages = with pkgs; [
		(pkgs.st.overrideAttrs (_: {
					src = ../config/suckless/st;
					patches = [ ];
					}))

	(pkgs.dmenu.overrideAttrs (_: {
				   src = ../config/suckless/dmenu;
				   patches = [ ];
				   }))
	slock
		surf
	];
}

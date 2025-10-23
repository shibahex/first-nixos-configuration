{ pkgs, suckless, ... }:
{
	home.packages = with pkgs; [
		(pkgs.st.overrideAttrs (_: {
					src = "${suckless}/st";
					patches = [ ];
					}))
	
	(pkgs.dmenu.overrideAttrs (_: {
				   src = "${suckless}/dmenu";
				   patches = [ ];
				   }))
	slock
		surf
	];
}

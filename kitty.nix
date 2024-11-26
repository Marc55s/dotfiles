{pkgs, ...}:
{
	fonts.packages = with pkgs; [
    	(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    	#nerdfonts
  ];

	programs.kitty = {
		settings = {
	font_family      JetBrainsMono Nerd Font
	bold_font        auto
	italic_font      auto
	bold_italic_font auto

	font_size 14

	background_opacity 0.9
		}

	}

}

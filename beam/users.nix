# Configuration file purely for users
{ config, pkgs, ... }:
{
  # Import home manager
  imports = [ <home-manager/nixos> ];
  home-manager.useGlobalPkgs = true;
  
  # Users
  users.users.foxtrot = {
    isNormalUser   = true;
    description    = "William";
    extraGroups    = [ "networkmanager" "wheel" ];
    hashedPassword = "";
  };

  # Home Manager - dotfile management
  home-manager.users.foxtrot = { pkgs, ... }: {
    # Nix language version
    home.stateVersion = "22.05";
    # Bash configuration
  	programs.bash.enable = true;
  	# Fish configuration
  	programs.fish = {
  	  enable     = true;
  	  shellAbbrs = {
  	    nano   = "micro $argv";
  	    flatin = "sudo flatpak install $argv";
  	    flatre = "sudo flatpak uninstall  $argv";
  	    wget   = "wget --hsts-file=\"$XDG_DATA_HOME\"/wget-hsts $argv";
  	  };
  	};
  	# xdg spec configuration
  	xdg = {
  	  enable         = true;
  	  desktopEntries = {
  	  	steamGamepadUi = {
  	  	  terminal   = false;
  	  	  icon       = "steam_deck";
  	  	  exec       = "steam -gamepadui";
  	  	  name       = "Steam (Gamepad UI)";
  	  	  categories = [ "Network" "FileTransfer" "Game" ];
  	  	};
  	  };
  	};
  	# Enable kde-connect
  	services.kdeconnect.enable = true;
  	# Git configuration
  	programs.git = {
  	  enable               = true;
  	  diff-so-fancy.enable = true;
  	  userName             = "William";
  	  userEmail            = "williamhai@hotmail.com";
  	};
  	# Allow fonts installed by home-manager to be used elsewhere
  	fonts.fontconfig.enable = true;
  	# Cursor configuration
  	home.pointerCursor = {
  	  size       = 24;
  	  gtk.enable = true;
  	  x11.enable = true;
  	  name       = "breeze_cursors";
  	  package    = pkgs.breeze-icons;
  	};
  	# GTK configuration
  	gtk = {
  	  enable         = true;
  	  font           = { name = "Noto Sans"; size = 10; };
  	  theme          = { package = pkgs.breeze-gtk; name = "Breeze"; };
  	  iconTheme      = { package = pkgs.breeze-icons; name = "Breeze"; };
  	};
  	# Mangohud configuration
  	programs.mangohud = {
  	  enable            = true;
  	  enableSessionWide = true;
  	  settings          = {
  	  	frame_timing       = 1;
  	  	round_corners      = 5;
  	  	font_size          = 24;
  	  	background_alpha   = 0.4;
  	  	toggle_fps_limit   = "F1";
  	  	upload_log         = "F5";
  	  	core_load_change   = true;
  	  	cpu_load_change    = true;
  	  	cpu_stats          = true;
  	  	cpu_temp           = true;
  	  	fps                = true;
  	  	gamepad_battery    = true;
  	  	gpu_load_change    = true;
  	  	gpu_stats          = true;
  	  	gpu_temp           = true;
  	  	media_player       = true;
  	  	time               = true;
  	  	legacy_layout      = false;
  	  	cpu_text           = "CPU";
  	  	gpu_text           = "GPU";
  	  	cpu_load_value     = "50,90";
  	  	gpu_load_value     = "50,90";
  	  	media_player_color = "ffffff";
  	  	background_color   = "020202";
  	  	cpu_color          = "ffffff";
  	  	engine_color       = "ffffff";
  	  	frametime_color    = "ffffff";
  	  	gpu_color          = "ffffff";
  	  	io_color           = "ffffff";
  	  	ram_color          = "ffffff";
  	  	text_color         = "ffffff";
  	  	vram_color         = "ffffff";
  	  	wine_color         = "ffffff";
  	  	media_player_name  = "spotify";
  	  	position           = "top-right";
  	  	toggle_logging     = "Shift_L+F2";
  	  	toggle_hud         = "Shift_R+F12";
  	  	output_folder      = "~/Games/MH_Output";
  	  	cpu_load_color     = "FFFFFF,FFAA7F,CC0000";
  	  	gpu_load_color     = "FFFFFF,FFAA7F,CC0000";
  	  };
  	};
  };

  # Environment variables
  environment.sessionVariables = rec {
    MANGOHUD           = "1";
    KWIN_DRM_NO_AMS    = "1"; # RDNA2 colour/gamma modesetting bug workaround for kwin wayland
    MOZ_ENABLE_WAYLAND = "1"; # Enables wayland support for firefox and thunderbird
    KDEHOME            = "$XDG_CONFIG_HOME/kde4"; # Stops kde from placing a .kde4 folder in you home dir
  };
}

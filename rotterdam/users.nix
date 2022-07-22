# Configuration file purely for users
{ config, pkgs, ... }:
{
  # Import home manager
  imports = [ <home-manager/nixos> ];

  # System wide environment variables
  environment.sessionVariables = rec {
    MANGOHUD = "1";
    KWIN_DRM_NO_AMS = "1";             # RDNA2 colour/gamma modesetting bug workaround for kwin wayland.
    MOZ_ENABLE_WAYLAND = "1";          # Enables wayland support for firefox and thunderbird.
    KDEHOME = "$XDG_CONFIG_HOME/kde4"; # Stops kde from placing a .kde4 folder in you home dir.
  };
  
  # Users
  users.users.foxtrot = {
    isNormalUser = true;
    description = "William";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "";
  };

  # Home Manager - dotfile management
  home-manager = {
  	useGlobalPkgs = true;
  	users.foxtrot = { pkgs, ... }: {
  	  # General home confiuration
  	  home = {
  	  	stateVersion = "22.05";
  	  	pointerCursor = { # Good god, cursor theming is a bitch.
  	  	  size = 24;
  	  	  gtk.enable = true;
  	  	  x11.enable = true;
  	  	  name = "breeze_cursors";
  	  	  package = pkgs.breeze-icons;
  	  	};
  	  	# Configuring arbitrary files
  	  	file = {
  	  	  ".config/MangoHud/MangoHud.conf".text = ''
  	  	  	toggle_fps_limit=F1
  	  	  	legacy_layout=false
  	  	  	gpu_stats
  	  	  	gpu_temp
  	  	  	gpu_load_change
  	  	  	gpu_load_value=50,90
  	  	  	gpu_load_color=FFFFFF,FFAA7F,CC0000
  	  	  	gpu_text=GPU
  	  	  	cpu_stats
  	  	  	cpu_temp
  	  	  	cpu_load_change
  	  	  	core_load_change
  	  	  	cpu_load_value=50,90
  	  	  	cpu_load_color=FFFFFF,FFAA7F,CC0000
  	  	  	cpu_color=2e97cb
  	  	  	cpu_text=CPU
  	  	  	io_color=a491d3
  	  	  	vram_color=ad64c1
  	  	  	ram_color=c26693
  	  	  	fps
  	  	  	engine_color=eb5b5b
  	  	  	gpu_color=2e9762
  	  	  	wine_color=eb5b5b
  	  	  	frame_timing=1
  	  	  	frametime_color=00ff00
  	  	  	gamepad_battery
  	  	  	media_player
  	  	  	media_player_color=ffffff
  	  	  	time
  	  	  	background_alpha=0.4
  	  	  	font_size=24
  	  	  	background_color=020202
  	  	  	position=top-right
  	  	  	text_color=ffffff
  	  	  	round_corners=5
  	  	  	toggle_hud=Shift_R+F12
  	  	  	toggle_logging=Shift_L+F2
  	  	  	upload_log=F5
  	  	  	output_folder=/home/foxtrot
  	  	  	media_player_name=spotify
  	  	  	gpu_color=ffffff
  	  	  	cpu_color=ffffff
  	  	  	vram_color=ffffff
  	  	  	ram_color=ffffff
  	  	  	io_color=ffffff
  	  	  	engine_color=ffffff
  	  	  	frametime_color=ffffff
  	  	  '';
  	  	};
  	  };
  	  # Allow fonts installed by home-manager to be used elsewhere
  	  fonts.fontconfig.enable = true;
  	  # GTK configuration.
  	  gtk = {
  	    enable = true;
  	    font = { name = "Noto Sans"; size = 10; };
  	    theme = { package = pkgs.breeze-gtk; name = "Breeze"; };
  	    iconTheme = { package = pkgs.breeze-icons; name = "Breeze"; };
  	  };
  	  # User services configuration.
  	  services.kdeconnect.enable = true;
  	  # xdg spec.
  	  xdg = {
  	    enable = true;
  	    desktopEntries = {
  	      steamGamepadUi = { # Menu entry for steam gamepadui.
  	   	    terminal = false;
  	        icon = "steam_deck";
  	        exec = "steam -gamepadui";
  	        name = "Steam (Gamepad UI)";
  	        categories = [ "Game" ];
  	      };
  	    };
  	  };
  	  # Systemd services and timers. Doesn't work will figure this out later.
  	  # systemd.user = {
  	  	# services = {
  	  	  # plasmaColourScheme = { # Colour scheme switching service.
  	  	  	# Unit.Description = "Automatically change colour schemes.";
            # Install.WantedBy = [ "graphical-session.target" ];
  	  	  	# Service.ExecStart = "bash -c 'H=$(date +%H); if [[ $H > \"21\" ]] || [[ $H < \"08\" ]]; then plasma-apply-colorscheme BreezeDarkNeutral; else plasma-apply-colorscheme BreezeLight; fi'";
  	  	  # };
  	  	# };
  	  	# timers = {
  	  	  # plasmaColourScheme = { # Timer for the colour scheme switching service
            # Unit.Description = "Runs at 2100 and 0800.";
            # Timer = {
              # Unit = "plasmaColourScheme.service";
              # OnCalendar = "*-*-* 08,21:00:00";
            # };
            # Install.WantedBy = [ "timers.target" ];
  	  	  # };
  	  	# };
  	  # };
  	  # Configuration of programs.
  	  programs = {
  	  	# Allow bash to be managed by home-manager.
  	  	bash.enable = true;
  	  	# Fish configuration.
  	  	fish = {
  	  	  enable = true;
  	  	  shellAliases = {
  	  	  	g = "git";
  	  	  	nano = "micro";
  	  	  };
  	  	  functions = {
  	  	  	fish_greeting = ''
              #set -x PF_INFO ascii os kernel uptime pkgs memory shell palette
  	  	  	  #eval /var/run/current-system/sw/bin/pfetch
  	  	  	'';
  	  	  };
  	  	  shellInit = ''
            set -g theme_date_format "+%H:%M"
            set -g theme_date_timezone Europe/Berlin
            set -g theme_avoid_ambiguous_glyphs yes
            set -g theme_color_scheme dark
            set -g theme_nerd_fonts yes
            set -g theme_display_git_default_branch yes
            set --global --export FONTCONFIG_FILE ${pkgs.fontconfig.out}/etc/fonts/fonts.conf
  	  	  '';
  	  	  plugins  = [
  	  	  	{
  	  	  	  name = "bobthefish";
  	  	  	  src = pkgs.fetchFromGitHub {
  	  	  	  	owner = "oh-my-fish";
  	  	  	  	repo = "theme-bobthefish";
  	  	  	  	rev = "14a6f2b317661e959e13a23870cf89274f867f12";
  	  	  	  	sha256 = "kl6XR6IFk5J5Bw7/0/wER4+TnQfC18GKxYbt9C+YHJ0=";
  	  	  	  };
  	  	  	}
  	  	  	{
  	  	  	  name = "bang-bang";
  	  	  	  src = pkgs.fetchFromGitHub {
  	  	  	  	owner = "oh-my-fish";
  	  	  	  	repo = "plugin-bang-bang";
  	  	  	  	rev = "f969c618301163273d0a03d002614d9a81952c1e";
  	  	  	  	sha256 = "A8ydBX4LORk+nutjHurqNNWFmW6LIiBPQcxS3x4nbeQ=";
  	  	  	  };
  	  	  	}
  	  	  ];
  	  	};
  	  	# Kitty terminal emulator configuration.
  	  	kitty = {
  	  	  enable = true;
  	  	  theme = "Afterglow";
  	  	  font = {
  	  	  	name = "Hack Nerd Font";
  	  	  	size = 10;
  	  	  };
  	  	  settings = {
  	  	  	tab_bar_edge = "top";
  	  	  	tab_switch_strategy = "left";
  	  	  	tab_bar_style = "powerline";
  	  	  	tab_powerline_style = "slanted";
  	  	  	tab_bar_background = "#444";
  	  	  	tab_bar_margin_color = "#111";
  	  	  	# shell = "fish";
  	  	  	remember_window_size = "no";
  	  	  	initial_window_width = "120c";
  	  	  	initial_window_height = "42c";
  	  	  	confirm_os_window_close = "-1";
  	  	  };
  	  	};
  	  	# Git configuration.
  	  	git = {
  	  	  enable = true;
  	  	  diff-so-fancy.enable = true;
  	  	  userName = "William";
  	  	  userEmail = "williamhai@hotmail.com";
  	  	};
  	  	# Mangohud configuration.
  	  	mangohud = {
  	  	  enable            = true;
  	  	  enableSessionWide = true;
  	  	};
  	  };
  	};
  };
}

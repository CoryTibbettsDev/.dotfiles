# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# https://discourse.nixos.org/t/nix-env-list-generations-is-empty/33747/5
# sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
# https://discourse.nixos.org/t/how-to-remove-old-generations-from-grub/30225
# sudo nixos-rebuild switch --install-bootloader

# sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system

{ config, lib, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
		./wordpress.nix
		./firefox.nix
	];

	# https://nixos.wiki/wiki/Nix_Cookbook#Managing_storage
	# https://wiki.nixos.org/wiki/Storage_optimization
	# Garbage collect the nix store weekly
	nix.gc.automatic = true;
	nix.gc.dates = "weekly";
	# Optimise the nix store when the store changes
	nix.settings.auto-optimise-store = true;


	# Use the GRUB 2 boot loader.
	boot.loader.grub.enable = true;
	# boot.loader.grub.efiSupport = true;
	# boot.loader.grub.efiInstallAsRemovable = true;
	# boot.loader.efi.efiSysMountPoint = "/boot/efi";
	# Define on which hard drive you want to install Grub.
	boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

	networking.hostName = "nixos"; # Define your hostname.
	# Pick only one of the below networking options.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
	# networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

	# Set your time zone.
	time.timeZone = "America/New_York";

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Select internationalisation properties.
	# i18n.defaultLocale = "en_US.UTF-8";
	# console = {
	#   font = "Lat2-Terminus16";
	#   keyMap = "us";
	#   useXkbConfig = true; # use xkb.options in tty.
	# };

	# Enable the X11 windowing system.
	services.xserver.enable = true;

	services.xserver.displayManager.lightdm.enable = true;
	services.xserver.desktopManager.xfce.enable = true;

	# Configure keymap in X11
	# services.xserver.xkb.layout = "us";
	# services.xserver.xkb.options = "eurosign:e,caps:escape";
	
	# Enable CUPS to print documents.
	# services.printing.enable = true;
	
	# Enable sound.
	# sound.enable = true;
	# hardware.pulseaudio.enable = true;
	
	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;
	
	# Don't let users be managed imperatively
	users.mutableUsers = false;
	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.cjt = {
		password = "test";
		isNormalUser = true;
		extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
			packages = with pkgs; [
				tree
			];
	};

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	# Do not forget to add an editor to edit configuration.nix!
	# The Nano editor is also installed by default.
	environment.systemPackages = with pkgs; [
		firefox-esr
		tmux
		curl
	];

	# neovim cannot be added to "environment.systemPackages" otherwise
	# the configuration here does not get applied
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		configure = {
			customRC = ''
				set number relativenumber
				set nowrap
				set list
				set smartindent
				set tabstop=2 shiftwidth=2 noexpandtab
				set noswapfile nobackup
				colorscheme default
				set background=dark
				let mapleader = ' '
				nnoremap <leader>s :w<CR>
				noremap <Tab> :bnext<CR>
				noremap <S-Tab> :bprevious<CR>
				noremap <leader>d :bdelete<CR>
			'';
		};
	};

	environment.etc = {
		"xdg/gtk-3.0".source = ./gtk-3.0;
	};

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };
	
	# List services that you want to enable:
	
	# Enable the OpenSSH daemon.
	services.openssh.enable = true;
	
	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;
	
	# Copy the NixOS configuration file and link it from the resulting system
	# (/run/current-system/configuration.nix). This is useful in case you
	# accidentally delete configuration.nix.
	system.copySystemConfiguration = true;
	
	# This option defines the first version of NixOS you have installed on this particular machine,
	# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
	#
	# Most users should NEVER change this value after the initial install, for any reason,
	# even if you've upgraded your system to a new NixOS release.
	#
	# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
	# so changing it will NOT upgrade your system.
	#
	# This value being lower than the current NixOS release does NOT mean your system is
	# out of date, out of support, or vulnerable.
	#
	# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
	# and migrated your data accordingly.
	#
	# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
	system.stateVersion = "23.11"; # Did you read the comment?
}


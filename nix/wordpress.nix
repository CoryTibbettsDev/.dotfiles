{ config, lib, pkgs, ... }:

# https://nixos.wiki/wiki/Wordpress

let
	#domain = "example.com";
	domain = "localhost";

	# Use unstable nix channel only for wordpress
	# so we get the (almost) current wordpress release
	# https://discourse.nixos.org/t/installing-only-a-single-package-from-unstable/5598/4
	# https://stackoverflow.com/questions/48831392/how-to-add-nixos-unstable-channel-declaratively-in-configuration-nix
	unstable = import
		(builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz)
		# reuse the current configuration
		{ config = config.nixpkgs.config; };

	# Auxiliary functions
	fetchPackage = { name, version, hash, isTheme }:
	pkgs.stdenv.mkDerivation rec {
		inherit name version hash;
		src = let type = if isTheme then "theme" else "plugin";
		in pkgs.fetchzip {
			inherit name version hash;
			url = "https://downloads.wordpress.org/${type}/${name}.${version}.zip";
		};
		installPhase = "mkdir -p $out; cp -R * $out/";
	};

	fetchPlugin = { name, version, hash }:
	(fetchPackage {
		name = name;
		version = version;
		hash = hash;
		isTheme = false;
	});

	fetchTheme = { name, version, hash }:
	(fetchPackage {
		name = name;
		version = version;
		hash = hash;
		isTheme = true;
	});

	# Plugins
	#google-site-kit = (fetchPlugin {
	#	name = "google-site-kit";
	#	version = "1.103.0";
	#	hash = "sha256-8QZ4XTCKVdIVtbTV7Ka4HVMiUGkBYkxsw8ctWDV8gxs=";
	#});
	yoast-seo = (fetchPlugin {
		name = "wordpress-seo";
		version = "22.7";
		hash = "sha256-TehcuBqGb4cUsxkp40Xe3P7903cGRRSLDmATk21ZwSg=";
	});
	woocommerce = (fetchPlugin {
		name = "woocommerce";
		version = "8.9.1";
		hash = "sha256-dIFbzL+eDx/jR80/EeX1TTpx0hdhboEPyCrsxt04GhA=";
	});

	# Themes
	astra = (fetchTheme {
		name = "astra";
		version = "4.1.5";
		hash = "sha256-X3Jv2kn0FCCOPgrID0ZU8CuSjm/Ia/d+om/ShP5IBgA=";
	});

in {
	services = {
		nginx.virtualHosts.${domain} = {
			#enableACME = true;
			#forceSSL = true;
		};

		wordpress = {
			webserver = "nginx";
			sites."${domain}" = {
				package = unstable.wordpress;
				#plugins = { inherit google-site-kit; };
				plugins = { inherit yoast-seo woocommerce; };
				themes = { inherit astra; };
				settings = {
					WP_DEFAULT_THEME = "astra";
					#FORCE_SSL_ADMIN = true;
				};
				# https://stackoverflow.com/questions/19845192/create-new-user-automatically-via-functions-php-in-wordpress
				extraConfig = ''
					echo( "hello");
					//if ( !defined('ABSPATH') )
					//	define('ABSPATH', dirname(__FILE__) . '/');
					//require_once(ABSPATH . 'wp-settings.php');
					//require_once ABSPATH . 'wp-admin/includes/plugin.php';
					//activate_plugin( 'akismet/akismet.php' );
				'';
			};
		};
	};

	# As this is a root on tmpfs system, we use the impermanence
	# NixOS module to persist WordPress state between reboots.
	# You can omit the next two lines if using a regular configuration.
	#environment.persistence."/persist".directories =
	#	[ "/var/lib/mysql" "/var/lib/wordpress" ];
}


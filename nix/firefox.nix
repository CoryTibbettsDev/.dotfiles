{ config, pkgs, ... }:

let
	lock-false = {
		Value = false;
		Status = "locked";
	};
	lock-true = {
		Value = true;
		Status = "locked";
	};
in {
	programs.firefox = {
		package = pkgs.firefox-esr;
		enable = true;
		languagePacks = [ "en-US" ];

		/* POLICIES */
		# Check about:policies#documentation for options.
		policies = {
			SearchEngines = {
				Default = "DuckDuckGo";
				PreventInstalls = true;
				Add = [
				{
					Name = "Nix Packages";
					URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
					Method = "GET";
					IconURL = "https://search.nixos.org/images/nix-logo.png";
					Alias = "@n";
					Description = "Search Nix Packages";
					#PostData = "?query={searchTerms}";
					#SuggestURLTemplate = "https://search.nixos.org/suggestions/q={searchTerms}";
				}
				{
					Name = "Nixos Options";
					URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
					Method = "GET";
					IconURL = "https://search.nixos.org/images/nix-logo.png";
					Alias = "@o";
					Description = "Search NixOS Options";
				}
				];
				# The names appear to be case sensitive
				Remove = [ "Google" "Amazon.com" "Bing" "eBay"];
			};
			FirefoxHome = {
				Search = false;
				TopSites = false;
				SponsoredTopSites = false;
				Highlights = false;
				Pocket = false;
				SponsoredPocket = false;
				Snippets = false;
				Locked = true;
			};
			FirefoxSuggest = {
				WebSuggestions = false;
				SponsoredSuggestions = false;
				ImproveSuggestions = false;
				Locked = true;
			};
			OfferToSaveLogins = false;
			SanitizeOnShutDown = true;
			Cookies = {
				Behavior = "reject-foreign";
				BehaviorPrivateBrowsing = "reject-foreign";
			};
			DisableTelemetry = true;
			EnableTrackingProtection = {
				Value = true;
				Locked = true;
				Cryptomining = true;
				Fingerprinting = true;
			};
			NewTabPage = false;
			DisablePocket = true;
			DisableProfileImport = true;
			DisableSetDesktopBackground = true;
			DisableFirefoxAccounts = true;
			DisableAccounts = true;
			DisableFirefoxScreenshots = true;
			DisableFirefoxStudies = true;
			PromptForDownloadLocation = true;
			DownloadDirectory = "\${home}/Downloads";
			OverrideFirstRunPage = "";
			OverridePostUpdatePage = "";
			DontCheckDefaultBrowser = true;
			DisplayMenuBar = "default-off"; # "always", "never" "default-on" "default-off"
			SearchBar = "unified"; # "unified" "separate"
			DisplayBookmarksToolbar = "newtab"; # "never" "always" "newtab"
			NoDefaultBookmarks = true;
			ManagedBookmarks = [
				{ url = "youtube.com"; name = "YouTube"; }
				{ url = "old.reddit.com/r/linux"; name = "Linux Reddit"; }
			];
			PictureInPicture = {
				Enabled = false;
			};

			/* EXTENSIONS */
			ExtensionUpdate = true;
			# Check about:support for extension/add-on ID strings.
			# Valid strings for installation_mode are "allowed", "blocked",
			# "force_installed" and "normal_installed".
			ExtensionSettings = {
				"*".installation_mode = "blocked"; # blocks all addons except the ones specified below
				"uBlock0@raymondhill.net" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
					installation_mode = "force_installed";
				};
				"addon@darkreader.org" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
					installation_mode = "force_installed";
				};
			};
			"3rdparty" = {
				Extensions = {
					"uBlock0@raymondhill.net" = {
						userSettings = [ [ "advancedUserEnabled" "true" ] ];
					};
				};
			};

			/* PREFERENCES */
			# Check about:config for options.
			Preferences = {
				"browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
				"extensions.pocket.enabled" = lock-false;
				"extensions.screenshots.disabled" = lock-true;
				"browser.topsites.contile.enabled" = lock-false;
				"browser.formfill.enable" = lock-false;
				"browser.search.suggest.enabled" = lock-false;
				"browser.search.suggest.enabled.private" = lock-false;
				"browser.urlbar.suggest.searches" = lock-false;
				"browser.urlbar.showSearchSuggestionsFirst" = lock-false;
				"browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
				"browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
				"browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
				"browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
				"browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
				"browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
				"browser.newtabpage.activity-stream.showSponsored" = lock-false;
				"browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
				"browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
				# Geolocation
				# Use mozilla location service instead of google if permission is granted to use geolocation
				"geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
				# disable using OS's geolocation service
				"geo.provider.use_gpsd" = lock-false;
				# disable region updates
				"browser.region.network.url" = "";
				"browser.region.update.enable" = lock-false;
				# disable auto update
				"app.update.auto" = lock-false;
				# disable auto update backrgound service
				"app.update.background.scheduling.enabled" = lock-false;
				# disable about:addons Recommendations (uses Google Analytics)
				"extensions.getAddons.showPane" = lock-false;
				"extensions.htmlaboutaddons.recommendations.enabled" = lock-false;
				# Disable more telemetry stuff
				"toolkit.telemetry.unified" = lock-false;
				"toolkit.telemetry.enabled" = lock-false;
				"toolkit.telemetry.server" = "data:,";
				"toolkit.telemetry.archive.enabled" = lock-false;
				"toolkit.telemetry.newProfilePing.enabled" = lock-false;
				"toolkit.telemetry.shutdownPingSender.enabled" = lock-false;
				"toolkit.telemetry.updatePing.enabled" = lock-false;
				"toolkit.telemetry.bhrPing.enabled" = lock-false;
				"toolkit.telemetry.firstShutdownPing.enabled" = lock-false;
				"toolkit.telemetry.coverage.opt-out" = lock-true;
				"toolkit.coverage.opt-out" = lock-true;
				"toolkit.coverage.endpoint.base" = "";
				"datareporting.healthreport.uploadEnabled" = lock-false;
				"datareporting.policy.dataSubmissionEnabled" = lock-false;
				"app.shield.optoutstudies.enabled" = lock-false;
				"browser.discovery.enabled" = lock-false;
				"breakpad.reportURL" = "";
				"browser.tabs.crashReporting.sendReport" = lock-false;
				"browser.crashReports.unsubmittedCheck.autoSubmit2" = lock-false;
				"network.captive-portal-service.enabled" = lock-false;
				"network.connectivity-service.enabled" = lock-false;
				"app.normandy.enabled" = lock-false;
				"app.normandy.api_url" = "";
				"browser.ping-centre.telemetry" = lock-false;
				"extensions.formautofill.addresses.enabled" = lock-false;
				"extensions.formautofill.creditCards.available" = lock-false;
				"extensions.formautofill.creditCards.enabled" = lock-false;
				"extensions.formautofill.heuristics.enabled" = lock-false;
				"extensions.formautofill.available" = "off";
				"extensions.webcompat-reporter.enabled" = lock-false;
				"network.prefetch-next" = lock-false;
				"network.dns.disablePrefetch" = lock-true;
				"network.predictor.enabled" = lock-false;
				"network.http.speculative-parallel-limit" = 0;
				"network.dns.disableIPv6" = lock-true;
				"browser.fixup.alternate.enabled" = lock-false;
				"browser.urlbar.trimURLs" = lock-false;
				"layout.css.visited_links_enabled" = lock-false;
				"browser.urlbar.speculativeConnect.enabled" = lock-false;
				"browser.urlbar.dnsResolvingSingleWordsAfterSearch" = 0;
				"browser.urlbar.suggest.history" = lock-false;
				"browser.urlbar.suggest.bookmark" = lock-false;
				"browser.urlbar.suggest.openpage" = lock-false;
				"browser.urlbar.suggest.topsites" = lock-false;
				"browser.taskbar.lists.enabled" = lock-false;
				"browser.taskbar.lists.frequent.enabled" = lock-false;
				"browser.taskbar.lists.recent.enabled" = lock-false;
				"browser.taskbar.lists.tasks.enabled" = lock-false;
				"signon.rememberSignons" = lock-false;
				# Store nowhere
				"browser.sessionstore.privacy_level" = 2;
				"dom.security.https_only_mode" = lock-true;
				"dom.security.https_only_mode_send_http_background_request" = lock-false;
				# Clear data on browser close
				"privacy.clearOnShutdown.cache" = lock-true;
				"privacy.clearOnShutdown.cookies" = lock-true;
				"privacy.clearOnShutdown.downloads" = lock-true;
				"privacy.clearOnShutdown.formdata" = lock-true;
				"privacy.clearOnShutdown.history" = lock-true;
				"privacy.clearOnShutdown.offlineApps" = lock-true;
				"privacy.clearOnShutdown.sessions" = lock-true;
				"privacy.clearOnShutdown.siteSettings" = lock-true;
				"privacy.resistFingerprinting" = lock-true;
				"privacy.resistFingerprinting.block_mozAddonManager" = lock-true;
				"privacy.resistFingerprinting.letterboxing" = lock-true;
				"browser.startup.blankWindow" = lock-false;
				"widget.non-native-theme.enabled" = lock-true;
				# Force links targeting new windows to open in new tabs instead
				"browser.link.open_newwindow" = 3;
				# Set all open window methods to abide by "browser.link.open_newwindow"
				"browser.link.open_newwindow.restriction" = 0;
				"webgl.disabled" = lock-true;
				"javascript.options.wasm" = lock-false;
				"security.csp.enable" = lock-true;
				# Disable website control over browser right-click context menu
				"dom.event.contextmenu.enabled" = lock-false;
				# Disable clipboard API
				"dom.event.clipboardevents.enabled" = lock-false;
			};
		};
	};
}

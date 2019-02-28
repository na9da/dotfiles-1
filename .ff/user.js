// lol no

user_pref("browser.newtabpage.activity-stream.feeds.newtabinit", false);
user_pref("dom.webnotifications.enabled", false);
user_pref("media.autoplay.enabled", false);
user_pref("dom.min_background_timeout_value", 99999);
user_pref("toolkit.cosmeticAnimations.enabled", false);

// security

user_pref("media.peerconnection.enabled", false);
user_pref("media.peerconnection.use_document_iceservers", false);
user_pref("network.proxy.socks_remote_dns", true);
user_pref("geo.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.enabled", false);
user_pref("browser.safebrowsing.maleware.enabled", false);
user_pref("xpinstall.signatures.required", false);

user_pref("security.insecure_password.ui.enabled", true);
user_pref("accessibility.blockautorefresh", true);
user_pref("plugins.hide_infobar_for_blocked_plugin", true);
user_pref("plugins.notifyMissingFlash", false);
user_pref("security.ask_for_password", 1);

// perf

user_pref("network.http.pipelining", true);
user_pref("network.http.pipelining.max-optimistic-requests", 3);
user_pref("network.http.pipelining.maxrequests", 12);
user_pref("network.http.pipelining.maxsize", 300000);
user_pref("network.http.pipelining.read-timeout", 60000);
user_pref("network.http.pipelining.ssl", true);
user_pref("network.http.proxy.pipelining", true);
user_pref("network.http.fast-fallback-to-IPv4", true);

user_pref("network.dns.disablePrefetch", true);
user_pref("network.prefetch-next", false);

// misc prefs

user_pref("browser.urlbar.trimURLs", false);
user_pref("browser.fullscreen.animate", false);
user_pref("browser.newtabpage.directory.ping", "");
user_pref("browser.newtabpage.directory.source", "");
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.tabs.animate", false);
user_pref("security.dialog_enable_delay", 400);
user_pref("browser.pocket.enabled", false);
user_pref("browser.preferences.inContent", true);
user_pref("social.enabled", false);
user_pref("social.remote-install.enabled", false);
user_pref("general.warnOnAboutConfig", false);
user_pref("browser.backspace_action", 1);

// these get mysteriously ignored

user_pref("browser.search.defaultenginename", "DuckDuckGo");
user_pref("font.default.x-western", "Ubuntu");
user_pref("font.default.x-unicode", "Ubuntu");
user_pref("browser.download.dir", "/home/phil");
user_pref("browser.search.hiddenOneOffs", "Yahoo,Twitter");

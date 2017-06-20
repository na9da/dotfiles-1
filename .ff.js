// lol no

user_pref("dom.webnotifications.enabled", false);
user_pref("media.autoplay.enabled", false);
user_pref("dom.min_background_timeout_value", 99999);

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

user_pref("browser.search.defaultenginename", "DuckDuckGo HTML");
user_pref("font.default.x-western", "Ubuntu");
user_pref("browser.download.dir", "/home/phil");

// extensions

user_pref("noscript.notify", false);
user_pref("noscript.forbidFonts", false);
user_pref("noscript.firstRunRedirection", false);

user_pref("extensions.keysnail.plugin.location",
          "/home/phil/.dotfiles/.keysnail-plugins");

// Define keyboard shortcuts for showing and hiding a custom panel.
var { Hotkey } = require("sdk/hotkeys");

var qr_str = "https://chart.googleapis.com/chart?cht=qr&chl=%s&chs=180x180&choe=UTF-8&chld=L|2"

var showHotKey = Hotkey({
    combo: "meta-q",
    onPress: function() {
        window.location = qr_str % url_escape(window.location);
    }
});

// profile-specific bits

// TODO: this crashes silently; woooo
var file = Components.classes["@mozilla.org/file/directory_service;1"].
    getService(Components.interfaces.nsIProperties).
    get("ProfD", Components.interfaces.nsIFile);

user_pref("profile_file", file);

if(file.indexOf("proxied") > -1) {
    user_pref("network.proxy.type", 1);
    user_pref("network.proxy.socks", "localhost");
    user_pref("network.proxy.socks_port", "8088");
    user_pref("network.proxy.socks_remote_dns", true);

    // thanks, stamps.com!
    user_pref("general.useragent.override", "the Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.2; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022)");
}

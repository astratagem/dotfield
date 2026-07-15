# NOTE: The keys must not be changed! Only change the values.
#
# NOTE: All settings likely still need to be present in order to prevent
# config corruption.  Don't remove any top-level properties from the object.
#
# It's okay if not all items apply to all configurations, as they indicate the
# totality of possible items. Some of the extensions might not even be installed
# anymore, and that's okay.
#
# TODO: hide the stuff we don't care about so that only stuff like "nav-bar" and
# "unified-extensions-area" are accessible.
let
  navbarItems = [
    # Removes the current page from browsing history!!!!11!1!
    "panic-button"
    "back-button"
    "forward-button"
    "stop-reload-button"
    "urlbar-container"
    "bookmarks-menu-button"
    "bookmarks-menu-button"
    "tab-stash_condordes_net-browser-action"
    "alltabs-button"
    "downloads-button"
    # 1Password
    "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"
    "addon_darkreader_org-browser-action"
    # Raindrop.io
    "_5158522f-7494-41b1-89ff-00d4cc1d87d3_-browser-action"
    "add-ons-button"
    # SingleFile
    "_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action"
    "offline-qr-code_rugk_github_io-browser-action"
    "display-anchors_robwu_nl-browser-action"
    "reset-pbm-toolbar-button"
    # Violentmonkey
    "_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action"
    # Stylus
    "_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action"
    "ublock0_raymondhill_net-browser-action"
    "unified-extensions-button"
    "_7fb64bcb-eee8-45dd-993a-caf63dca5294_-browser-action"
    "vertical-spacer"
  ];
  extensionsFlyoutItems = [
    # Link Gopher
    "linkgopher_oooninja_com-browser-action"
    # Obsidian Web Clipper
    "clipper_obsidian_md-browser-action"
    # Browserpass password-store integration
    "browserpass_maximbaz_com-browser-action"
    # Firefox Multi-Account Containers
    "_testpilot-containers-browser-action"
    "jid1-xx0tccgba7gvgw_jetpack-browser-action"
    # Tab Session Manager
    "tab-session-manager_sienori-browser-action"
    # GNOME Shell Integration
    "chrome-gnome-shell_gnome_org-browser-action"
    # Refined GitHub
    "_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action"
    # Auto Tab Discard
    "_c2c003ee-bd69-42a2-b0e9-6f34222cb046_-browser-action"
    # Consent-O-Matic
    "gdpr_cavi_au_dk-browser-action"
    # Copy Selection As Markdown
    "_db9a72da-7bc5-4805-bcea-da3cb1a15316_-browser-action"
    "_59e590fc-6635-45fe-89c7-af637eb4b9c0_-browser-action"
    "_b5e0e8de-ebfe-4306-9528-bcc18241a490_-browser-action"
    "_bb475b2b-f49c-4f3c-ae36-0fe15a6017e9_-browser-action"
    "_ddefd400-12ea-4264-8166-481f23abaa87_-browser-action"
    "atbc_easonwong-browser-action"
    "firefox-extension_steamdb_info-browser-action"
    "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"
    "_d07ccf11-c0cd-4938-a265-2a4d6ad01189_-browser-action"
    "_cb31ec5d-c49a-4e5a-b240-16c767444f62_-browser-action"
  ];
in
{
  "browser.uiCustomization.state" = builtins.toJSON {
    currentVersion = 24;
    # These are the sections being overridden.  See .placements below
    dirtyAreaCache = [
      "nav-bar"
      "PersonalToolbar"
      "toolbar-menubar"
      "TabsToolbar"
      "widget-overflow-fixed-list"
      "unified-extensions-area"
      "vertical-tabs"
    ];
    newElementCount = 14;
    placements = {
      PersonalToolbar = [ "personal-bookmarks" ];
      TabsToolbar = [ "tabbrowser-tabs" ];
      nav-bar = navbarItems;
      toolbar-menubar = [ "menubar-items" ];
      unified-extensions-area = extensionsFlyoutItems;
      vertical-tabs = [ ];
      widget-overflow-fixed-list = [ "fxa-toolbar-menu-button" ];
    };
    # New extensions are appended to this list.
    # It doesn't affect anything of consequence as far as I can tell.
    seen = [
      "developer-button"
      "addon_darkreader_org-browser-action"
      "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"
      "_testpilot-containers-browser-action"
      "_5158522f-7494-41b1-89ff-00d4cc1d87d3_-browser-action"
      "_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action"
      "ublock0_raymondhill_net-browser-action"
      "bukubrow_samhh_com-browser-action"
      "chrome-gnome-shell_gnome_org-browser-action"
      "_af37054b-3ace-46a2-ac59-709e4412bec6_-browser-action"
      "browserpass_maximbaz_com-browser-action"
      "display-anchors_robwu_nl-browser-action"
      "tab-session-manager_sienori-browser-action"
      "_c607c8df-14a7-4f28-894f-29e8722976af_-browser-action"
      "_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action"
      "_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action"
      "_c2c003ee-bd69-42a2-b0e9-6f34222cb046_-browser-action"
      "jid1-xx0tccgba7gvgw_jetpack-browser-action"
      "gdpr_cavi_au_dk-browser-action"
      "_db9a72da-7bc5-4805-bcea-da3cb1a15316_-browser-action"
      "jid0-adyhmvsp91nuo8prv0mn2vkeb84_jetpack-browser-action"
      "offline-qr-code_rugk_github_io-browser-action"
      "_59e590fc-6635-45fe-89c7-af637eb4b9c0_-browser-action"
      "_b5e0e8de-ebfe-4306-9528-bcc18241a490_-browser-action"
      "_bb475b2b-f49c-4f3c-ae36-0fe15a6017e9_-browser-action"
      "_ddefd400-12ea-4264-8166-481f23abaa87_-browser-action"
      "atbc_easonwong-browser-action"
      "firefox-extension_steamdb_info-browser-action"
      "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"
      "_d07ccf11-c0cd-4938-a265-2a4d6ad01189_-browser-action"
      "clipper_obsidian_md-browser-action"
      "linkgopher_oooninja_com-browser-action"
      "_cb31ec5d-c49a-4e5a-b240-16c767444f62_-browser-action"
      "reset-pbm-toolbar-button"
      "1094918_gmail_com-browser-action"
      "maxurl_qsniyg-browser-action"
      "tab-stash_condordes_net-browser-action"
      "_6c00218c-707a-4977-84cf-36df1cef310f_-browser-action"
      "7esoorv3_alefvanoon_anonaddy_me-browser-action"
      "_09acf9ff-55d4-4366-a1a9-c9b3c8877c09_-browser-action"
      "_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action"
      "_7fb64bcb-eee8-45dd-993a-caf63dca5294_-browser-action"
      "_ddc62400-f22d-4dd3-8b4a-05837de53c2e_-browser-action"
      "languagetool-webextension_languagetool_org-browser-action"
      "_b9db16a4-6edc-47ec-a1f4-b86292ed211d_-browser-action"
      "screenshot-button"
      "_powerthesaurus_org-browser-action"
    ];
  };
}

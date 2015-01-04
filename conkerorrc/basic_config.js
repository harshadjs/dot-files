/*
 * Conkeror configuration
 *- Harshad
 */

/* Tab bar */
require("new-tabs.js");

/* Use only these digits so that the hand movement is minimized */
hint_digits="0123489"

/* */
function define_switch_buffer_key (key, buf_num) {
    define_key(default_global_keymap, key,
               function (I) {
                   switch_to_buffer(I.window,
                                    I.window.buffers.get_buffer(buf_num));
               });
}
for (let i = 0; i < 10; ++i) {
    define_switch_buffer_key(String((i+1)%10), i);
}

function google_search (window, message) {
	newurl= "http://www.google.com/search?client=ubuntu&channel=fs&ie=utf-8&oe=utf-8&q=" + message;

	load_url_in_new_buffer(newurl);
    window.minibuffer.message("There you go!");
}

interactive("google-search",
			"echo a user-supplied message in the minibuffer",
			function (I) {
				google_search(I.window,
							  (yield I.minibuffer.read($prompt = "Search google for: ")));
			});

/* Disable scroll bar */

/* Disable tab-bars by default */
tab_bar_mode()

/* My Keybindings */
define_key(default_global_keymap, "o", "find-url-new-buffer")
define_key(default_global_keymap, "O", "find-url")
define_key(default_global_keymap, "C-S", "google-search")

define_key(default_global_keymap, "C-x t", "tab-bar-mode")
define_key(default_global_keymap, "C-x C-p", "buffer-move-backward")
define_key(default_global_keymap, "C-x C-n", "buffer-move-forward")
define_key(default_global_keymap, "C-tab", "buffer-next")
define_key(default_global_keymap, "C-S-tab", "buffer-previous")
define_key(default_global_keymap, "C-j", "unfocus")

//theme_load("gesso");
//theme_unload("gesso");

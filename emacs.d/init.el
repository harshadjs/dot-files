;; Emacs configuration top level script
;; Load path etc.

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))


(add-to-list 'load-path (concat dotfiles-dir "lisp"))

(require 'my-packages)
(require 'configure-packages)

;; Load basic configuration
(require 'basic-config)

;; Set the custom keybindings
(require 'my-keybindings)

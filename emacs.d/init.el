;; Emacs configuration top level script
;; Load path etc.
(setq package-check-signature 'nil)

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))


(add-to-list 'load-path (concat dotfiles-dir "lisp"))
(add-to-list 'custom-theme-load-path (concat dotfiles-dir "lisp"))


(require 'my-packages)
(require 'configure-packages)

;; Load basic configuration
(require 'basic-config)

;; Set the custom keybindings
(require 'my-keybindings)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-done ((t (:foreground "PaleGreen" :weight normal :strike-through t))))
 '(org-headline-done ((((class color) (min-colors 16) (background dark)) (:foreground "LightSalmon" :strike-through t))))
 '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button))))))

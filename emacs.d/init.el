;; Emacs configuration top level script
;; Load path etc.

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))


(add-to-list 'load-path (concat dotfiles-dir "lisp"))

;; Load basic configuration
(require 'basic-config)

;; Load extensions
(require 'extensions-wrapper)

;; Set the custom keybindings
(require 'my-keybindings)
(put 'set-goal-column 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8864a341f2e567ef45bacd4c45384cea4418bb67d7f937814ef9a202dd43e620" default)))
 '(org-agenda-files (quote ("~/org/fall_1.org")))
 '(safe-local-variable-values (quote ((related-file-name . "../../lib/xiaextheader.cc") (whitespace-line-column . 80) (lexical-binding . t))))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-done ((t (:foreground "PaleGreen" :strike-through nil))) t)
 '(org-done ((t (:foreground "PaleGreen" :weight normal :strike-through t))) t)
 '(org-headline-done ((((class color) (min-colors 16) (background dark)) (:foreground "LightSalmon" :strike-through t))) t))


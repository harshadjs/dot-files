;;; configure-packages.el
;;;
;;; Author: Harshad Shirwadkar
;;; Email: harshadshirwadkar@gmail.com
;;; Last modified: Tue Dec 30 22:36:23 UTC 2014
;;;
;;; Configure installed packages. Make sure that we have
;;; the required packages installed.
;;;

;; color-themes
(require 'gotham-theme)

;; auto-pair-mode
(require 'autopair)
(autopair-global-mode)
(setq autopair-autowrap t)

;; auto-complete-mode
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat dotfiles-dir "/extensions/auto-complete/ac-dict"))
(ac-config-default)

;; etags-select: TAGS for emacs
(require 'etags-select)

;; xcscope: Cscope for emacs
(require 'xcscope)

;; emamux: emacs + tmux
(require 'emamux)

(provide 'configure-packages)

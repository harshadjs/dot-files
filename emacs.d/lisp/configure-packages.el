;;; configure-packages.el
;;;
;;; Author: Harshad Shirwadkar
;;; Email: harshadshirwadkar@gmail.com
;;; Last modified: Tue Dec 30 22:36:23 UTC 2014
;;;
;;; Configure installed packages. Make sure that we have
;;; the required packages installed.
;;;

;; auto-pair-mode
(require 'autopair)
(autopair-global-mode)
(setq autopair-autowrap t)

;; auto-complete-mode
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat dotfiles-dir "/extensions/auto-complete/ac-dict"))
(ac-config-default)

;; xcscope: Cscope for emacs
(require 'xcscope)

;; emamux: emacs + tmux
(require 'emamux)


;; Google Packages (source: go/emacs)
(defun require-google-specific-packages ()
  (require 'compilation-colorization) ;; colorizes output of (i)grep
  (require 'rotate-clients)           ;; google-rotate-client
  (require 'rotate-among-files)       ;; google-rotate-among-files
  (require 'googlemenu)               ;; handy Google menu bar
  (require 'p4-files)                 ;; transparent support for Perforce filesystem
  (require 'google3)                  ;; magically set paths for compiling google3 code
  (require 'google3-build)            ;; support for blaze builds
  )


;; Ido vertical mode configuration
(ido-vertical-mode)
(setq ido-vertical-define-keys 'C-n-C-p-up-and-down)

(provide 'configure-packages)

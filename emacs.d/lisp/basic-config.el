;; basic-config.el
;;;
;;; Author: Harshad Shirwadkar
;;; Email: harshadshirwadkar@gmail.com
;;; Last modified: Tue Dec 30 22:36:23 UTC 2014
;;;
;;; This file sets basic configuration parameters. Please find more details
;;; in the code.
;;;

(setq user-full-name "Harshad Shirwadkar")
(setq user-mail-address "harshadshirwadkar@gmail.com")

;; Toggle fullscreen
(defun toggle-fullscreen()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

;; Set indentation params
(defun config-indent-config_tabs(tb-width tb-count)
  (interactive "nTab width: \nnTab Count: ")
  (setq-default tab-width tb-width)
  (setq c-basic-offset (* tb-width tb-count))
  (setq sh-basic-offset (* tb-width tb-count))
  )

;; Scroll one line at a time
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse~
(setq scroll-step 1)

;; Show line and column numbers on minibuffer
(line-number-mode 1)
(column-number-mode 1)

;; Enable delete selection mode
(delete-selection-mode 1)

;; Line numbers on left side
(autoload 'linum-mode "linum" "toggle line numbers on/off" t)
(if (display-graphic-p)
  (setq linum-format " %d")
  (setq linum-format "%4d | ")
  )

(global-linum-mode 1)

(global-hl-line-mode 1)
;;; C indentation start ---------------

(defun config-indent-80andNoTrail()
  (setq whitespace-line-column 80) ;; limit line length
  (setq whitespace-style '(face lines-tail))
  (add-hook 'prog-mode-hook 'whitespace-mode)
  (setq show-trailing-whitespace t)
  )

(defun config-indent-linux()
  (setq c-default-style "linux")
  ;; Use TABs of length of 8
  (setq indent-tabs-mode 1
	tab-width 8
	c-basic-offset 8)
  )
(add-hook 'c-mode-hook 'config-indent-linux)
;; (add-hook 'c-mode-hook '(lambda () (print "hello c")))
;; a(add-hook 'c++-mode-hook '(lambda () (print "hello c++")))
;; (add-hook 'c-mode-common-hook '(lambda () (print "hello c common")))
(add-hook 'c-mode-common-hook 'config-indent-80andNoTrail)
(if (file-directory-p "/google/")
   (add-hook 'c-mode-common-hook '(lambda () (require 'google))))


;;(config-indent-linux)

;;; C indentation stop -----------------

;; UI
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1))

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(ansi-color-for-comint-mode-on)

(setq visible-bell t
      echo-keystrokes 0.1
      font-lock-maximum-decoration t
      inhibit-startup-message t
      transient-mark-mode t
      color-theme-is-global t
      shift-select-mode nil
      mouse-yank-at-point t
      require-final-newline t
      truncate-partial-width-windows nil
      uniquify-buffer-name-style 'forward
      ediff-window-setup-function 'ediff-setup-windows-plain
      oddmuse-directory (concat dotfiles-dir "oddmuse")
      xterm-mouse-mode t
      save-place-file (concat dotfiles-dir "places"))

(add-to-list 'safe-local-variable-values '(lexical-binding . t))
(add-to-list 'safe-local-variable-values '(whitespace-line-column . 80))

;; Transparently open compressed files
(auto-compression-mode t)

;; Enable syntax highlighting for older Emacsen that have it off
(global-font-lock-mode t)

;; Save a list of recent files visited.
;; (recentf-mode 1)

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

;; ido-mode is like magic pixie dust!
(when (> emacs-major-version 21)
  (ido-mode t)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point 'guess
        ido-max-prospects 10))

(set-default 'indicate-empty-lines t)
(set-default 'imenu-auto-rescan t)

(add-hook 'text-mode-hook 'turn-on-auto-fill)

(defvar coding-hook nil
  "Hook that gets run on activation of any programming mode.")

(defalias 'yes-or-no-p 'y-or-n-p)
(random t) ;; Seed the random-number generator

;; Hippie expand: at times perhaps too hip
(delete 'try-expand-line hippie-expand-try-functions-list)
(delete 'try-expand-list hippie-expand-try-functions-list)

;; Don't clutter up directories with files~
(setq backup-directory-alist `(("." . ,(expand-file-name
                                        (concat dotfiles-dir "backups")))))

;; nxhtml stuff
(setq mumamo-chunk-coloring 'submode-colored
      nxhtml-skip-welcome t
      indent-region-mode t
      rng-nxml-auto-validate-flag nil)

;; Associate modes with file extensions
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.js\\(on\\)?$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.xml$" . nxml-mode))

(eval-after-load 'grep
  '(when (boundp 'grep-find-ignored-files)
    (add-to-list 'grep-find-ignored-files "target")
    (add-to-list 'grep-find-ignored-files "*.class")))

;; Default to unified diffs
(setq diff-switches "-u")

;; Cosmetics
(set-face-background 'vertical-border "white")
(set-face-foreground 'vertical-border "white")

(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))

;; (eval-after-load 'magit
;;   '(progn
;;      (set-face-foreground 'magit-diff-add "green3")
;;      (set-face-foreground 'magit-diff-del "red3")))

(eval-after-load 'mumamo
  '(eval-after-load 'zenburn
     '(ignore-errors (set-face-background
                      'mumamo-background-chunk-submode "gray22"))))

;; Platform-specific stuff
(when (eq system-type 'darwin)
  ;; Work around a bug on OS X where system-name is FQDN
  (setq system-name (car (split-string system-name "\\."))))

;; make emacs use the clipboard
(setq x-select-enable-clipboard t)

;; Get around the emacswiki spam protection
(add-hook 'oddmuse-mode-hook
          (lambda ()
            (unless (string-match "question" oddmuse-post)
              (setq oddmuse-post (concat "uihnscuskc=1;" oddmuse-post)))))

;; do not make backup files
(setq make-backup-files nil)

;; load theme only if outside of terminal
(if (display-graphic-p)
    (load-theme 'gotham t)
  (load-theme 'distraction-free t)
  )



(setq org-fontify-done-headline t)
(custom-set-faces
 '(org-done ((t (:foreground "PaleGreen"
							 :weight normal
							 :strike-through t))))


 '(org-headline-done
   ((((class color) (min-colors 16) (background dark))
	 (:foreground "LightSalmon" :strike-through t)))))


(setq-default org-export-html-postamble nil)

(put 'set-goal-column 'disabled nil)

(defun make-capture-frame ()
  "Create a new frame and run org-capture."
  (interactive)
  (make-frame '((name . "capture")))
  (select-frame-by-name "capture")
  (delete-other-windows)
  (org-capture)
  (delete-other-windows)
  )

;; Configure org-mode
(require 'org-mode-conf)

;; For CamelCase Editing
(add-hook 'c-mode-common-hook
          (lambda () (subword-mode 1)))



(provide 'basic-config)

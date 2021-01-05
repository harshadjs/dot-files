;;; my-packages.el
;;;
;;; Author: Harshad Shirwadkar
;;; Email: harshadshirwadkar@gmail.com
;;; Last modified: Tue Dec 30 22:36:23 UTC 2014
;;;
;;; Install packages
;;;

(defvar packages  '(
		;;; This is the list of packages to be installed
		;;; Add packages here
		auto-complete
		autopair
		emamux
		xcscope
		gotham-theme
		markdown-mode
		dracula-theme
		company
		ido-vertical-mode
		bbdb
		smex
		org-mime
		)
  )

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
  )

(when (not package-archive-contents) (package-refresh-contents))

(dolist (p packages)
  (when (not (package-installed-p p))
    (package-refresh-contents)
    (package-install p)))

(provide 'my-packages)

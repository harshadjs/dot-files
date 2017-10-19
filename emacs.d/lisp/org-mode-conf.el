;;; org-mode-conf.el
;;;
;;; Author: Harshad Shirwadkar
;;; Email: harshadshirwadkar@gmail.com
;;;
;;; Org-mode configuration
;;;

(require 'org)

(setq org-startup-indented t)
(setq org-indent-mode t)
(setq org-log-into-drawer t)
(setq org-agenda-files '("~/org" "~/org/music" "~/org/personal" "~/org/work"))
(setq org-default-notes-file "~/org/notes.org")

(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d!)" "WAIT(w!)" "CANCELED(c!)")))
(provide 'org-mode-conf)

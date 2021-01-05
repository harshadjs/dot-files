;; Forked from http://doc.norang.ca/org-mode.html
;; Original Author: Bernt Hansen

(if (boundp 'org-mode-user-lisp-path)
    (add-to-list 'load-path org-mode-user-lisp-path)
  (add-to-list 'load-path (expand-file-name "~/org-mode/lisp")))

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(require 'org)
;;
;; Standard key bindings
(global-set-key "\C-ca" 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; The following setting is different from the document so that you
;; can override the document org-agenda-files by setting your
;; org-agenda-files in the variable org-user-agenda-files
;;
(setq org-agenda-files (directory-files-recursively "~/org/" "\.org$"))


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "BLOCKED(b)" "NEXT(n)" "WORKING(w)" "|" "DONE(d)" "CANCELLED(c)" "SOMEDAY(s)")
	      )))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("WORKING" :foreground "cyan" :weight bold)
	      ("BLOCKED" :foreground "pink" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
	      ("CANCELLED" :foreground "gray" :weight bold)
	      )))

(setq org-use-fast-todo-selection t)

(setq org-treat-S-cursor-todo-selection-as-state-change nil)

(setq org-directory "~/org")
(setq org-default-notes-file "~/org/scribble.org")

(defun hs/org-file-by-date ()
  "Create an Org file with current time as name."
  (find-file (format-time-string "~/org/journal/journal-%Y-%m.org")))

;; Capture templates for: TODO tasks, Notes, appointments, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/org/scribble.org")
               "* TODO %?\n%U\n%a\n")
	      ("T" "today" entry (file "~/org/scribble.org")
               "* TODO %? \nSCHEDULED: %(org-insert-time-stamp (current-time) nil nil nil nil )\n%a\n")
	      ("n" "note" entry (file "~/org/scribble.org")
               "* %? :note:\n%U\n%a\n")
	      ("j" "journal" entry (function hs/org-file-by-date)
	       "* %U %? :journal:\n")
	      )))

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 1)
                                 (org-agenda-files :maxlevel . 1))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path 'file)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
;; Do not dim blocked tasks
;(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (
	      ("o" "Overview"
	       (
		(agenda "" (
			    (org-agenda-overriding-header "========\nOverview\n========\n\n** Today's Agenda **\n")
			    (org-agenda-span 'day)
			    (org-deadline-warning-days 0)
			    (org-agenda-compact-blocks nil)
			    (org-agenda-sorting-strategy '(todo-state-down))))
		(tags "+sticky"
                      ((org-agenda-overriding-header "\n** Sticky Notes **\n")
                       (org-tags-match-list-sublevels t)))
		(tags-todo "+work/WORKING|NEXT|TODO|BLOCKED"
                      ((org-agenda-overriding-header "\n** Work **\n")
                       (org-tags-match-list-sublevels t)
		       (org-agenda-sorting-strategy '(todo-state-down))))
		(tags-todo "-work/WORKING|NEXT|TODO|BLOCKED"
                      ((org-agenda-overriding-header "\n** Personal **\n")
                       (org-tags-match-list-sublevels t)
		       (org-agenda-sorting-strategy '(todo-state-down))))
		)
	       )
	      ("n" "Notes" tags "note"
	       ((org-agenda-overriding-header
		 (concat "===============\n"
			 " Note Pointers\n"
			 "===============\n"))
		(org-tags-match-list-sublevels t)))
	      ("s" "Pick and Finish!" todo "SOMEDAY"
               ((org-agenda-overriding-header
		 (concat "=================\n"
			 " Pick and Finish\n"
			 "=================\n"))
                (org-tags-match-list-sublevels t)))
	      ("j" "Journal" tags "journal"
	       ((org-agenda-overriding-header
		 (concat "===============\n"
			 " Journal Entries\n"
			 "===============\n"))
		(org-tags-match-list-sublevels t)))

	      )))


(defun hs/org-schedule-today ()
  (interactive)
  (org-agenda-schedule 'nil (current-time)))
(global-set-key "\C-ct" 'hs/org-schedule-today)

;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)

;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)


(setq org-time-stamp-rounding-minutes (quote (1 1)))

(setq org-agenda-clock-consistency-checks
      (quote (:max-duration "4:00"
              :min-duration 0
              :max-gap 0
              :gap-ok-around ("4:00"))))

;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Agenda clock report parameters
(setq org-agenda-clockreport-parameter-plist
      (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)))

; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

; global Effort estimate values
; global STYLE property values for completion
(setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
                                    ("STYLE_ALL" . "habit"))))

;; Agenda log mode items to display (closed and state changes by default)
(setq org-agenda-log-mode-items (quote (closed state)))

; Tags with fast selection keys
(setq org-tag-alist (quote (("read" . ?r)
                            ("note" . ?n)
			    )))

; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

; For tag searches ignore tasks with scheduled and deadline dates
;(setq org-agenda-tags-todo-honor-ignore-options t)

(setq org-agenda-span 'week)

(setq org-stuck-projects (quote ("" nil nil "")))

(setq org-archive-mark-done nil)
(setq org-archive-location "archives/%s-archived::* Archived Tasks")

(setq org-alphabetical-lists t)

;; Explicitly load required exporters
(require 'ox-html)
(require 'ox-latex)
(require 'ox-ascii)


; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")


(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (clojure . t)
         (shell . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t))))

; Inline images in HTML instead of producting links to the image
(setq org-html-inline-images t)
; Do not use sub or superscripts - I currently don't need this functionality in my documents
(setq org-export-with-sub-superscripts nil)
; Use org.css from the norang website for export document stylesheets
(setq org-html-head-extra "<link rel=\"stylesheet\" href=\"http://doc.norang.ca/org.css\" type=\"text/css\" />")
(setq org-html-head-include-default-style nil)
; Do not generate internal css formatting for HTML exports
(setq org-export-htmlize-output-type (quote css))
; Export with LaTeX fragments
(setq org-export-with-LaTeX-fragments t)
; Increase default number of headings to export
(setq org-export-headline-levels 6)

(setq org-latex-listings t)

(setq org-html-xml-declaration (quote (("html" . "")
                                       ("was-html" . "<?xml version=\"1.0\" encoding=\"%s\"?>")
                                       ("php" . "<?php echo \"<?xml version=\\\"1.0\\\" encoding=\\\"%s\\\" ?>\"; ?>"))))

(setq org-export-allow-BIND t)

;; Enable abbrev-mode
(add-hook 'org-mode-hook (lambda () (abbrev-mode 1)))

;; Limit restriction lock highlighting to the headline only
(setq org-agenda-restriction-lock-highlight-subtree nil)

;; Always hilight the current agenda line
;(add-hook 'org-agenda-mode-hook
;          '(lambda () (hl-line-mode 1))
;          'append)

;; Keep tasks with dates on the global todo lists
(setq org-agenda-todo-ignore-with-date nil)

;; Keep tasks with deadlines on the global todo lists
(setq org-agenda-todo-ignore-deadlines nil)

;; Keep tasks with scheduled dates on the global todo lists
(setq org-agenda-todo-ignore-scheduled nil)

;; Keep tasks with timestamps on the global todo lists
(setq org-agenda-todo-ignore-timestamp nil)

;; Remove completed deadline tasks from the agenda view
(setq org-agenda-skip-deadline-if-done t)

;; Remove completed scheduled tasks from the agenda view
(setq org-agenda-skip-scheduled-if-done t)

;; Remove completed items from search results
(setq org-agenda-skip-timestamp-if-done t)

(setq org-agenda-include-diary nil)
(setq org-agenda-diary-file "~/org/diary.org")

(setq org-agenda-insert-diary-extract-time t)

;; Include agenda archive files when searching for things
(setq org-agenda-text-search-extra-files (quote (agenda-archives)))

;; Show all future entries for repeating tasks
(setq org-agenda-repeating-timestamp-show-all t)

;; Show all agenda dates - even if they are empty
(setq org-agenda-show-all-dates t)

;; Sorting order for tasks on the agenda
(setq org-agenda-sorting-strategy
      (quote ((agenda habit-down time-up user-defined-up effort-up category-keep)
              (todo category-up effort-up)
              (tags category-up effort-up)
              (search category-up))))

;; Start the weekly agenda on Monday
(setq org-agenda-start-on-weekday 1)

;; Enable display of the time grid so we can see the marker for the current time
;; (setq org-agenda-time-grid (quote ((daily today remove-match)
;;                                    #("----------------" 0 16 (org-heading t))
;;                                    (0900 1100 1300 1500 1700))))

;; Display tags farther right
(setq org-agenda-tags-column -102)

;; Use sticky agenda's so they persist
(setq org-agenda-sticky t)

;; (require 'org-checklist)

(setq org-enforce-todo-dependencies t)


(setq org-startup-indented t)

(setq org-cycle-separator-lines 0)

(setq org-blank-before-new-entry (quote ((heading)
                                         (plain-list-item . auto))))

(setq org-insert-heading-respect-content nil)

(setq org-reverse-note-order nil)

(setq org-show-following-heading t)
(setq org-show-hierarchy-above t)
(setq org-show-siblings (quote ((default))))

(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-yank-adjusted-subtrees t)

(setq org-id-method (quote uuidgen))

(setq org-deadline-warning-days 30)

(setq org-table-export-default-format "orgtbl-to-csv")

(setq org-link-frame-setup (quote ((vm . vm-visit-folder)
                                   (gnus . org-gnus-no-new-news)
                                   (file . find-file))))

; Use the current window for C-c ' source editing
(setq org-src-window-setup 'current-window)

(setq org-log-done (quote time))
(setq org-log-into-drawer t)
(setq org-log-state-notes-insert-after-drawers nil)

(setq org-clock-sound "/usr/local/lib/tngchime.wav")

; Enable habit tracking (and a bunch of other modules)
(setq org-modules (quote (org-bibtex
                          org-crypt
                          org-gnus
                          org-id
                          org-info
                          org-jsinfo
                          org-habit
                          org-inlinetask
                          org-irc
                          org-mew
                          org-mhe
                          org-protocol
                          org-rmail
                          org-vm
                          org-wl
                          org-w3m)))

; position the habit graph on the agenda to the right of the default
(setq org-habit-graph-column 50)

(run-at-time "06:00" 86400 '(lambda () (setq org-habit-show-habits t)))

(global-auto-revert-mode t)

(setq org-use-speed-commands t)
(setq org-speed-commands-user (quote (("0" . ignore)
                                      ("1" . ignore)
                                      ("2" . ignore)
                                      ("3" . ignore)
                                      ("4" . ignore)
                                      ("5" . ignore)
                                      ("6" . ignore)
                                      ("7" . ignore)
                                      ("8" . ignore)
                                      ("9" . ignore)

                                      ("a" . ignore)
                                      ("d" . ignore)
                                      ("i" progn
                                       (forward-char 1)
                                       (call-interactively 'org-insert-heading-respect-content))
                                      ("k" . org-kill-note-or-show-branches)
                                      ("l" . ignore)
                                      ("m" . ignore)
                                      ("r" . ignore)
                                      ("s" . org-save-all-org-buffers)
                                      ("w" . org-refile)
                                      ("x" . ignore)
                                      ("y" . ignore)
                                      ("z" . org-add-note)

                                      ("A" . ignore)
                                      ("B" . ignore)
                                      ("E" . ignore)
                                      ("G" . ignore)
                                      ("H" . ignore)
                                      ("J" . org-clock-goto)
                                      ("K" . ignore)
                                      ("L" . ignore)
                                      ("M" . ignore)
                                      ("N" . org-narrow-to-subtree)
                                      ("Q" . ignore)
                                      ("R" . ignore)
                                      ("S" . ignore)
                                      ("V" . ignore)
                                      ("W" . widen)
                                      ("X" . ignore)
                                      ("Y" . ignore)
                                      ("Z" . ignore))))

(require 'org-protocol)

(setq require-final-newline t)

(setq org-export-with-timestamps nil)

(setq org-return-follows-link t)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button)))) t))

(setq org-remove-highlights-with-change t)

(setq org-read-date-prefer-future 'time)

(setq org-list-demote-modify-bullet (quote (("+" . "-")
                                            ("*" . "-")
                                            ("1." . "-")
                                            ("1)" . "-")
                                            ("A)" . "-")
                                            ("B)" . "-")
                                            ("a)" . "-")
                                            ("b)" . "-")
                                            ("A." . "-")
                                            ("B." . "-")
                                            ("a." . "-")
                                            ("b." . "-"))))

(setq org-tags-match-list-sublevels t)

(setq org-agenda-persistent-filter t)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

(require 'org-mime)

(setq org-agenda-skip-additional-timestamps-same-entry t)

(setq org-table-use-standard-references (quote from))

(setq org-file-apps (quote ((auto-mode . emacs)
                            ("\\.mm\\'" . system)
                            ("\\.x?html?\\'" . system)
                            ("\\.pdf\\'" . system))))

; Overwrite the current window with the agenda
(setq org-agenda-window-setup 'current-window)

(setq org-clone-delete-id t)

(setq org-cycle-include-plain-lists t)

(setq org-src-fontify-natively t)

(setq org-startup-folded t)

;; Disable keys in org-mode
;;    C-c [ 
;;    C-c ]
;;    C-c ;
;;    C-c C-x C-q  cancelling the clock (we never want this)
(add-hook 'org-mode-hook
          '(lambda ()
             ;; Undefine C-c [ and C-c ] since this breaks my
             ;; org-agenda files when directories are include It
             ;; expands the files in the directories individually
             (org-defkey org-mode-map "\C-c[" 'undefined)
             (org-defkey org-mode-map "\C-c]" 'undefined)
             (org-defkey org-mode-map "\C-c;" 'undefined)
             (org-defkey org-mode-map "\C-c\C-x\C-q" 'undefined))
          'append)


(setq org-src-preserve-indentation nil)
(setq org-edit-src-content-indentation 0)

(setq org-catch-invisible-edits 'error)

(setq org-export-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

(setq org-time-clocksum-format
      '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

(setq org-emphasis-alist (quote (("*" bold "<b>" "</b>")
                                 ("/" italic "<i>" "</i>")
                                 ("_" underline "<span style=\"text-decoration:underline;\">" "</span>")
                                 ("=" org-code "<code>" "</code>" verbatim)
                                 ("~" org-verbatim "<code>" "</code>" verbatim))))

(setq org-use-sub-superscripts nil)

(setq org-odd-levels-only nil)

(setq org-startup-indented nil)

(run-at-time "00:59" 3600 'org-save-all-org-buffers)

(provide 'org-mode-conf)

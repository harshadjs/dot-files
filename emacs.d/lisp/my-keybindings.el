;;; my-keybindings.el
;;;
;;; Author: Harshad Shirwadkar
;;; Email: harshadshirwadkar@gmail.com
;;; Last modified: Tue Dec 30 22:36:23 UTC 2014
;;;

;; Full-screen
(global-set-key [f11] 'toggle-fullscreen)

;; HS minor mode
(global-set-key (kbd "C-c h s") 'hs-minor-mode)
(global-set-key (kbd "C-c -") 'hs-hide-block)
(global-set-key (kbd "C-c h -") 'hs-hide-all)
(global-set-key (kbd "C-c =") 'hs-show-block)
(global-set-key (kbd "C-c h =") 'hs-show-all)

;; White-space mode
(global-set-key (kbd "C-c W") 'whitespace-mode)

;; etags-select
(global-set-key "\M-?" 'etags-select-find-tag-at-point)
(global-set-key "\M-." 'etags-select-find-tag)
;;; For setting current TAGS
(global-set-key (kbd "C-x t") 'visit-tags-table)

;; linum-mode
(global-set-key [C-f5] 'linum-mode)

;; config-tab-width
(global-set-key (kbd "C-c i t") 'config-indent-tabs)

;; Comment lines
(global-set-key (kbd "C-c / /") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c / *") 'comment-region)
(global-set-key (kbd "C-c * /") 'uncomment-region)

;; Emamux commands
(global-set-key (kbd "C-c w s") 'emamux:send-command)
(global-set-key (kbd "C-c w r") 'emamux:run-command)
(global-set-key (kbd "C-c w y") 'emamux:yank-from-list-buffers)
(global-set-key (kbd "C-c w w") 'emamux:copy-kill-ring)
(global-set-key (kbd "C-c w k") 'emamux:close-runner-pane)

;; Compile
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c a") 'org-agenda)

;; Cscope
(global-set-key (kbd "\C-c s s") 'cscope-find-this-symbol)
(global-set-key (kbd "\C-c s d") 'cscope-find-global-definition)
(global-set-key (kbd "\C-c s g") 'cscope-find-global-definition)
(global-set-key (kbd "\C-c s G") 'cscope-find-global-definition-no-prompting)
(global-set-key (kbd "\C-c s c") 'cscope-find-functions-calling-this-function)
(global-set-key (kbd "\C-c s C") 'cscope-find-called-functions)
(global-set-key (kbd "\C-c s t") 'cscope-find-this-text-string)
(global-set-key (kbd "\C-c s e") 'cscope-find-egrep-pattern)
(global-set-key (kbd "\C-c s f") 'cscope-find-this-file)
(global-set-key (kbd "\C-c s i") 'cscope-find-files-including-file)
;; --- (The '---' indicates that this line corresponds to a menu separator.)
(global-set-key (kbd "\C-c s b") 'cscope-display-buffer)
(global-set-key (kbd "\C-c s B") 'cscope-display-buffer-toggle)
(global-set-key (kbd "\C-c s n") 'cscope-next-symbol)
(global-set-key (kbd "\C-c s N") 'cscope-next-file)
(global-set-key (kbd "\C-c s p") 'cscope-prev-symbol)
(global-set-key (kbd "\C-c s P") 'cscope-prev-file)
(global-set-key (kbd "\C-c s u") 'cscope-pop-mark)
;; ---
(global-set-key (kbd "\C-c s a") 'cscope-set-initial-directory)
(global-set-key (kbd "\C-c s A") 'cscope-unset-initial-directory)
;; ---
(global-set-key (kbd "\C-c s L") 'cscope-create-list-of-files-to-index)
(global-set-key (kbd "\C-c s I") 'cscope-index-files)
(global-set-key (kbd "\C-c s E") 'cscope-edit-list-of-files-to-index)
(global-set-key (kbd "\C-c s W") 'cscope-tell-user-about-directory)
(global-set-key (kbd "\C-c s S") 'cscope-tell-user-about-directory)
(global-set-key (kbd "\C-c s T") 'cscope-tell-user-about-directory)
(global-set-key (kbd "\C-c s D") 'cscope-dired-directory)

(define-key global-map "\C-cc" 'org-capture)

(global-set-key [C-tab] 'next-buffer)
(global-set-key [C-iso-lefttab] 'previous-buffer)


;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

(provide 'my-keybindings)

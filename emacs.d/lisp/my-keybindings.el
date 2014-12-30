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

(provide 'my-keybindings)

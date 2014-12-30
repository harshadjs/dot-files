;;; Extensions-wrapper

;; color-themes
(add-to-list 'load-path (concat dotfiles-dir "/extensions/color-themes"))
;(require 'color-theme)
;(eval-after-load "color-theme" '(progn (color-theme-initialize)))

;;; Select Color Theme Wombat
;(require 'color-theme-wombat)
;(if window-system
;    (color-theme-wombat))
;(add-hook 'after-make-frame-functions 'color-theme-wombat)

(require 'gotham-theme)


;; auto-pair-mode
(add-to-list 'load-path (concat dotfiles-dir "/extensions/autopair"))
(require 'autopair)
(autopair-global-mode)
(setq autopair-autowrap t)

;; auto-complete-mode
(add-to-list 'load-path (concat dotfiles-dir "/extensions/auto-complete"))
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat dotfiles-dir "/extensions/auto-complete/ac-dict"))
(ac-config-default)

;; etags-select
(add-to-list 'load-path (concat dotfiles-dir "/extensions/etags-select"))
(require 'etags-select)

;; webkit
;; (add-to-list 'load-path (concat dotfiles-dir "/extensions/webkit"))
;; (require 'webkit)

;; xcscope
(add-to-list 'load-path (concat dotfiles-dir "/extensions/xcscope"))
(require 'xcscope)

;; xcscope
(add-to-list 'load-path (concat dotfiles-dir "/extensions/emamux"))
;;(add-to-list 'load-path  "/home/harshad/.emacs.d/extensions/emamux")
(require 'emamux)

;; el-get
;; (add-to-list 'load-path (concat dotfiles-dir "/extensions/el-get"))
;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (let (el-get-master-branch)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp))))

;; (el-get 'sync)

;; ;; yasnippet
;; (add-to-list 'load-path (concat dotfiles-dir "/extensions/yasnippet"))
;; (require 'yasnippet)
;; (setq yas/root-directory '("/home/harshad/.emacs.d/extensions/yasnippet/snippets"
;; 			   "/home/harshad/.emacs.d/extensions/yasnippet/my_snippets"))
;; (mapc 'yas/load-directory yas/root-directory)
;; (yas-global-mode 1)

;; chuck-mode
(add-to-list 'load-path (concat dotfiles-dir "/extensions/chuck-mode"))
(require 'chuck-mode)

(add-to-list 'load-path (concat dotfiles-dir "/extensions/websocket"))
(require 'websocket)


(add-to-list 'load-path (concat dotfiles-dir "/extensions/realtime-markdown-viewer"))
(require 'realtime-markdown-viewer)

(provide 'extensions-wrapper)

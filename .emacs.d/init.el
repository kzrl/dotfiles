(add-to-list 'load-path "~/.emacs.d/lisp/")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (manoj-dark)))
 '(package-selected-packages
   (quote
    (lsp-ui lsp-mode dash magit use-package ox-jira flycheck exec-path-from-shell)))
 '(save-place-mode t nil (saveplace))
 '(tool-bar-mode nil)
 '(transient-mark-mode (quote (only . t))))

(setq visible-bell 1)

(set-frame-font "Noto Mono 16" nil t)

;; add line numbers
(global-linum-mode t)
(setq linum-format "%d ")

;; add column number
(setq column-number-mode t)

;; Unsure how to make this work for Linux and Mac
;; (setq browse-url-browser-function 'browse-url-generic browse-url-generic-program "google-chrome")
;;(setq browse-url-browser-function 'browse-url-default-macosx-browser)

;; Emacs is not finding my go programs on this mac
;; (setq exec-path (append exec-path '("/home/kcordes/go/bin")))
;; (setq exec-path (append exec-path '("/home/kcordes/work/bin")))

(setq inhibit-startup-screen t)


;org mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-agenda-files '("~/org"))
(setq org-todo-keywords
      '((sequence "TODO" "INPROGRESS" "|" "DONE")))

;; Prompts for a URL like this:
;; https://jira.atlassian.com/browse/CONFDEV-56699
;; And adds this to your document:
;; [[https://jira.atlassian.com/browse/CONFDEV-56699][CONFDEV-56699]]
;; my first emacs func :D
(defun jiralink (string)
  "Insert orgmode link for a given jira ticket URL"
  (interactive "sticket URL: ")
  (insert "[[" string "][" (car (last (split-string string "/"))) "]]"))

;;
;; Using Emacs Package Manager: M-x list-packages
;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; org export to Confluence wiki markup
;;(require 'ox-confluence)

;; (when (memq window-system '(mac ns))
;;  (exec-path-from-shell-initialize)
;;  (exec-path-from-shell-copy-env "GOPATH"))


;; highlight-chars to see whitespace
;; (require 'highlight-chars) ;

;; (add-hook 'font-lock-mode-hook 'hc-highlight-trailing-whitespace)

;; flycheck linter
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Bootstrap `use-package' -  https://github.com/jwiegley/use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;(use-package projectile
;;  :ensure t)
;;(projectile-mode +1)
;;(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package go-mode
  :ensure t)


(use-package markdown-mode
  :ensure mc-extras
  :ensure t
  :mode "\\.md\\'"
  :mode "\\.markdown\\'")

(use-package json-mode
  :ensure t
  :mode "\\.json\\'")

(use-package yaml-mode
  :ensure t
  :mode "\\.yaml\\'")


(use-package lsp-mode
  :ensure t)

(use-package lsp-ui
  :ensure t)

;; lsp-mode
(require 'lsp-mode)
(add-hook 'go-mode-hook #'lsp)

(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; (require 'ob-python)
;; Configure babel for these languages
(org-babel-do-load-languages
  'org-babel-load-languages
  '((python . t)
    (shell . t)
    (dot . t)
    (org . t)
    (scheme . t)
    ))

;; run code blocks without prompt
(setq org-confirm-babel-evaluate nil)


;; auto revert mode
(global-auto-revert-mode 1)

;; magit bindings
(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "s-g") 'vc-git-grep)

;; go-setup thanks to https://johnsogg.github.io/emacs-golang
;; Key bindings specific to go-mode
(global-set-key (kbd "M-.") 'godef-jump)         ; Go to definition
(global-set-key (kbd "M-*") 'pop-tag-mark)       ; Return from whence you came
(global-set-key (kbd "M-p") 'compile)            ; Invoke compiler
(global-set-key (kbd "M-P") 'recompile)          ; Redo most recent compile cmd
(global-set-key (kbd "M-]") 'next-error)         ; Go to next error (or msg)
(global-set-key (kbd "M-[") 'previous-error)     ; Go to previous error or msg

;; https://godoc.org/golang.org/x/tools/cmd/goimports
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;; (require 'go-autocomplete)
;(require 'auto-complete-config)
;(ac-config-default)

(require 'org-daypage)
;(require 'go-guru)
;(add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)


(use-package markdown-mode
  :ensure mc-extras
  :ensure t
  :mode "\\.md\\'"
  :mode "\\.markdown\\'")

(use-package json-mode
  :ensure t
  :mode "\\.json\\'")

(use-package yaml-mode
  :ensure t
  :mode "\\.yaml\\'")


(global-set-key [f11] 'todays-daypage)
(global-set-key [f10] 'yesterdays-daypage)
(global-set-key "\C-con" 'todays-daypage)
(global-set-key "\C-coN" 'find-daypage)



(defun checklist()
  "Insert daily checklist into the buffer."
  (interactive)
  (insert "- [ ] Check emails (and close the tabs)\n")
  (insert "- [ ] Check hello (and close the tabs)\n")
  (insert "- [ ] Pick most important tasks for today\n")
  )


;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


(setq create-lockfiles nil)

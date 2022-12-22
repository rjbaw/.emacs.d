(emacs-init-time)
(setq inhibit-startup-message t)
(setq visible-bell 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
;(scroll-bar-mode -1)
(global-hl-line-mode t)
(line-number-mode t)
(visual-line-mode t)
(setq-default indent-tabs-mode nil)

(setq default-frame-alist '((font . "DM Mono")))
(setq custom-file "~/.emacs.d/custom-file.el")

(setq exec-path (append exec-path '("/usr/bin")))
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://github.com/quelpa/quelpa/raw/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))
(quelpa
  '(quelpa-use-package
     :fetcher git
     :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)
;(setq use-package-ensure-function 'quelpa)
(setq use-package-always-ensure t)

(use-package spinner
	     :quelpa (spinner
		       :fetcher github
		       :repo "Malabarba/spinner.el"))
(setq evil-want-C-i-jump nil)
(use-package evil
	     :ensure t
	     :init
             (setq evil-undo-system 'undo-fu)
             (setq evil-want-integration t)
             (setq evil-want-keybinding nil)
             :config
	     (evil-mode t))
(use-package evil-collection
	     :after evil
	     :config
	     (evil-collection-init)
	     :ensure t)
(setq-default evil-escape-key-sequence "<ESC>")
(use-package org
            :ensure t)
(use-package org-bullets
            :config
            (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(use-package undo-fu)
(use-package rust-mode)
(use-package julia-mode)
(use-package go-mode)
(use-package dockerfile-mode)
(use-package docker-compose-mode)
(use-package spacemacs-common
    :ensure spacemacs-theme
    :config (load-theme 'spacemacs-dark t))
(use-package magit
	     :ensure t)
(use-package lsp-mode
             :init (setq lsp-keymap-prefix "C-c l")
	     :hook
             (
              (sh-mode . lsp)
              (lsp-mode . lsp-enable-which-key-integration)
              )
	     :commands (lsp lsp-deferred)
             :ensure t)
(use-package lsp-ui
	     :quelpa (lsp-ui
		       :fetcher github
		       :repo "emacs-lsp/lsp-ui")
             :after lsp-mode
	     :config
	     (lsp-ui-peek-enable 1)
	     ;(lsp-ui-peek-show-directory 1)
	     (lsp-ui-doc-enable 1)
	     :commands lsp-ui-mode)
(use-package helm-lsp
	     :ensure t
             :after lsp-mode
	     :commands helm-lsp-workspace-symbol)
(use-package flycheck
             :after lsp-mode
	     :ensure t)
(use-package lsp-treemacs
             :after lsp-mode
             :commands lsp-treemacs-errors-list
	     :ensure t)
(use-package dap-mode
             :after lsp-mode
	     :ensure t)
(use-package which-key
	     :config
	     (which-key-mode))
(use-package company
	     :config
	     (setq company-idle-delay 0.0)
	     (setq company-minimum-prefix-length 1)
	     (global-company-mode t))
(use-package company-math)
(add-to-list 'company-backends 'company-math-symbols-unicode)
(use-package yasnippet
  :hook ((lsp-mode . yas-minor-mode))
  :ensure t)
(use-package yasnippet-snippets
  :ensure t)
(yas-global-mode 1)
(use-package spaceline
  :demand t
  :init
  (setq powerline-default-separator 'arrow-fade)
  :config
  (require 'spaceline-config)
  (spaceline-spacemacs-theme))
(use-package vimish-fold
  :ensure t
  :after evil)
(use-package evil-vimish-fold
  :ensure t
  :after vimish-fold
  :hook ((prog-mode conf-mode text-mode) . evil-vimish-fold-mode))
;(define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol)
;(add-hook 'dap-stopped-hook
;	  (lambda (arg) (call-interactively #'dap-hydra)))
;(setq dap-auto-configure-features '(sessions locals controls tooltip))
(add-hook 'julia-mode-hook #'lsp-mode)
(with-eval-after-load 'lsp-mode
  ;; :project/:workspace/:file
  (setq lsp-diagnostics-modeline-scope :project)
  (add-hook 'lsp-managed-mode-hook 'lsp-diagnostics-modeline-mode))
(quelpa
  '(lsp-julia
     :fetcher github
     :repo "gdkrmr/lsp-julia"
     :files (:defaults "languageserver")))

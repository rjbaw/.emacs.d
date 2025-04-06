(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode 1)
(global-visual-line-mode 1)
(line-number-mode 1)
(setq display-line-numbers-type 'relative)
(electric-pair-mode 1)
(setq indent-tabs-mode nil)
(setq native-comp-async-report-warnings-errors nil)
(setq inhibit-startup-message t)
(setq visible-bell t)
(cond
 ((find-font (font-spec :name "DM Mono"))
  (set-frame-font "DM Mono"))
 )

(setq custom-file "~/.emacs.d/custom-file.el")
(setq exec-path (append exec-path '("/usr/bin")))

;; Removed the unnecessary `package-initialize` call
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(use-package spinner)
(use-package key-chord
  :config
  (key-chord-define evil-insert-state-map "yy" 'evil-normal-state)
  :hook (evil-mode . key-chord-mode))

(use-package undo-tree
  :config
  (global-undo-tree-mode)
  (global-set-key (kbd "C-x u") 'undo-tree-visualize)
  (setq undo-tree-history-directory-alist `(("." . ,(expand-file-name "undo" user-emacs-directory)))))

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-undo-system 'undo-tree
        evil-want-C-u-scroll t
        evil-esc-delay 0)
  :config
  (evil-mode t)
  (define-key evil-normal-state-map "\C-v" 'evil-visual-block)
  (define-key evil-normal-state-map "u" 'undo-tree-undo)
  (define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package org
  :hook (org-mode . org-indent-mode))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package rust-mode)
(use-package julia-mode)
(use-package go-mode)
(use-package dockerfile-mode)
(use-package docker-compose-mode)

(use-package smartparens
  :config (smartparens-global-mode t))

(use-package highlight-indent-guides
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'character))

(use-package spacemacs-theme
  :defer t
  :init (load-theme 'spacemacs-dark t))

(use-package magit)

(use-package eglot
  :hook
  ((prog-mode . eglot-ensure)
   (org-mode . eglot-ensure))
  :config
  ;; Ensure language server is available for eglot before initializing
  (add-hook 'eglot-managed-mode-hook (lambda ()
                                       (unless (eglot--process-live-p)
                                         (message "Eglot server not running!")))))

(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

(use-package company
  :config
  (setq company-idle-delay 0.0
        company-minimum-prefix-length 1
        company-selection-wrap-around t)
  (global-company-mode t)
  (define-key company-active-map (kbd "TAB") 'company-complete-selection)
  (define-key company-active-map (kbd "<tab>") 'company-complete-selection))

(use-package company-math)
(add-to-list 'company-backends 'company-math-symbols-unicode)

(use-package yasnippet
  :hook ((eglot . yas-minor-mode))
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets)

(use-package spaceline
  :demand t
  :init
  (setq powerline-default-separator 'arrow-fade)
  :config
  (require 'spaceline-config)
  (spaceline-spacemacs-theme))

(use-package vimish-fold
  :after evil)

(use-package evil-vimish-fold
  :after vimish-fold
  :hook ((prog-mode conf-mode text-mode) . evil-vimish-fold-mode))

(use-package projectile
  :config
  (projectile-mode +1)
  (setq projectile-completion-system 'helm))

(use-package counsel
  :after (helm)
  :config
  (use-package swiper
    :bind (("C-s" . swiper)
           ("C-r" . swiper)))  
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x f" . counsel-find-file)))

(use-package flycheck
  :hook (prog-mode . flycheck-mode))

(use-package lsp-mode
  :hook ((rust-mode . lsp)
         (go-mode . lsp)
         (python-mode . lsp))
  :commands lsp)

(use-package lsp-ui
  :after lsp-mode
  :config
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-peek-enable t))

(use-package treemacs
  :config
  (setq treemacs-width 30)
  (treemacs-project-follow-mode))

(use-package all-the-icons)

(use-package beacon
  :config
  (beacon-mode 1))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package ace-window
  :bind ("M-o" . ace-window))

(use-package auto-package-update
  :config
  (setq auto-package-update-interval 7
        auto-package-update-prompt-before-update t)
  (auto-package-update-maybe))

;; init-utils.el --- Initialize ultilities.	-*- lexical-binding: t -*-
;;
;; Author: Vincent Zhang <seagle0128@gmail.com>
;; Version: 3.2.0
;; URL: https://github.com/seagle0128/.emacs.d
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;             Utils configurations.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(eval-when-compile
  (require 'init-const)
  (require 'init-custom))

;; Display available keybindings in popup
(use-package which-key
  :diminish which-key-mode
  :bind (:map help-map ("C-h" . which-key-C-h-dispatch))
  :init (add-hook 'after-init-hook #'which-key-mode))

;; Context-sensitive external browse URL or Internet search
(use-package browse-url-dwim
  :init (add-hook 'after-init-hook #'browse-url-dwim-mode))

;; A tree layout file explorer
(use-package treemacs
  :bind (([f8]        . treemacs-toggle)
         ("M-0"       . treemacs-select-window)
         ("C-c 1"     . treemacs-delete-other-windows))
  :config
  (setq treemacs-follow-after-init          t
        treemacs-width                      30
        treemacs-indentation                2
        treemacs-collapse-dirs              0
        treemacs-silent-refresh             t
        treemacs-change-root-without-asking nil
        treemacs-sorting                    'alphabetic-desc
        treemacs-show-hidden-files          t
        treemacs-never-persist              nil
        treemacs-is-never-other-window      nil
        treemacs-icon-fallback-text         ""
        treemacs-goto-tag-strategy          'refetch-index)

  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-git-mode 'simple))

;; Projectile integration for treemacs
(use-package treemacs-projectile
  :bind (([M-f8] . treemacs-projectile-toggle)
         ("C-c p h" . treemacs-projectile-toggle))
  :config
  (setq treemacs-header-function #'treemacs-projectile-create-header))

;; Dash: only avaliable on macOS
(when sys/macp
  (use-package dash-at-point
    :bind (("\C-cd" . dash-at-point)
           ("\C-ce" . dash-at-point-with-docset))))

;; Youdao Dictionay
(use-package youdao-dictionary
  :bind (("C-c y" . youdao-dictionary-search-at-point)
         ("C-c Y" . youdao-dictionary-search-at-point-tooltip))
  :config
  ;; Cache documents
  (setq url-automatic-caching t)

  ;; Enable Chinese word segmentation support (支持中文分词)
  (setq youdao-dictionary-use-chinese-word-segmentation t))

;; Search utils: `ag', `rg', `pt'
(use-package ag
  :bind (("C-c s a" . ag))
  :init
  (with-eval-after-load 'projectile
    (bind-key "C-c p s s" 'ag-project projectile-mode-map))
  :config
  (setq ag-highlight-search t)
  (setq ag-reuse-buffers t))

(use-package wgrep-ag
  :config
  (setq wgrep-auto-save-buffer t)
  (setq wgrep-change-readonly-file t))

(use-package rg
  :init
  (add-hook 'after-init-hook #'rg-enable-default-bindings)
  (if (fboundp 'wgrep-ag-setup)
      (add-hook 'rg-mode-hook #'wgrep-ag-setup))
  (with-eval-after-load 'projectile
    (bind-key "C-c p s r" 'rg-project projectile-mode-map))
  :config
  (setq rg-custom-type-aliases nil)
  (setq rg-group-result t)
  (setq rg-show-columns t)
  (with-eval-after-load 'counsel
    (bind-key "c" 'counsel-rg rg-global-map))
  (with-eval-after-load 'counsel-projectile
    (bind-key "s r" 'rg-project counsel-projectile-command-map)))

(use-package pt
  :bind (("C-c s P" . pt-regexp))
  :init
  (with-eval-after-load 'projectile
    (bind-key "C-c p s p" 'projectile-pt projectile-mode-map)))

;; Emoji
(when my-emoji-enabled
  (use-package emojify
    :init (add-hook 'after-init-hook #'global-emojify-mode)
    :config
    (with-eval-after-load 'company
      (use-package company-emoji
        :init (add-to-list 'company-backends 'company-emoji)))))

;; Discover key bindings and their meaning for the current Emacs major mode
(use-package discover-my-major
  :bind (("C-h M-m" . discover-my-major)
         ("C-h M-M" . discover-my-mode)))

;; Log keyboard commands to buffer
(use-package command-log-mode
  :diminish (command-log-mode . "¢")
  :init (setq command-log-mode-auto-show t))

;; A Simmple and cool pomodoro timer
(use-package pomidor
  :bind (("<f12>" . pomidor)))

;; Misc
(use-package fontawesome)
(use-package copyit)                    ; copy path, url, etc.
(use-package diffview)                  ; side-by-side diff view
(use-package esup)                      ; Emacs startup profiler
(use-package htmlize)                   ; covert to html
(use-package list-environment)
(use-package memory-usage)
(use-package open-junk-file)
(use-package try)
(use-package ztree)                     ; text mode directory tree. Similar with beyond compare

(provide 'init-utils)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-utils.el ends here

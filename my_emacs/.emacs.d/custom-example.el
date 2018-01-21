;;; custom-example.el --- user customization file    -*- no-byte-compile: t -*-
;;; Commentary:
;;;       Copy custom-example.el to custom.el and change the configurations,
;;;       then restart Emacs.
;;; Code:

(setq my-logo nil)                        ; Logo file or nil (official logo)
(setq my-full-name "yujmo")           ; User full name
(setq my-mail-address "yujmo94@gmail.com")   ; Email address
;; (setq my-proxy "127.0.0.1:1080")          ; Network proxy
(setq my-package-archives 'emacs-china)   ; Package repo: melpa, emacs-china or tuna
(setq my-theme 'dark)                     ; Color theme: default, dark, light or daylight
(setq my-emoji-enabled t)                 ; Enable emoji: t or nil
(setq my-benchmark-enabled t)             ; Enable initialization benchmark: t or nil

;;; custom-example.el ends here
(setq send-mail-function (quote smtpmail-send-it))
(setq smtpmail-smtp-server "smtp.qq.com")
(setq smtpmail-smtp-service 25)
(setq user-full-name "yujmo")
(setq user-mail-address "1103137684@qq.com")
;; 需要在home下新建.authinfo文件，内容如下（都是你作为发件人的信息，你的邮箱地址，你的邮箱密码）
;; machine smtp.qq.com login 邮箱地址 port 25 password 密码明文

;; 对经常使用的函数，使用Elisp函数避免重复手敲
(defun python-add-breakpoint ()
  "Add a break point"
  (interactive)
  (newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))

(define-key python-mode-map (kbd "C-c C-b") 'python-add-breakpoint)

;; emms configuration
(add-to-list 'load-path "~/emms/lisp")
(require 'emms-setup)
(emms-standard)
(emms-default-players)

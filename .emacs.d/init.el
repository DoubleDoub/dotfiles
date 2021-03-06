;; -*- mode: emacs-lisp -*-
;; Simple .emacs configuration

;; ---------------------
;; -- Global Settings --
;; ---------------------
(add-to-list 'load-path "~/dotfiles/.emacs.d")
(require 'cl)
(require 'ido)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'linum)
(require 'smooth-scrolling)
(require 'whitespace)
(require 'dired-x)
(require 'compile)
(require 'js-doc)
(ido-mode t)
(menu-bar-mode -1)
(normal-erase-is-backspace-mode 0)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq column-number-mode t)
(setq inhibit-startup-message t)
(setq save-abbrevs nil)
(setq show-trailing-whitespace t)
(setq suggest-key-bindings t)
(setq vc-follow-symlinks t)

;see matching pairs of parentheses etc
(setq show-paren-delay 0)
(show-paren-mode 1)
(electric-pair-mode t)

; add directory to duplicate  buffer name
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit autoface-default :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "monaco"))))
 '(column-marker-1 ((t (:background "red"))) t)
 '(diff-added ((t (:foreground "cyan"))) t)
 '(flymake-errline ((((class color) (background light)) (:background "Red"))))
 '(font-lock-comment-face ((((class color) (min-colors 8) (background light)) (:foreground "red"))))
 '(fundamental-mode-default ((t (:inherit default))) t)
 '(highlight ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(isearch ((((class color) (min-colors 8)) (:background "yellow" :foreground "black"))))
 '(linum ((t (:foreground "black" :weight bold))))
 '(region ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(secondary-selection ((((class color) (min-colors 8)) (:background "gray" :foreground "cyan"))))
 '(show-paren-match ((((class color) (background light)) (:background "black"))))
 '(vertical-border ((t nil))))

;; ------------
;; -- Macros --
;; ------------
(load "defuns-config.el")
(fset 'align-equals "\C-[xalign-regex\C-m=\C-m")
(global-set-key "\M-=" 'align-equals)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c;" 'comment-or-uncomment-region)
(global-set-key "\M-n" 'next5)
(global-set-key "\M-p" 'prev5)
(global-set-key "\M-o" 'other-window)
(global-set-key "\M-i" 'back-window)
(global-set-key "\C-z" 'zap-to-char)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-d" 'delete-word)
(global-set-key "\M-h" 'backward-delete-word)
(global-set-key "\M-u" 'zap-to-char)

;; ---------------------------
;; -- JS Mode configuration --
;; ---------------------------
(load "js-config.el")
(add-to-list 'load-path "~/.emacs.d/jade-mode") ;; github.com/brianc/jade-mode
(require 'sws-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; -------------------
;; -- Custom themes --
;; -------------------
(add-to-list 'custom-theme-load-path "~/dotfiles/.emacs.d/themes")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("2925ed246fb757da0e8784ecf03b9523bccd8b7996464e587b081037e0e98001" "fe230d2861a13bb969b5cdf45df1396385250cc0b7933b8ab9a2f9339b455f5c" default))))


;; ---------------
;; -- Add MELPA --
;; ---------------

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
;enable semantic color coding
(add-hook 'after-init-hook 'global-color-identifiers-mode) ;https://github.com/ankurdave/color-identifiers-mode

;; -------------------------------------
;; -- TERN static javascript analysis --
;; -------------------------------------
;http://ternjs.net/doc/manual.html#emacs
(add-to-list 'load-path "~/tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
;turn on autocomplete
(require 'auto-complete)
(global-auto-complete-mode t)

(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))
(add-hook 'after-init-hook 'auto-complete-mode)

;; --------------------
;; -- Backup options --
;; --------------------
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(add-to-list 'custom-theme-load-path "~/dotfiles/.emacs.d/themes")



;; ----------------------
;; -- JS documentation --
;; ----------------------


(setq js-doc-mail-address "wwierda@gmail.com"
       js-doc-author (format "Wietse" js-doc-mail-address)
       js-doc-url "N/A"
       js-doc-license "copyright")

(add-hook 'js2-mode-hook
           #'(lambda ()
               (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
               (define-key js2-mode-map "@" 'js-doc-insert-tag)))

;; ------------------------------------------------------------------------------------------
;; -- web-mode.el is an autonomous emacs major-mode for editing web templates.             --
;; -- HTML documents can embed parts (CSS / JavaScript) and blocks (client / server side). --
;; ------------------------------------------------------------------------------------------

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; set color for web-mode
(set-face-attribute 'web-mode-doctype-face nil :foreground "SlateBlue")
(set-face-attribute 'web-mode-html-tag-face nil :foreground "lightBlue")
(set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "red")
(set-face-attribute 'web-mode-html-attr-name-face nil :foreground "orange")
(set-face-attribute 'web-mode-css-at-rule-face nil :foreground "Pink3")
(set-face-attribute 'web-mode-variable-name-face nil :foreground "DarkGreen")
(set-face-attribute 'web-mode-comment-face nil :foreground "red")


;; fix anoying jshint error that require is not defined as variable
(setq js2-include-node-externs t)
(global-set-key "\C-cq" 'keyboard-quit)

 
(require `prettier-js)
(add-hook `js2-mode-hook `prettier-js-mode)
(add-hook `web-mode-hook `prettier-js-mode)

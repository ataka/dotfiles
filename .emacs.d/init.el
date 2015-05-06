;;;; Emacs の設定 --- 安宅正之 (Masayuki Ataka)
;;
;; Masayuki Ataka  <masayuki.ataka@gmail.com>
;;
;; Since 1998-09-XX
;;

;;
;; Japanese Environment
;;
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)

;;
;; Package (Emacs 24+)
;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;;
;; Edit Options
;;
(setq load-path (cons "~/.emacs.d/site-lisp/" load-path))
(setq load-path (cons "/usr/local/share/emacs/site-lisp" load-path))
(setq load-path (cons "/usr/local/share/emacs/site-lisp/tc" load-path))

(setq eval-expression-debug-on-error nil)
(setq visible-bell t)

(tool-bar-mode -1)
(column-number-mode t)

(setq line-move-visual nil)

; set fill-column. (default value is 70)
(setq default-fill-column 80)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

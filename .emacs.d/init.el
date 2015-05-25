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

;;
;; Key binding
;;
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end]  'end-of-buffer)
(global-unset-key "\C-z")
(global-unset-key "\C-x\C-z")

; C-h prefix
(define-key help-map "/" 'ispell-complete-word)

; C-c prefix
(define-key mode-specific-map "c" 'compile)
(define-key mode-specific-map "f" 'ffap)
(define-key mode-specific-map "g" 'grep)
(define-key mode-specific-map "o" 'occur)
(define-key mode-specific-map "y" 'clipboard-yank)

; C-x prefix
(define-key ctl-x-map "f" 'font-lock-mode)


;;;;;;;;;;;;;;;;;;;;
;; Custom Package ;;
;;;;;;;;;;;;;;;;;;;;

;;
;; paren
;;
(require 'paren)
(show-paren-mode t)
(setq show-paren-style 'mixed)

;;
;; CC-mode
;;
(defconst ataka-style
  '((c-basic-offset         . 2)
;;    (c-comment-only-line-offset . (0 . 0))
    (c-offsets-alist        . ((statement-block-intro . +)
                               (knr-argdecl-intro     . 5)
                               (substatement-open     . +)
                               (substatement-label    . 0)
                               (label                 . 0)
                               (statement-case-open   . +)
                               (statement-cont        . +)
                               (arglist-intro         . c-lineup-arglist-intro-after-paren)
                               (arglist-close         . c-lineup-arglist)
                               (inline-open           . 0)
                               (brace-list-open       . +)
                               (c                     . c-lineup-C-comments)
                               ))
;;    (c-special-indent-hook  . c-gnu-impose-minimum)
    (c-cleanup-list         . (brace-else-brace
                               brace-elseif-brace
                               scope-operator
                               defun-close-semi))
    (c-block-comment-prefix . "*")
    )
  "My C programing style.")

(add-hook 'c-mode-common-hook
          '(lambda ()
             ;; (c-set-style "gnu")
             (c-add-style "PERSONAL" ataka-style t)
             (setq tab-width 4
                   indent-tabs-mode nil
                   compilation-window-height nil)
             (c-toggle-auto-hungry-state 1)
             (define-key c-mode-base-map "\C-m" 'newline-and-indent)
             ))



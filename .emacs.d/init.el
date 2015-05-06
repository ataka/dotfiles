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

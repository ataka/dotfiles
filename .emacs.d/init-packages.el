;;
;; Settings for packages installed via package-system
;;

;;
;; fcopy
;;
(define-key mode-specific-map "k" 'fcopy)

;;
;; haskell-mode
;;
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;;
;; magit
;;
(define-key mode-specific-map "v" 'magit-status)

;;
;; scala-mode2
;;
(add-hook 'scala-mode-hook '(lambda ()
                              (interactive)
                              (newline-and-indent)
                              (scala-indent:insert-asterisk-on-multiline-comment)))

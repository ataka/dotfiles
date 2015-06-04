;;
;; Abbrev for HTML/XHTML
;;
(define-skeleton xhtml "" nil
"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
"<!DOCTYPE html>\n"
"<html xmlns=\"http://www.w3.org/1999/xhtml\">\n"
"<head>\n"
"  <title>" _ "</title>\n"
"</head>\n"
"<body>\n"
"<h1></h1>\n"
"</body>\n"
"</html>\n"
)
(define-skeleton nxml-element-h4 "" nil
  "<h4>" _ "</h4>")
(define-skeleton nxml-element-h5 "" nil
  "<h5>" _ "</h5>")
(define-skeleton nxml-element-dfn "" nil
  "<dfn>" _ "</dfn>")
(define-skeleton nxml-element-kbd "" nil
  "<kbd>" _ "</kbd>")
(define-skeleton nxml-element-samp "" nil
  "<samp>" _ "</samp>")
(define-skeleton nxml-element-code "" nil
  "<code>" _ "</code>")
(define-skeleton nxml-element-pre "" nil
  "<pre class=\"sample\">" _ "</pre>")
(define-skeleton nxml-element-strong "" nil
  "<strong>" _ "</strong>")
(define-skeleton nxml-element-ruby "" nil
  "<ruby>" _ "<rp> (</rp><rt></rt><rp>) </rp></ruby>"
(define-skeleton nxml-element-ul "" nil
  "<ul>\n"
  > "<li>" _ "</li>\n"
  "</ul>")
(define-skeleton nxml-element-ol "" nil
  "<ol>\n"
  > "<li>" _ "</li>\n"
  "</ol>")
(define-skeleton nxml-element-li "" nil
  "<li>" _ "</li>")
(define-skeleton nxml-element-blockquote "" nil
  "<blockquote>\n" _ "\n</blockquote>")

(define-abbrev-table 'nxml-mode-abbrev-table 
  '(("4" "" nxml-element-h4)
    ("5" "" nxml-element-h5)
    ("k" "" nxml-element-kbd)
    ("d" "" nxml-element-dfn)
    ("s" "" nxml-element-samp)
    ("c" "" nxml-element-code)
    ("p" "" nxml-element-pre)
    ("*" "" nxml-element-strong)
    ("r" "" nxml-element-ruby)
    ("u" "" nxml-element-ul)
    ("o" "" nxml-element-ol)
    ("l" "" nxml-element-li)
    ("bq" "" nxml-element-blockquote)
    ))

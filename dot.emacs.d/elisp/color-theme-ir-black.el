
;; -*- emacs-lisp -*-
;;
;;
;; name: color-theme-ir-black
;; date: Sat Sep 25 2010 20:54:37 GMT+0200 (CET)
;;
;;
;; To use this theme save this code into a
;; file named color-theme-ir-black.el and place it
;; in a directory in your load-path
;;
;;    (require 'color-theme-ir-black)
;;    (color-theme-ir-black)
;;


(require 'color-theme)

(defun color-theme-ir-black ()
  "Generated with http://color-theme-select.heroku.com/ on Sat Sep 25 2010 20:54:36 GMT+0200 (CET)  
color-theme-ir-black"
  (interactive)
  (color-theme-install
    '(color-theme-ir-black
      (
       (background-color . "#000000")
       (background-mode . "dark")
       (border-color . "#000000")
       (cursor-color . "#FFA560")
       (foreground-color . "#F6F3E8")
       (mouse-color . "sienna1")
      )
      (
      )
      (default  ((t (:foreground "#F6F3E8" :background "#000000"))))
      (blue  ((t (:foreground "blue"))))
      (buffers-tab  ((t (:foreground "#F6F3E8" :background "#000000"))))
      (font-lock-builtin-face  ((t (:foreground "#F6F3E8"))))
      (font-lock-comment-face  ((t (:foreground "#7C7C7C"))))
      (font-lock-constant-face  ((t (:foreground "#99CC99"))))
      (font-lock-doc-string-face  ((t (:foreground "#A8FF60"))))
      (font-lock-function-name-face  ((t (:foreground "#FFB774"))))
      (font-lock-keyword-face  ((t (:foreground "#66B5FF"))))
      (font-lock-preprocessor-face  ((t (:foreground "#66B5FF"))))
      (font-lock-reference-face  ((t (:foreground "#99CC99"))))
      (font-lock-regexp-grouping-backslash-face  ((t (:foreground "#FF6C60"))))
      (font-lock-regexp-grouping-construct-face  ((t (:foreground "#FF6C60"))))
      (font-lock-string-face  ((t (:foreground "#A8FF60"))))
      (font-lock-type-face  ((t (:foreground "#FFB774"))))
      (font-lock-variable-name-face  ((t (:foreground "#C6C5FE"))))
      (font-lock-warning-face  ((t (:foreground "white" :background "#FF6C60"))))
      (gui-element  ((t (:foreground "#000000" :background "#D4D0C8"))))
      (region  ((t (:background "#1D1E2C"))))
      (mode-line  ((t (:foreground "#000000" :background "grey75"))))
      (highlight  ((t (:background "#151515"))))
      (highline-face  ((t (:background "#151515"))))
      (text-cursor  ((t (:foreground "#000000" :background "yellow"))))
      (bold  ((t (:bold t))))
      (bold-italic  ((t (:bold t))))
     )
  )
)

(provide 'color-theme-ir-black)
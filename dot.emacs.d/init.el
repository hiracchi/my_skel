(when (> emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d"))

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
             (expand-file-name (concat user-emacs-directory path))))
      (add-to-list 'load-path default-directory)
      (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
        (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path "elisp" "conf" "public_repos")

;; auto-install ================================================================
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))

;; anything ====================================================================
(when (require 'anything nil t)
  (setq 
   anything-idle-delay 0.3
   anything-input-idle-delay 0.2
   anything-candidate-number-limit 100
   anything-quick-update t
   anything-enable-shortcut 'alphabet)

  (when (require 'anything-config nil t)
    (setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)

  (when (and (executable-find "cmigemo")
	     (require 'migemo nil t))
    (require 'anything-migemo nil t))

  (when (require 'anything-complete nil t)
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
    (descbinds-anything-install))
)

;; auto-complete ==============================================================
;(add-to-list 'load-path "~/.emacs.d/elisp/")
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default)
)

;; common user access =========================================================
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; language ===================================================================
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

  ;; for mac
(when (eq system-type 'darwin)
  ;; for filename
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

  ;; for windows
(when (eq window-system 'w32)
  (set-file-name-coding-system 'cp932)
  (setq locale-coding-system 'cp932))


;; visual =====================================================================
;; NOT for terminal
(when window-system
  ;; disable tool-bar
  (tool-bar-mode 0)
  ;; disable scroll-bar
  (scroll-bar-mode 0))

;; NOT for CocoaEmacs
(unless (eq window-system 'ns)
  (menu-bar-mode 0))

(column-number-mode t)
(line-number-mode t)

;; file
(size-indication-mode t)
(setq frame-title-format "%f")

;; time, day and date
(setq display-time-day-and-date t)
(setq display-time-24ht-format t)
(display-time-mode t)
;(display-battery-mode t)

;; http://d.hatena.ne.jp/sonota88/20110224/1298557375
(defun count-lines-and-chars ()
  (if mark-active
    (format "%d lines, %d chars "
      (count-lines (region-beginning) (region-end))
      (- (region-end) (region-beginning)))
    ;; flicker on the below case
    ;;(count-lines-region (region-beginning) (region-end))
    ""))
(add-to-list 'default-mode-line-format
             '(:eval (count-lines-and-chars)))

;; color-theme
(when (require 'color-theme nil t)
  (color-theme-initialize)
  (color-theme-xp))

;; hilight current line
(defface my-hl-line-face
  '((((class color) (background dark))
     (:background "NavyBlue" t))
    (((class color) (background light))
     (:backgound "LightGoldenrodYellow" t))
    (t (:bold t)))
  "hi-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)

;; paren-mode
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "yellow")

;; programing ==================================================================

;; file extention
(setq auto-mode-alist
      (append '(("\\.tpl$" . html-mode)
                ("\\.perl$\\|\\.p[hlm]$\\|/perl/" . perl-mode)
                ("\\.cpp$" . c++-mode)
                ("\\.cxx$" . c++-mode)
                ("\\.cu$"  . c++-mode)
                ("\\.h$"   . c++-mode)
                ("\\.hpp$" . c++-mode)
                ("\\.xsl$" . xml-mode)
                ("\\.py$"  . python-mode)
                ("\\.pp$"  . puppet-mode)
                ) auto-mode-alist))

;; for shebang
(add-hook 'after-save-hook 'my-chmod-script)
(defun my-chmod-script() 
  (interactive) (save-restriction 
                  (widen)
                  (let ((name (buffer-file-name)))
                    (if (and (not (string-match ":" name))
                             (not (string-match "/\\.[^/]+$" name))
                             (equal "#!" (buffer-substring 1 (min 3 (point-max)))))
                        (progn (set-file-modes name (logior (file-modes name) 73))
                               (message "Wrote %s (chmod +x)" name)
                               )
                      )
                    )
                  )
  )


;; for C/C++
(require 'cc-mode)
(add-hook 'c-mode-hook
          '(lambda()
             (turn-on-font-lock)
             (c-set-style "stroustrup")
             (setq tab-width 4)
             (c-set-offset 'statement-case-open '+)
             (setq c-auto-newline nill)
             (setq c-tab-always-indent t)
             (setq c-toggle-electric-state t)
             (setq c-toggle-hungry-state t)
             (setq indent-tabs-mode nil)
             (setq next-line-add-newlines nil)
             (setq compile-command "LANG=C make -k -j 3")
             (which-function-mode 1)
             ))

(add-hook 'c++-mode-hook
          '(lambda ()
             (turn-on-font-lock)
             (c-set-style "stroustrup")
             (setq tab-width 4)
             (c-set-offset 'statement-case-intro '+)
             (c-set-offset 'statement-case-open '+)
             (setq c-auto-newline nil)
             (setq c-tab-always-indent t)
             (setq c-toggle-electric-state t)
             (setq c-toggle-hungry-state t)
             (setq indent-tabs-mode nil)
             (setq next-line-add-newlines nil)
             (setq compile-command "LANG=C make -k -j 3")
             (which-function-mode 1)
             ))

;; git
(when (executable-find "git")
  (require 'egg nil t))


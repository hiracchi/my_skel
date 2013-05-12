;; for debug mode ==============================================================
(require 'cl)
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-screen t)


;; emacs setting and management ================================================
(when (< emacs-major-version 23)
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


;; for machine environment =====================================================
;; detect envrioentments
(defvar run-linux
  (equal system-type 'gnu/linux))
(defvar run-darwine
  (equal system-type 'darwine))

(defvar run-cli
  (equal window-system nil))
(defvar run-cocoa
  (equal window-system 'ns))

;; not for terminal
(when window-system
  ;; disable tool-bar
  (tool-bar-mode 0)
  ;; disable scroll-bar
  (scroll-bar-mode 0))

;; not for CocoaEmacs
(unless (eq window-system 'ns)
  ;; disable menu-bar
  (menu-bar-mode 0)
  ;; emacs server
  (require 'server)
  (unless (server-running-p)
    (server-start))
)

;; ビープ音・画面フラッシュなし ================================================
(setq ring-bell-function 'ignore)

;; window mode =================================================================
;; frame size
(setq initial-frame-alist
      (append (list
               '(width . 80)
               '(height . 40)
               )
              initial-frame-alist))
(setq default-frame-alist initial-frame-alist)


;; key-bind ====================================================================
;; assign backspace to C-h
(keyboard-translate ?\C-h ?\C-?)
;; assign C-m to newline-and-indent
;;(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-j") 'newline)
;; 
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)
;; window switch / default "C-t" is transpose-chars
(define-key global-map (kbd "C-t") 'other-window)

(setq kill-whole-line t)
(global-set-key "\C-h" 'delete-backward-char);
(global-set-key "\C-xh" 'help-command);
(global-set-key "\C-x\C-i" 'indent-region)

(global-set-key "\C-x;" 'comment-region)
(global-set-key "\C-x:" 'uncomment-region)
(global-set-key "\C-cc" 'compile)

(global-set-key "\C-x\C-g" 'goto-line)

;; environment variable ========================================================
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "~/bin")

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


;; frame =======================================================================
;; show column number
(column-number-mode t)
;; show file size
(size-indication-mode t)
;; time, day and date
;;(setq display-time-day-and-date t)
;;(setq display-time-24ht-format t)
(display-time-mode t)
;; battery
;;(display-battery-mode t)
;; the number of lines and chars in the region
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
;; show pullpath
(setq frame-title-format "%f")
;; line number
;; (global-linum-mode t)



;; indent ======================================================================
;; TAB
(setq-default tab-width 4)
;; don't show TAB char in the case of indent
(setq-default indent-tabs-mode nil)
;; NOT use TAB in php-mode
;; (add-hook 'php-mode-hook
;;           '(lambda ()
;;             (setq indent-tabs-mode nil)))

;; indent for C、C++、JAVA、and PHP etc.
(add-hook 'c-mode-common-hook
          '(lambda ()
             (c-set-style "bsd")))


;; display, decolation =========================================================
;; region background
;; (set-face-background 'region "darkgreen")
;; color-theme (http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz)
(when (require 'color-theme nil t)
  (color-theme-initialize)
  ;(color-theme-arjen)
  (color-theme-charcoal-black)
)

;(line-number-mode t)

;; font
;; font settings on mac
;; copied form http://d.hatena.ne.jp/setoryohei/20110117/1295336454
(if run-cocoa
    (let* ((size 12)
           (asciifont "Ricty") ; ASCII fonts
           (jpfont "Ricty") ; Japanese fonts
           (h (* size 10))
           (fontspec (font-spec :family asciifont))
           (jp-fontspec (font-spec :family jpfont)))
      (set-face-attribute 'default nil :family asciifont :height h)
      ;; (set-face-bold-p 'bold nil)
      (set-fontset-font t 'japanese-jisx0213.2004-1 jp-fontspec)
      (set-fontset-font t 'japanese-jisx0213-2 jp-fontspec)
      (set-fontset-font t 'japanese-jisx0213-1 jp-fontspec)
      (set-fontset-font t 'japanese-jisx0212 jp-fontspec)
      (set-fontset-font t 'japanese-jisx0208 jp-fontspec)
      (set-fontset-font t 'katakana-jisx0201 jp-fontspec)
      (set-fontset-font t '(#x0080 . #x024F) fontspec) 
      (set-fontset-font t '(#x0370 . #x03FF) fontspec)))

(if run-cocoa
    (dolist (elt '(("^-apple-hiragino.*" . 1.2)
                   (".*osaka-bold.*" . 1.2)
                   (".*osaka-medium.*" . 1.2)
                   (".*courier-bold-.*-mac-roman" . 1.0)
                   (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
                   (".*monaco-bold-.*-mac-roman" . 0.9)))
      (add-to-list 'face-font-rescale-alist elt))
)


;; high-light ==================================================================
(defface my-hl-line-face
  ;; 背景がdarkならば背景色を紺に
  '((((class color) (background dark))
     (:background "NavyBlue" t))
    ;; 背景がlightならば背景色を緑に
    (((class color) (background light))
     (:background "LightGoldenrodYellow" t))
    (t (:bold t)))
  "hl-line's my face")
;(setq hl-line-face 'my-hl-line-face)
;(setq hl-line-face 'underline)
;(global-hl-line-mode t)
;; paren-mode
(setq show-paren-delay 0)
(show-paren-mode t)
;; 色が付く部分
(setq show-paren-style 'parenthesis) ; かっこに色が付く
;(setq show-paren-style 'expression)  ; かっこ内に色が付く
;(setq show-paren-style 'mixed)       ; その両方
(set-face-background 'show-paren-match-face nil)
;(set-face-underline-p 'show-paren-match-face "yellow")
(set-face-attribute 'show-paren-match-face nil
                    :background nil :foreground nil
                    :weight 'extra-bold)

;; backup ======================================================================
;;; P102-103 バックアップとオートセーブの設定
;; バックアップファイルを作成しない
;; (setq make-backup-files nil) ; 初期値はt
;; オートセーブファイルを作らない
;; (setq auto-save-default nil) ; 初期値はt

;; バックアップファイルの作成場所をシステムのTempディレクトリに変更する
;; (setq backup-directory-alist
;;       `((".*" . ,temporary-file-directory)))
;; オートセーブファイルの作成場所をシステムのTempディレクトリに変更する
;; (setq auto-save-file-name-transforms
;;       `((".*" ,temporary-file-directory t)))
;; バックアップとオートセーブファイルを~/.emacs.d/backups/へ集める
;;(add-to-list 'backup-directory-alist
;;             (cons "." "~/.emacs.d/backups/"))
;;(setq auto-save-file-name-transforms
;;      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))
;; オートセーブファイル作成までの秒間隔
(setq auto-save-timeout 15)
;; オートセーブファイル作成までのタイプ間隔
(setq auto-save-interval 60)


;; hook ========================================================================
;; ファイルが #! から始まる場合、+xを付けて保存する
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)
;; emacs-lisp-mode-hook用の関数を定義
(defun elisp-mode-hooks ()
  "lisp-mode-hooks"
  (when (require 'eldoc nil t)
    (setq eldoc-idle-delay 0.2)
    (setq eldoc-echo-area-use-multiline-p t)
    (turn-on-eldoc-mode)))
;; emacs-lisp-modeのフックをセット
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)


;; auto-install ================================================================
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  )

;;(install-elisp "http://www.emacswiki.org/emacs/download/redBo+.el")
(when (require 'redo+ nil t)
  ;; C-' にリドゥを割り当てる
  (global-set-key (kbd "C-'") 'redo)
  ;; (global-set-key (kbd "C-.") 'redo)
  )


;; anything ====================================================================
(require 'anything-startup)
(global-set-key (kbd "C-;") 'anything)
(global-set-key (kbd "C-]") 'anything-for-files)
(global-set-key (kbd "\C-x b") 'anything)

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

(require 'split-root)
(defun anything-display-function--split-root (buf)
  (let ((percent 40.0))
    (set-window-buffer (split-root-window (truncate (* (frame-height) (/ percent 100.0)))) buf)))
(setq anything-display-function 'anything-display-function--split-root)

;; auto-complete ===============================================================
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default)
  (setq ac-auto-start nil)
  ;(setq ac-auto-start 4)
  (ac-set-trigger-key "TAB")
  )


;; common user access ==========================================================
(cua-mode t)
(setq cua-enable-cua-keys nil)
;(setq cua-rectangle-mark-key (kbd "C-S-return"))


;; popwin ======================================================================
(when (require 'popwin nil t)
  (setq display-buffer-function 'popwin:display-buffer)
  (setq anything-samewindow nil)
  (push '("*anything*" :height 20) popwin:special-display-config)
  (push '(dired-mode :position top) popwin:special-display-config)
)


;; buffer ======================================================================
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")
(setq uniquify-min-dir-content 1)

(iswitchb-mode t)
(setq read-buffer-function 'iswitchb-read-buffer)
(setq iswitchb-regexp nil)
(setq iswitchb-prompt-newbuffer nil)

(setq recentf-max-saved-items 500)
(setq recentf-exclude '("/TAGS$" "/var/tmp/"))
(require 'recentf-ext)

;; 不要なバッファを自動で削除
;(require 'tempbuf)
;(add-hook 'find-file-hooks 'turn-on-tempbuf-mode)
;(add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)


;; find / replace ==============================================================
;(require 'moccur-edit)
;(setq moccur-split-word t)

;(require 'igrep)
;(igrep-define lgrep (igrep-use-zgrep nil)(igrep-regex-option "-n -0u8"))
;(igrep-find-define lgrep (igrep-use-zgrep nil)(igrep-regex-option "-n -0u8"))

;(require 'grep-a-lot)
;(grep-a-lot-setup-keys)
;(grep-a-lot-advise igrep)

;(require 'grep-edit)

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

;; fold block
(require 'hideshow)
(require 'fold-dwim)


;; show function name
(which-func-mode 1)
(setq which-func-modes t)
(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq-default header-line=format '(which-func-mode ("" which-func-format)))

;; to pop up compilation buffers at the bottom
(require 'compile)
(defvar compilation-window nil
  "The window opened for displaying a compilation buffer.")
(setq compilation-window-height 10)

;; for python
(add-hook 'python-mode-hook
          (lambda ()
            (turn-on-font-lock)
            (define-key python-mode-map "\C-m" 'newline-and-indent)
            (setq-default indent-tabs-mode nil)
            (setq-default tab-width 4)
            ))
;(add-hook 'python-mode-hook
;          (lambda ()
;            (turn-on-font-lock)
;            (define-key python-mode-map "\"" 'electric-pair)
;            (define-key python-mode-map "\'" 'electric-pair)
;            (define-key python-mode-map "(" 'electric-pair)
;            (define-key python-mode-map "[" 'electric-pair)
;            (define-key python-mode-map "{" 'electric-pair)
;            (define-key python-mode-map "\C-m" 'newline-and-indent)
;            (setq-default indent-tabs-mode nil)
;            (setq-default tab-width 4)
;            ))
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))



;; for YAML
(require 'yaml-mode)


;; git
(when (executable-find "git")
  (require 'egg nil t))


;; ReST ========================================================================
;; Emacs起動時にrst.elを読み込み
(require 'rst)
;; 拡張子の*.rst, *.restのファイルをrst-modeで開く
(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
                ("\\.rest$" . rst-mode)) auto-mode-alist))
;; 背景が黒い場合はこうしないと見出しが見づらい
(setq frame-background-mode 'dark)
;; 全部スペースでインデントしましょう
(add-hook 'rst-mode-hook '(lambda() (setq indent-tabs-mode nil)))

;; sphinx ======================================================================
;; sphinx-numfig
(defun rst-bk-numfigs (Fig Caption)
  "Inserts numbered firgure in sphinx, using numfig extension:
https://bitbucket.org/arjones6/sphinx-numfig"
  (interactive
   (list
    (file-name-nondirectory (read-file-name "Image file: " (if (file-exists-p "_static")
                                                               "_static"
                                                             default-directory) ))
    (read-string "Caption: ") ))
  (let (FigStripped FigStrippedLowerCase)
    (setq FigStripped
          (replace-regexp-in-string "[^a-zA-Z]" ""
                                    (file-name-sans-extension Fig)))
    (with-temp-buffer
      (insert FigStripped)
      (downcase-region (point-min) (point-max))
      (setq FigStrippedLowerCase (buffer-substring-no-properties (point-min) (point-max))))
    (insert (format "\
:num:`Fig. #%s`

.. _%s:

.. figure:: _static/%s
   :width: 50%s
   :alt: %s
   :align: center

   %s
" FigStrippedLowerCase FigStrippedLowerCase Fig "%" Fig Caption)))
  (search-backward-regexp "`")
  (forward-char 1)
)


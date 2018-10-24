(setq font-lock-maximum-decoration t
      color-theme-is-global t
      truncate-partial-width-windows nil)

;; Don't beep. Don't visible-bell (fails on el capitan). Just blink the modeline on errors.

(setq visible-bell nil)
(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.05 nil 'invert-face 'mode-line)))

;; Highlight current line
(global-hl-line-mode 1)
;; Line number
(global-display-line-numbers-mode)

;; Don't defer screen updates when performing operations
(setq redisplay-dont-pause t)

;; org-mode colors
(setq org-todo-keyword-faces
      '(
        ("INPR" . (:foreground "yellow" :weight bold))
        ("DONE" . (:foreground "green" :weight bold))
        ("IMPEDED" . (:foreground "red" :weight bold))
        ))

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))


;; --------------------------------------------------------
;; Theme
;; --------------------------------------------------------
(require-package 'gruvbox-theme)

;; If you don't customize it, this is the theme you get.
(setq-default custom-enabled-themes '(gruvbox-dark-medium))

;; Ensure that themes will be applied even if they have not been customized
(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))

(add-hook 'after-init-hook 'reapply-themes)


;;------------------------------------------------------------------------------
;; Toggle between light and dark
;;------------------------------------------------------------------------------
(defun light ()
  "Activate a light color theme."
  (interactive)
  (setq custom-enabled-themes '(sanityinc-tomorrow-day))
  (reapply-themes))

(defun dark ()
  "Activate a dark color theme."
  (interactive)
  (setq custom-enabled-themes '(sanityinc-tomorrow-bright))
  (reapply-themes))


(when (maybe-require-package 'dimmer)
  (setq-default dimmer-fraction 0.15)
  (add-hook 'after-init-hook 'dimmer-mode))


;; Make zooming affect frame instead of buffers
(require 'zoom-frm)

;; Unclutter the modeline
; (require 'diminish)
; (eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
; (eval-after-load "eldoc" '(diminish 'eldoc-mode))
; (eval-after-load "paredit" '(diminish 'paredit-mode))
; (eval-after-load "tagedit" '(diminish 'tagedit-mode))
; (eval-after-load "elisp-slime-nav" '(diminish 'elisp-slime-nav-mode))
; (eval-after-load "skewer-mode" '(diminish 'skewer-mode))
; (eval-after-load "skewer-css" '(diminish 'skewer-css-mode))
; (eval-after-load "skewer-html" '(diminish 'skewer-html-mode))
; (eval-after-load "smartparens" '(diminish 'smartparens-mode))
; (eval-after-load "guide-key" '(diminish 'guide-key-mode))
; (eval-after-load "whitespace-cleanup-mode" '(diminish 'whitespace-cleanup-mode))
; (eval-after-load "subword" '(diminish 'subword-mode))

(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))

(rename-modeline "js2-mode" js2-mode "JS2")
(rename-modeline "clojure-mode" clojure-mode "Clj")


(provide 'init-themes)

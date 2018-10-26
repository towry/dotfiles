;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Remove security vulnerability
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path settings-dir)
(add-to-list 'load-path site-lisp-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Settings for currently logged in user
(setq user-settings-dir
      (concat user-emacs-directory "users/" user-login-name))
(add-to-list 'load-path user-settings-dir)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))
(setq auto-save-file-name-transforms
  `((".*" "~/.emacs-saves/" t)))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))
(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Bootstrap config
;; load-paths is done.
;;----------------------------------------------------------------------------
;; esup
(autoload 'esup "esup" "Emacs Start Up Profiler." nil)
; (require 'esup)
(require 'init-proxy) ;; proxy for url package.
(require 'init-benchmarking) ;; Measure startup time
(require 'init-utils) ;; functions.
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH
(require 'init-themes)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require-package 'diminish)

(require 'init-frame-hooks)
(require 'init-ibuffer)
(require 'init-osx-keys)
(require 'init-gui-frames)
(require 'init-dired)
(require 'init-ivy)
(require 'init-isearch)
(require 'init-grep) ;; fd, ag etc.
(require 'init-flycheck)

(require 'init-vc)
(require 'init-darcs)
(require 'init-git)
(require 'init-compile)
(require 'init-recentf)
(require 'init-smex)
(require 'init-company)
(require 'init-windows)
(require 'init-sessions)
(require 'init-mmm)
(require 'init-editing-utils)
(require 'init-whitespace)

(require 'init-markdown)
(require 'init-javascript)
(require 'init-org)
(require 'init-html)
(require 'init-css)
(require 'init-yaml)
(require 'init-paredit)
(require 'init-lisp)
(require 'init-common-lisp)
(require 'init-python)
(require 'init-ruby)
(require 'init-swift)

(require 'init-misc)
(require 'init-dash)

(require 'init-projectile)

;; Load stuff on demand
(autoload 'skewer-start "setup-skewer" nil t)
(autoload 'skewer-demo "setup-skewer" nil t)
(autoload 'auto-complete-mode "auto-complete" nil t)

;; Emacs server
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))

;; Run at full power please
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; Conclude init by setting up specifics for the current user
(when (file-exists-p user-settings-dir)
  (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))
;; Load custom-file after package initialize.
(when (file-exists-p custom-file)
  (load custom-file))

;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)

(provide 'init)

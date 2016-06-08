;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;----------------------------------------------------------------------------
(add-auto-mode 'tcl-mode "Portfile\\'")
(fset 'yes-or-no-p 'y-or-n-p)

(dolist (hook (if (fboundp 'prog-mode)
                  '(prog-mode-hook ruby-mode-hook)
                '(find-file-hooks)))
  (add-hook hook 'goto-address-prog-mode))
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(setq goto-address-mail-face 'link)
(setq-default regex-tool-backend 'perl)
(add-auto-mode 'conf-mode "Procfile")

;;; Whitespace

(setq-default show-trailing-whitespace t)

(defun sanityinc/no-trailing-whitespace ()
  "Turn off display of trailing whitespace in this buffer."
  (setq show-trailing-whitespace nil))

;; But don't show trailing whitespace in SQLi, inf-ruby etc.
(dolist (hook '(special-mode-hook
                Info-mode-hook
                eww-mode-hook
                term-mode-hook
                comint-mode-hook
                compilation-mode-hook
                twittering-mode-hook
                minibuffer-setup-hook))
  (add-hook hook #'sanityinc/no-trailing-whitespace))


(require-package 'whitespace-cleanup-mode)
(global-whitespace-cleanup-mode t)

(global-set-key [remap just-one-space] 'cycle-spacing)

;; default prefer tabs
(setq-default indent-tabs-mode t)
;; tab size
(setq-default tab-width 4)
;; line number
(global-linum-mode t)

;; backup files
(setq version-control t
  kept-new-versions 5
  kept-old-versions 0
  delete-old-versions t 
  backup-by-copying t)
(setq vc-make-backup-files nil)
;; Default and per-save backups go here
(setq backup-directory-alist `(("." . "~/.emacs.d/backup/per-save/")))
(setq auto-save-file-name-transforms
  `((".*" ,"~/.emacs.d/backup/autosave/" t)))
(defun force-backup-of-buffer ()
  ;; Make a special "per session" backup at the first save of each
  ;; emacs session.
  (when (not buffer-backed-up)
    ;; Override the default parameters for per-session backups.
    (let ((backup-directory-alist '((".*" . ,"~/.emacs.d/backup/per-session/")))
          (kept-new-versions 3))
      (backup-buffer)))
  ;; Make a "per save" backup on each save.  The first save results in
  ;; both a per-session and a per-save backup, to keep the numbering
  ;; of per-save backups consistent.
  (let ((buffer-backed-up nil))
    (backup-buffer)))
(add-hook 'before-save-hook  'force-backup-of-buffer)


;; auto complete
(require-package 'auto-complete)
(ac-config-default)


(provide 'init-misc)

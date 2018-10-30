(setq-default dired-dwim-target t)

;; Prefer g-prefixed coreutils version of standard utilities when available
(let ((gls (executable-find "gls")))
  (when gls (setq insert-directory-program gls)))

(when (maybe-require-package 'diredfl)
  (after-load 'dired
    (diredfl-global-mode)))

(after-load 'dired
  (setq dired-recursive-deletes 'top)
  (define-key dired-mode-map [mouse-2] 'dired-find-file)
  (define-key dired-mode-map (kbd "C-c C-p") 'wdired-change-to-wdired-mode))

(when (maybe-require-package 'diff-hl)
  (after-load 'dired
    (add-hook 'dired-mode-hook
      (lambda ()
        (dired-hide-details-mode)))
    (add-hook 'dired-mode-hook 'diff-hl-dired-mode)))

(when (maybe-require-package 'dired-narrow)
  (after-load 'dired
    (add-hook 'dired-mode-hook
      (lambda ()
        (define-key dired-mode-map (kbd "i") 'dired-subtree-insert)
        (define-key dired-mode-map (kbd ";") 'dired-subtree-remove)
        (define-key dired-mode-map (kbd "/") 'dired-narrow)))))

(maybe-require-package 'dired-subtree)

(provide 'init-dired)

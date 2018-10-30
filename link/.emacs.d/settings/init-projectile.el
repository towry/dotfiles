
(defun projectile-nil ()
  "Do nothing"
  (interactive)
  )

(when (maybe-require-package 'projectile)
  (add-hook 'after-init-hook 'projectile-mode)

  ;; Shorter modeline
  (setq-default projectile-mode-line-prefix " Proj")
  (setq projectile-git-submodule-command "")

  (after-load 'projectile
    (setq projectile-switch-project-action 'projectile-dired)
    (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map))

  (maybe-require-package 'ibuffer-projectile)

  (maybe-require-package 'helm-projectile))


(provide 'init-projectile)

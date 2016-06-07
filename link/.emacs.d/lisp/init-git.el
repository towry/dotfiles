;; TODO: link commits from vc-log to magit-show-commit
;; TODO: smerge-mode
(require-package 'git-blame)
(require-package 'gitignore-mode)
(require-package 'gitconfig-mode)
;; (require-package 'git-gutter)
(require-package 'git-messenger) ;; Though see also vc-annotate's "n" & "p" bindings
(require-package 'git-timemachine)

(when (maybe-require-package 'git-commit)
  (add-hook 'git-commit-mode-hook 'goto-address-mode))

;; Convenient binding for vc-git-grep
(global-set-key (kbd "C-x v f") 'vc-git-grep)

; git gutter
(global-git-gutter-mode t)
(git-gutter:linum-setup)
(custom-set-variables
  '(git-gutter:update-interval 2))

(provide 'init-git)

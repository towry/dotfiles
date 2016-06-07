(when (maybe-require-package 'flycheck)
  (add-hook 'after-init-hook 'global-flycheck-mode)

  ;; Override default flycheck triggers
  (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-idle-change-delay 0.8)

  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list))

  (add-hook 'flycheck-mode-hook
    (lambda ()
      ;; disable jshint 
      (setq-default flycheck-disabled-checkers
        (append flycheck-disabled-checkers
          '(javascript-jshint)))
      ;; use eslint
      (flycheck-add-mode 'javascript-eslint 'web-mode)
      ;; customize flycheck temp file prefix
      (setq-default flycheck-temp-prefix ".flycheck")
      ;; disable json-jsonlist checking for json files
      (setq-default flycheck-disabled-checkers
        (append flycheck-disabled-checkers
          '(json-jsonlist)))

      ;; https://github.com/purcell/exec-path-from-shell
      ;; only need exec-path-from-shell on OSX
      ;; this hopefully sets up path and other vars better
      (when (memq window-system '(mac ns))
        (exec-path-from-shell-initialize))))

(provide 'init-flycheck)

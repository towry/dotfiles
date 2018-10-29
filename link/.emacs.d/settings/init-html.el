(require-package 'tagedit)
(after-load 'sgml-mode
  (tagedit-add-paredit-like-keybindings)
  (define-key tagedit-mode-map (kbd "M-?") nil)
  (define-key tagedit-mode-map (kbd "M-s") nil)
  (add-hook 'sgml-mode-hook (lambda () (tagedit-mode 1))))

(add-auto-mode 'html-mode "\\.\\(jsp\\|tmpl\\)\\'")

(when (maybe-require-package 'web-mode)
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode)))

;; Note: ERB is configured in init-ruby

(provide 'init-html)

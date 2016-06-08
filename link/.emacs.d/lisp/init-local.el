;;; Commentary:
;; configuration of some package

;; fuzzy file find
;;; Code:
(require-package 'fiplr)
(setq fiplr-ignored-globs '((directories (".git" ".svn" "node_modules" "bower_components"
										  "build" "dist"))
							(files ("*.jpg" "*.png" "*.zip" "*~"))))
(global-set-key (kbd "C-x f") 'fiplr-find-file)


;; neotree
(require-package 'neotree)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)


(provide 'init-local)

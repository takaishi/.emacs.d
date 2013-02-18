(require 'cl)

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files
(defconst dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))
(defconst config-dir (concat dotfiles-dir "conf.d/"))

(let* ((org-dir (expand-file-name
                 "lisp" (expand-file-name
                         "org-mode" (expand-file-name
                                     "site-lisp" dotfiles-dir))))
       (org-contrib-dir (expand-file-name
                         "lisp" (expand-file-name
                                 "contrib" (expand-file-name
                                            ".." org-dir)))))
  (setq load-path (append (list org-dir org-contrib-dir)
                          (or load-path nil))))

;; load up Org-mode and Org-babel
(require 'org)
(require 'ob-tangle)

;; load up all literate org-mode files in this directory
(mapc #'org-babel-load-file (directory-files config-dir t "\\.org$"))

;;(require 'cl)

;; el-get
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(setq-default el-get-dir (locate-user-emacs-file "el-get")
              el-get-emacswiki-base-url
              "http://raw.github.com/emacsmirror/emacswiki.org/master/")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "http://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

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
(require 'org)

;; bunele(el-get wrapper)
(add-to-list 'el-get-sources '(:name bundle :type github :pkgname "tarao/bundle-el"))
(el-get 'sync 'bundle)

(bundle emacs-jp/init-loader)
(bundle takaishi/babel-loader.el)
(require 'org-element)
(require 'babel-loader)
(setq init-loader-byte-compile t)
(bl:load-dir "~/.emacs.d/conf.d/")  

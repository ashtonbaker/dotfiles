;;; init.el
;;
;; Loads customizations stored in an Org-mode file

;; This sets up the load path so that we can override it
(package-initialize nil)

;; Use melpa
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(setq load-prefer-newer t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Load the rest of the packages
(package-initialize t)
(setq package-enable-at-startup nil)

(require 'org)
(org-babel-load-file "~/.emacs.d/config.org")
(org-babel-load-file "~/.emacs.d/secrets.org")

;; Keep emacs Custom-settings in a separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

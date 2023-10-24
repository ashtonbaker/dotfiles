;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(package-initialize t)
;;(setq doom-font (font-spec :family "Source Code Pro" :size 14))
;;(setq doom-font (font-spec :family "JetBrains Mono NL" :size 14))
(setq doom-font (font-spec :family "Berkeley Mono" :size 13))

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.lisp.d")
(load "~/.emacs.secrets" t)

(setq python-shell-interpreter "python3")
(setq js-indent-level 2)
(add-hook 'java-mode-hook (lambda () (setq c-basic-offset 2)))


(cl-loop for file in '("~/.nix-profile/bin/fish" "/usr/bin/bash")
        when (file-exists-p file)
        do (progn
          (setq shell-file-name file)
          (cl-return)))

(defun hsplit-last-buffer ()
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-next-buffer))

(defun vsplit-last-buffer ()
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer))

(defun set-ui-mode (mode)
  "Set the theme based on MODE."
  (cond
   ((eq mode 'dark)
    (disable-theme 'doom-gruvbox-light)
    (load-theme 'doom-gruvbox t))
   ((eq mode 'light)
    (disable-theme 'doom-gruvbox)
    (load-theme 'doom-gruvbox-light t))))

(bind-key "C-x 2" 'vsplit-last-buffer)
(bind-key "C-x 3" 'hsplit-last-buffer)
(bind-key [mouse-8] 'previous-buffer)
(bind-key [mouse-9] 'next-buffer)

(require 'doom-themes)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)

;;(load-theme 'doom-nord-aurora t)

(load-theme 'doom-gruvbox t)

(doom-themes-visual-bell-config)

(setq doom-themes-treemacs-theme "doom-colors")
(setq doom-themes-treemacs-enable-variable-pitch nil)

(doom-themes-treemacs-config)

(doom-themes-org-config)

(auto-fill-mode -1)
(remove-hook 'text-mode-hook #'turn-on-auto-fill)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(use-package request :ensure t)


(defun home-manager/switch ()
  (interactive)
  (shell-command "home-manager switch")
  (quit-window))

(map! :leader
      :desc "build and activate home-manager config"
      "h h s" #'home-manager/switch)

(setq auth-sources '("~/.authinfo"))

(setq max-specpdl-size 100000)


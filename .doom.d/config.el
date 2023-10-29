(package-initialize t)

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.lisp.d")
(load "~/.emacs.secrets" t)
(setq auth-sources '("~/.authinfo"))

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
(bind-key "C-x 2" 'vsplit-last-buffer)
(bind-key "C-x 3" 'hsplit-last-buffer)
(bind-key [mouse-8] 'previous-buffer)
(bind-key [mouse-9] 'next-buffer)

;; (when (memq window-system '(mac ns x))
;;   (exec-path-from-shell-initialize))

(setq max-specpdl-size 100000)
(auto-fill-mode -1)
(remove-hook 'text-mode-hook #'turn-on-auto-fill)

(setq python-shell-interpreter "python3")

(add-hook 'java-mode-hook (lambda () (setq c-basic-offset 2)))

(setq js-indent-level 2)

(setq doom-font (font-spec :family "Berkeley Mono" :size 13))
(defun set-ui-mode (mode)
  "Set the theme based on MODE."
  (cond
   ((eq mode 'dark)
    (disable-theme 'doom-gruvbox-light)
    (load-theme 'doom-gruvbox t))
   ((eq mode 'light)
    (disable-theme 'doom-gruvbox)
    (load-theme 'doom-gruvbox-light t))))
(require 'doom-themes)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)
(doom-themes-visual-bell-config)
(doom-themes-treemacs-config)
(setq doom-themes-treemacs-theme "doom-colors")
(setq doom-themes-treemacs-enable-variable-pitch nil)
(doom-themes-org-config)
(load-theme 'doom-gruvbox t)

(defun home-manager/switch ()
  (interactive)
  (shell-command "home-manager switch")
  (quit-window))

(map! :leader
      :desc "build and activate home-manager config"
      "h h s" #'home-manager/switch)

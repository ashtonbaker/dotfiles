;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(package-initialize t)
;;(setq doom-font (font-spec :family "Source Code Pro" :size 14))
;;(setq doom-font (font-spec :family "JetBrains Mono NL" :size 14))

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.lisp.d")
(load "~/.emacs.secrets" t)

;;(load "peg-mode")
(add-to-list 'auto-mode-alist '("\\.peg\\'" . peg-mode))
(setq python-shell-interpreter "python3")
(setq js-indent-level 2)
(add-hook 'java-mode-hook (lambda () (setq c-basic-offset 2)))

(setq org-directory "~/sync/org/")
(defun org-file (x) (concat org-directory x))
(setq org-default-notes-file (org-file "inbox.org"))
;;(setq org-agenda-files (list org-directory))
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)
(cl-loop for file in '("~/.nix-profile/bin/fish" "/usr/bin/bash")
        when (file-exists-p file)
        do (progn
          (setq shell-file-name file)
          (cl-return)))
(after! org (setq org-capture-templates
    `(("t" "Task" entry (file ,(org-file "inbox.org"))
        "* TODO %?\n")
      ("p" "Project" entry (file+headline ,(org-file "todo.org") "Projects")
        (file ,(org-file "templates/newprojecttemplate.org")))
      ("g" "Goal" entry (file+headline ,(org-file "goals.org") "Current Goals")
        (file ,(org-file "templates/newgoaltemplate.org")))
      ("n" "Note" entry (file+headline ,(org-file "notes.org") "Inbox")
        "* NOTE %?\n")
      ("s" "Someday" entry (file+headline ,(org-file "somedaymaybe.org") "Someday / Maybe")
        "* SOMEDAY %?\n")
      ("b" "Maybe" entry (file+headline ,(org-file "somedaymaybe.org") "Someday / Maybe")
        "* MAYBE %?\n")
      ("r" "Recipe" entry (file+headline ,(org-file "reference/food/recipes.org") "Recipes")
        (file ,(org-file "templates/recipetemplate.org")))
      ("d" "Review - Daily" entry (file+olp+datetree ,(org-file "reviews.org"))
        (file ,(org-file "templates/dailyreviewtemplate.org")))
      ("w" "Review - Weekly" entry (file+olp+datetree ,(org-file "reviews.org"))
        (file ,(org-file "templates/weeklyreviewtemplate.org")))
      ("m" "Review - Monthly" entry (file+olp+datetree ,(org-file "reviews.org"))
        (file ,(org-file "templates/monthlyreviewtemplate.org")))
      ("y" "Review - Yearly" entry (file+olp+datetree ,(org-file "reviews.org"))
        (file ,(org-file "templates/annualreviewtemplate.org")))
      )))

(setq org-agenda-files `(,(org-file "todo.org")
                         ,(org-file "agendas.org")
                         ,(org-file "inbox.org")
                         ,(org-file "calendar/personal.org")
                         ,(org-file "calendar/blumira.org")
                         ,(org-file "somedaymaybe.org")
                         ,(org-file "goals.org")
                         ,(org-file "reviews.org")
                         ,(org-file "notes.org")))
(setq org-refile-targets `((org-agenda-files :maxlevel . 3)))
(setq org-agenda-time-grid '((daily today require-timed)
                              (800 830 900 930 1000 1030 1100 1130 1200 1230 1300 1330 1400 1430 1500 1530 1600 1630 1700 1730 1800)
                              "......"
                              "----------------"))
(setq org-stuck-projects '("+LEVEL=2+PROJECT" ("NEXT" "TODO") nil ""))

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

(require 'doom-themes)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)

(load-theme 'doom-nord t)

(doom-themes-visual-bell-config)

(setq doom-themes-treemacs-theme "doom-colors")
(setq doom-themes-treemacs-enable-variable-pitch nil)

(doom-themes-treemacs-config)

(doom-themes-org-config)

(require 'lsp)
(require 'lsp-haskell)
(setq lsp-haskell-process-path-hie "hie-wrapper")

(add-hook 'haskell-mode-hook #'lsp)

(auto-fill-mode -1)
(remove-hook 'text-mode-hook #'turn-on-auto-fill)

(use-package org-brain :ensure t
  :init
  (setq org-brain-path (org-file "brain/"))
  ;; For Evil users
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  :config
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  (add-hook 'before-save-hook #'org-brain-ensure-ids-in-buffer)
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12)
  (setq org-brain-include-file-entries nil
        org-brain-file-entries-use-title nil))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(use-package request :ensure t)

(defun bitbucket/get-repositories (&optional url)
  (let ((auth-string
             (concat
              "Basic "
              (base64-encode-string (concat blu/bitbucket-username ":" blu/bitbucket-app-password)))))

       (let (result next)
         (request
           (if url url "https://api.bitbucket.org/2.0/repositories/blumira")
           :sync t
           :type "GET"
           :headers `(("Authorization" . ,auth-string))
           :params '(("role" . "member") ("pagelen" . "50"))
           :parser 'json-read
           :encoding 'utf-8
           :success (cl-function
                     (lambda (&key data &allow-other-keys)
                       (setq result (mapcar
                                     (lambda (value) (cdr (assq 'slug value)))
                                     (cdr (assq 'values data))))
                       (setq next (cdr (assq 'next data))))))
         ;; Handle pagination recursively
         (if next
             ;; if we have a "next" link, recurse and append
             (append result (bitbucket/get-repositories next))
             ;; otherwise, just return the result.
             result))))

(defun home-manager/switch ()
  (interactive)
  (shell-command "home-manager switch")
  (quit-window))

(map! :leader
      :desc "build and activate home-manager config"
      "h h s" #'home-manager/switch)


(defun bitbucket/clone-project ()
  (interactive)
    (let ((repos (bitbucket/get-repositories)))
      (ivy-read "Select a Git Repo: "
                repos
                :action (lambda (repo)
                          (setq project-root (format "~/blumira/%s" repo))
                          (magit-git-command (format "git clone --recurse-submodules git@bitbucket.org:blumira/%s.git %s" repo project-root))
                          (projectile-add-known-project project-root)))))

(with-eval-after-load 'magit
  (require 'forge))

(setq auth-sources '("~/.authinfo"))

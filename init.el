;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
                    '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(defvar myPackages
    '(better-defaults
      ein
      flycheck
      monokai-theme
      py-autopep8
      ivy
      swiper
      popwin
      iedit
      evil-nerd-commenter
      ido
      projectile
      ))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
            myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(set-language-environment "UTF-8")
(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'monokai t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
(global-company-mode 1)
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; PYTHON CONFIGURATION
;; --------------------------------------
(elpy-enable)
(setq elpy-rpc-python-command "python3")
(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
      (add-hook 'elpy-mode-hook 'flycheck-mode))
 
;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(tool-bar-mode 0) 
(scroll-bar-mode 0)
(menu-bar-mode 0)
(global-company-mode 1)
(setq-default cursor-type 'bar)
(setq make-backup-files nil)
(setq inital-frame-alist (quote ((fullscreen . maximized))))
(global-hl-line-mode 1)
(global-auto-revert-mode 1)
(setq auto-save-default nil)
(fset 'yes-or-no-p 'y-or-n-p)

(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-init-file)

(global-set-key [f1] 'info)
(global-set-key [f3] 'kill-this-buffer)
(global-set-key [f4] 'eshell)
;;;;;popwin
(require 'popwin)
(popwin-mode 1)
;;;;;iedit
(global-set-key (kbd "M-s e") 'iedit-mode)
;;;;;IVY
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
;;;;;;;;;;;;;IDO
(require 'ido)
(ido-mode t)
;;;;;;;;;;;;;Dired-mode
;;(set dired-recursive-deletes 'always)
;;(set dired-recursive-copies 'always)
(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
;;;;;;;;;;;;;org-mode
(require 'org)
(require 'org-install)
(require 'ob-tangle)
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
;;(org-babel-load-file (expand-file-name "org-file-name.org" user-emacs-directory))
;;(require 'org)
;;(set org-src-fontify-natively t)
;;(setq org-agenda-files '("~/org"))
;;(global-set-key (kbd "C-c a") 'org-agenda)
;;;;;;;;;;;;;PROJECTILE
(require 'projectile)
(projectile-global-mode)
(setq projectile-require-project-root nil)

;;;;;;;;;;;;;EVIL;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;;;;;;;evil-leader
(add-to-list 'load-path "~/.emacs.d/evil/evil-leader")
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  )
;;;;;;;vim-commont
(evil-leader/set-key
 "ci" 'evilnc-comment-or-uncomment-lines
 "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
 "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
 "cc" 'evilnc-copy-and-comment-lines
 "cp" 'evilnc-comment-or-uncomment-paragraphs
 "cr" 'comment-or-uncomment-region
 "cv" 'evilnc-toggle-invert-comment-line-by-line
 "."  'evilnc-copy-and-comment-operator
 "\\" 'evilnc-comment-operator
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(add-to-list 'company-backends 'company-jedi)
;;(add-to-list 'company-backends '(company-jedi company-files))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org org-evil helm-gtags company-ycmd swiper py-autopep8 monokai-theme flycheck elpy ein company-jedi company-anaconda better-defaults)))
 '(python-shell-interpreter "ipython3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

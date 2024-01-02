(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(ispell-dictionary nil)
 '(org-agenda-files
   '("/home/lucas/orgMobile/masterTaskList.org" "/home/lucas/Org/SysMan.org" "/home/lucas/Documents/Orgmode/inbox.org" "/home/lucas/Documents/Orgmode/4.org"))
 '(package-selected-packages
   '(emmet-mode org-roam web-mode ## org dashboard all-the-icons neotree dired-sidebar org-bullets doom-themes use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t (:family "Fira Code Retina" :height 160))))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-info ((t (:foreground "dark orange"))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-title ((t (:inherit default :weight bold :foreground "#eceff4" :family "Sans Serif" :height 2.0 :underline nil))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-level-1 ((t (:inherit default :weight bold :foreground "#eceff4" :family "Sans Serif" :height 1.75))))
 '(org-level-2 ((t (:inherit default :weight bold :foreground "#eceff4" :family "Sans Serif" :height 1.5))))
 '(org-level-3 ((t (:inherit default :weight bold :foreground "#eceff4" :family "Sans Serif" :height 1.25))))
 '(org-level-4 ((t (:inherit default :weight bold :foreground "#eceff4" :family "Sans Serif" :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :foreground "#eceff4" :family "Sans Serif"))))
 '(org-level-6 ((t (:inherit default :weight bold :foreground "#eceff4" :family "Sans Serif"))))
 '(org-level-7 ((t (:inherit default :weight bold :foreground "#eceff4" :family "Sans Serif"))))
 '(org-level-8 ((t (:inherit default :weight bold :foreground "#eceff4" :family "Sans Serif"))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))))
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-table ((t nil)))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
 '(variable-pitch ((t (:family "ETBembo" :height 180 :weight thin)))))

;; CHANGES WRITTEN BY MYSELF START HERE

;; SECTION 1 - First configuration
;; -*- mode: elisp -*- All changes after this here are custom

;; Disable the splash screen (to enable it agin, replace the t with 0)
;;(setq inhibit-splash-screen 0) <-- Get a splash screen of my own later

;; Enable transient mark mode
(transient-mark-mode 1)

;; SECTION -  Org mode configuration
;; Enable Org mode
(require 'org)

;; SECTION 2 - Key bindings
;; Some key bindings
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

;; SECTION 3 - Todos

;; Show moment a task was done
(setq org-log-done t)

;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

;; SECTION 4 - Theme
(require 'use-package)
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-opera t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-opera") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; SECTION 5 - MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

;; SECTION 6 - Customization of text n stuff
;;Hide emphasis markers
(setq org-hide-emphasis-markers t)
;; Switch list mode for points
(font-lock-add-keywords 'org-mode
'(("^ *\\([-]\\) "
   (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
;; Headline bullets
(use-package org-bullets
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
;; Headline fonts
(let* ((variable-tuple
          (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
                ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                ((x-list-fonts "Verdana")         '(:font "Verdana"))
                ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
         (base-font-color     (face-foreground 'default nil 'default))
         (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

    (custom-theme-set-faces
     'user
     `(org-level-8 ((t (,@headline ,@variable-tuple))))
     `(org-level-7 ((t (,@headline ,@variable-tuple))))
     `(org-level-6 ((t (,@headline ,@variable-tuple))))
     `(org-level-5 ((t (,@headline ,@variable-tuple))))
     `(org-level-4 ((t (,@headline ,@variable-tuple))))
     `(org-level-3 ((t (,@headline ,@variable-tuple))))
     `(org-level-2 ((t (,@headline ,@variable-tuple))))
     `(org-level-1 ((t (,@headline ,@variable-tuple))))
     `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

;; Original heights from first edit. Immediately after @variable-tuple, :height x
;; where x was, for each level from 1 to 4
;; 1.75, 1.5, 1.25, 1.1

;; Normal text fonts. Both variable and fixed pitch
(custom-theme-set-faces
   'user
   '(variable-pitch ((t (:family "ETBembo" :height 130 :weight thin))))
   '(fixed-pitch ((t ( :family "Fira Code Retina" :height 130))))
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:foreground "dark orange"))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   '(org-link ((t (:foreground "royal blue" :underline t))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))) t)
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-table ((t (:family "Georgia" :height 130 :foreground "#83a598"))))
		    ;;:inherit fixed-pitch :foreground "#ff0000"))))
			     ;;"#83a598"))))
   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

;;Trying to fix tables
;;(set-face-attribute 'org-table nil  :inherit 'fixed-pitch)

;; Set variable pitch as normal
(add-hook 'org-mode-hook 'variable-pitch-mode)

;; Make me select paragraph size myself
(add-hook 'org-mode-hook 'visual-line-mode)


;; SECTION 7 - Neotree file explorer
(require 'neotree)
(global-set-key [C-f8] 'neotree-toggle) ;;notworking
(when (display-graphic-p)
  (require 'all-the-icons))
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;;SECTION 8 - Dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)

;;SECTION 9 - Babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((gnuplot . t)
   (emacs-lisp . t)
   (ledger . t)
   (python . t)
   (latex . t)
   (R . t)))

;;SECTION 10 LaTeX
;;(require 'ox-latex)
;;(setq org-preview-latex-default-process dvipng)
;; None of these where necessary. Just installed the proper packages.

(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

;;SECTION 11 Indent mode by default
(setq org-startup-indented t)

;;SECTION 12 org-roam
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/orgRoam")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-setup))
;;APENDIX - I: Problems with installations
;;1. Org mode 9.6 installation - SOLVED through reddit
;;- Installing org mode 9.6 through melpa automatically installed magit, org-9.6, and I don't know what else
;;- Anything that installs org mode 9.6 makes the config file unavailable, therefore breaking my whole system

;;SECTION 13 Encryption
;;(require 'epa-file)
;;(epa-file-enable)
(setq epa-file-cache-passphrase-for-symmetric-encryption nil)
;; DOn't know if this is acrually doing anything but it's working so I'll let it be.

;;SECTION 14 Pics
(setq org-image-actual-width nil)

;;SECTION 15 Web-dev
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-hook 'web-mode-hook 'emmet-mode)

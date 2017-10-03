(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-engine (quote luatex))
 '(inhibit-startup-screen t)
 '(package-archives
   (quote
    (("MELPA Stable" . "https://stable.melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/"))))
 '(package-selected-packages
   (quote
    (magit flycheck auto-complete auto-correct company company-math company-statistics context-coloring ergoemacs-mode auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package ergoemacs-mode
  :init
  (setq ergomacs-theme nil)
  (setq ergoemacs-keyboard-layout "de")
  :config
  (ergoemacs-mode 1))

(use-package emacs-setup)

(use-package magit)

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(use-package ispell)

(setq english-dict "english")
(setq german-dict "deutsch8")

(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-really-hunspell t))
  (add-to-list 'ispell-local-dictionary-alist '("deutsch-hunspell"
                                              "[[:alpha:]]"
                                              "[^[:alpha:]]"
                                              "[']"
                                              t
                                              ("-d" "de_DE"); Dictionary file name
                                              nil
                                              iso-8859-1))

  (add-to-list 'ispell-local-dictionary-alist '("english-hunspell"
                                              "[[:alpha:]]"
                                              "[^[:alpha:]]"
                                              "[']"
                                              t
                                              ("-d" "en_US")
                                              nil
                                              iso-8859-1))
  (setq english-dict "english-hunspell")
  (setq german-dict "deutsch-hunspell")


(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
     (change (if (string= dic german-dict) english-dict german-dict)))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))
    
 (global-set-key (kbd "<f8>")   'fd-switch-dictionary)
(ispell-change-dictionary english-dict)

(add-hook 'after-init-hook 'global-company-mode)

;;AucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

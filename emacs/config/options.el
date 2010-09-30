;;; Paths and loading
(add-path "~/emacs/site-lisp/scala")

(load-library "linum")
(load-library "midnight")
;(load-library "dot-mode")             ; Use C-. to redo commands
;(load-library "flex-mode")
(load-library "buff-menu+")
(load-library "save-macro")
(load-library "myutilities")
(load-library "gse-number-rect")
(load-library "auctex")
(load-library "preview-latex")

(require 'ido)
(require 'uniquify)
(require 'dot-mode)
(require 'color-theme)
(require 'scala-mode-auto)
(require 'iedit)

(load "evimodeline.el")

(load "tramp")
(load "vip")
;(require 'viper)

;; Use actual tabs (grrr) for java mode
(add-hook 'java-mode-hook
          (lambda()
            (setq-default c-basic-offset 8 tab-width 8 indent-tabs-mode 't)))


(add-path "~/emacs/site-lisp/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/emacs/site-lisp/yasnippet-0.6.1c/snippets")

;; Maude
(setq maude-path "/home/ilseman2/maude-linux/maude")
(load-library "maude-mode")

;; Vim mode-line
(add-hook 'find-file-hook 'evimodeline-find-file-hook)


(load-library "tuareg")

(require 'yaml-mode)

;; Org Mode
(unless (assoc "\\.org\\'" auto-mode-alist)
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)))
(add-hook 'org-mode-hook (lambda () (local-set-key "\M-m" 'org-meta-return)))
(add-hook 'org-mode-hook 'org-indent-mode)


;; Haskell
(load "~/emacs/site-lisp/haskell-mode-2.4/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'linum-mode)
(add-hook 'haskell-mode-hook ( lambda () (global-unset-key "\C-c \C-g")))
(add-hook 'haskell-mode-hook ( lambda () (local-unset-key "\C-c \C-g")))
(add-hook 'haskell-mode-hook ( lambda () (setq haskell-indent-offset 2)))
;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)


;; OCaml
(setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)

;; Yaml
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; AspectJ
(add-to-list 'auto-mode-alist '("\\.aj$" . java-mode))

;; JavaMOP
(add-to-list 'auto-mode-alist '("\\.mop$" . java-mode))

;; .emacs
(add-to-list 'auto-mode-alist '("dotemacs$" . lisp-mode))


;;; End Loads ;;;


;;; Mode configurations ;;;

(add-hook 'find-file-hooks 'linum-off)     ; linum off when a file is opened
;(add-hook 'find-file-hooks 'dot-mode-on)  ; dot mode when file is opened
;(add-hook 'find-file-hooks 'vip-mode)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")
(setq uniquify-buffer-name-style 'reverse)
(setq ido-enable-flex-matching t)
(setq vip-inhibit-startup-message t)

(add-hook 'fundamental-mode-hook 'flyspell-mode) ; Auto-flyspell for fundamental mode
(add-hook 'text-mode-hook 'flyspell-mode)        ; as above, text-mode

;; Scala
(add-hook 'scala-mode-hook
          '(lambda ()
             (yas/minor-mode-on)))


;; Sml Modeline
(if (require 'sml-modeline nil 'noerror)    ;; use sml-modeline if available
  (progn
    (sml-modeline-mode 1)                   ;; show buffer pos in the mode line
    (scroll-bar-mode -1))                   ;; turn off the scrollbar
  (scroll-bar-mode 1)                       ;; otherwise, show a scrollbar...
  (set-scroll-bar-mode 'right))             ;; ... on the right


;;; End Mode configs ;;;


;;; Misc Options ;;;

(setq show-trailing-whitespace 1)               ;; Highlight trailing whitespace
(ido-mode t)                                    ;; Interactive Do, for opening files and switching buffers
;(iswitchb-mode 1)                              ;; Interactive buffer switching, don't use with ido
(tool-bar-mode -1)                              ;; Remove the entirely useless tool-bar
(menu-bar-mode -1)                              ;; Hide menu
(show-paren-mode 1)                             ;; Show Paren-matching
;(global-dot-mode 1)                            ;; C-. to redo
(transient-mark-mode 1)                         ;; Show Highlight-region
(column-number-mode 1)                          ;; Show column number on mode bar
(setq echo-keystrokes 0.1)                      ;; Quickly show key pressed
(setq-default indent-tabs-mode nil)             ;; Use spaces instead of tabs
(setq inhibit-splash-screen t)                  ;; I hate the splash screen
(scroll-bar-mode -1)                            ;; I hate the scroll bar
(line-number-mode 1)                            ;; Show line number on mode-bar
(blink-cursor-mode 1)                           ;; I like blink
(global-linum-mode 0)                           ;; Have line numbers on right hand side for all buffers by default
(midnight-delay-set 'midnight-delay "4:30am")   ;; Performs midnight mode at 4:30am, namely clean-buffer-list
(setq clean-buffer-list-delay-special (* 1 60)) ;; Clean special buffers

(setq ispell-program-name "aspell")   ; Use aspell instead of ispell

; 2 Space Tabs, by default (unless otherwise defined)
(setq-default c-basic-offset 2 tab-width 2 indent-tabs-mode nil)
(add-hook 'text-mode-hook 'flyspell-mode)        ;; Auto-flyspell for text mode
(add-to-list 'backup-directory-alist             ;; Move all those NAME~ files to ~/.backups
             '("." . "~/.backups/"))

; Auto-delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; Smart tab
(require 'smart-tab)

; Google Maps
(add-path "~/emacs/site-lisp/google-maps")
(require 'google-maps)

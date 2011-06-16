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
(load-library "psvn")
(require 'hexrgb)
(require 'psvn)

;; Set up Icicles
(require 'icicles)

(require 'ido)
(require 'uniquify)
(require 'dot-mode)
(require 'color-theme)
(require 'scala-mode-auto)
(require 'iedit)
(require 'undo-tree)

;; M-arrows will move between buffers
(require 'windmove)
(windmove-default-keybindings 'meta)

;; When opening a file, go to the same place in it
(require 'saveplace)
(setq-default save-place t)

;; Highlight FIXME, TODO, BUG
'(copy-face font-lock-warning-face 'fixme-face)
(add-hook 'c-mode-common-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))


;; M-y, when not done after a C-y, will open a buffer of the kill ring.
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; Run undo-tree rather than undo
(global-undo-tree-mode)

;; Have CUA for rectangles (but not for it's keys
(setq cua-enable-cua-keys nil)
(cua-mode t)

;; Smoother scrolling
(setq
  scroll-margin 0
  scroll-conservatively 100000
  scroll-preserve-screen-position 1)

;; Autopair
(require 'autopair)
(autopair-global-mode 1)


(load "evimodeline.el")

;(load "tramp")

(add-path "~/emacs/site-lisp/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/emacs/site-lisp/yasnippet-0.6.1c/snippets")

;; Maude
(setq maude-path "/home/ilseman2/maude-linux/maude")
(load-library "maude-mode")

;; K Framework
;(load-library "k-mode")


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

;; .h files are c++
(add-to-list 'auto-mode-alist '(".h$" . c++-mode))

;; .frag files can be treated as c++ files for now
(add-to-list 'auto-mode-alist '(".frag$" . c++-mode))

;; .k
(add-to-list 'auto-mode-alist '("\\.k$" . k-mode))
(setq k-dash-comments 1) ;; See "--" as the beginning of a single line comment


;;; End Loads ;;;


;;; Mode configurations ;;;

(add-hook 'find-file-hooks 'linum-off)     ; linum off when a file is opened
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")
(setq uniquify-buffer-name-style 'reverse)
(setq ido-enable-flex-matching t)
(ido-everywhere t)

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
(tool-bar-mode -1)                              ;; Remove the entirely useless tool-bar
;;(menu-bar-mode -1)                              ;; Hide menu
(menu-bar-mode 1)                               ;; Show menu
(show-paren-mode 1)                             ;; Show Paren-matching
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
(setq-default c-basic-offset 4 tab-width 4 indent-tabs-mode nil)
(add-hook 'text-mode-hook 'flyspell-mode)        ;; Auto-flyspell for text mode
(add-to-list 'backup-directory-alist             ;; Move all those NAME~ files to ~/.backups
             '("." . "~/.backups/"))

; Auto-delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; Smart tab
(require 'smart-tab)

; Auto-fill comments
(add-hook 'c-mode-common-hook
          (lambda ()
            (auto-fill-mode 1)
            (set (make-local-variable 'fill-nobreak-predicate)
                 (lambda ()
                   (not (eq (get-text-property (point) 'face)
                            'font-lock-comment-face))))))
(add-hook 'find-file-hook (lambda() (setq fill-column 80)))

; hs-minor-mode
(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; Make tags be case sensitive
(setq tags-case-fold-search nil)

;; Have gdb use many windows
(setq gdb-many-windows t)

;; Have watched expressions raise the speedbar when they change
(setq gdb-speedbar-auto-raise t)

;; Have speedbar recognize fragment and vertex shaders
(speedbar-add-supported-extension ".frag")
(speedbar-add-supported-extension ".vert")

(setq dabbrev-case-fold-search t)       ;; Have M-/ be case sensitive

(setq ediff-split-window-function 'split-window-horizontally) ;; Have Ediff split down the middle by default
(setq ediff-auto-refine 1)
(setq-default ediff-auto-refine 1)
(setq ediff-auto-refine-limit 1048576)

;; Have ibuffer know about LunarGLASS directories
(require 'ibuffer)
(setq ibuffer-saved-filter-groups
  (quote (("default"
            ("TAGS"
              (filename . "TAGS"))
            ("LLVM"
              (filename . "/LunarGLASS/Core/LLVM"))
            ("LunarGLASS Core"
              (filename . "/LunarGLASS/Core/"))
            ("mesa"
              (filename . "/LunarGLASS/mesa/"))
            ("LunarGLASS misc"
              (filename . "/LunarGLASS/"))
            ("Kiwi"
              (filename . "/Kiwi/"))
            ))))

;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000000) (format "%6.1fM" (/ (buffer-size) 1000000.0)))
   ((> (buffer-size) 1000) (format "%6dk" (/ (buffer-size) 1000.0)))
   (t (format "%6d" (buffer-size)))))

;; Modify the default ibuffer-formats
(setq ibuffer-formats
      '((mark modified read-only " "
              (name 18 18 :left :elide)
              " "
              (size-h 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              filename-and-process)))

(add-hook 'ibuffer-mode-hook
  (lambda ()
    (ibuffer-switch-to-saved-filter-groups "default")))

;; Choose hl-line-mode
;;(global-hl-line-mode)
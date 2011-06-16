;;;Key shortcuts
(global-set-key "\C-o" 'find-file)
(global-set-key "\M-o" 'find-file-other-window)
(global-set-key "\C-z" 'switch-to-buffer)
;(global-set-key "\M-z" 'switch-to-buffer-other-window)
(global-set-key "\M-z"   'zap-up-to-char)               ;; I like better than zap-to-char
(global-set-key "\M-i" 'help)
(global-set-key (kbd "C-.") 'kmacro-end-and-call-macro) ;; Cx-e
(global-set-key "\C-v" 'other-window)
;;(global-set-key "\M-v" 'delete-other-windows)
;(global-set-key "\M-\C-i" 'delete-window)
(global-set-key "\M-m" 'open-line)
(global-set-key "\C-h"   'backward-delete-char)         ;; I like terminal style backspace
(global-set-key "\M-h"   'backward-kill-word)

(global-set-key "\M-,"   'icy-mode) ;; Toggle icy-mode. I like icy-mode for tag searches, but nothing else

(global-set-key (kbd "C-x C-b") 'ibuffer) ;; ibuffer is awesome

;(global-set-key "\C-cz"  'zsh)
;(global-set-key "\C-ce"  'eshell)
;(global-set-key "\C-z"   'vip-mode)                    ;; Easy switching to Vi mode
(global-set-key "\M-g"   'goto-line)
(global-set-key "\C-cl"  'linum-mode)
;(global-set-key "\C-cw"  'kill-region)                 ;; Replaces C-w
(global-set-key "\C-cm"  'menu-bar-mode)                ;; Sometimes the menu is useful
(global-set-key "\C-cb"  'revert-buffer)                ;; Occasionally used frequently
(global-set-key "\C-cr"  'comment-region)               ;; A must
(global-set-key "\C-ch"  'help)
(global-set-key "\C-ca"  'align-regexp)                 ;; Very useful, does column aligning (e.g. ;; in this file)

(global-set-key "\C-cn"  'hs-toggle-hiding)                 ;; Toggle hide/show for hs-minor-mode


(global-set-key "\C-cu"  'uncomment-region)             ;; Likewise
;(global-set-key "\C-cs"  'spacey-parenthesis)           ;; Likewise
(global-set-key "\C-cs"  'svn-status)

;(global-set-key "\C-w"  'backward-kill-word)           ;; Uncomment for terminal style words
;(global-set-key "\M-C-h" 'backward-kill-word)
;(global-set-key "\C-cv"  'vip-change-mode-to-vi)
(global-set-key "\C-cd"  'delete-trailing-whitespace)

(global-set-key "\C-ci"  (lambda () (interactive) (point-to-register 0)))
(global-set-key "\C-ce"  (lambda () (interactive) (jump-to-register 0)))


(global-set-key "\M-n" 'scroll-up-1-line)
(global-set-key "\M-p" 'scroll-down-1-line)

(global-set-key [(control down)] 'scroll-up)
                                                        ;;(global-set-key "\C-9" 'scroll-up)
(global-set-key [(control up)] 'scroll-down)


(global-set-key [(meta down)] 'end-of-buffer)
(global-set-key [(meta up)] 'beginning-of-buffer)

(define-key global-map (kbd "C-;") 'iedit-mode)         ;; Pretty cool, replace all at once

(global-set-key (kbd "C-=")
  (lambda ()
    (interactive)
    (set-default-font "-xos4-terminus-medium-r-normal--14-140-72-72-c-80-iso10646-1")))


;; Increment the number at the point
(global-set-key (kbd "C-c +") 'increment-number-at-point)

;; Complete symbol
(global-set-key [C-tab] 'complete-symbol)

;; Below key choice might be incompatible with undo-tree
;;(global-set-key (kbd "C-?") 'toggle-case-fold-search)

;; Have F1 toggle refinement in EDiff
(global-set-key [f1] 'ediff-toggle-autorefine)


(add-hook 'ediff-keymap-setup-hook (lambda () (interactive) (define-key ediff-mode-map "f" 'ediff-make-or-kill-fine-diffs)))

;; Use C-` to step through matches (e.g. for grep, or compilations)
(global-set-key (kbd "C-`") 'next-error)

;; LunarGLASS bindings
(global-set-key [f5] 'build-lunarglass)
(global-set-key [f6] 'debug-lunarglass)
(global-set-key [f7] 'run-lunarglass)
(global-set-key [f8] 'run-lunarglass-ndbg)

(global-set-key [f9] 'grep-project)
(global-set-key [f10] 'grep-gla)
(global-set-key [f11] 'occur)

;; TODO: keybinds for
;; C-x r w R : Save the window config into register R. C-x r j R to get back to it. Useful to store the current buffer and get back to it later
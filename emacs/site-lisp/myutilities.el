(defun spacey-parenthesis ()
  "Go through and add spaces before and after parenthesis, to make some stuff
pretty. May have to run a couple of times for parens that are right next to each
other"
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    (query-replace-regexp "(\\([^ \*\n(]\\)" "( \\1")
    (beginning-of-buffer)
    (query-replace-regexp "\\([^ \*\n)]\\))" "\\1 )")
    (beginning-of-buffer)
    (query-replace-regexp ",\\([^ \n]\\)" ", \\1")
    (beginning-of-buffer)
    (query-replace-regexp "( (" "((")
    (beginning-of-buffer)
    (query-replace-regexp "( (" "((")
    (beginning-of-buffer)
    (query-replace-regexp ") )" "))")
    (beginning-of-buffer)
    (query-replace-regexp ") )" "))")
    ))

;; Variation of `zap-to-char'.

(defun zap-up-to-char (arg char)
  "Kill up to, but not including ARG'th occurrence of CHAR.
Case is ignored if `case-fold-search' is non-nil in the current buffer.
Goes backward if ARG is negative; error if CHAR not found.
Ignores CHAR at point."
  (interactive "p\ncZap up to char: ")
  (let ((direction (if (>= arg 0) 1 -1)))
    (kill-region (point)
		 (progn
		   (forward-char direction)
		   (unwind-protect
		       (search-forward (char-to-string char) nil nil arg)
		     (backward-char direction))
		   (point)))))

(defun zsh ()
  (interactive)
  (term "/bin/zsh"))

(defun scroll-up-1-line nil
  (interactive)
  (scroll-up 1))

(defun scroll-down-1-line nil
  (interactive)
  (scroll-down 1))

(defun word-count nil "Count words in buffer" (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))

(defun linum-off ()
  (unless (minibufferp)
    (linum-mode 0)))

(defun align-repeat (start end regexp)
  "Repeat alignment with respect to
   the given regular expression."
  (interactive "r\nsAlign regexp: ")
  (align-regexp start end
      (concat "\\(\\s-*\\)" regexp) 1 1 t))

(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

;; emacs-fu's remember-mode frame
(defun djcb-remember-frame ()
  "turn the current frame into a small popup frame for remember mode;
this is meant to be called with
     emacsclient -c -e '(djcb-remember-frame)'"
  (modify-frame-parameters nil
    '( (name . "*Remember*") ;; must be same as in mode-hook below
       (width .  80)
       (height . 10)
       (vertical-scroll-bars . nil)
       (menu-bar-lines . nil)
       (tool-bar-lines . nil)))
  (org-remember)
  (when (fboundp 'x-focus-frame) (x-focus-frame nil)) ;; X only....

  (delete-other-windows))

;; Semantic utilities from the CEDET mailing list
(defvar semantic-tags-location-ring (make-ring 20))

(defun semantic-goto-definition (point)
  "Goto definition using semantic-ia-fast-jump save the pointer
marker if tag is found"
  (interactive "d")
  (condition-case err
      (progn
        (ring-insert semantic-tags-location-ring (point-marker))
        (semantic-ia-fast-jump point))
    (error
     ;;if not found remove the tag saved in the ring
     (set-marker (ring-remove semantic-tags-location-ring 0) nil nil)
     (signal (car err) (cdr err)))))

(defun semantic-pop-tag-mark ()
  "popup the tag save by semantic-goto-definition"
  (interactive)
  (if (ring-empty-p semantic-tags-location-ring)
      (message "%s" "No more tags available")
    (let* ((marker (ring-remove semantic-tags-location-ring 0))
              (buff (marker-buffer marker))
                 (pos (marker-position marker)))
      (if (not buff)
            (message "Buffer has been deleted")
        (switch-to-buffer buff)
        (goto-char pos))
      (set-marker marker nil nil))))


;; Build LunarGLASS
(defun build-lunarglass ()
  (interactive)
  (compile "cd ~/LunarGLASS/Standalone ; make"))

;; Debug lunarglass macro
(fset 'debug-lunarglass
   [?\M-x ?g ?d ?b return ?\C-a ?\M-f ?\M-f ?\M-f ?\C-k ? ?~ ?/ ?L ?u ?n ?a ?r ?G ?L ?A ?S ?S ?/ ?S ?t ?a ?n ?d ?a ?l ?o ?n ?e ?/ ?S ?t ?a ?n ?d ?A ?l ?o ?n ?e return])

;; Run a LunarGLASS test
(defun run-lunarglass (testpath)
  (interactive (list (read-from-minibuffer "Test case: " nil nil nil 'run-lg-history)))
  (shell-command (concat (concat "~/LunarGLASS/Standalone/StandAlone -d " (concat "~/LunarGLASS/test/" testpath)) ".frag")))

;; Run a LunarGLASS test (do debug)
(defun run-lunarglass-ndbg (testpath)
  (interactive (list (read-from-minibuffer "Test case: " nil nil nil 'run-lg-history)))
  (shell-command (concat (concat "~/LunarGLASS/Standalone/StandAlone " (concat "~/LunarGLASS/test/" testpath)) ".frag")))


(defun grep-project (regex)
  (interactive "sSearch project using regex: ")
  (rgrep regex "*.cpp *.h *.inc" "~/LunarGLASS/"))

(defun grep-gla (regex)
  (interactive "sSearch LunarGLASS Core using regex: ")
  (rgrep regex "*.cpp *.h *.inc" "~/LunarGLASS/Core/"))

(defun grep-llvm (regex)
  (interactive "sSearch LLVM using regex: ")
  (rgrep regex "*.cpp *.h *.inc" "~/LunarGLASS/Core/LLVM/"))



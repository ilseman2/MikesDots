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
  (rgrep regex "*.cpp *.h" "~/LunarGLASS/"))

(defun grep-gla (regex)
  (interactive "sSearch LunarGLASS Core using regex: ")
  (rgrep regex "*.cpp *.h" "~/LunarGLASS/Core/"))

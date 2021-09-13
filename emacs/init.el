;;;; emacs init.el

; Swap super and meta(alt) keys
; https://stackoverflow.com/questions/18970977/user-super-key-for-meta-commands-in-emacs
(setq x-meta-keysym 'super
  x-super-keysym 'meta)

; Set font size
; https://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 180)

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
    (format "%.2f seconds"
      (float-time
        (time-subtract after-init-time before-init-time)))
          gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

; Disable menu-bar, tool-bar, and scroll-bar.
(if (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

; Disable startup screen
(setq inhibit-startup-screen t)

; Line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

; Disable bell sound
(setq ring-bell-function 'ignore)
; Line-style cursor similar to other text editors
(setq-default cursor-type 'bar)
; Auto-update buffer if file has changed on disk
(global-auto-revert-mode t)
; Make *scratch* buffer blank
(setq initial-scratch-message "")
; Make window title the buffer name
(setq-default frame-title-format '("%b"))
; y-or-n-p makes answering questions faster
(fset 'yes-or-no-p 'y-or-n-p)
; Show closing parens by default
(show-paren-mode 1)
; Line number format
(setq linum-format "%4d ")
; Selected text will be overwritten when you start typing
(delete-selection-mode 1)
; Lockfiles unfortunately cause more pain than benefit
(setq create-lockfiles nil)
; Disable saving history mode
(savehist-mode -1)
; Set the temporary-file-directory as the backup directory
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))

;;; Keybindings
; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

; Gives right-click a context menu
(global-set-key [mouse-3] 'mouse-popup-menubar-stuff)

; Indent and De-indent  selection by one tab length
(global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop)
(global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop)
;;; End Keybindings

;;; START TABS CONFIG
;; Create a variable for our preferred tab width
(setq custom-tab-width 2)

;; Two callable functions for enabling/disabling tabs in Emacs
(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

;; Hooks to Enable Tabs
(add-hook 'prog-mode-hook 'enable-tabs)
;; Hooks to Disable Tabs
(add-hook 'lisp-mode-hook 'disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'disable-tabs)

;; Language-Specific Tweaks
(setq-default python-indent-offset custom-tab-width) ; Python
(setq-default js-indent-level custom-tab-width) ; Javascript

;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)

;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)

;; (OPTIONAL) Shift width for evil-mode users
;; For the vim-like motions of ">>" and "<<".
(setq-default evil-shift-width custom-tab-width)

;; WARNING: This will change your life
;; (OPTIONAL) Visualize tabs as a pipe character - "|"
;; This will also show trailing characters as they are useful to spot.
(setq whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
  '(whitespace-tab ((t (:foreground "#636363")))))
(setq whitespace-display-mappings
  '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
(global-whitespace-mode) ; Enable whitespace mode everywhere
;;; END TABS CONFIG

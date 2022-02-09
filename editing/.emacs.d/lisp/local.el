;; * TODO move to main config
(gsetq mac-option-modifier 'meta)

;; * Initial Width/Height
;; Set default window size
(general-after-gui
  (cl-pushnew '(width . 265) default-frame-alist
              :key #'car)
  (cl-pushnew '(height . 80) default-frame-alist
              :key #'car))

;; * Org
;; TODO temporary until have pushed full org config to main dotfiles
(setq org-descriptive-links nil
      org-src-preserve-indentation t)

;; * Python
;; allows evaling things with absolute imports even when shell starts in subdirectory
(defvar user2053036-python-shell-dir-setup-code
  "import os
home = os.path.expanduser('~')
while os.path.isfile('__init__.py') and (os.getcwd() != home):
    os.chdir('..')
del os")

;; TODO sys.path.append('..') all the way to dir above top module

(defun user2053036-python-shell-dir-setup ()
  (let ((process (get-buffer-process (current-buffer))))
    (python-shell-send-string user2053036-python-shell-dir-setup-code process)))

(general-add-hook 'inferior-python-mode-hook 'user2053036-python-shell-dir-setup)

;; TODO importmagic
;; NOTE microsoft python server's import action usually works
;; (use-package pyimport)

;; since python 3 is python3 not python on OSX
(setq flycheck-python-flake8-executable "python3"
      flycheck-python-pylint-executable "python3")

;; bind `dap-debug'
;; (use-package dap-mode
;;   :config
;;   (dap-mode 1)
;;   (dap-ui-mode 1)
;;   ;; enables mouse hover support
;;   (dap-tooltip-mode 1)
;;   (require 'dap-python))

;; (use-package conda)

;; (use-package lsp-python-ms
;;   :init
;;   (general-after 'python-mode
;;     (require 'lsp-python-ms))
;;   :config
;;   (general-pushnew 'pyls lsp-disabled-clients)
;;   (gsetq lsp-python-ms-python-executable-cmd "python3"
;;          ;; use existing linting tools
;;          lsp-python-ms-warnings []
;;          lsp-python-ms-errors []))

;; * Targets
;; for seeing old code
(use-package targets
  :straight (targets
             :type git
             :host github
             :repo "noctuid/targets.el"))

;; * Project Specific
;; preseed file
(use-package conf-mode
  :straight nil
  :mode "\\.seed\\'")

;; * Other
(let ((local-unclean-file (expand-file-name "lisp/local-unclean.el"
                                            user-emacs-directory)))
  (when (file-exists-p local-unclean-file)
    (load-file local-unclean-file)))

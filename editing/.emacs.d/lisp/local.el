;; * Font Size
;; needs to be different/~double on macOS (probably due to scaling)
(general-with 'textsize
  (gsetq textsize-default-points 20))

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

;; * Quickmarks
(general-after-init
  (general-after 'dired
    (general-def 'normal dired-mode-map
      :prefix "'"
      "V" (noct-find-file "/Volumes/"))))

;; * Other
(setq browse-url-generic-program "firefox")

(let ((local-unclean-file (expand-file-name "lisp/local-unclean.el"
                                            user-emacs-directory)))
  (when (file-exists-p local-unclean-file)
    (load-file local-unclean-file)))

;; what is lsp-dired-mode?
;; consult lsp?
;; ind lsp-iedit-linked-ranges or lsp-evil-multiedit-ranges

;; https://github.com/remarkjs/remark-language-server
;; https://github.com/tamasfe/taplo
;; https://emacs-lsp.github.io/lsp-mode/page/lsp-json/
;; https://github.com/valentjn/ltex-ls for org, latex, text (grammar/spelling)
;; https://emacs-lsp.github.io/lsp-mode/page/lsp-pwsh/

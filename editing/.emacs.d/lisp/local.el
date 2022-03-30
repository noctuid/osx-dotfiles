;; * TODO move to main config
;; TODO in main configuration, remove on next pull
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

;; * Quickmarks
(general-after-init
  (general-after 'dired
    (general-def 'normal dired-mode-map
      :prefix "'"
      "V" (noct-find-file "/Volumes/")
      "v" (noct-find-file "~/src/jabberwocky/vertexhmi/")
      "b" (noct-find-file "~/src/jabberwocky/vertexhmi/backend/")
      "u" (noct-find-file "~/src/jabberwocky/vertexhmi/ubuntu-installer/")
      "j" (noct-find-file "~/src/jabberwocky/vertexhmi/vertexjs/")
      "r" (noct-find-file "~/src/jabberwocky/vertex-refresh/chemcam/"))))

;; * Other
(let ((local-unclean-file (expand-file-name "lisp/local-unclean.el"
                                            user-emacs-directory)))
  (when (file-exists-p local-unclean-file)
    (load-file local-unclean-file)))

;; * Messing with alternate F
;; experimental
(general-def 'motion
  "f" #'evil-avy-goto-word-1)

;; * Update Path
;; TODO in main configuration, remove on next pull
(use-package exec-path-from-shell
  ;; TODO decide how to load
  :defer 3
  :config
  ;; make `exec-path' match shell path in GUI Emacs
  ;; e.g. so poetry in path
  (when (memq window-system '(mac ns x))
    (gsetq exec-path-from-shell-shell-name "bash")
    (gsetq exec-path-from-shell-arguments '("-l"))
    ;; takes about 0.1s
    (exec-path-from-shell-initialize)))


;; what is lsp-dired-mode?
;; consult lsp?
;; ind lsp-iedit-linked-ranges or lsp-evil-multiedit-ranges

;; https://github.com/remarkjs/remark-language-server
;; https://github.com/tamasfe/taplo
;; https://emacs-lsp.github.io/lsp-mode/page/lsp-json/
;; https://github.com/valentjn/ltex-ls for org, latex, text (grammar/spelling)
;; https://emacs-lsp.github.io/lsp-mode/page/lsp-pwsh/

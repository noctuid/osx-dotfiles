;; temporary fix for issue with HEAD (fixed but I haven't pulled/reinstalled)
(load "custom")

;; * env variables
;; TODO because running emacs server with launchtl, env variables not the
;; same...; this doesn't fix
;; (setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))

;; * Initial Width/Height
;; Set default window size
(noct:after-gui
  (cl-pushnew '(width . 250) default-frame-alist
              :key #'car)
  (cl-pushnew '(height . 65) default-frame-alist
              :key #'car))

;; * Org
;; TODO temporary until have pushed full org config to main dotfiles
(setq org-descriptive-links nil
      org-src-preserve-indentation t)

;; * Docker
(use-package dockerfile-mode)

;; * JavasScript, TypeScript, Web
(use-package typescript-mode
  :gfhook #'lsp
  :config
  (gsetq typescript-indent-level 2))

(use-package prettier-js
  ;; :gfhook (nil (lambda () (aggressive-indent-mode -1)))
  )

(defun noct:maybe-enable-prettier ()
  "Enable prettier in [jt]sx? file."
  (when (and buffer-file-name
             (string-match
              (rx (or (seq buffer-start
                           (or "j" "t") "s" (opt "x")
                           buffer-end)))
              buffer-file-name))
    (aggressive-indent-mode -1)
    (prettier-js-mode)))

(use-package web-mode
  ;; web-mode gives better syntax highlighting than just typescript-mode
  :mode ("\\.[tj]sx?\\'" . web-mode)
  ;; :gfhook (lambda ()
  ;;           (when (string-equal "tsx" (file-name-extension buffer-file-name))
  ;;             (setup-tide-mode)))
  :gfhook
  #'lsp
  #'noct:maybe-enable-prettier
  :config
  (setq web-mode-code-indent-offset 2))

(with-eval-after-load 'flycheck
  ;; enable typescript-tslint checker
  (flycheck-add-mode 'typescript-tslint 'web-mode))

;; ** Eslint
;; make use .gitignore mode

;; * JSON
(use-package json-mode
  :gfhook (nil (lambda () (setq-local js-indent-level 2))))

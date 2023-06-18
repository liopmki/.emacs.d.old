;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)

;; company
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

;; embark
(global-set-key (kbd "C-'") 'embark-act) ; 触发 action

;; consult
(global-set-key (kbd "C-s") 'consult-line)
(global-set-key (kbd "C-x b") 'consult-buffer)

;; embark-consult
(defun embark-export-write ()
  (interactive)
  (require 'embark)
  (require 'wgrep)
  (pcase-let ((`(,type . ,candidates)
	       (run-hook-with-args-until-success 'embark-candidate-collectors)))
    (pcase type
      ('consult-grep (let ((embark-after-export-hook #'wgrep-change-to-wgrep-mode))
		       (embark-export)))
      ('file (let ((embark-after-export-hook #'wdired-change-to-wdired-mode))
	       (embark-export)))
      ('consult-location (let ((embark-after-export-hook #'occur-edit-mode))
			   (embark-export)))
      (x (user-error "Embark category %S doesn't support writable export" x)))))
(define-key minibuffer-local-map (kbd "C-c C-e") 'embark-export-write)

(provide 'init-keybindings)

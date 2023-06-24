;; company 补全
(use-package company
  :bind (:map company-active-map
	      ("C-n" . 'company-select-next)
	      ("C-p" . 'company-select-previous))
  :init
  (global-company-mode t)
  :config
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0))

;; vertico mini buffer 补全
(package-install 'vertico)
(vertico-mode t)

;; orderless mini buffer 的命令是模糊搜索的
(package-install 'orderless)
(setq completion-styles '(orderless))

;; marginalia 显示命令的信息 文件的信息
(package-install 'marginalia)
(marginalia-mode t)

;; embark  触发对变量的action
(package-install 'embark)

(setq prefix-help-command 'embark-prefix-help-command) ; 会显示快捷键

;; consult 搜索增强
(package-install 'consult)

;; embark-consult 批量搜索替换
(package-install 'embark-consult)
(package-install 'wgrep)  ;; wgrep
(setq wgrep-auto-save-buffer t)
(eval-after-load 'consult
  '(eval-after-load 'embark
     '(progn
	(require 'embark-consult)
	(add-hook
	 'embark-collect-mode-hook
	 #'consult-preview-at-point-mode))))


;; Valign Org-mode 表格对齐
(package-install 'valign)
(add-hook 'org-mode-hook #'valign-mode)

(provide 'init-plugins)

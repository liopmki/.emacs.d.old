;; init.el

;; [[ Init Packages Manager ]]
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))
;; [ end init package ]

;; Install use-package
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))
;; [[ END ]]

;; [[ Options ]]
(global-linum-mode 1) ;; 开启全局行号
(setq inhibit-startup-screen t) ;; 关闭欢迎界面
(setq tab-always-indent 'complete) ;; 当输入内置的变量时，tab会补全
;(icomplete-mode t) ;; minibuffer 会补全
(electric-pair-mode t) ;; 括号补全
;; (toggle-frame-maximized) ;; 启动最大化
(tool-bar-mode -1) ;; 关闭工具栏
(scroll-bar-mode -1) ;; 关闭滑动条
(setq-default cursor-type '(bar . 3)) ;; 设置光标样式
(show-paren-mode t) ;; 显示括号匹配
(setq make-backup-files nil) ;; 关闭备份文件
(global-auto-revert-mode 1) ;; 自动加载外部修改过的文件
(setq auto-save-default nil) ;; 关闭自动保存的文件
(setq ring-bell-function 'ignore) ;; 关闭Emacs的警告音
(fset 'yes-or-no-p 'y-or-n-p) ;; 将(yes-or-no-p)修改成(y-or-n-p)
;; recent file
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)
;; recent file end
(delete-selection-mode 1) ;; 优化删除，当选中一些内容时，输入会直接更新这些内容
;; 优化鼠标滚轮
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)
(global-hl-line-mode 1) ;; 高亮当前行
;; [[ appearence ]]
;; [ font ]
(add-to-list 'default-frame-alist '(font . "LXGW WenKai Mono-14" ))
(set-face-attribute 'default t :font "LXGW WenKai Mono-14") ;; font size
;; 设置文件的默认编码
(set-language-environment "UTF-8")
;(set-locale-environment "en_US.UTF-8")
					;(setq system-time-locale "C")  ;; 这个是为了在 org mode 中用英文显示日期，默认是中文
(setq scroll-conservatively 101 scroll-margin 8) ;; 设置 scrolloff 为 8
;; [[ END ]]

;; [[ UI ]]
(use-package dracula-theme
  :init
  (load-theme 'dracula t))
;; [[ END ]]

;; [[ Packages ]]
;; [ company ]
(use-package company
  :ensure t
  :bind (:map company-active-map
	      ("C-n" . 'company-select-next)
	      ("C-p" . 'company-select-previous))
  :init
  (global-company-mode t)
  :config
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0))

;; [ vertico ]
(use-package vertico
  :ensure t
  :init
  (vertico-mode t))

;; [ orderless ]
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless)))

;; [ marginalia ]
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

;; [ embark ]
(use-package embark
  :ensure t
  :bind(
	("C-'" . embark-act))
  :init
  (setq prefix-help-command 'embark-prefix-help-command)
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; [ consult ]
(use-package consult
  :ensure t
  :bind(
	("C-s" . consult-line)
	("C-x b" . consult-buffer)))

;; [ embark-consult ]
(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; [ wgrep ]
(use-package wgrep
  :ensure t
  :config
  (setq wgrep-auto-save-buffer t))

;; [ valign ]
(use-package valign
  :ensure t
  :hook
  (org-mode . valign-mode))

;; [[ END ]]

;; [[ Custom Functions and Keybindings]]
;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)

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
;; [[ END ]]

;; [[ 手动安装的插件 ]]
(add-to-list 'load-path (expand-file-name "/home/yang/.emacs.d/elisp/plugins-manually"))
(require 'awesome-tab)
(awesome-tab-mode t)
;; (use-package awesome-tab
;;   :load-path "/elisp/plugins-manually"
;;   :init
;;   (awesome-tab-mode t))
;; [[ END ]]

;; Emacs 自动生成的customize-variables
(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
(load custom-file 'no-error 'no-message)

;; init.el end


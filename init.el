;;; -*- lexical-binding: t -*-
;; init.el

;; [[ global keybindings ]]
;;(global-set-key (kbd "s-a") 'mark-whole-buffer) ;; super-a 全选
;;(global-set-key (kbd "s-c") 'kill-ring-save) ;; super-c 复制
;;(global-set-key (kbd "s-s") 'save-buffer) ;; super-s 保存
;;(global-set-key (kbd "s-v") 'yank) ;; super-v 粘贴
;;(global-set-key (kbd "s-z") 'undo) ;; super-z 撤销
;;(global-set-key (kbd "s-x") 'kill-region) ;; super-x 剪切

;; [[ options ]]
(global-linum-mode 1) ;; 开启全局行号
(setq inhibit-startup-screen t) ;; 关闭欢迎界面
(setq tab-always-indent 'complete) ;; 当输入内置的变量时，tab会补全
;(icomplete-mode t) ;; minibuffer 会补全
(electric-pair-mode t) ;; 括号补全
;; (toggle-frame-maximized) ;; 启动最大化
(tool-bar-mode -1) ;; 关闭工具栏
(scroll-bar-mode -1) ;; 关闭滑动条
(setq cursor-type '(bar . 3)) ;; 设置光标样式
;; 优化鼠标滚轮
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; [[ appearence ]]
;; [ font ]
(add-to-list 'default-frame-alist '(font . "LXGW WenKai Mono-14" ))
(set-face-attribute 'default t :font "LXGW WenKai Mono-14") ;; font size

;; [[ custom function ]]
;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)

;; [[ Plugins ]]
;; [ init package ]
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))
;; [ end init package ]

;; company 补全
(package-install 'company)
(global-company-mode 1)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

;; keycast 显示按键和执行的命令 不能使用
;;(package-install 'keycast)
;;(keycast-mode t)

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
(global-set-key (kbd "C-'") 'embark-act) ; 触发 action
(setq prefix-help-command 'embark-prefix-help-command) ; 会显示快捷键

;; consult 搜索增强
(package-install 'consult)
(global-set-key (kbd "C-s") 'consult-line)

;; Valign Org-mode 表格对齐
(package-install 'valign)
(add-hook 'org-mode-hook #'valign-mode)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company consult valign vertico orderless marginalia embark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

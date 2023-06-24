;;; -*- lexical-binding: t -*-
;; init.el

(add-to-list 'load-path "~/.emacs.d/elisp/")
(add-to-list 'load-path "~/.emacs.d/elisp/plugins-manually/")
(require 'init-packages)  ;; [ 初始化包管理器 ]
(require 'options) ;; [ Options ]
(require 'init-theme) ;; [ Theme ]
(require 'init-plugins) ;; [ Plugins ]
(require 'init-keybindings)  ;; [ Keybindings ]
(require 'init-plugins-manually)  ;; [ 手动安装的插件 ]

;; Emacs 自动生成的customize-variables
(setq custom-file (expand-file-name "~/.emacs.d/elisp/custom.el"))
(load custom-file 'no-error 'no-message)

;; init.el end


;; [ init package ]
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))
;; [ end init package ]

;; Install use-package
(package-install 'use-package)

(provide 'init-packages)

;; end init-packages

(setq inhibit-startup-message t)

(tool-bar-mode -1)

(menu-bar-mode -1)

(scroll-bar-menu -1)

(global-hl-line-mode +1)

(delete-selection-mode 1)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(show-paren-mode 1)

(setq doom-theme 'doom-horizon)
(map! :leader
      :desc "Load a new theme"
      "h t" #'councel-load-theme)

(setq doom-font                 (font-spec :family "Source Code Pro" :size 14)
      doom-variable-pitch-font  (font-spec :family "Source Code Pro" :size 15)
      doom-unicode-font         (font-spec :family "Source Code Pro" :size 14)
      doom-big-font             (font-spec :family "Source Code Pro" :size 24)
      )
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face      :slant italic)
  '(font-lock-keyword-face      :slant italic))

(use-package all-the-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))

(setq +ivy-buffer-preview t)

(when-let (dims (doom-store-get 'last-frame-size))
  (cl-destructuring-bind ((left . top) width height fullscreen) dims
    (setq initial-frame-alist
          (append initial-frame-alist
                  `((left . ,left)
                    (top . ,top)
                    (width . ,width)
                    (height . ,height)
                    (fullscreen . ,fullscreen))))))

(defun save-frame-dimensions ()
  (doom-store-put 'last-frame-size
                  (list (frame-position)
                        (frame-width)
                        (frame-height)
                        (frame-parameter nil 'fullscreen))))

(add-hook 'kill-emacs-hook #'save-frame-dimensions)

(use-package treemacs
  :ensure t
  :bind
  (:map global-map
   ([f8] . treemacs)
   ("C-<f8>" . treemacs-select-window))
  :config
  (setq treemacs-is-never-other-window t))

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

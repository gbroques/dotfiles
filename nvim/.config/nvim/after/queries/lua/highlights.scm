;; extends

;; Highlight vim as builtin
;; See https://github.com/LazyVim/LazyVim/blob/v14.15.0/queries/lua/highlights.scm#L1-L4
((identifier) @namespace.builtin
  (#eq? @namespace.builtin "vim"))

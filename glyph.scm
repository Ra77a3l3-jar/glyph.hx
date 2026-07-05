(provide glyph-icon
         glyph-color)

(define DEFAULT-ICON "󰍔")
(define DEFAULT-COLOR "#6d8086")

(define *glyph-filename*
  (hash "Makefile" (cons "󱁤" "#6d8086")
        "makefile" (cons "󱁤" "#6d8086")
        "CMakeLists.txt" (cons "󱁤" "#6d8086")
        "README" (cons "" "#dddddd")
        "LICENSE" (cons "" "#d0bf41")))

(define *glyph-extension*
  (hash "rs" (cons "󱘗" "#dea584")
        "py" (cons "󰌠" "#ffbc03")
        "js" (cons "󰌞" "#cbcb41")
        "ts" (cons "󰛦" "#519aba")
        "go" (cons "󰟓" "#519aba")
        "c" (cons "󰙱" "#599eff")
        "h" (cons "󰫵" "#a074c4")
        "cpp" (cons "󰙲" "#519aba")
        "hpp" (cons "󰙲" "#a074c4")
        "cs" (cons "󰌛" "#596706")
        "java" (cons "󰬷" "#cc3e44")
        "html" (cons "󰌝" "#e44d26")
        "css" (cons "󰌜" "#42a5f5")
        "json" (cons "󰘦" "#cbcb41")
        "md" (cons "󰍔" "#dddddd")
        "yml" (cons "" "#6d8086")
        "yaml" (cons "" "#6d8086")
        "toml" (cons "" "#9c4221")
        "sh" (cons "" "#4d5a5e")
        "zig" (cons "" "#f69a1b")
        "scm" (cons "󰘧" "#eeeeee")
        "cmake" (cons "󱁤" "#6d8086")))

;; trim file type after .
(define (file-extension name)
  (let ([parts (split-many name ".")])
    (if (> (length parts) 1)
        (list-ref parts (- (length parts) 1))
        "")))

(define (lookup-entry name)
  (or (hash-try-get *glyph-filename* name)
      (hash-try-get *glyph-extension* (file-extension name))))

;; match icon to file type
(define (glyph-icon name)
  (let ([entry (lookup-entry name)])
    (if entry (car entry) DEFAULT-ICON)))

;; match color to file type
(define (glyph-color name)
  (let ([entry (lookup-entry name)])
    (if entry (cdr entry) DEFAULT-COLOR)))

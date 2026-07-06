(provide glyph-icon
         glyph-color
         glyph-dir-icon
         glyph-dir-color
         glyph-git-icon
         glyph-git-color)

(define DEFAULT-DIR-ICON "󰉋")
(define DEFAULT-DIR-COLOR "#3aa6e0")

(define DEFAULT-GIT-ICON "?")
(define DEFAULT-GIT-COLOR "#6d8086")

(define *glyph-git-status*
  (hash 'modified (cons "~" "#cbcb41")
        'added (cons "+" "#4caf50")
        'deleted (cons "-" "#e06c75")
        'renamed (cons "→" "#599eff")
        'untracked (cons "?" "#22d3ee")
        'ignored (cons "!" "#6d8086")))

(define (glyph-git-icon status)
  (let ([entry (hash-try-get *glyph-git-status* status)])
    (if entry (car entry) DEFAULT-GIT-ICON)))

(define (glyph-git-color status)
  (let ([entry (hash-try-get *glyph-git-status* status)])
    (if entry (cdr entry) DEFAULT-GIT-COLOR)))

(define *glyph-directory*
  (hash ".git" (cons "" "#f69a1b")
        ".github" (cons "" "#3aa6e0")
        ".config" (cons "󱁿" "#22d3ee")
        "node_modules" (cons "" "#4caf50")
        "src" (cons "󰴉" "#9d7cd8")
        "lib" (cons "󰲂" "#cbcb41")
        "test" (cons "󱞊" "#599eff")
        "tests" (cons "󱞊" "#599eff")
        "build" (cons "󱧼" "#6d8086")
        "Documents" (cons "󱧶" "#f69a1b")
        "Downloads" (cons "󰉍" "#f69a1b")
        "Desktop" (cons "󰚝" "#f69a1b")
        "Music" (cons "󱍙" "#f69a1b")
        "Pictures" (cons "󰉏" "#f69a1b")
        "Videos" (cons "󱞊" "#f69a1b")))

;; match directory name to icon
(define (glyph-dir-icon name)
  (let ([entry (hash-try-get *glyph-directory* (trim-end-matches name "/"))])
    (if entry (car entry) DEFAULT-DIR-ICON)))

(define (glyph-dir-color name)
  (let ([entry (hash-try-get *glyph-directory* (trim-end-matches name "/"))])
    (if entry (cdr entry) DEFAULT-DIR-COLOR)))

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

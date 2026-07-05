(provide glyph-icon
         glyph-color)

(define (file-extension name)
  (let ([parts (split-many name ".")])
    (if (> (length parts) 1)
        (list-ref parts (- (length parts) 1))
        "")))

(define (lookup-entry name)
  (or (hash-try-get *glyph-filename* name)
      (hash-try-get *glyph-extension* (file-extension name))))

(define (glyph-icon name)
  (let ([entry (lookup-entry name)])
    (if entry (car entry) DEFAULT-ICON)))

(define (glyph-color name)
  (let ([entry (lookup-entry name)])
    (if entry (palette-color (cdr entry)) DEFAULT-COLOR)))

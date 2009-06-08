; リストにある要素が含まれるか
(define (include? needle heystack)
  (if (null? heystack)
      #f
      (if (equal? needle (car heystack))
          #t
          (include? needle (cdr heystack))
          )
      )
  )

; 勝利判定
(define (win? player)
  (include? (sort player) '((1 2 3) (4 5 6) (7 8 9) (1 4 7) (2 5 8) (3 6 9) (1 5 9) (3 5 7)))
  )

(if (win? '(1 2 3))
    (print "win")
    (print "loose")
)


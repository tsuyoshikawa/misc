(use srfi-27)

(random-source-randomize! default-random-source)

;;リストにある要素が含まれるか
(define (include? needle heystack)
  (if (null? heystack)
      #f
      (if (equal? needle (car heystack))
          #t
          (include? needle (cdr heystack))
          )
      )
  )

;;リストのサイズを調べる
(define (size-of list)
  (fold (lambda (a b) (+ b 1)) 0 list)
  )

;;再帰バージョン
(define (size-of list)
  (if (null? list)
      0
      (+ 1 (size-of (cdr list)))
      )
  )

(print (size-of '(1 2 3 4 5))) ;=> 5

;;n番目の要素を取り出す
(define (value-at list n)
  (if (or (null? list) (< n 0) (< (size-of list) n))
      '()
      (if (equal? n 1)
          (car list)
          (value-at (cdr list) (- n 1))
          )
      )
  )

(print (value-at '(1 2 6 9) 4)) ;=> 9

;;要素の追加(空リストなら無視され、アトムなら連結してリストにされる)
(define (force-merge from to)
  (if (and (pair? from) (pair? to))
      (cons (car from) (force-merge (cdr from) to))
      (if (null? from)
          to
          (if (pair? to)
              (cons from to)
              (list from to)
              )
          )
      )
  )

(print (force-merge 1 3)) ;=> (1 3)
(print (force-merge '(1 3) 5)) ;=> (1 3)
(print (force-merge 1 '(3 4))) ;=> (1 3 4)
(print (force-merge '() '(3 4))) ;=> (3 4)
(print (force-merge '(1 2) '(3 4))) ;=> (1 2 3 4)

;;要素の削除
(define (delete-at list n)
  )

;;リストからランダムに一つ取り出す
(define (random-one list)
  (value-at list (+ 1 (random-integer (- (size-of list) 1))))
  )

(print (random-one '(10 20 30 40 50)))
(print (random-one '(10 20 30 40 50)))
(print (random-one '(10 20 30 40 50)))



;;勝利判定
(define (win? player)
  (include? (sort player) '((1 2 3) (4 5 6) (7 8 9) (1 4 7) (2 5 8) (3 6 9) (1 5 9) (3 5 7)))
  )

(if (win? '(1 2 3))
    (print "win")
    (print "loose")
    ) ;=>"win"

#;;盤から一つ番号を選ぶ
(define (choice player board)
  (begin (push player choiced) (delete board choice))
  )


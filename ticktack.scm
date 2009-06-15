(use srfi-27)

;;乱数の種リセット
(random-source-randomize! default-random-source)

;;リストにある要素が含まれるか #t/#f
(define (include? needle heystack)
  (if (null? heystack)
      #f
      (if (equal? needle (car heystack))
	  #t
	  (include? needle (cdr heystack))
	  )
      )
  )

;;リストのサイズを測る
(define (size-of lis)
  (if (null? lis)
      0
      (+ 1 (size-of (cdr lis)))
      )
  )

(print (size-of '(1 2 3 4 5))) ;=> 5

;;n番目の要素を取り出す
(define (value-at lis n)
  (if (or (null? lis) (< n 0) (< (size-of lis) n))
      '()
      (if (equal? n 1)
	  (car lis)
	  (value-at (cdr lis) (- n 1))
	  )
      )
  )

(print (value-at '(1 2 6 9) 4)) ;=> 9

;;１リストに１リストを付け加える
(define (my-append a b)
  (if (pair? a)
      (cons (car a) (my-append (cdr a) b))
      b
      )
  )

(print (my-append '(1 2 3) '(4 5 6))) ;=> (1 2 3 4 5 6)

;;必ず平らなリストにして返す
(define (flatten lis)
  (if (null? lis)
      '()
      (if (pair? lis)
	  (my-append (flatten (car lis)) (flatten (cdr lis)))
	  (list lis)
	  )
      )
  )

;;強制的に２つのリストをネスト無しのリストとして結合する
(define (non-nested-merge a b)
  (my-append (flatten a) (flatten b))
  )

(print (non-nested-merge 1 3)) ;=> (1 3)
(print (non-nested-merge '(1 3) 5)) ;=> (1 3 5)
(print (non-nested-merge 1 '(3 4))) ;=> (1 3 4)
(print (non-nested-merge '() '(3 4))) ;=> (3 4)
(print (non-nested-merge '(1 2) '(3 4))) ;=> (1 2 3 4)

;;要素の削除
(define (delete-at lis n)
  (if (null? lis)
      '()
      (if (pair? lis)
	  (if (equal? (car lis) n)
	      (delete-at (cdr lis) n)
	      (cons (car lis) (delete-at (cdr lis) n))
	      )
	  )
      )
  )

(print (delete-at '(1 2 (3 1) 4) '(3 1)))

;;リストからランダムに一つ取り出す
(define (random-one lis)
  (value-at lis (+ 1 (random-integer (- (size-of lis) 1))))
  )

(print (random-one '(10 20 30 40 50)))
(print (random-one '(10 20 30 40 50)))
(print (random-one '(10 20 30 40 50)))

;;勝利判定
(define (win? player)
  (include? (sort player) '((1 2 3) (4 5 6) (7 8 9) (1 4 7) (2 5 8) (3 6 9) (1 5 9) (3 5 7)))
  )

(if (win? '(1 2 3)) (print "win") (print "loose")) ;=>"win"

;;盤から一つ番号を選ぶ
(define (choice player board)
  (let ((choiced (random-one board)))
    (begin (non-nested-merge player choiced) (delete-at board choiced))
    )
  )

(choice '() '(1 2 3 4 5 6 7 8 9))

(define (game)
  (map
   (lambda (player)
     (if (or (null? board) (win? player))
	 (print "win!")
	 (choice player board)
	 )
     )
   '(() ())
   )
  )


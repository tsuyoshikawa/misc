;;ランダムビットのソースモジュール
(use srfi-27)

;;乱数の種をセット。これやらないと、random-integerが毎回一緒の値を返す
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

;;２つのリストの積集合を返す
(define (intersection a b)
  (if (or (null? a) (null? b))
      '()
      (if (pair? a)
          (if (include? (car a) b)
              (cons (car a) (intersection (cdr a) b))
              (intersection (cdr a) b)
              )
          (if (include? a b)
              a
              '()
              )
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

;;１リストに１リストを付け加える
(define (my-append a b)
  (if (pair? a)
      (cons (car a) (my-append (cdr a) b))
      b
      )
  )

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

;;リストからランダムに一つ取り出す
(define (random-one lis)
  (value-at lis (+ 1 (random-integer (size-of lis))))
  )

;;2番目の要素を（アトムとして）取り出す。
(define (2nd lis)
  (if (or (null? lis) (not (pair? lis)))
      '()
      (car (cdr lis))
      )
  )

;;勝利パターン
(define win-patterns '((1 2 3) (4 5 6) (7 8 9) (1 4 7) (2 5 8) (3 6 9) (1 5 9) (3 5 7)))

;;勝利判定
(define (win? player)
  (include?
   #t
   (map
    (lambda (pattern)
      (equal? (size-of (intersection player pattern)) 3)
      )
    win-patterns)
   )
  )

;;盤から一つ番号を選ぶ
(define (choice player board)
  (let ((choiced (random-one board)))
    (values
     (non-nested-merge player choiced)
     (delete-at board choiced)
     )
    )
  )

;;決着するまで回数を重ねる
(define (fight board p1 p2)
  (if (null? board)
      (cond [(win? (2nd p1)) (car p1)]
            [(win? (2nd p2)) (car p2)]
            [else 'draw]
            )
      (receive (pl bo)
               (choice (2nd p1) board)
               (if (win? pl)
                   (car p1)
                   (fight bo p2 (cons (car p1) (list pl)))
                   )
               )
      )
  )

;;1ゲーム実行
(define (1game)
  (fight '(1 2 3 4 5 6 7 8 9) '(P1 ()) '(P2 ()))
  )

;;指定回数ゲーム実行
(define (run c1 c2 cd max)
  (if (equal? (+ c1 c2 cd) max)
      (print "P1:" c1 " " "P2:" c2 " " "draw:" cd)
      (case (1game)
        ((P1) (run (+ c1 1) c2 cd max))
        ((P2) (run c1 (+ c2 1) cd max))
        (else (run c1 c2 (+ cd 1) max))
        )
      )
  )

;;実行
(run 0 0 0 10000)

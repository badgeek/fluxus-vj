(clear)
(start-audio "system:capture_1" 512 44100)
(define x (build-nurbs-sphere 10 30))

(with-primitive x
    (scale (vector 2 2 2))
    (pdata-add "ori" "v")
    (pdata-copy "p" "ori")
)

(define (render y)
    (with-primitive x
      ;(hint-none)
      (hint-wire)
      (backfacecull 1)
      (opacity (* (gh 5) 1000))
      ;(wire-line 1)
      (wire-opacity (* (gh 3) 100))
      (wire-colour (vector 1 0.5 0))
      (colour (vector 1 0 0))
      (rotate (vector 0 (* (delta) y) 0))
  ;    (scale (vector (gh 2) (gh 3) (gh 4)))
      (pdata-index-map!
           (lambda (index val)
                (vadd (pdata-ref "ori" index) (vmul (pdata-ref "n" index) (* (gh index) 10)))
           )
        "p"
      )

    )
)

(every-frame (render 50))

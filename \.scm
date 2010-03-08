;; hackpact day 7 - 543_987
;; gabor papp http://mndl.hu/hackpact

(require scheme/math)
(require scheme/class)

(clear)

(collisions 1)

(colour #(1 .5))
(hint-ignore-depth)

(define (get-pos)
    (let ([t (get-global-transform)])
        (vector (vector-ref t 12)
                (vector-ref t 13)
                (vector-ref t 14))))

(define ribbon%
    (class object%
        (init id_)
        
        (field [id id_])
        
        (define c (build-cube))
        (active-box c)
        
        (define r (build-ribbon 32))
        
        (with-primitive r
            (hint-unlit)
            (pdata-index-map!
                (lambda (i w)
                    (* .1 (cos (* .5 pi (/ i (pdata-size))))))
                "w"))
        
        (define (add-p np)
            (with-primitive r
                (pdata-index-map!
                    (lambda (i p)
                        (if (< i (- (pdata-size) 2))
                            (pdata-ref "p" (add1 i))
                            np))
                    "p")))
            
        (define/public (update)
            (with-primitive c
                (opacity (gl id)))
            (add-p (with-primitive c
						(get-pos)))
            (when (> (gl id) .2)
                (kick c (vmul (crndvec) (gl id)))
                (twist c (vmul (crndvec) (gl id))))
            (let ([p (with-primitive c
						(get-pos))])
                (kick c (vmul p -.05))))
        
        (super-new)))

(define ribbons (build-list 64 (lambda (x) (make-object ribbon% x))))

(define (render)
    (for-each
        (lambda (r)
            (send r update))
        ribbons))

(every-frame (render))



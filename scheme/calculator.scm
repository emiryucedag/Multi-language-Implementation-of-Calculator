#lang racket

(define ns (make-base-namespace)) 

(define (safe-eval input)
  (with-handlers ([exn:fail? (lambda (e) 'error)])
    (parameterize ([current-namespace ns])
      (eval (read (open-input-string input))))))

(define (calculator-loop)
  (displayln "Enter Scheme expression (e.g., (+ 2 (* 3 4)), use ^ or ** for expt):")
  (let loop ()
    (display "> ")
    (flush-output)
    (let ([input (read-line)])
      (when input
        (cond
          
          [(not (regexp-match? #px"^[0-9\\s()+\\-*\\/^]*$" input))
           (displayln "Invalid characters in input!")]
          [else
           
           (define cleaned
             (regexp-replace* #px"(\\^|\\*\\*)" input "expt"))
           (define result (safe-eval cleaned))
           (if (eq? result 'error)
               (displayln "Error in expression.")
               (printf "Result: ~a\n" result))])
        (loop)))))

(calculator-loop)

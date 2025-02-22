#lang plai

(define-type Binding
  [bind (name symbol?) (val FAES?)])

(define-type FAES
  [numS (n number?)]
  [withS (bindings (listof bind?))
         (body FAES?)]
  [with*S (bindings (listof bind?))
          (body FAES?)]
  [idS (name symbol?)]
  [funS (params (listof symbol?))
        (body FAES?)]
  [appS (fun FAES?)
        (args (listof FAES?))]
  [binopS (f procedure?)
         (l FAES?)
         (r FAES?)])

(define-type RCFAEL;FAE
  [num (n number?)]
  [id (name symbol?)]
  [bool (l boolean?)]
  [lista (n MList?)];;?
  [with (name symbol?)
        (named-expr RCFAEL?)
        (body RCFAEL?)]
  [rec (id symbol?)
       (n RCFAEL?)
       (m RCFAEL?)]
  [fun (params (listof symbol?))
       (body RCFAEL?)]
  [equal (e symbol?)]
  [app (fun RCFAEL?)
       (args (listof RCFAEL?))]
  [ifR (cond bool?)
       (then RCFAEL?)
       (else RCFAEL?)]
  [binop (f procedure?)
         (l RCFAEL?)
         (r RCFAEL?)]
  )

(define-type MList
  [MEmpty]
  [MCons (n RCFAEL?)
         (rest MList?)])

(define-type RCFAEL-Value
  [numV (n number?)]
  [closureV (param (listof symbol?))
            (body RCFAEL?)
            (env Env?)]
  [boolV (s symbol?)]
  [MListV (listof RCFAEL?)]
  )


(define-type Env
  [ mtSub ]
  [ aSub (name symbol?)
         (value RCFAEL-Value?)
         (env Env?)]
  [ aRecSub (name symbol?)
            (value (lambda (x)
                     (and (box? x)
                          (RCFAEL-Value? (unbox x)))))
                   (rnv Env?)])


(define (lookup name env)
  (type-case Env env
    [ mtSub () (error "lookup no binding for identifier" )]
    [ aSub (bound-name bound-value rest-env)
           (if (symbol=? bound-name name)
               bound-value
               (lookup name rest-env))]
    [ aRecSub (bound-name boxed-bound-value rest-env)
              (if (symbol=? bound-name name)
                  (unbox boxed-bound-value)
                  (lookup name rest-env))]))

; FUNCIONES AUXILIARES

;; A::= <number>|<symbol>|listof(<A>)
;; B::= (list <symbol> <A>)
;; parse-bindings: listof(B) -> listof(bind?)
;; "Parsea" la lista de bindings lst en sintaxis concreta
;; mientras revisa la lista de id's en busca de repetidos.
;; (define (parse-bindings lst) 
(define (parse-bindings lst allow)
  (let ([bindRep (buscaRepetido lst (lambda (e1 e2) (symbol=? (car e1) (car e2))))])
    (if (or (boolean? bindRep) allow)
        (map (lambda (b) (bind (car b) (parse (cadr b)))) lst)
        (error 'parse-bindings (string-append "El id " (symbol->string (car bindRep)) " está repetido")))))

(define (elige s)
  (case s
    [(+) +]
    [(-) -]
    [(*) *]
    [(/) /]))
  
;; buscaRepetido: listof(X) (X X -> boolean) -> X
;; Dada una lista, busca repeticiones dentro de la misma
;; usando el criterio comp. Regresa el primer elemento repetido
;; o falso eoc.
;; (define (buscaRepetido l comp) 
(define (buscaRepetido l comp) 
  (cond
    [(empty? l) #f]
    [(member? (car l) (cdr l) comp) (car l)]
    [else (buscaRepetido (cdr l) comp)]))

;; member?: X listof(Y) (X Y -> boolean) -> boolean
;; Determina si x está en l usando "comparador" para
;; comparar x con cada elemento de la lista.
;; (define (member? x l comparador)
(define (member? x l comparador)
  (cond
    [(empty? l) #f]
    [(comparador (car l) x) #t]
    [else (member? x (cdr l) comparador)]))

;; A::= <number>|<symbol>|listof(<A>)
;; parse: A -> FAES
(define (parse sexp)
  (cond
    [(symbol? sexp) (idS sexp)]
    [(number? sexp) (numS sexp)]
    [(list? sexp)
     (case (car sexp)
       [(with) (withS (parse-bindings (cadr sexp) #f) (parse (caddr sexp)))]
       [(with*) (with*S (parse-bindings (cadr sexp) #t) (parse (caddr sexp)))]
       [(fun) (funS (cadr sexp) (parse (caddr sexp)))]
       [(+ - / *) (binopS (elige (car sexp)) (parse (cadr sexp)) (parse (caddr sexp)))]
       [else (appS (parse (car sexp)) (map parse (cdr sexp)))])]
    ))

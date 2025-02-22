#lang plai
#|
--------------------------------
|  Lenguajes de programación     |
|  Práctica 1                    |
|  Guerrero Chávez Diana Lucía   |
|Lázaro Arias Jorge Alberto      |
| Sánchez Alcántara Jesús Esteban|

---------------------------------

|#

#|
EJERCICIO 1
Pow eleva un numero z a la potencia w
|#
(define (pow z w)
  (if (= w 0)
      1
      (* z (pow z (- w 1)))))

(test (pow 2 3)8)
(test (pow 7 3)343)
(test (pow 2 0)1)
(test (pow 2 1)2)
(test (pow 3 3)27)

#|
EJERCICIO 3
Devuelve una lista con los numeros primos del 2 ...n
Esta función utiliza las funciones auxiliares
*lista-hasta que genera una lista desde un numero dado hasta el número 2
*reverse, genera el reverso de una lista
*evalua-lista 
*dividir
*es-primo?
NOTA: las pruebas para esta función están después de la función es-primo?

|#
(define (primes n)
  (evalua-lista (reverse(lista-hasta n))) )


;;crea una lista desde x hasta 2
(define (lista-hasta x)
   (if (= x 1)
      '() 
      (cons x (lista-hasta (- x 1)))))

;;utiliza la función es-primo? para evaluar a cáda elemento de una lista de enteros
;;si ese elemento es primo, se agrega a la lista resultante
(define evalua-lista (lambda (lista)
                 (if (and(list? lista)
                         (andmap integer? lista))
                     (filter (lambda (x)
                               (es-primo? x ))
                             lista)
                     "Error se necesita una lista de numeros enteros")))


#|Verifica si un número es primo
al principio de la llamada esta funcion debe recibir un
número para evaluar y una constante 2 esto es para comenzar a verificar los modulos:
ejemplo: n%2 -->inicio de la iteración
n%3 ---> segunda iteracion
...
n % n-1
El caso base es cuando el divisor es igual al dividendo
|#
(define (dividir a b)
  (cond
    [(= a b) #t];;llegamos al "final" de la iteración, devolvemos true 
    [(eq? (modulo a b) 0) #f ] ;;si a%b == 0 no es número primo devolvemos false
    [else (dividir a (+ b 1))]));;llamada recursiva aumentamos en uno el divisor (b)
    
#|Regresa true cuando un numero es primo y false en caso contrario
llama a la funcion dividir pasándole como parámetros el número a
evaluar y una constante 2 
|#
(define (es-primo? n)
  (cond
    [(dividir n 2) #t]
    [else #f]))
  

;Pruebas para la función primes
(test (primes 10) '(2 3 5 7))
(test (primes 1) '())
(test (primes 5) '(2 3 5))
(test (primes 30) '(2 3 5 7 11 13 17 19 23 29))
(test (primes 7) '(2 3 5 7))


;;EJERCICIO 6------------------------------------
;;concatena 2 listas
;;tiene 2 casos base, cuando alguna de las dos listas es vacía, regresa la lista que no lo es
;;concatena recursivamente la cabeza de una lista con el resto de esa misma, cuando esta
;;queda vacía, concatenamos la segunda lista
(define (mconcat lista1 lista2)
  (cond
    [(and (empty? lista1) (not(empty? lista2)) ) lista2];;caso base '(1 2)+'()='(1 2)
    [(and (empty? lista2) (not(empty? lista1)) ) lista1];;caso base '()+'(1 2)='(1 2)
    [else (cons 
          (car lista1) (mconcat(cdr lista1 ) lista2) )]))

(test (mconcat '( A B C) '(D E F)) '(A B C D E F))
(test (mconcat '() '(D E F)) '(D E F))
(test (mconcat '( A B C) '()) '(A B C))
(test (mconcat '((A) (B) (C)) '(D E F)) '((A) (B) (C) D E F))
(test (mconcat (cdr '( A B C)) '(D E F)) '(B C D E F))


#|
EJERCICIO 7------------------------------------
mmap aplica una función a los elementos de una lista
|#
(define (mmap funcion lista)
  (cond
    [(empty? lista) empty]
    [else (cons (funcion (car lista)) (mmap funcion (cdr lista)))]))

  [test (mmap  car '((1 2 3) (4 5 6) (7 8 9) )) '(1 4 7)]
  [test (mmap  cdr '((1 2 3) (4 5 6) (7 8 9) )) '((2 3) (5 6) (8 9))]
  [test (mmap  sqrt '(4 16 81 49)) '(2 4 9 7)]
  [test (mmap  sqr '(4 16 81 49)) '(16 256 6561 2401)]
  [test (mmap  abs '(-4 16 -81.9 4.9)) '(4 16 81.9 4.9)]

#|
Ejercicio  11

|#
(define (mpowerset ls)
  (if (empty? ls)
      '(())
      (let ((rst (mpowerset (cdr ls))))
        (mconcat (mmap (lambda (x) (cons (car ls) x))
                     rst)
                rst))))
(test (mpowerset '()) '(()))
(test (mpowerset '(1 2)) '((1 2) (1) (2) ()))
(test (mpowerset '(1)) '((1) ()))
(test (mpowerset '(2)) '((2) ()))
(test (mpowerset '(1 2 3)) '((1 2 3) (1 2) (1 3) (1) (2 3) (2) (3) ()))


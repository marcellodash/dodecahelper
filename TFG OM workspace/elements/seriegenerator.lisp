(setq notas '(1 2 3 4 5 6 7 8 9 10 11 12))
(setq lista '(0 0 3 0 5 0 7 0 9 0 11 0))
(setq min 2)
(setq max 6)

; function to rotate a list:
; (my-rotate (list 0 1 2 3 4 5)) -> (1 2 3 4 5 0)
; (my-rotate (list 0 1 2 3 4 5) 2) -> (2 3 4 5 0 1)
(defun my-rotate (list &optional (n 1))
(if (<= n 0) list (my-rotate (append (last list) (reverse (cdr (reverse list)))) (1- n))))
; function to randomize a list
(defun randomize-list (list)
(setf temp-list nil)
(dotimes (i (length list))
(setf list (my-rotate list (random (length list))))
(setf temp-list (push (car list) temp-list))
(pop list))
temp-list)




(defun myf (lista min max)
    ; Obtiene las notas que faltan en la secuencia parcial
  (setq notasfaltan (delete nil (remove-duplicates (loop for x in notas do
     collect (if (member x lista) nil x))  ; comprobar si x est� en lista y si no est�, a�adir a notasfaltan
  )))

  (setq notasfaltan (randomize-list notasfaltan)) ; reordenar aleatoriamente notasfaltan

  (loop for x in notasfaltan do     ; para cada elemento de notasfaltan (bucle)
      ; seleccionar nueva nota y comprobar si cumple las restricciones
      ; obtener posici�n del primer 0
      ; en la posici�n -1 est� la nota anterior
      (if (= 0 (position 0 lista)) ; Si es la primera posici�n de la lista
          (
          (setf (nth (position 0 lista) lista) x)
          (myf lista min max)
          )

          (if (and ; Si no es la primera posici�n de la lista, miramos las restricciones
              (>= (if (> (abs (- x (nth (- (position 0 lista) 1) lista))) 6)
                  (- 6 (- (abs (- x (nth (- (position 0 lista) 1) lista))) 6))
                  (abs (- x (nth (- (position 0 lista) 1) lista)))) min)
              (<= (if (> (abs (- x (nth (- (position 0 lista) 1) lista))) 6)
                  (- 6 (- (abs (- x (nth (- (position 0 lista) 1) lista))) 6))
                  (abs (- x (nth (- (position 0 lista) 1) lista)))) max)
              )
              (
              (setf (nth (position 0 lista) lista) x); si las dos notas cumplen las restricciones, asigna la nueva nota en la posici�n del primer cero
              (if (not (position 0 (myf lista min max))); llama recursivamente a myf con la nueva lista
                                  ; si myf devuelve una lista completa entonces termina y devuelve la lista
                  (myf lista min max)
              )
              )
          )
      )
  )
  (if (position 0 lista)
      '(nil))
  ; si al terminar el bucle ninguna nota cumple la restricci�n devuelve lista vac�a
)
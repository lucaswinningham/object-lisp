; commands to return to interpreter
'(lambda ( / )
  ;
  ; redefine object functions
  ;
  (defun type (object / return_type)
    (setq return_type (NATIVE_FUNCTION_TYPE object))

    (if (equal return_type 'LIST)
      (if (not (pairp object))
        (if (equal (NATIVE_FUNCTION_LENGTH object) 3)
          (if (equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CADDR object)) 'SUBR)
            ((lambda ( / object_type)
              (if (NATIVE_FUNCTION_MEMBER (setq object_type (NATIVE_FUNCTION_CADR object)) RUBY_OBJECTS)
                (cond
                  ((equal object_type 'LISTOBJECT)
                    (setq return_type 'LISTOBJECT)
                  )

                  ((equal object_type 'STROBJECT)
                    (setq return_type 'LISTOBJECT)
                  )
                )
              )
            ))
          )
        )
      )
    )

    return_type
  )
  ;
  ; trace redefined object functions
  ;
  (if debug_trace
    (progn
      (trace type)
    )
  )

  ;
  ; define new object variables and functions
  ;

  ; identifier constant for new object types
  (setq RUBY_OBJECTS (NATIVE_FUNCTION_LIST 'LISTOBJECT 'STROBJECT))

  ; check new object type
  (defun objectp (object / )
    (not (not (NATIVE_FUNCTION_MEMBER (type object) RUBY_OBJECTS)))
  )

  ; check symbol type
  (defun symp (object / )
    (equal (type object) 'SYM)
  )

  ; check dot pair
  (defun pairp (object / )
    (if (equal (NATIVE_FUNCTION_TYPE object) 'LIST)
      (if (not (equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CDR object)) 'LIST))
        T
      ;else
        (if (equal (NATIVE_FUNCTION_LENGTH object) 3)
          (equal (NATIVE_FUNCTION_CADR object) 'QUOTE)
        ;else
          nil
        )
      )
    ;else
      nil
    )
  )

  ; TODO: move to ObjectString.lsp
  (defun stringp (object / )
    (not (not (NATIVE_FUNCTION_MEMBER (type object) (NATIVE_FUNCTION_LIST 'STR 'STROBJECT))))
  )

  ; takes object symbol, method symbol, and remaining arguments from interpreter wrapper
  (defun dot (object method &rest / )
; (terpri)(princ "object -> ")(prin1 object)
; (terpri)(princ "typeof object -> ")(prin1 (type object))
; (terpri)(princ "method -> ")(prin1 method)
; (terpri)(princ "typeof method -> ")(prin1 (type method))
; (terpri)(princ "params -> ")(prin1 &rest)(terpri)
; (terpri)(princ "typeof params -> ")(prin1 (type &rest))
; (foreach param &rest
;   (terpri)(princ "  param -> ")(prin1 param)(terpri)
;   (terpri)(princ "  typeof param -> ")(prin1 (type param))
; )
    (if (objectp object)
      ((lambda ( / object_copy)
        (setq object_copy object)
        ((NATIVE_FUNCTION_CADDR object) 'object_copy method &rest)
      ))
    ;else
      ((NATIVE_FUNCTION_CADDR (eval object)) object method &rest)
    )
  )

  ; if type of new object, returns native value of new objects
  ; if not type of new object, returns given object
  (defun valof (object / )
    (if (equal (type object) 'SYM)
      (if (objectp (eval object))
        (NATIVE_FUNCTION_CAR (eval object))
      ;else
        object
      )
    ;else
      (if (objectp object)
        (NATIVE_FUNCTION_CAR object)
      ;else
        object
      )
    )
  )

  ; raises custom error message
  (defun raise (&rest / *error*)
    (defun *error* (messages / i message)
      (setq i 0)
      
      (terpri)

      (while (< i (NATIVE_FUNCTION_LENGTH messages))
        (setq message (NATIVE_FUNCTION_NTH i messages))
        (princ message)
        (setq i (1+ i))
      )
    )

    (*error* &rest)
  )

  ; TODO: put this in a Math object
  ; returns a pseudo random number 0.0..1.0
  (defun rand ( / modulus multiplier increment random)
    (if (not seed)
      (setq seed (getvar "DATE"))
    )
    
    (setq
      modulus 65536
      multiplier 25173
      increment 13849
      seed (rem (+ (* multiplier seed) increment) modulus)
      random (/ seed modulus)
    )
    
    random
  )

  ;
  ; trace new object functions
  ;
  (if debug_trace
    (progn
      (trace objectp)
      (trace symp)
      (trace pairp)
      (trace dot)
      (trace valof)
      (trace raise)
      (trace rand)
    )
  )
)

; TODO: using vanilla lisp, concatenate strings (not strcat)
; takes list
; returns a literal of the concatenation of uniform types save strings
; (defun + (&rest / to_s?)
; 	(typep &rest 'LIST)

; 	(setq to_s? nil)

; 	((lambda ( / arg arg_type)
; 		(foreach arg &rest
; 			(setq arg_type (type arg))

; 			(if (not to_s?)
; 				(if (NATIVE_FUNCTION_MEMBER arg_type (list 'STR 'STROBJECT))
; 					(setq to_s? T)
; 				)
; 			)
; 		)
; 	))

; 	(if to_s?
; 		((lambda ( / return_string arg)
; 			(setq return_string "")

; 			(foreach arg &rest
; 				(setq return_string (strcat return_string (to_s arg)))
; 			)

; 			return_string
; 		))
; 	;else check that all items in list are of same type family and add if so
; 		((lambda ( / types_white_list uniform? return_object arg)
; 			(setq
; 				types_white_list (list 'INT 'REAL)
; 				uniform? T
; 				objects? nil
; 				arg_type (type (valof (car &rest)))
; 				return_object nil
; 			)

; 			(foreach arg &rest
; 				(if (not (equal (type (valof arg)) arg_type))
; 					(setq uniform? nil)
; 				)

; 				(if (objectp arg)
; 					(setq objects? T)
; 				)
; 			)

; 			(if uniform?
; 				(if objects?
; 					(cond
; 						((equal arg_type 'LIST)
; 							(setq return_object (newlist))

; 							(dot return_object concat &rest)

; 							(setq return_object (valof return_object))
; 						)

; 						(T
; 							(setq return_object nil)
; 						)
; 					)
; 				;else
; 					(cond
; 						((member arg_type types_white_list)
; 							(setq return_object (apply '+ &rest))
; 						)

; 						((equal arg_type 'LIST)
; 							((lambda ( / item)
; 								(setq return_object nil)

; 								(foreach item &rest
; 									(setq return_object (append return_object item))
; 								)
; 							))
; 						)
						
; 						(T
; 							(raise (+ "add function given arguments of not additive type : " &rest))
; 						)
; 					)
; 				)
; 			;else
; 				(raise (+ "add function given arguments of not uniform type : " &rest))
; 			)

; 			return_object
; 		))
; 	)
; )



; type check
; (defun typep (arg types / found arg_type)
;   (setq found nil)
  
;   (if (listp types)
;     (foreach arg_type types
;       (if (equal (type arg) arg_type)
;         (setq found T)
;       )
;     )
;   ;else
;     (if (equal (type arg) types)
;       (setq found T)
;     )
;   )
  
;   (if (not found)
;     (raise (+ "bad argument type: -> " types " : " arg))
;   )

;   T
; )

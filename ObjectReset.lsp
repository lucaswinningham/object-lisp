;
; reset native object functions
;

((lambda ( / )
  (if NATIVE_FUNCTION_TYPE
    (setq type NATIVE_FUNCTION_TYPE)
  )
))

;
; reset placeholders for native object functions
;

(setq
  NATIVE_FUNCTION_TYPE nil
)

;
; untrace native object functions
;
(untrace type)

;
; untrace placeholders for native object functions
;
(untrace NATIVE_FUNCTION_TYPE)

;
; untrace object functions
;
(untrace objectp)
(untrace symp)
(untrace pairp)
(untrace dot)
(untrace valof)
(untrace raise)

;
; reset object
;
(setq
  objectp nil
  symp nil
  pairp nil
  dot nil
  valof nil
  raise nil
)

(princ)

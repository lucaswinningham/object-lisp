;
; save native object functions
;

((lambda ( / )
  (if (not NATIVE_FUNCTION_TYPE)
    (setq NATIVE_FUNCTION_TYPE type)
  )

  ; (if (not NATIVE_FUNCTION_+)
  ;   (setq NATIVE_FUNCTION_+ +)
  ; )
))

;
; trace native object functions
;
(if debug_trace
  (progn
    (trace NATIVE_FUNCTION_TYPE)
    ; (trace NATIVE_FUNCTION_+)
  )
)

(princ)

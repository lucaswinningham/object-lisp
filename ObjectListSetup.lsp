;
; save native list functions
;

((lambda ( / )
  (if (not NATIVE_FUNCTION_APPEND)
    (setq NATIVE_FUNCTION_APPEND append)
  )

  (if (not NATIVE_FUNCTION_APPLY)
    (setq NATIVE_FUNCTION_APPLY apply)
  )

  (if (not NATIVE_FUNCTION_ASSOC)
    (setq NATIVE_FUNCTION_ASSOC assoc)
  )

  (if (not NATIVE_FUNCTION_CAR)
    (setq NATIVE_FUNCTION_CAR car)
  )

  (if (not NATIVE_FUNCTION_CDR)
    (setq NATIVE_FUNCTION_CDR cdr)
  )

  (if (not NATIVE_FUNCTION_CAAR)
    (setq NATIVE_FUNCTION_CAAR caar)
  )

  (if (not NATIVE_FUNCTION_CADR)
    (setq NATIVE_FUNCTION_CADR cadr)
  )

  (if (not NATIVE_FUNCTION_CDAR)
    (setq NATIVE_FUNCTION_CDAR cdar)
  )

  (if (not NATIVE_FUNCTION_CDDR)
    (setq NATIVE_FUNCTION_CDDR cddr)
  )

  (if (not NATIVE_FUNCTION_CAAAR)
    (setq NATIVE_FUNCTION_CAAAR caaar)
  )

  (if (not NATIVE_FUNCTION_CAADR)
    (setq NATIVE_FUNCTION_CAADR caadr)
  )

  (if (not NATIVE_FUNCTION_CADAR)
    (setq NATIVE_FUNCTION_CADAR cadar)
  )

  (if (not NATIVE_FUNCTION_CADDR)
    (setq NATIVE_FUNCTION_CADDR caddr)
  )

  (if (not NATIVE_FUNCTION_CDAAR)
    (setq NATIVE_FUNCTION_CDAAR cdaar)
  )

  (if (not NATIVE_FUNCTION_CDADR)
    (setq NATIVE_FUNCTION_CDADR cdadr)
  )

  (if (not NATIVE_FUNCTION_CDDAR)
    (setq NATIVE_FUNCTION_CDDAR cddar)
  )

  (if (not NATIVE_FUNCTION_CDDDR)
    (setq NATIVE_FUNCTION_CDDDR cdddr)
  )

  (if (not NATIVE_FUNCTION_CAAAAR)
    (setq NATIVE_FUNCTION_CAAAAR caaaar)
  )

  (if (not NATIVE_FUNCTION_CAAADR)
    (setq NATIVE_FUNCTION_CAAADR caaadr)
  )

  (if (not NATIVE_FUNCTION_CAADAR)
    (setq NATIVE_FUNCTION_CAADAR caadar)
  )

  (if (not NATIVE_FUNCTION_CAADDR)
    (setq NATIVE_FUNCTION_CAADDR caaddr)
  )

  (if (not NATIVE_FUNCTION_CADAAR)
    (setq NATIVE_FUNCTION_CADAAR cadaar)
  )

  (if (not NATIVE_FUNCTION_CADADR)
    (setq NATIVE_FUNCTION_CADADR cadadr)
  )

  (if (not NATIVE_FUNCTION_CADDAR)
    (setq NATIVE_FUNCTION_CADDAR caddar)
  )

  (if (not NATIVE_FUNCTION_CADDDR)
    (setq NATIVE_FUNCTION_CADDDR cadddr)
  )

  (if (not NATIVE_FUNCTION_CDAAAR)
    (setq NATIVE_FUNCTION_CDAAAR cdaaar)
  )

  (if (not NATIVE_FUNCTION_CDAADR)
    (setq NATIVE_FUNCTION_CDAADR cdaadr)
  )

  (if (not NATIVE_FUNCTION_CDADAR)
    (setq NATIVE_FUNCTION_CDADAR cdadar)
  )

  (if (not NATIVE_FUNCTION_CDADDR)
    (setq NATIVE_FUNCTION_CDADDR cdaddr)
  )

  (if (not NATIVE_FUNCTION_CDDAAR)
    (setq NATIVE_FUNCTION_CDDAAR cddaar)
  )

  (if (not NATIVE_FUNCTION_CDDADR)
    (setq NATIVE_FUNCTION_CDDADR cddadr)
  )

  (if (not NATIVE_FUNCTION_CDDDAR)
    (setq NATIVE_FUNCTION_CDDDAR cdddar)
  )

  (if (not NATIVE_FUNCTION_CDDDDR)
    (setq NATIVE_FUNCTION_CDDDDR cddddr)
  )

  (if (not NATIVE_FUNCTION_CONS)
    (setq NATIVE_FUNCTION_CONS cons)
  )

  (if (not NATIVE_FUNCTION_FOREACH)
    (setq NATIVE_FUNCTION_FOREACH foreach)
  )

  (if (not NATIVE_FUNCTION_LAST)
    (setq NATIVE_FUNCTION_LAST last)
  )

  (if (not NATIVE_FUNCTION_LENGTH)
    (setq NATIVE_FUNCTION_LENGTH length)
  )

  (if (not NATIVE_FUNCTION_LIST)
    (setq NATIVE_FUNCTION_LIST list)
  )
  
  (if (not NATIVE_FUNCTION_LISTP)
    (setq NATIVE_FUNCTION_LISTP listp)
  )

  (if (not NATIVE_FUNCTION_MAPCAR)
    (setq NATIVE_FUNCTION_MAPCAR mapcar)
  )

  (if (not NATIVE_FUNCTION_MEMBER)
    (setq NATIVE_FUNCTION_MEMBER member)
  )

  (if (not NATIVE_FUNCTION_NTH)
    (setq NATIVE_FUNCTION_NTH nth)
  )

  (if (not NATIVE_FUNCTION_REVERSE)
    (setq NATIVE_FUNCTION_REVERSE reverse)
  )

  (if (not NATIVE_FUNCTION_SUBST)
    (setq NATIVE_FUNCTION_SUBST subst)
  )
))

;
; trace native list functions
;
(if debug_trace
  (progn
    (trace NATIVE_FUNCTION_APPEND)
    (trace NATIVE_FUNCTION_APPLY)
    (trace NATIVE_FUNCTION_ASSOC)
    (trace NATIVE_FUNCTION_CAR)
    (trace NATIVE_FUNCTION_CDR)
    (trace NATIVE_FUNCTION_CAAR)
    (trace NATIVE_FUNCTION_CADR)
    (trace NATIVE_FUNCTION_CDAR)
    (trace NATIVE_FUNCTION_CDDR)
    (trace NATIVE_FUNCTION_CAAAR)
    (trace NATIVE_FUNCTION_CAADR)
    (trace NATIVE_FUNCTION_CADAR)
    (trace NATIVE_FUNCTION_CADDR)
    (trace NATIVE_FUNCTION_CDAAR)
    (trace NATIVE_FUNCTION_CDADR)
    (trace NATIVE_FUNCTION_CDDAR)
    (trace NATIVE_FUNCTION_CDDDR)
    (trace NATIVE_FUNCTION_CAAAAR)
    (trace NATIVE_FUNCTION_CAAADR)
    (trace NATIVE_FUNCTION_CAADAR)
    (trace NATIVE_FUNCTION_CAADDR)
    (trace NATIVE_FUNCTION_CADAAR)
    (trace NATIVE_FUNCTION_CADADR)
    (trace NATIVE_FUNCTION_CADDAR)
    (trace NATIVE_FUNCTION_CADDDR)
    (trace NATIVE_FUNCTION_CDAAAR)
    (trace NATIVE_FUNCTION_CDAADR)
    (trace NATIVE_FUNCTION_CDADAR)
    (trace NATIVE_FUNCTION_CDADDR)
    (trace NATIVE_FUNCTION_CDDAAR)
    (trace NATIVE_FUNCTION_CDDADR)
    (trace NATIVE_FUNCTION_CDDDAR)
    (trace NATIVE_FUNCTION_CDDDDR)
    (trace NATIVE_FUNCTION_CONS)
    (trace NATIVE_FUNCTION_FOREACH)
    (trace NATIVE_FUNCTION_LAST)
    (trace NATIVE_FUNCTION_LENGTH)
    (trace NATIVE_FUNCTION_LIST)
    (trace NATIVE_FUNCTION_LISTP)
    (trace NATIVE_FUNCTION_MAPCAR)
    (trace NATIVE_FUNCTION_MEMBER)
    (trace NATIVE_FUNCTION_NTH)
    (trace NATIVE_FUNCTION_REVERSE)
    (trace NATIVE_FUNCTION_SUBST)
  )
)

(princ)

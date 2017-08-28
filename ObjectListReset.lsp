;
; reset native list functions
;

((lambda ( / )
  (if NATIVE_FUNCTION_APPEND
    (setq append NATIVE_FUNCTION_APPEND)
  )

  (if NATIVE_FUNCTION_APPLY
    (setq apply NATIVE_FUNCTION_APPLY)
  )

  (if NATIVE_FUNCTION_ASSOC
    (setq assoc NATIVE_FUNCTION_ASSOC)
  )

  (if NATIVE_FUNCTION_CAR
    (setq car NATIVE_FUNCTION_CAR)
  )

  (if NATIVE_FUNCTION_CDR
    (setq cdr NATIVE_FUNCTION_CDR)
  )

  (if NATIVE_FUNCTION_CAAR
    (setq caar NATIVE_FUNCTION_CAAR)
  )

  (if NATIVE_FUNCTION_CADR
    (setq cadr NATIVE_FUNCTION_CADR)
  )

  (if NATIVE_FUNCTION_CDAR
    (setq cdar NATIVE_FUNCTION_CDAR)
  )

  (if NATIVE_FUNCTION_CDDR
    (setq cddr NATIVE_FUNCTION_CDDR)
  )

  (if NATIVE_FUNCTION_CAAAR
    (setq caaar NATIVE_FUNCTION_CAAAR)
  )

  (if NATIVE_FUNCTION_CAADR
    (setq caadr NATIVE_FUNCTION_CAADR)
  )

  (if NATIVE_FUNCTION_CADAR
    (setq cadar NATIVE_FUNCTION_CADAR)
  )

  (if NATIVE_FUNCTION_CADDR
    (setq caddr NATIVE_FUNCTION_CADDR)
  )

  (if NATIVE_FUNCTION_CDAAR
    (setq cdaar NATIVE_FUNCTION_CDAAR)
  )

  (if NATIVE_FUNCTION_CDADR
    (setq cdadr NATIVE_FUNCTION_CDADR)
  )

  (if NATIVE_FUNCTION_CDDAR
    (setq cddar NATIVE_FUNCTION_CDDAR)
  )

  (if NATIVE_FUNCTION_CDDDR
    (setq cdddr NATIVE_FUNCTION_CDDDR)
  )

  (if NATIVE_FUNCTION_CAAAAR
    (setq caaaar NATIVE_FUNCTION_CAAAAR)
  )

  (if NATIVE_FUNCTION_CAAADR
    (setq caaadr NATIVE_FUNCTION_CAAADR)
  )

  (if NATIVE_FUNCTION_CAADAR
    (setq caadar NATIVE_FUNCTION_CAADAR)
  )

  (if NATIVE_FUNCTION_CAADDR
    (setq caaddr NATIVE_FUNCTION_CAADDR)
  )

  (if NATIVE_FUNCTION_CADAAR
    (setq cadaar NATIVE_FUNCTION_CADAAR)
  )

  (if NATIVE_FUNCTION_CADADR
    (setq cadadr NATIVE_FUNCTION_CADADR)
  )

  (if NATIVE_FUNCTION_CADDAR
    (setq caddar NATIVE_FUNCTION_CADDAR)
  )

  (if NATIVE_FUNCTION_CADDDR
    (setq cadddr NATIVE_FUNCTION_CADDDR)
  )

  (if NATIVE_FUNCTION_CDAAAR
    (setq cdaaar NATIVE_FUNCTION_CDAAAR)
  )

  (if NATIVE_FUNCTION_CDAADR
    (setq cdaadr NATIVE_FUNCTION_CDAADR)
  )

  (if NATIVE_FUNCTION_CDADAR
    (setq cdadar NATIVE_FUNCTION_CDADAR)
  )

  (if NATIVE_FUNCTION_CDADDR
    (setq cdaddr NATIVE_FUNCTION_CDADDR)
  )

  (if NATIVE_FUNCTION_CDDAAR
    (setq cddaar NATIVE_FUNCTION_CDDAAR)
  )

  (if NATIVE_FUNCTION_CDDADR
    (setq cddadr NATIVE_FUNCTION_CDDADR)
  )

  (if NATIVE_FUNCTION_CDDDAR
    (setq cdddar NATIVE_FUNCTION_CDDDAR)
  )

  (if NATIVE_FUNCTION_CDDDDR
    (setq cddddr NATIVE_FUNCTION_CDDDDR)
  )

  (if NATIVE_FUNCTION_CONS
    (setq cons NATIVE_FUNCTION_CONS)
  )

  (if NATIVE_FUNCTION_FOREACH
    (setq foreach NATIVE_FUNCTION_FOREACH)
  )

  (if NATIVE_FUNCTION_LAST
    (setq last NATIVE_FUNCTION_LAST)
  )

  (if NATIVE_FUNCTION_LENGTH
    (setq length NATIVE_FUNCTION_LENGTH)
  )

  (if NATIVE_FUNCTION_LIST
    (setq list NATIVE_FUNCTION_LIST)
  )

  (if NATIVE_FUNCTION_LISTP
    (setq listp NATIVE_FUNCTION_LISTP)
  )

  (if NATIVE_FUNCTION_MEMBER
    (setq member NATIVE_FUNCTION_MEMBER)
  )

  (if NATIVE_FUNCTION_NTH
    (setq nth NATIVE_FUNCTION_NTH)
  )

  (if NATIVE_FUNCTION_MAPCAR
    (setq mapcar NATIVE_FUNCTION_MAPCAR)
  )

  (if NATIVE_FUNCTION_REVERSE
    (setq reverse NATIVE_FUNCTION_REVERSE)
  )

  (if NATIVE_FUNCTION_SUBST
    (setq subst NATIVE_FUNCTION_SUBST)
  )
))

;
; reset placeholders for native list functions
;

(setq
  NATIVE_FUNCTION_APPEND nil
  NATIVE_FUNCTION_APPLY nil
  NATIVE_FUNCTION_ASSOC nil
  NATIVE_FUNCTION_CAR nil
  NATIVE_FUNCTION_CDR nil
  NATIVE_FUNCTION_CAAR nil
  NATIVE_FUNCTION_CADR nil
  NATIVE_FUNCTION_CDAR nil
  NATIVE_FUNCTION_CDDR nil
  NATIVE_FUNCTION_CAAAR nil
  NATIVE_FUNCTION_CAADR nil
  NATIVE_FUNCTION_CADAR nil
  NATIVE_FUNCTION_CADDR nil
  NATIVE_FUNCTION_CDAAR nil
  NATIVE_FUNCTION_CDADR nil
  NATIVE_FUNCTION_CDDAR nil
  NATIVE_FUNCTION_CDDDR nil
  NATIVE_FUNCTION_CAAAAR nil
  NATIVE_FUNCTION_CAAADR nil
  NATIVE_FUNCTION_CAADAR nil
  NATIVE_FUNCTION_CAADDR nil
  NATIVE_FUNCTION_CADAAR nil
  NATIVE_FUNCTION_CADADR nil
  NATIVE_FUNCTION_CADDAR nil
  NATIVE_FUNCTION_CADDDR nil
  NATIVE_FUNCTION_CDAAAR nil
  NATIVE_FUNCTION_CDAADR nil
  NATIVE_FUNCTION_CDADAR nil
  NATIVE_FUNCTION_CDADDR nil
  NATIVE_FUNCTION_CDDAAR nil
  NATIVE_FUNCTION_CDDADR nil
  NATIVE_FUNCTION_CDDDAR nil
  NATIVE_FUNCTION_CDDDDR nil
  NATIVE_FUNCTION_CONS nil
  NATIVE_FUNCTION_FOREACH nil
  NATIVE_FUNCTION_LAST nil
  NATIVE_FUNCTION_LENGTH nil
  NATIVE_FUNCTION_LIST nil
  NATIVE_FUNCTION_LISTP nil
  NATIVE_FUNCTION_MEMBER nil
  NATIVE_FUNCTION_NTH nil
  NATIVE_FUNCTION_MAPCAR nil
  NATIVE_FUNCTION_REVERSE nil
  NATIVE_FUNCTION_SUBST nil
)

;
; untrace native list functions
;
(untrace append)
(untrace apply)
(untrace assoc)
(untrace car)
(untrace cdr)
(untrace caar)
(untrace cadr)
(untrace cdar)
(untrace cddr)
(untrace caaar)
(untrace caadr)
(untrace cadar)
(untrace caddr)
(untrace cdaar)
(untrace cdadr)
(untrace cddar)
(untrace cdddr)
(untrace caaaar)
(untrace caaadr)
(untrace caadar)
(untrace caaddr)
(untrace cadaar)
(untrace cadadr)
(untrace caddar)
(untrace cadddr)
(untrace cdaaar)
(untrace cdaadr)
(untrace cdadar)
(untrace cdaddr)
(untrace cddaar)
(untrace cddadr)
(untrace cdddar)
(untrace cddddr)
(untrace cons)
(untrace foreach)
(untrace last)
(untrace length)
(untrace list)
(untrace listp)
(untrace member)
(untrace nth)
(untrace mapcar)
(untrace reverse)
(untrace subst)

;
; untrace placeholders for native list functions
;
(untrace NATIVE_FUNCTION_APPEND)
(untrace NATIVE_FUNCTION_APPLY)
(untrace NATIVE_FUNCTION_ASSOC)
(untrace NATIVE_FUNCTION_CAR)
(untrace NATIVE_FUNCTION_CDR)
(untrace NATIVE_FUNCTION_CAAR)
(untrace NATIVE_FUNCTION_CADR)
(untrace NATIVE_FUNCTION_CDAR)
(untrace NATIVE_FUNCTION_CDDR)
(untrace NATIVE_FUNCTION_CAAAR)
(untrace NATIVE_FUNCTION_CAADR)
(untrace NATIVE_FUNCTION_CADAR)
(untrace NATIVE_FUNCTION_CADDR)
(untrace NATIVE_FUNCTION_CDAAR)
(untrace NATIVE_FUNCTION_CDADR)
(untrace NATIVE_FUNCTION_CDDAR)
(untrace NATIVE_FUNCTION_CDDDR)
(untrace NATIVE_FUNCTION_CAAAAR)
(untrace NATIVE_FUNCTION_CAAADR)
(untrace NATIVE_FUNCTION_CAADAR)
(untrace NATIVE_FUNCTION_CAADDR)
(untrace NATIVE_FUNCTION_CADAAR)
(untrace NATIVE_FUNCTION_CADADR)
(untrace NATIVE_FUNCTION_CADDAR)
(untrace NATIVE_FUNCTION_CADDDR)
(untrace NATIVE_FUNCTION_CDAAAR)
(untrace NATIVE_FUNCTION_CDAADR)
(untrace NATIVE_FUNCTION_CDADAR)
(untrace NATIVE_FUNCTION_CDADDR)
(untrace NATIVE_FUNCTION_CDDAAR)
(untrace NATIVE_FUNCTION_CDDADR)
(untrace NATIVE_FUNCTION_CDDDAR)
(untrace NATIVE_FUNCTION_CDDDDR)
(untrace NATIVE_FUNCTION_CONS)
(untrace NATIVE_FUNCTION_FOREACH)
(untrace NATIVE_FUNCTION_LAST)
(untrace NATIVE_FUNCTION_LENGTH)
(untrace NATIVE_FUNCTION_LIST)
(untrace NATIVE_FUNCTION_LISTP)
(untrace NATIVE_FUNCTION_MEMBER)
(untrace NATIVE_FUNCTION_NTH)
(untrace NATIVE_FUNCTION_MAPCAR)
(untrace NATIVE_FUNCTION_REVERSE)
(untrace NATIVE_FUNCTION_SUBST)

;
; reset list object
;
(setq newlist nil)

(princ)

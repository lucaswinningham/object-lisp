(load "ObjectLoader.lsp")

(interpret '(lambda ( / )
  (defun princ_card (card)
    (princ (dot card join " of "))
    ; (princ (dot card first))
    ; (princ " of ")
    ; (princ (dot card last))
  )

  (defun princ_hand (hand / mapped)
    (setq mapped (dot hand map (lambda (card / )
      (dot card join " of ")
    )))

    (princ (dot mapped join ", "))
  )

  (defun score (hand / )
    (setq hand_score 0)

    (dot hand each (lambda (card / face)
      (setq face (dot card first))

      (cond
        ((equal face "2")
          (setq hand_score (+ hand_score 2))
        )
        ((equal face "3")
          (setq hand_score (+ hand_score 3))
        )
        ((equal face "4")
          (setq hand_score (+ hand_score 4))
        )
        ((equal face "5")
          (setq hand_score (+ hand_score 5))
        )
        ((equal face "6")
          (setq hand_score (+ hand_score 6))
        )
        ((equal face "7")
          (setq hand_score (+ hand_score 7))
        )
        ((equal face "8")
          (setq hand_score (+ hand_score 8))
        )
        ((equal face "9")
          (setq hand_score (+ hand_score 9))
        )
        ((equal face "10")
          (setq hand_score (+ hand_score 10))
        )
        ((equal face "Jack")
          (setq hand_score (+ hand_score 10))
        )
        ((equal face "Queen")
          (setq hand_score (+ hand_score 10))
        )
        ((equal face "King")
          (setq hand_score (+ hand_score 10))
        )
        ((equal face "Ace")
          (if (< (+ hand_score 11) 22)
            (setq hand_score (+ hand_score 11))
          ;else
            (setq hand_score (+ hand_score 1))
          )
        )
      )
      ; (terpri)(princ hand_score)
    ))
      ; (terpri)(princ hand_score)

    hand_score
  )

  (setq suits (list "Clubs" "Diamonds" "Hearts" "Spades"))
  (setq faces (list "2" "3" "4" "5" "6" "7" "8" "9" "10" "Jack" "Queen" "King" "Ace"))

  (setq deck (dot faces product suits))

  (dot deck shuffle!)

  (setq dealer (dot deck pop 1))
  (setq player (dot deck pop 1))
  (dot dealer push (dot deck pop))
  (dot player push (dot deck pop))

  (terpri)(princ "Dealer shows ")(princ_card (dot dealer first))

  (setq hit T)

  (while (and hit (< (score player) 21))
    (terpri)(princ "Player shows ")(princ_hand player)(princ " - ")(princ (score player))

    (terpri)(setq response (getstring "hit/stay? [h/s]"))

    (if (equal response "s")
      (setq hit nil)
    )

    (if hit
      (progn
        (dot player push (dot deck pop))
        (terpri)(princ "Player hits")
      )
    ;else
      (progn
        (terpri)(princ "Player stays")
      )
    )
  )

  (terpri)(princ "Player shows ")(princ_hand player)(princ " - ")(princ (score player))

  (if (> (score player) 21)
    (progn
      (terpri)(princ "Player busts")
    )
  )

  (setq hit T)

  (while (and hit (< (score dealer) 21))
    (terpri)(princ "Dealer shows ")(princ_hand dealer)(princ " - ")(princ (score dealer))

    (if (> (score dealer) 16)
      (setq hit nil)
    )

    (if hit
      (progn
        (dot dealer push (dot deck pop))
        (terpri)(princ "Dealer hits")
      )
    ;else
      (progn
        (terpri)(princ "Dealer stays")
      )
    )
  )

  (terpri)(princ "Dealer shows ")(princ_hand dealer)(princ " - ")(princ (score dealer))

  (if (> (score dealer) 21)
    (progn
      (terpri)(princ "Dealer busts")
    )
  )

  (terpri)

  (if (< (score player) 22)
    (cond
      ((equal (score player) (score dealer))
        (princ "Push")
      )
      ((> (score dealer) 21)
        (princ "You win")
      )
      ((> (score player) (score dealer))
        (princ "You win")
      )
      (T
        (princ "You lose")
      )
    )
  ; else
    (princ "You lose")
  )
))

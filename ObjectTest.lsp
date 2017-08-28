(interpret '(lambda ( / )

(setq all_tests_passed T)

(defun assert_equal (actual expected / )
  (terpri)(princ "asserting ")(princ actual)(princ " = ")(princ expected)

  (if (not (equal (valof actual) (valof expected)))
    (progn
      ; (raise "Test failed: expected -> " expected " : actual -> " actual)
      (terpri)(princ "!")
      (raise "Previous test failed!")
      (terpri)(princ "!")
      (setq all_tests_passed nil)
    )
  )
)

(defun testlist ( / )
  ; any?
  ((lambda ( / a)
    ; %w[ant bear cat].any? { |word| word.length >= 3 } #=> true
    ; %w[ant bear cat].any? { |word| word.length >= 4 } #=> true
    ; [nil, true, 99].any?                              #=> true
    (terpri)(princ "...")(terpri)(princ "testing list any?")

    (setq a (list 3 4 3))

    (assert_equal (dot a any? (lambda (x / ) (>= x 3)) 'hi 'hello) T)
    (assert_equal a (list 3 4 3))
    (assert_equal (dot a any? (lambda (x / ) (>= x 4))) T)
    (assert_equal a (list 3 4 3))

    (setq a (list nil T 99))

    (assert_equal (dot a any?) T)
    (assert_equal a (list nil T 99))

    (assert_equal (dot (list nil nil) any?) nil)
  ))

  ; assoc
  ((lambda ( / s1 s2 s3 a)
    ; s1 = [ "colors", "red", "blue", "green" ]
    ; s2 = [ "letters", "a", "b", "c" ]
    ; s3 = "foo"
    ; a  = [ s1, s2, s3 ]
    ; a.assoc("letters")  #=> [ "letters", "a", "b", "c" ]
    ; a.assoc("foo")      #=> nil
    (terpri)(princ "...")(terpri)(princ "testing list assoc")

    (setq 
      s1 (list "colors" "red" "blue" "green")
      s2 (list "letters" "a" "b" "c")
      s3 "foo"
      a (list s1 s2 s3)
    )

    (assert_equal (dot a assoc "letters") (list "letters" "a" "b" "c"))
    (assert_equal a (list (list "colors" "red" "blue" "green") (list "letters" "a" "b" "c") "foo"))
    (assert_equal (dot a assoc "foo") nil)
    (assert_equal a (list (list "colors" "red" "blue" "green") (list "letters" "a" "b" "c") "foo"))
  ))

  ; at
  ((lambda ( / a)
    ; a = [ "a", "b", "c", "d", "e" ]
    ; a.at(0)     #=> "a"
    ; a.at(-1)    #=> "e"
    (terpri)(princ "...")(terpri)(princ "testing list at")

    (setq a (list "a" "b" "c" "d" "e"))

    (assert_equal (dot a at 0) "a")
    (assert_equal a (list "a" "b" "c" "d" "e"))
    (assert_equal (dot a at -1) "e")
    (assert_equal a (list "a" "b" "c" "d" "e"))
    (assert_equal (dot a at 5) nil)
    (assert_equal a (list "a" "b" "c" "d" "e"))
    (assert_equal (dot a at -6) nil)
    (assert_equal a (list "a" "b" "c" "d" "e"))
  ))

  ; ; bsearch
  ; ((lambda ( / ary)
  ;   ; ary = [0, 4, 7, 10, 12]
  ;   ; ary.bsearch {|x| x >=   4 } #=> 4
  ;   ; ary.bsearch {|x| x >=   6 } #=> 7
  ;   ; ary.bsearch {|x| x >=  -1 } #=> 0
  ;   ; ary.bsearch {|x| x >= 100 } #=> nil
  ;   ; # try to find v such that 4 <= v < 8
  ;   ; ary.bsearch {|x| 1 - x / 4 } #=> 4 or 7
  ;   ; # try to find v such that 8 <= v < 10
  ;   ; ary.bsearch {|x| 4 - x / 2 } #=> nil
  ;   (terpri)(princ "...")(terpri)(princ "testing list bsearch")

  ;   (setq ary (list 0 4 7 10 12))

  ;   (assert_equal (dot ary bsearch (lambda (x / ) (>= x 4))) 4)
  ;   (assert_equal ary (list 0 4 7 10 12))
  ;   (assert_equal (dot ary bsearch (lambda (x / ) (>= x 6))) 7)
  ;   (assert_equal ary (list 0 4 7 10 12))
  ;   (assert_equal (dot ary bsearch (lambda (x / ) (>= x -1))) 0)
  ;   (assert_equal ary (list 0 4 7 10 12))
  ;   (assert_equal (dot ary bsearch (lambda (x / ) (>= x 100))) nil)
  ;   (assert_equal ary (list 0 4 7 10 12))

  ;   ; try to find v such that 4 <= v < 8
  ;   (assert_equal (dot ary bsearch (lambda (x / ) (- 1.0 (/ x 4.0)))) 7)
  ;   (assert_equal ary (list 0 4 7 10 12))
  ;   ; try to find v such that 8 <= v < 10
  ;   (assert_equal (dot ary bsearch (lambda (x / ) (- 4.0 (/ x 2.0)))) nil)
  ;   (assert_equal ary (list 0 4 7 10 12))
  ; ))

  ; ; bsearch_index
  ; ((lambda ( / ary)
  ;   ; ary = [0, 4, 7, 10, 12]
  ;   ; ary.bsearch_index {|x| x >=   4 } #=> 1
  ;   ; ary.bsearch_index {|x| x >=   6 } #=> 2
  ;   ; ary.bsearch_index {|x| x >=  -1 } #=> 0
  ;   ; ary.bsearch_index {|x| x >= 100 } #=> nil
  ;   ; # try to find v such that 4 <= v < 8
  ;   ; ary.bsearch_index {|x| 1 - x / 4 } #=> 2 or 3
  ;   ; # try to find v such that 8 <= v < 10
  ;   ; ary.bsearch_index {|x| 4 - x / 2 } #=> nil
  ;   (terpri)(princ "...")(terpri)(princ "testing list bsearch_index")

  ;   (setq ary (list 0 4 7 10 12))

  ;   (assert_equal (dot ary bsearch_index (lambda (x / ) (>= x 4))) 1)
  ;   (assert_equal ary (list 0 4 7 10 12))
  ;   (assert_equal (dot ary bsearch_index (lambda (x / ) (>= x 6))) 2)
  ;   (assert_equal ary (list 0 4 7 10 12))
  ;   (assert_equal (dot ary bsearch_index (lambda (x / ) (>= x -1))) 0)
  ;   (assert_equal ary (list 0 4 7 10 12))
  ;   (assert_equal (dot ary bsearch_index (lambda (x / ) (>= x 100))) nil)
  ;   (assert_equal ary (list 0 4 7 10 12))

  ;   ; try to find v such that 4 <= v < 8
  ;   (assert_equal (dot ary bsearch_index (lambda (x / ) (- 1.0 (/ x 4.0)))) 2)
  ;   (assert_equal ary (list 0 4 7 10 12))
  ;   ; try to find v such that 8 <= v < 10
  ;   (assert_equal (dot ary bsearch_index (lambda (x / ) (- 4.0 (/ x 2.0)))) nil)
  ;   (assert_equal ary (list 0 4 7 10 12))
  ; ))

  ; clear
  ((lambda ( / a)
    ; a = [ "a", "b", "c", "d", "e" ]
    ; a.clear    #=> [ ]
    (terpri)(princ "...")(terpri)(princ "testing list clear")

    (setq a (list "a" "b" "c" "d" "e"))
    
    (assert_equal (dot a clear) nil)
    (assert_equal a nil)
  ))

  ; collect
  ((lambda ( / a)
    ; a = [ "a", "b", "c", "d" ]
    ; a.collect { |x| x + "!" }         #=> ["a!", "b!", "c!", "d!"]
    ; a.map.with_index { |x, i| x * i } #=> ["", "b", "cc", "ddd"]
    ; a                                 #=> ["a", "b", "c", "d"]
    (terpri)(princ "...")(terpri)(princ "testing list collect")

    (setq a  (list "a" "b" "c" "d"))

    (assert_equal (dot a collect (lambda (x / ) (strcat x "!"))) (list "a!" "b!" "c!" "d!"))
    (assert_equal a (list "a" "b" "c" "d"))

    (assert_equal (dot a collect) (list "a" "b" "c" "d"))
    (assert_equal a (list "a" "b" "c" "d"))
  ))

  ; collect!
  ((lambda ( / a)
    ; a = [ "a", "b", "c", "d" ]
    ; a.map! {|x| x + "!" }
    ; a #=>  [ "a!", "b!", "c!", "d!" ]
    ; a.collect!.with_index {|x, i| x[0...i] }
    ; a #=>  ["", "b", "c!", "d!"]
    (terpri)(princ "...")(terpri)(princ "testing list collect!")

    (setq a  (list "a" "b" "c" "d"))

    (assert_equal (dot a collect! (lambda (x / ) (strcat x "!"))) (list "a!" "b!" "c!" "d!"))
    (assert_equal a (list "a!" "b!" "c!" "d!"))

    (assert_equal (dot a collect!) (list "a!" "b!" "c!" "d!"))
    (assert_equal a (list "a!" "b!" "c!" "d!"))
  ))

  ; ; combination
  ; ((lambda ( / a)
  ;   ; a = [1, 2, 3, 4]
  ;   ; a.combination(1).to_a  #=> [[1],[2],[3],[4]]
  ;   ; a.combination(2).to_a  #=> [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
  ;   ; a.combination(3).to_a  #=> [[1,2,3],[1,2,4],[1,3,4],[2,3,4]]
  ;   ; a.combination(4).to_a  #=> [[1,2,3,4]]
  ;   ; a.combination(0).to_a  #=> [[]] # one combination of length 0
  ;   ; a.combination(5).to_a  #=> []   # no combinations of length 5
  ;   (terpri)(princ "...")(terpri)(princ "testing list combination")

  ;   (setq a (list 1 2 3 4))

  ;   (assert_equal (dot a combination 1) (list (list 1) (list 2) (list 3) (list 4)))
  ;   (assert_equal a (list 1 2 3 4))
  ;   (assert_equal (dot a combination 2) (list (list 1 2) (list 1 3) (list 1 4) (list 2 3) (list 2 4) (list 3 4)))
  ;   (assert_equal a (list 1 2 3 4))
  ;   (assert_equal (dot a combination 3) (list (list 1 2 3) (list 1 2 4) (list 1 3 4) (list 2 3 4)))
  ;   (assert_equal a (list 1 2 3 4))
  ;   (assert_equal (dot a combination 4) (list (list 1 2 3 4)))
  ;   (assert_equal a (list 1 2 3 4))
  ;   (assert_equal (dot a combination 0) (list nil))
  ;   (assert_equal a (list 1 2 3 4))
  ;   (assert_equal (dot a combination 5) nil)
  ;   (assert_equal a (list 1 2 3 4))
  ; ))

  ; compact
  ((lambda ( / a)
    ; [ "a", nil, "b", nil, "c", nil ].compact #=> [ "a", "b", "c" ]
    (terpri)(princ "...")(terpri)(princ "testing list compact")

    (assert_equal (dot (list "a" nil "b" nil "c") compact) (list "a" "b" "c"))

    (setq a (list "a" nil "b" nil "c"))

    (assert_equal (dot a compact) (list "a" "b" "c"))
    (assert_equal a (list "a" nil "b" nil "c"))
  ))

  ; compact!
  ((lambda ( / a)
    ; [ "a", nil, "b", nil, "c" ].compact! #=> [ "a", "b", "c" ]
    ; [ "a", "b", "c" ].compact!           #=> nil
    (terpri)(princ "...")(terpri)(princ "testing list compact!")

    (assert_equal (dot (list "a" nil "b" nil "c") compact!) (list "a" "b" "c"))

    (assert_equal (dot (list "a" "b" "c") compact!) nil)

    (setq a (list "a" nil "b" nil "c"))

    (assert_equal (dot a compact!) (list "a" "b" "c"))
    (assert_equal a (list "a" "b" "c"))

    (assert_equal (dot a compact!) nil)
    (assert_equal a (list "a" "b" "c"))
  ))

  ; concat
  ((lambda ( / a)
    ; [ "a", "b" ].concat( ["c", "d"] ) #=> [ "a", "b", "c", "d" ]
    ; [ "a" ].concat( ["b"], ["c", "d"] ) #=> [ "a", "b", "c", "d" ]
    ; [ "a" ].concat #=> [ "a" ]
    ; a = [ 1, 2, 3 ]
    ; a.concat( [ 4, 5 ] )
    ; a                                 #=> [ 1, 2, 3, 4, 5 ]
    ; a = [ 1, 2 ]
    ; a.concat(a, a)                    #=> [1, 2, 1, 2, 1, 2]
    (terpri)(princ "...")(terpri)(princ "testing list concat")

    (assert_equal (dot (list "a" "b") concat (list "c" "d")) (list "a" "b" "c" "d"))

    (assert_equal (dot (list "a") concat (list "b") (list "c" "d")) (list "a" "b" "c" "d"))

    (assert_equal (dot (list "a") concat) (list "a"))

    (setq a (list "a" "b"))

    (assert_equal (dot a concat (list "c" "d")) (list "a" "b" "c" "d"))
    (assert_equal a (list "a" "b" "c" "d"))

    (setq a (list "a"))

    (assert_equal (dot a concat (list "b") (list "c" "d")) (list "a" "b" "c" "d"))
    (assert_equal a (list "a" "b" "c" "d"))

    (setq a (list "a"))

    (assert_equal (dot a concat) (list "a"))
    (assert_equal a (list "a"))

    (setq a (list 1 2 3))

    (assert_equal (dot a concat (list 4 5)) (list 1 2 3 4 5))
    (assert_equal a (list 1 2 3 4 5))

    (setq a (list 1 2))

    (assert_equal (dot a concat a a) (list 1 2 1 2 1 2))
    (assert_equal a (list 1 2 1 2 1 2))
  ))

  ; count
  ((lambda ( / ary)
    ; ary = [1, 2, 4, 2]
    ; ary.count                  #=> 4
    ; ary.count(2)               #=> 2
    ; ary.count { |x| x%2 == 0 } #=> 3
    (terpri)(princ "...")(terpri)(princ "testing list count")

    (setq ary (list 1 2 4 2))

    (assert_equal (dot ary count) 4)
    (assert_equal ary (list 1 2 4 2))

    (assert_equal (dot ary count 2) 2)
    (assert_equal ary (list 1 2 4 2))

    (assert_equal (dot ary count (lambda (x / ) (equal (rem x 2) 0))) 3)
    (assert_equal ary (list 1 2 4 2))

    (assert_equal (dot ary count 2 (lambda (x / ) (equal (rem x 2) 0))) 2)
    (assert_equal ary (list 1 2 4 2))
  ))

  ; cycle
  ((lambda ( / a)
    ; a = ["a", "b", "c"]
    ; a.cycle { |x| puts x }     # print, a, b, c, a, b, c,.. forever.
    ; a.cycle(2) { |x| puts x }  # print, a, b, c, a, b, c.
    (terpri)(princ "...")(terpri)(princ "testing list cycle")

    (setq a (list "a" "b" "c"))

    ((lambda ( / old_str_val)
      (setq
        old_str_val str
        str ""
      )

      (assert_equal (dot a cycle 2 '(lambda (x / ) (setq str (strcat str x)))) nil)
      (assert_equal a (list "a" "b" "c"))
      (assert_equal str "abcabc")
      (assert_equal (dot a cycle 0 (lambda (x / ) (setq str (strcat str x)))) nil)
      (assert_equal a (list "a" "b" "c"))
      (assert_equal str "abcabc")
      (assert_equal (dot a cycle -1 (lambda (x / ) (setq str (strcat str x)))) nil)
      (assert_equal a (list "a" "b" "c"))
      (assert_equal str "abcabc")
      (assert_equal (dot a cycle 2) a)
      (assert_equal a (list "a" "b" "c"))
      (assert_equal str "abcabc")

      (setq str old_str_val)
    ))
  ))

  ; delete
  ((lambda ( / a)
    ; a = [ "a", "b", "b", "b", "c" ]
    ; a.delete("b")                   #=> "b"
    ; a                               #=> ["a", "c"]
    ; a.delete("z")                   #=> nil
    ; a.delete("z") { "not found" }   #=> "not found"
    (terpri)(princ "...")(terpri)(princ "testing list delete")

    (setq a (list "a" "b" "b" "b" "c"))

    (assert_equal (dot a delete "b") "b")
    (assert_equal a (list "a" "c"))
    (assert_equal (dot a delete"z") nil)
    (assert_equal a (list "a" "c"))
    (assert_equal (dot a delete "z" (lambda ( / ) "not found")) "not found")
    (assert_equal a (list "a" "c"))
  ))

  ; delete_at
  ((lambda ( / a)
    ; a = ["ant", "bat", "cat", "dog"]
    ; a.delete_at(2)    #=> "cat"
    ; a                 #=> ["ant", "bat", "dog"]
    ; a.delete_at(99)   #=> nil
    (terpri)(princ "...")(terpri)(princ "testing list delete_at")

    (setq a (list "ant" "bat" "cat" "dog"))

    (assert_equal (dot a delete_at 2) "cat")
    (assert_equal a (list "ant" "bat" "dog"))
    (assert_equal (dot a delete_at 99) nil)
    (assert_equal a (list "ant" "bat" "dog"))
    (assert_equal (dot a delete_at -2) "bat")
    (assert_equal a (list "ant" "dog"))
  ))

  ; TODO: put instant delete check back in after figuring out function scope in interpreter 
  ; delete_if
  ((lambda ( / scores)
    ; scores = [ 97, 42, 75 ]
    ; scores.delete_if {|score| score < 80 }   #=> [97]
    (terpri)(princ "...")(terpri)(princ "testing list delete_if")

    (setq scores (list 97 42 75))

    (assert_equal (dot scores delete_if (lambda (score / ) (< score 70))) (list 97 75))
    (assert_equal scores (list 97 75))
    (assert_equal (dot scores delete_if) scores)
    (assert_equal scores (list 97 75))
    ; (assert_equal (dot scores delete_if (lambda (score / ) (> (dot self length) 1))) (list 75))
    ; (assert_equal scores (list 75))
    (assert_equal (dot scores delete_if (lambda (score / ) (> (NATIVE_FUNCTION_LENGTH (NATIVE_FUNCTION_CAR (eval self))) 1))) (list 75))
    (assert_equal scores (list 75))
  ))  

  ; drop
  ((lambda ( / a)
    ; a = [1, 2, 3, 4, 5, 0]
    ; a.drop(3)             #=> [4, 5, 0]
    (terpri)(princ "...")(terpri)(princ "testing list drop")

    (setq a (list 1 2 3 4 5 0))

    (assert_equal (dot a drop 3) (list 4 5 0))
    (assert_equal a (list 1 2 3 4 5 0))
  ))

  ; drop_while
  ((lambda ( / a)
    ; a = [1, 2, 3, 4, 5, 0]
    ; a.drop_while {|i| i < 3 }   #=> [3, 4, 5, 0]
    (terpri)(princ "...")(terpri)(princ "testing list drop_while")

    (setq a (list 1 2 3 4 5 0))

    (assert_equal (dot a drop_while (lambda (i / ) (< i 3))) (list 3 4 5 0))
    (assert_equal a (list 1 2 3 4 5 0))
  ))

  ; each
  ((lambda ( / a)
    ; a = [ "a", "b", "c" ]
    ; a.each {|x| print x, " -- " }
    ; produces:
    ; a -- b -- c --
    (terpri)(princ "...")(terpri)(princ "testing list each")

    (setq a (list "a" "b" "c"))

    ((lambda ( / old_str_val)
      (setq
        old_str_val str
        str ""
      )

      (assert_equal (dot a each (lambda (x / ) (setq str (strcat str x " -- ")))) a)
      (assert_equal a (list "a" "b" "c"))
      (assert_equal str "a -- b -- c -- ")

      (setq str old_str_val)
    ))
  ))

  ; each_index
  ((lambda ( / a)
    ; a = [ "a", "b", "c" ]
    ; a.each_index {|x| print x, " -- " }
    (terpri)(princ "...")(terpri)(princ "testing list each_index")

    (setq a (list "a" "b" "c"))

    ((lambda ( / old_str_val)
      (setq
        old_str_val str
        str ""
      )

      (assert_equal (dot a each_index (lambda (x / ) (setq str (strcat str (itoa x) " -- ")))) a)
      (assert_equal a (list "a" "b" "c"))
      (assert_equal str "0 -- 1 -- 2 -- ")

      (setq str old_str_val)
    ))
  ))

  ; empty?
  ((lambda ( / )
    (terpri)(princ "...")(terpri)(princ "testing list empty?")

    (assert_equal (dot (newlist nil) empty?) T)
  ))

  ; eql?
  ((lambda ( / array other)
    (terpri)(princ "...")(terpri)(princ "testing list eql?")

    (setq array (list "a" "b" "c"))
    (setq other (list "a" "b" "c"))

    (assert_equal (dot array eql? other) T)
    (assert_equal array (list "a" "b" "c"))
    (assert_equal other (list "a" "b" "c"))

    (assert_equal (dot array eql? (list 1 2 3)) nil)
    (assert_equal array (list "a" "b" "c"))
  ))

  ; fetch
  ((lambda ( / a)
    ; a = [ 11, 22, 33, 44 ]
    ; a.fetch(1)               #=> 22
    ; a.fetch(-1)              #=> 44
    ; a.fetch(4, 'cat')        #=> "cat"
    ; a.fetch(100) { |i| puts "#{i} is out of bounds" } #=> "100 is out of bounds"
    (terpri)(princ "...")(terpri)(princ "testing list fetch")

    (setq a (list 11 22 33 44))

    (assert_equal (dot a fetch 1) 22)
    (assert_equal a (list 11 22 33 44))

    (assert_equal (dot a fetch -1) 44)
    (assert_equal a (list 11 22 33 44))

    (assert_equal (dot a fetch 4 "cat") "cat")
    (assert_equal a (list 11 22 33 44))

    ((lambda ( / old_str_val)
      (setq
        old_str_val str
        str ""
      )

      (assert_equal (dot a fetch 4 "cat" (lambda (i / ) (setq str (itoa i)))) a)
      (assert_equal a (list 11 22 33 44))
      (assert_equal str "4")

      (setq str "")

      (assert_equal (dot a fetch 100 (lambda (i / ) (setq str (strcat (itoa i) " is out of bounds")))) a)
      (assert_equal a (list 11 22 33 44))
      (assert_equal str "100 is out of bounds")

      (setq str old_str_val)
    ))
  ))

  ; ; fill
  ; ((lambda ( / a)
  ;   ; a = [ "a", "b", "c", "d" ]
  ;   ; a.fill("x")              #=> ["x", "x", "x", "x"]
  ;   ; a.fill("z", 2, 2)        #=> ["x", "x", "z", "z"]
  ;   ; a.fill("y", 0..1)        #=> ["y", "y", "z", "z"]
  ;   ; a.fill { |i| i*i }       #=> [0, 1, 4, 9]
  ;   ; a.fill(-2) { |i| i*i*i } #=> [0, 1, 8, 27]
  ;   (terpri)(princ "...")(terpri)(princ "testing list fill")

  ;   (setq a (list "a" "b" "c" "d"))

  ;   (assert_equal (dot a fill "x") (list "x" "x" "x" "x"))
  ;   (assert_equal a (list "x" "x" "x" "x"))

  ;   (assert_equal (dot a fill "z" 2 2) (list "x" "x" "z" "z"))
  ;   (assert_equal a (list "x" "x" "z" "z"))

  ;   ; (assert_equal (dot a fill "y" 0..1) (list "y" "y" "z" "z"))
  ;   ; (assert_equal a (list "y" "y" "z" "z"))
  ;   (setq a (list "y" "y" "z" "z"))

  ;   (assert_equal (dot a fill (lambda (i / ) (* i i))) (list 0 1 4 9))
  ;   (assert_equal a (list 0 1 4 9))

  ;   (assert_equal (dot a fill -2 (lambda (i / ) (* (* i i) i))) (list 0 1 8 27))
  ;   (assert_equal a (list 0 1 8 27))
  ; ))

  ; find_index
  ((lambda ( / a)
    ; a = [ "a", "b", "c" ]
    ; a.index("b")              #=> 1
    ; a.index("z")              #=> nil
    ; a.index { |x| x == "b" }  #=> 1
    (terpri)(princ "...")(terpri)(princ "testing list find_index")

    (setq a (list "a" "b" "c"))

    (assert_equal (dot a find_index "b") 1)
    (assert_equal a (list "a" "b" "c"))

    (assert_equal (dot a find_index "z") nil)
    (assert_equal a (list "a" "b" "c"))

    (assert_equal (dot a find_index (lambda (x / ) (equal x "b"))) 1)
    (assert_equal a (list "a" "b" "c"))

    (assert_equal (dot a find_index) (list "a" "b" "c"))
    (assert_equal a (list "a" "b" "c"))
  ))

  ; first
  ((lambda ( / a)
    ; a = [ "q", "r", "s", "t" ]
    ; a.first     #=> "q"
    ; a.first(2)  #=> ["q", "r"]
    (terpri)(princ "...")(terpri)(princ "testing list first")

    (setq a (list "q" "r" "s" "t"))

    (assert_equal (dot a first) "q")
    (assert_equal a (list "q" "r" "s" "t"))

    (assert_equal (dot a first 2) (list "q" "r"))
    (assert_equal a (list "q" "r" "s" "t"))
  ))

  ; flatten
  ((lambda ( / a b c)
    ; s = [ 1, 2, 3 ]           #=> [1, 2, 3]
    ; t = [ 4, 5, 6, [7, 8] ]   #=> [4, 5, 6, [7, 8]]
    ; a = [ s, t, 9, 10 ]       #=> [[1, 2, 3], [4, 5, 6, [7, 8]], 9, 10]
    ; a.flatten                 #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    ; a = [ 1, 2, [3, [4, 5] ] ]
    ; a.flatten(1)              #=> [1, 2, 3, [4, 5]]
    (terpri)(princ "...")(terpri)(princ "testing list flatten")

    (setq b (list 1 2 3))
    (setq c (list 4 5 6 (list 7 8)))
    (setq a (list b c 9 10))

    (assert_equal (dot a flatten) (list 1 2 3 4 5 6 7 8 9 10))
    (assert_equal a (list (list 1 2 3) (list 4 5 6 (list 7 8)) 9 10))

    (setq a (list 1 2 (list 3 (list 4 5))))

    (assert_equal (dot a flatten 1) (list 1 2 3 (list 4 5)))
    (assert_equal a (list 1 2 (list 3 (list 4 5))))
  ))

  ; flatten!
  ((lambda ( / a)
    ; a = [ 1, 2, [3, [4, 5] ] ]
    ; a.flatten!   #=> [1, 2, 3, 4, 5]
    ; a.flatten!   #=> nil
    ; a            #=> [1, 2, 3, 4, 5]
    ; a = [ 1, 2, [3, [4, 5] ] ]
    ; a.flatten!(1) #=> [1, 2, 3, [4, 5]]
    (terpri)(princ "...")(terpri)(princ "testing list flatten!")

    (setq a (list 1 2 (list 3 (list 4 5))))

    (assert_equal (dot a flatten!) (list 1 2 3 4 5))
    (assert_equal a (list 1 2 3 4 5))

    (assert_equal (dot a flatten!) nil)
    (assert_equal a (list 1 2 3 4 5))

    (setq a (list 1 2 (list 3 (list 4 5))))

    (assert_equal (dot a flatten! 1) (list 1 2 3 (list 4 5)))
    (assert_equal a (list 1 2 3 (list 4 5)))
  ))

  ; ; frozen?
  ; ((lambda ( / a)
  ;   (terpri)(princ "...")(terpri)(princ "testing list frozen?")

  ;   (setq a (list "a" "b" "c"))

  ;   (assert_equal (dot a freeze) (list "a" "b" "c"))
  ;   (assert_equal a (list "a" "b" "c"))

  ;   (assert_equal (dot a frozen?) T)
  ;   (assert_equal a (list "a" "b" "c"))
  ; ))

  ; ; hash
  ; ((lambda ( / )
  ;   (terpri)(princ "...")(terpri)(princ "testing list hash")
  ; ))

  ; include?
  ((lambda ( / a)
    ; a = [ "a", "b", "c" ]
    ; a.include?("b")   #=> true
    ; a.include?("z")   #=> false
    (terpri)(princ "...")(terpri)(princ "testing list include?")

    (setq a (list "a" "b" "c"))

    (assert_equal (dot a include? "b") T)
    (assert_equal a (list "a" "b" "c"))

    (assert_equal (dot a include? "z") nil)
    (assert_equal a (list "a" "b" "c"))
  ))

  ; index
  ((lambda ( / a)
    ; a = [ "a", "b", "c" ]
    ; a.index("b")              #=> 1
    ; a.index("z")              #=> nil
    ; a.index { |x| x == "b" }  #=> 1
    (terpri)(princ "...")(terpri)(princ "testing list index")

    (setq a (list "a" "b" "b" "b" "c"))

    (assert_equal (dot a index "b") 1)
    (assert_equal a (list "a" "b" "b" "b" "c"))

    (assert_equal (dot a index "z") nil)
    (assert_equal a (list "a" "b" "b" "b" "c"))

    (assert_equal (dot a index (lambda (x / ) (equal x "b"))) 1)
    (assert_equal a (list "a" "b" "b" "b" "c"))
  ))

  ; initialize_copy
  ((lambda ( / a)
    ; a = [ "a", "b", "c", "d", "e" ]
    ; a.replace([ "x", "y", "z" ])   #=> ["x", "y", "z"]
    ; a                              #=> ["x", "y", "z"]
    (terpri)(princ "...")(terpri)(princ "testing list initialize_copy")

    (setq a (list "a" "b" "c" "d" "e"))

    (assert_equal (dot a initialize_copy (list "x" "y" "z")) (list "x" "y" "z"))
    (assert_equal a (list "x" "y" "z"))
  ))

  ; insert
  ((lambda ( / a)
    ; a = %w{ a b c d }
    ; a.insert(2, 99)         #=> ["a", "b", 99, "c", "d"]
    ; a.insert(-2, 1, 2, 3)   #=> ["a", "b", 99, "c", 1, 2, 3, "d"]
    (terpri)(princ "...")(terpri)(princ "testing list insert")

    (setq a (list "a" "b" "c" "d"))

    (assert_equal (dot a insert 2 99) (list "a" "b" 99 "c" "d"))
    (assert_equal a (list "a" "b" 99 "c" "d"))

    (assert_equal (dot a insert -2 1 2 3) (list "a" "b" 99 "c" 1 2 3 "d"))
    (assert_equal a (list "a" "b" 99 "c" 1 2 3 "d"))

    (setq a (list "a" "b" "c" "d"))

    (assert_equal (dot a insert 10 "hi") (list "a" "b" "c" "d" nil nil nil nil nil nil "hi"))
    (assert_equal a (list "a" "b" "c" "d" nil nil nil nil nil nil "hi"))

    (assert_equal (dot a insert -1 "hello") (list "a" "b" "c" "d" nil nil nil nil nil nil "hi" "hello"))
    (assert_equal a (list "a" "b" "c" "d" nil nil nil nil nil nil "hi" "hello"))
  ))

  ; inspect
  ((lambda ( / a)
    ; [ "a", "b", "c" ].to_s     #=> "[\"a\", \"b\", \"c\"]" 
    (terpri)(princ "...")(terpri)(princ "testing list inspect")

    (setq a (list "a" "b" "c"))

    (assert_equal (dot a inspect) "(\"a\" \"b\" \"c\")")
    (assert_equal a (list "a" "b" "c"))
  ))

  ; join
  ((lambda ( / )
    ; [ "a", "b", "c" ].join        #=> "abc"
    ; [ "a", "b", "c" ].join("-")   #=> "a-b-c"
    (terpri)(princ "...")(terpri)(princ "testing list join")

    (assert_equal (dot (list "a" "b" "c") join) "abc")
    (assert_equal (dot (list "a" "b" "c") join "-") "a-b-c")
  ))

  ; keep_if
  ((lambda ( / a)
    ; a = %w{ a b c d e f }
    ; a.keep_if { |v| v =~ /[aeiou]/ }  #=> ["a", "e"]
    (terpri)(princ "...")(terpri)(princ "testing list keep_if")

    (setq a (list "a" "b" "c" "d" "e" "f"))

    (assert_equal (dot a keep_if (lambda (v / ) (or (equal v "a") (equal v "e") (equal v "i") (equal v "o") (equal v "u")))) (list "a" "e"))
    (assert_equal a (list "a" "e"))
  ))

  ; last
  ((lambda ( / a)
    ; a = [ "w", "x", "y", "z" ]
    ; a.last     #=> "z"
    ; a.last(2)  #=> ["y", "z"]
    (terpri)(princ "...")(terpri)(princ "testing list last")

    (setq a (list "w" "x" "y" "z"))

    (assert_equal (dot a last) "z")
    (assert_equal a (list "w" "x" "y" "z"))

    (assert_equal (dot a last 2) (list "y" "z"))
    (assert_equal a (list "w" "x" "y" "z"))
  ))

  ; TODO: uncomment after figuring out function scope in interpreter 
  ; ; length
  ; ((lambda ( / )
  ;   ; [ 1, 2, 3, 4, 5 ].length   #=> 5
  ;   ; [].length                  #=> 0
  ;   (terpri)(princ "...")(terpri)(princ "testing list length")

  ;   (assert_equal (dot (list 1 2 3 4 5) length) 5)
  ;   (assert_equal (dot (newlist nil) length) 0)
  ; ))

  ; map
  ((lambda ( / a)
    ; a = [ "a", "b", "c", "d" ]
    ; a.collect { |x| x + "!" }         #=> ["a!", "b!", "c!", "d!"]
    ; a.map.with_index { |x, i| x * i } #=> ["", "b", "cc", "ddd"]
    ; a                                 #=> ["a", "b", "c", "d"]
    (terpri)(princ "...")(terpri)(princ "testing list map")

    (setq a (list "a" "b" "c" "d"))

    (assert_equal (dot a map (lambda (x / ) (strcat x "!"))) (list "a!" "b!" "c!" "d!"))
    (assert_equal a (list "a" "b" "c" "d"))
  ))

  ; map!
  ((lambda ( / a)
    ; a = [ "a", "b", "c", "d" ]
    ; a.map! {|x| x + "!" }
    ; a #=>  [ "a!", "b!", "c!", "d!" ]
    ; a.collect!.with_index {|x, i| x[0...i] }
    ; a #=>  ["", "b", "c!", "d!"]
    (terpri)(princ "...")(terpri)(princ "testing list map!")

    (setq a (list "a" "b" "c" "d"))

    (assert_equal (dot a map! (lambda (x / ) (strcat x "!"))) (list "a!" "b!" "c!" "d!"))
    (assert_equal a (list "a!" "b!" "c!" "d!"))
  ))

  ; ; max
  ; ((lambda ( / a)
  ;   ; a = %w(albatross dog horse)
  ;   ; a.max                                   #=> "horse"
  ;   ; a.max { |a, b| a.length <=> b.length }  #=> "albatross"
  ;   ; a = %w[albatross dog horse]
  ;   ; a.max(2)                                  #=> ["horse", "dog"]
  ;   ; a.max(2) {|a, b| a.length <=> b.length }  #=> ["albatross", "horse"]
  ;   (terpri)(princ "...")(terpri)(princ "testing list max")

  ;   (setq a (list "albatross" "dog" "horse"))

  ;   (assert_equal (dot a max) "horse")
  ;   (assert_equal a (list "albatross" "dog" "horse"))

  ;   (assert_equal (dot a max (lambda (a b / ) (<=> (dot a length) (dot b length)))) "albatross")
  ;   (assert_equal a (list "albatross" "dog" "horse"))

  ;   (assert_equal (dot a max 2) (list "horse" "dog"))
  ;   (assert_equal a (list "albatross" "dog" "horse"))

  ;   (assert_equal (dot a max 2 (lambda (a b / ) (<=> (dot a length) (dot b length)))) (list "albatross" "horse"))
  ;   (assert_equal a (list "albatross" "dog" "horse"))
  ; ))

  ; ; min
  ; ((lambda ( / a)
  ;   ; a = %w(albatross dog horse)
  ;   ; a.min                                   #=> "albatross"
  ;   ; a.min { |a, b| a.length <=> b.length }  #=> "dog"
  ;   ; a = %w[albatross dog horse]
  ;   ; a.min(2)                                  #=> ["albatross", "dog"]
  ;   ; a.min(2) {|a, b| a.length <=> b.length }  #=> ["dog", "horse"]
  ;   (terpri)(princ "...")(terpri)(princ "testing list min")

  ;   (setq a (list "albatross" "dog" "horse"))

  ;   (assert_equal (dot a min) "albatross")
  ;   (assert_equal a (list "albatross" "dog" "horse"))

  ;   (assert_equal (dot a min (lambda (a b / ) (<=> (dot a length) (dot b length)))) "dog")
  ;   (assert_equal a (list "albatross" "dog" "horse"))

  ;   (assert_equal (dot a min 2) (list "albatross" "dog"))
  ;   (assert_equal a (list "albatross" "dog" "horse"))

  ;   (assert_equal (dot a min 2 (lambda (a b / ) (<=> (dot a length) (dot b length)))) (list "dog" "horse"))
  ;   (assert_equal a (list "albatross" "dog" "horse"))
  ; ))

  ; ; pack
  ; ((lambda ( / a n)
  ;   ; a = [ "a", "b", "c" ]
  ;   ; n = [ 65, 66, 67 ]
  ;   ; a.pack("A3A3A3")   #=> "a  b  c  "
  ;   ; a.pack("a3a3a3")   #=> "a\000\000b\000\000c\000\000"
  ;   ; n.pack("ccc")      #=> "ABC"
  ;   (terpri)(princ "...")(terpri)(princ "testing list pack")

  ;   (setq a (list "a" "b" "c"))
  ;   (setq n (list 65 66 67))

  ;   (assert_equal (dot a pack "A3A3A3") "a  b  c  ")
  ;   (assert_equal a (list "a" "b" "c"))

  ;   (assert_equal (dot a pack "a3a3a3") "a\000\000b\000\000c\000\000")
  ;   (assert_equal a (list "a" "b" "c"))

  ;   (assert_equal (dot n pack "ccc") "ABC")
  ;   (assert_equal n (list 65 66 67))
  ; ))

  ; ; permutation
  ; ((lambda ( / a)
  ;   ; a = [1, 2, 3]
  ;   ; a.permutation.to_a    #=> [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
  ;   ; a.permutation(1).to_a #=> [[1],[2],[3]]
  ;   ; a.permutation(2).to_a #=> [[1,2],[1,3],[2,1],[2,3],[3,1],[3,2]]
  ;   ; a.permutation(3).to_a #=> [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
  ;   ; a.permutation(0).to_a #=> [[]] # one permutation of length 0
  ;   ; a.permutation(4).to_a #=> []   # no permutations of length 4
  ;   (terpri)(princ "...")(terpri)(princ "testing list permutation")

  ;   (setq a (list 1 2 3))

  ;   (assert_equal (dot a permutation) (list (list 1 2 3) (list 1 3 2) (list 2 1 3) (list 2 3 1) (list 3 1 2) (list 3 2 1)))
  ;   (assert_equal a (list 1 2 3))

  ;   (assert_equal (dot a permutation 1) (list (list 1) (list 2) (list 3)))
  ;   (assert_equal a (list 1 2 3))

  ;   (assert_equal (dot a permutation 2) (list (list 1 2) (list 1 3) (list 2 1) (list 2 3) (list 3 1) (list 3 2)))
  ;   (assert_equal a (list 1 2 3))

  ;   (assert_equal (dot a permutation 3) (list (list 1 2 3) (list 1 3 2) (list 2 1 3) (list 2 3 1) (list 3 1 2) (list 3 2 1)))
  ;   (assert_equal a (list 1 2 3))

  ;   (assert_equal (dot a permutation 0) (list nil))
  ;   (assert_equal a (list 1 2 3))

  ;   (assert_equal (dot a permutation 4) nil)
  ;   (assert_equal a (list 1 2 3))
  ; ))

  ; pop
  ((lambda ( / a)
    ; a = [ "a", "b", "c", "d" ]
    ; a.pop     #=> "d"
    ; a.pop(2)  #=> ["b", "c"]
    ; a         #=> ["a"]
    (terpri)(princ "...")(terpri)(princ "testing list pop")

    (setq a (list "a" "b" "c" "d"))

    (assert_equal (dot a pop) "d")
    (assert_equal a (list "a" "b" "c"))

    (assert_equal (dot a pop 2) (list "b" "c"))
    (assert_equal a (list "a"))
  ))

  ; product
  ((lambda ( / )
    ; [1,2,3].product([4,5])     #=> [[1,4],[1,5],[2,4],[2,5],[3,4],[3,5]]
    ; [1,2].product([1,2])       #=> [[1,1],[1,2],[2,1],[2,2]]
    ; [1,2].product([3,4],[5,6]) #=> [[1,3,5],[1,3,6],[1,4,5],[1,4,6],[2,3,5],[2,3,6],[2,4,5],[2,4,6]]
    ; [1,2].product()            #=> [[1],[2]]
    ; [1,2].product([])          #=> []
    (terpri)(princ "...")(terpri)(princ "testing list product")

    (assert_equal (dot (list 1 2 3) product (list 4 5)) (list (list 1 4) (list 1 5) (list 2 4) (list 2 5) (list 3 4) (list 3 5)))
    (assert_equal (dot (list 1 2) product (list 1 2)) (list (list 1 1) (list 1 2) (list 2 1) (list 2 2)))
    (assert_equal (dot (list 1 2) product (list 3 4) (list 5 6)) (list (list 1 3 5) (list 1 3 6) (list 1 4 5) (list 1 4 6) (list 2 3 5) (list 2 3 6) (list 2 4 5) (list 2 4 6)))
    (assert_equal (dot (list 1 2) product) (list (list 1) (list 2)))
    (assert_equal (dot (list 1 2) product (newlist nil)) nil)

    ((lambda ( / old_str_val)
      (setq
        old_str_val str
        str ""
      )

      (assert_equal (dot (list 1 2) product (list 3 4) (list 5 6) (lambda (prod / ) (setq str (strcat str "(" (NATIVE_FUNCTION_APPLY 'strcat (NATIVE_FUNCTION_MAPCAR 'itoa (valof prod))) ")")))) (list 1 2))
      (assert_equal str "(135)(136)(145)(146)(235)(236)(245)(246)")

      (setq str old_str_val)
    ))
  ))

  ; push
  ((lambda ( / a)
    ; a = [ "a", "b", "c" ]
    ; a.push("d", "e", "f") #=> ["a", "b", "c", "d", "e", "f"]
    ; [1, 2, 3].push(4).push(5)  #=> [1, 2, 3, 4, 5]
    (terpri)(princ "...")(terpri)(princ "testing list push")

    (setq a (list "a" "b" "c"))

    (assert_equal (dot a push "d" "e" "f") (list "a" "b" "c" "d" "e" "f"))
    (assert_equal a (list "a" "b" "c" "d" "e" "f"))

    (assert_equal (dot (dot (list 1 2 3) push 4) push 5) (list 1 2 3 4 5))
  ))

  ; rassoc
  ((lambda ( / a)
    ; a = [ [ 1, "one"], [2, "two"], [3, "three"], ["ii", "two"] ]
    ; a.rassoc("two")    #=> [2, "two"]
    ; a.rassoc("four")   #=> nil
    (terpri)(princ "...")(terpri)(princ "testing list rassoc")

    (setq a (list (list 1 "one") (list 2 "two") (list three "three") (list "ii" "two")))

    (assert_equal (dot a rassoc "two") (list 2 "two"))
    (assert_equal a (list (list 1 "one") (list 2 "two") (list three "three") (list "ii" "two")))

    (assert_equal (dot a rassoc "four") nil)
    (assert_equal a (list (list 1 "one") (list 2 "two") (list three "three") (list "ii" "two")))
  ))

  ; reject
  ((lambda ( / scores)
    (terpri)(princ "...")(terpri)(princ "testing list reject")

    (setq scores (list 97 42 75))

    (assert_equal (dot scores reject (lambda (score / ) (< score 70))) (list 97 75))
    (assert_equal scores (list 97 42 75))
    (assert_equal (dot scores reject) scores)
    (assert_equal scores (list 97 42 75))
  ))

  ; reject!
  ((lambda ( / scores)
    (terpri)(princ "...")(terpri)(princ "testing list reject!")

    (setq scores (list 97 42 75))

    (assert_equal (dot scores reject! (lambda (score / ) (< score 70))) (list 97 75))
    (assert_equal scores (list 97 75))
    (assert_equal (dot scores reject! (lambda (score / ) (< score 70))) nil)
    (assert_equal scores (list 97 75))
    (assert_equal (dot scores reject!) scores)
    (assert_equal scores (list 97 75))
  ))

  ; ; repeated_combination
  ; ((lambda ( / a)
  ;   ; a = [1, 2, 3]
  ;   ; a.repeated_combination(1).to_a  #=> [[1], [2], [3]]
  ;   ; a.repeated_combination(2).to_a  #=> [[1,1],[1,2],[1,3],[2,2],[2,3],[3,3]]
  ;   ; a.repeated_combination(3).to_a  #=> [[1,1,1],[1,1,2],[1,1,3],[1,2,2],[1,2,3],[1,3,3],[2,2,2],[2,2,3],[2,3,3],[3,3,3]]
  ;   ; a.repeated_combination(4).to_a  #=> [[1,1,1,1],[1,1,1,2],[1,1,1,3],[1,1,2,2],[1,1,2,3],[1,1,3,3],[1,2,2,2],[1,2,2,3],[1,2,3,3],[1,3,3,3],[2,2,2,2],[2,2,2,3],[2,2,3,3],[2,3,3,3],[3,3,3,3]]
  ;   ; a.repeated_combination(0).to_a  #=> [[]] # one combination of length 0
  ;   (terpri)(princ "...")(terpri)(princ "testing list repeated_combination")

  ;   (setq a (list 1 2 3))

  ;   (assert_equal (dot a repeated_combination 1) (list (list 1) (list 2) (list 3)))
  ;   (assert_equal a (list 1 2 3))

  ;   (assert_equal (dot a repeated_combination 2) (list (list 1 1) (list 1 2) (list 1 3) (list 2 2) (list 2 3) (list 3 3)))
  ;   (assert_equal a (list 1 2 3))

  ;   (assert_equal (dot a repeated_combination 3) (list (list 1 1 1) (list 1 1 2) (list 1 1 3) (list 1 2 2) (list 1 2 3) (list 1 3 3) (list 2 2 2) (list 2 2 3) (list 2 3 3) (list 3 3 3)))
  ;   (assert_equal a (list 1 2 3))

  ;   (assert_equal (dot a repeated_combination 4) (list (list 1 1 1 1) (list 1 1 1 2) (list 1 1 1 3) (list 1 1 2 2) (list 1 1 2 3) (list 1 1 3 3) (list 1 2 2 2) (list 1 2 2 3) (list 1 2 3 3) (list 1 3 3 3) (list 2 2 2 2) (list 2 2 2 3) (list 2 2 3 3) (list 2 3 3 3) (list 3 3 3 3)))
  ;   (assert_equal a (list 1 2 3))

  ;   (assert_equal (dot a repeated_combination 0) (list nil))
  ;   (assert_equal a (list 1 2 3))
  ; ))

  ; ; repeated_permutation
  ; ((lambda ( / a)
  ;   ; a = [1, 2]
  ;   ; a.repeated_permutation(1).to_a  #=> [[1], [2]]
  ;   ; a.repeated_permutation(2).to_a  #=> [[1,1],[1,2],[2,1],[2,2]]
  ;   ; a.repeated_permutation(3).to_a  #=> [[1,1,1],[1,1,2],[1,2,1],[1,2,2],[2,1,1],[2,1,2],[2,2,1],[2,2,2]]
  ;   ; a.repeated_permutation(0).to_a  #=> [[]] # one permutation of length 0
  ;   (terpri)(princ "...")(terpri)(princ "testing list repeated_permutation")

  ;   (setq a (list 1 2))

  ;   (assert_equal (dot a repeated_permutation 1) (list (list 1) (list 2)))
  ;   (assert_equal a (list 1 2))

  ;   (assert_equal (dot a repeated_permutation 2) (list (list 1 1) (list 1 2) (list 2 1) (list 2 2)))
  ;   (assert_equal a (list 1 2))

  ;   (assert_equal (dot a repeated_permutation 2) (list (list 1 1 1) (list 1 1 2) (list 1 2 1) (list 1 2 2) (list 2 1 1) (list 2 1 2) (list 2 2 1) (list 2 2 2)))
  ;   (assert_equal a (list 1 2))

  ;   (assert_equal (dot a repeated_permutation 0) (list nil))
  ;   (assert_equal a (list 1 2))
  ; ))

  ; replace
  ((lambda ( / a)
    ; a = [ "a", "b", "c", "d", "e" ]
    ; a.replace([ "x", "y", "z" ])   #=> ["x", "y", "z"]
    ; a                              #=> ["x", "y", "z"]
    (terpri)(princ "...")(terpri)(princ "testing list replace")

    (setq a (list "a" "b" "c" "d" "e"))

    (assert_equal (dot a replace (list "x" "y" "z")) (list "x" "y" "z"))
    (assert_equal a (list "x" "y" "z"))
  ))

  ; reverse
  ((lambda ( / a)
    ; [ "a", "b", "c" ].reverse   #=> ["c", "b", "a"]
    ; [ 1 ].reverse               #=> [1]
    (terpri)(princ "...")(terpri)(princ "testing list reverse")

    (setq a (list "a" "b" "c"))

    (assert_equal (dot a reverse) (list "c" "b" "a"))
    (assert_equal a (list "a" "b" "c"))

    (assert_equal (dot (list 1) reverse) (list 1))
  ))

  ; reverse!
  ((lambda ( / a)
    ; a = [ "a", "b", "c" ]
    ; a.reverse!       #=> ["c", "b", "a"]
    ; a                #=> ["c", "b", "a"]
    (terpri)(princ "...")(terpri)(princ "testing list reverse!")

    (setq a (list "a" "b" "c"))

    (assert_equal (dot a reverse!) (list "c" "b" "a"))
    (assert_equal a (list "c" "b" "a"))
  ))

  ; reverse_each
  ((lambda ( / a)
    ; a = [ "a", "b", "c" ]
    ; a.reverse_each {|x| print x, " " }
    (terpri)(princ "...")(terpri)(princ "testing list reverse_each")

    (setq a (list "a" "b" "c"))

    ((lambda ( / old_str_val)
      (setq
        old_str_val str
        str ""
      )

      (assert_equal (dot a reverse_each (lambda (x / ) (setq str (strcat str x " ")))) a)
      (assert_equal a (list "a" "b" "c"))
      (assert_equal str "c b a ")

      (setq str old_str_val)
    ))
  ))

  ; rindex
  ((lambda ( / a)
    ; a = [ "a", "b", "b", "b", "c" ]
    ; a.rindex("b")             #=> 3
    ; a.rindex("z")             #=> nil
    ; a.rindex { |x| x == "b" } #=> 3
    (terpri)(princ "...")(terpri)(princ "testing list rindex")

    (setq a (list "a" "b" "b" "b" "c"))

    (assert_equal (dot a rindex "b") 3)
    (assert_equal a (list "a" "b" "b" "b" "c"))

    (assert_equal (dot a rindex "z") nil)
    (assert_equal a (list "a" "b" "b" "b" "c"))

    (assert_equal (dot a rindex (lambda (x / ) (equal x "b"))) 3)
    (assert_equal a (list "a" "b" "b" "b" "c"))
  ))

  ; rotate
  ((lambda ( / a)
    ; a = [ "a", "b", "c", "d" ]
    ; a.rotate         #=> ["b", "c", "d", "a"]
    ; a                #=> ["a", "b", "c", "d"]
    ; a.rotate(2)      #=> ["c", "d", "a", "b"]
    ; a.rotate(-3)     #=> ["b", "c", "d", "a"]
    (terpri)(princ "...")(terpri)(princ "testing list rotate")

    (setq a (list "a" "b" "c" "d"))

    (assert_equal (dot a rotate) (list "b" "c" "d" "a"))
    (assert_equal a (list "a" "b" "c" "d"))

    (assert_equal (dot a rotate 2) (list "c" "d" "a" "b"))
    (assert_equal a (list "a" "b" "c" "d"))

    (assert_equal (dot a rotate -3) (list "b" "c" "d" "a"))
    (assert_equal a (list "a" "b" "c" "d"))
  ))

  ; rotate!
  ((lambda ( / a)
    ; a = [ "a", "b", "c", "d" ]
    ; a.rotate!        #=> ["b", "c", "d", "a"]
    ; a                #=> ["b", "c", "d", "a"]
    ; a.rotate!(2)     #=> ["d", "a", "b", "c"]
    ; a.rotate!(-3)    #=> ["a", "b", "c", "d"]
    (terpri)(princ "...")(terpri)(princ "testing list rotate!")

    (setq a (list "a" "b" "c" "d"))

    (assert_equal (dot a rotate!) (list "b" "c" "d" "a"))
    (assert_equal a (list "b" "c" "d" "a"))

    (assert_equal (dot a rotate! 2) (list "d" "a" "b" "c"))
    (assert_equal a (list "d" "a" "b" "c"))

    (assert_equal (dot a rotate! -3) (list "a" "b" "c" "d"))
    (assert_equal a (list "a" "b" "c" "d"))
  ))

  ; DONT: test
  ; ; sample
  ; ((lambda ( / a)
  ;   ; a = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
  ;   ; a.sample         #=> 7
  ;   ; a.sample(4)      #=> [6, 4, 2, 5]
  ;   (terpri)(princ "...")(terpri)(princ "testing list sample")

  ;   (setq a (list 1 2 3 4 5 6 7 8 9 10))
  ; ))

  ; select
  ((lambda ( / a)
    ; [1,2,3,4,5].select { |num|  num.even?  }   #=> [2, 4]
    ; a = %w{ a b c d e f }
    ; a.select { |v| v =~ /[aeiou]/ }  #=> ["a", "e"]
    (terpri)(princ "...")(terpri)(princ "testing list select")

    (assert_equal (dot (list 1 2 3 4 5) select (lambda (num / ) (equal (rem num 2) 0))) (list 2 4))

    (setq a (list "a" "b" "c" "d" "e" "f"))

    (assert_equal (dot a select (lambda (v / ) (or (equal v "a") (equal v "e") (equal v "i") (equal v "o") (equal v "u")))) (list "a" "e"))
    (assert_equal a (list "a" "b" "c" "d" "e" "f"))
  ))

  ; select!
  ((lambda ( / a)
    ; [1,2,3,4,5].select { |num|  num.even?  }   #=> [2, 4]
    ; a = %w{ a b c d e f }
    ; a.select { |v| v =~ /[aeiou]/ }  #=> ["a", "e"]
    (terpri)(princ "...")(terpri)(princ "testing list select!")

    (setq a (list 1 2 3 4 5))

    (assert_equal (dot a select! (lambda (num / ) (equal (rem num 2) 0))) (list 2 4))
    (assert_equal a (list 2 4))

    (setq a (list "a" "b" "c" "d" "e" "f"))

    (assert_equal (dot a select! (lambda (v / ) (or (equal v "a") (equal v "e") (equal v "i") (equal v "o") (equal v "u")))) (list "a" "e"))
    (assert_equal a (list "a" "e"))
  ))

  ; shift
  ((lambda ( / args)
    ; args = [ "-m", "-q", "filename" ]
    ; args.shift     #=> "-m"
    ; args           #=> ["-q", "filename"]
    ; args = [ "-m", "-q", "filename" ]
    ; args.shift(2)  #=> ["-m", "-q"]
    ; args           #=> ["filename"]
    (terpri)(princ "...")(terpri)(princ "testing list shift")

    (setq args (list "-m" "-q" "filename"))

    (assert_equal (dot args shift) "-m")
    (assert_equal args (list "-q" "filename"))

    (setq args (list "-m" "-q" "filename"))

    (assert_equal (dot args shift 2) (list "-m" "-q"))
    (assert_equal args (list "filename"))
  ))

  ; DONT: test
  ; ; shuffle
  ; ((lambda ( / a)
  ;   ; a = [ 1, 2, 3 ]           #=> [1, 2, 3]
  ;   ; a.shuffle                 #=> [2, 3, 1]
  ;   ; a                         #=> [1, 2, 3]
  ;   (terpri)(princ "...")(terpri)(princ "testing list shuffle")

  ;   (setq a (list 1 2 3))

  ;   (assert_equal (dot a shuffle) (list 2 3 1))
  ;   (assert_equal a (list 1 2 3))
  ; ))

  ; DONT: test
  ; ; shuffle!
  ; ((lambda ( / a)
  ;   ; a = [ 1, 2, 3 ]           #=> [1, 2, 3]
  ;   ; a.shuffle!                #=> [2, 3, 1]
  ;   ; a                         #=> [2, 3, 1]
  ;   (terpri)(princ "...")(terpri)(princ "testing list shuffle!")

  ;   (setq a (list 1 2 3))

  ;   (assert_equal (dot a shuffle!) (list 2 3 1))
  ;   (assert_equal a (list 2 3 1))
  ; ))
 
  ; size
  ((lambda ( / )
    ; [ 1, 2, 3, 4, 5 ].length   #=> 5
    ; [].length                  #=> 0
    (terpri)(princ "...")(terpri)(princ "testing list size")

    (assert_equal (dot (list 1 2 3 4 5) size) 5)
    (assert_equal (dot (newlist nil) size) 0)
  ))

  ; slice
  ((lambda ( / a)
    ; a = [ "a", "b", "c", "d", "e" ]
    ; a[2] +  a[0] + a[1]    #=> "cab"
    ; a[6]                   #=> nil
    ; a[1, 2]                #=> [ "b", "c" ]
    ; a[1..3]                #=> [ "b", "c", "d" ]
    ; a[4..7]                #=> [ "e" ]
    ; a[6..10]               #=> nil
    ; a[-3, 3]               #=> [ "c", "d", "e" ]
    ; # special cases
    ; a[5]                   #=> nil
    ; a[6, 1]                #=> nil
    ; a[5, 1]                #=> []
    ; a[5..10]               #=> []
    (terpri)(princ "...")(terpri)(princ "testing list slice")

    (setq a (list "a" "b" "c" "d" "e"))

    (assert_equal (strcat (dot a slice 2) (dot a slice 0) (dot a slice 1)) "cab")
    (assert_equal a (list "a" "b" "c" "d" "e"))

    (assert_equal (dot a slice 6) nil)
    (assert_equal a (list "a" "b" "c" "d" "e"))

    (assert_equal (dot a slice 1 2) (list "b" "c"))
    (assert_equal a (list "a" "b" "c" "d" "e"))

    (assert_equal (dot a slice -3 3) (list "c" "d" "e"))
    (assert_equal a (list "a" "b" "c" "d" "e"))

    (assert_equal (dot a slice 5) nil)
    (assert_equal a (list "a" "b" "c" "d" "e"))

    (assert_equal (dot a slice 6 1) nil)
    (assert_equal a (list "a" "b" "c" "d" "e"))

    (assert_equal (dot a slice 5 1) nil)
    (assert_equal a (list "a" "b" "c" "d" "e"))
  ))

  ; slice!
  ((lambda ( / a)
    ; a = [ "a", "b", "c" ]
    ; a.slice!(1)     #=> "b"
    ; a               #=> ["a", "c"]
    ; a.slice!(-1)    #=> "c"
    ; a               #=> ["a"]
    ; a.slice!(100)   #=> nil
    ; a               #=> ["a"]
    (terpri)(princ "...")(terpri)(princ "testing list slice!")

    (setq a (list "a" "b" "c"))

    (assert_equal (dot a slice! 1) "b")
    (assert_equal a (list "a" "c"))

    (assert_equal (dot a slice! -1) "c")
    (assert_equal a (list "a"))

    (assert_equal (dot a slice! 100) nil)
    (assert_equal a (list "a"))

    (setq a (list "a" "b" "c" "d" "e"))

    (assert_equal (dot a slice! 1 2) (list "b" "c"))
    (assert_equal a (list "a" "d" "e"))

    (assert_equal (dot a slice! -3 2) (list "a" "d"))
    (assert_equal a (list "e"))
  ))

  ; sort
  ((lambda ( / a)
    ; a = [ "d", "a", "e", "c", "b" ]
    ; a.sort                    #=> ["a", "b", "c", "d", "e"]
    ; a.sort { |x,y| y <=> x }  #=> ["e", "d", "c", "b", "a"]
    (terpri)(princ "...")(terpri)(princ "testing list sort")

    (setq a (list "d" "a" "e" "c" "b"))

    (assert_equal (dot a sort) (list "a" "b" "c" "d" "e"))
    (assert_equal a (list "d" "a" "e" "c" "b"))

    (assert_equal (dot a sort (lambda (x y / ) (cond ((equal x y) 0) ((< x y) 1) ((> x y) -1)))) (list "e" "d" "c" "b" "a"))
    (assert_equal a (list "d" "a" "e" "c" "b"))
  ))

  ; sort!
  ((lambda ( / a)
    ; a = [ "d", "a", "e", "c", "b" ]
    ; a.sort!                    #=> ["a", "b", "c", "d", "e"]
    ; a.sort! { |x,y| y <=> x }  #=> ["e", "d", "c", "b", "a"]
    (terpri)(princ "...")(terpri)(princ "testing list sort!")

    (setq a (list "d" "a" "e" "c" "b"))

    (assert_equal (dot a sort!) (list "a" "b" "c" "d" "e"))
    (assert_equal a (list "a" "b" "c" "d" "e"))

    (assert_equal (dot a sort! (lambda (x y / ) (cond ((equal x y) 0) ((< x y) 1) ((> x y) -1)))) (list "e" "d" "c" "b" "a"))
    (assert_equal a (list "e" "d" "c" "b" "a"))
  ))

  ; TODO: uncomment commented tests after implementing global < equal > functions for all objects
  ; sort_by!
  ((lambda ( / a)
    ; Taking a use case from https://allenan.com/how-to-use-sort_by-to-sort-by-multiple-parameters-in-ruby/

    ; Id  Title                       Due Date  Priority
    ; 1   Stop by the Bank            5/5/2015  2
    ; 2   Finish TPS Reports          5/8/2015  1
    ; 3   Buy groceries               5/4/2015  2
    ; 4   Prepare slides for meeting  5/4/2015  1
    ; 5   Water the plants            5/6/2015  3
    ; 6   Schedule dentist appt       5/4/2015  3

    ; tasks.sort_by{ |t| t.due_date }
    ; #or
    ; tasks.sort_by(&:due_date)

    ; Id  Title                       Due Date  Priority
    ; 3   Buy groceries               5/4/2015  2
    ; 4   Prepare slides for meeting  5/4/2015  1
    ; 6   Schedule dentist appt       5/4/2015  3
    ; 1   Stop by the Bank            5/5/2015  2
    ; 5   Water the plants            5/6/2015  3
    ; 2   Finish TPS Reports          5/8/2015  1

    ; tasks.sort_by{ |t| [t.due_date, t.priority] }

    ; Id  Title                       Due Date  Priority
    ; 4   Prepare slides for meeting  5/4/2015  1
    ; 3   Buy groceries               5/4/2015  2
    ; 6   Schedule dentist appt       5/4/2015  3
    ; 1   Stop by the Bank            5/5/2015  2
    ; 5   Water the plants            5/6/2015  3
    ; 2   Finish TPS Reports          5/8/2015  1

    (terpri)(princ "...")(terpri)(princ "testing list sort_by!")

    (setq a (list
        (list 1 "Stop by the Bank"            "5/5/2015" 2)
        (list 2 "Finish TPS Reports"          "5/8/2015" 1)
        (list 3 "Buy groceries"               "5/4/2015" 2)
        (list 4 "Prepare slides for meeting"  "5/4/2015" 1)
        (list 5 "Water the plants"            "5/6/2015" 3)
        (list 6 "Schedule dentist appt"       "5/4/2015" 3)
      )
    )

    (assert_equal (dot a sort_by! (lambda (row / ) (nth 2 row))) (list
        (list 6 "Schedule dentist appt"       "5/4/2015" 3)
        (list 4 "Prepare slides for meeting"  "5/4/2015" 1)
        (list 3 "Buy groceries"               "5/4/2015" 2)
        (list 1 "Stop by the Bank"            "5/5/2015" 2)
        (list 5 "Water the plants"            "5/6/2015" 3)
        (list 2 "Finish TPS Reports"          "5/8/2015" 1)
      )
    )
    (assert_equal a (list
        (list 6 "Schedule dentist appt"       "5/4/2015" 3)
        (list 4 "Prepare slides for meeting"  "5/4/2015" 1)
        (list 3 "Buy groceries"               "5/4/2015" 2)
        (list 1 "Stop by the Bank"            "5/5/2015" 2)
        (list 5 "Water the plants"            "5/6/2015" 3)
        (list 2 "Finish TPS Reports"          "5/8/2015" 1)
      )
    )

    ; (assert_equal (dot a sort_by! (lambda (row / ) (list (nth 2 row) (nth 3 row)))) (list
    ;     (list 4 "Prepare slides for meeting"  "5/4/2015" 1)
    ;     (list 3 "Buy groceries"               "5/4/2015" 2)
    ;     (list 6 "Schedule dentist appt"       "5/4/2015" 3)
    ;     (list 1 "Stop by the Bank"            "5/5/2015" 2)
    ;     (list 5 "Water the plants"            "5/6/2015" 3)
    ;     (list 2 "Finish TPS Reports"          "5/8/2015" 1)
    ;   )
    ; )
    ; (assert_equal a (list
    ;     (list 4 "Prepare slides for meeting"  "5/4/2015" 1)
    ;     (list 3 "Buy groceries"               "5/4/2015" 2)
    ;     (list 6 "Schedule dentist appt"       "5/4/2015" 3)
    ;     (list 1 "Stop by the Bank"            "5/5/2015" 2)
    ;     (list 5 "Water the plants"            "5/6/2015" 3)
    ;     (list 2 "Finish TPS Reports"          "5/8/2015" 1)
    ;   )
    ; )
  ))

  ; TODO: uncomment commented tests after implementing global + function for all objects
  ; sum
  ((lambda ( / )
    ; [].sum                             #=> 0
    ; [].sum(0.0)                        #=> 0.0
    ; [1, 2, 3].sum                      #=> 6
    ; [3, 5.5].sum                       #=> 8.5
    ; [2.5, 3.0].sum(0.0) {|e| e * e }   #=> 15.25
    ; [Object.new].sum                   #=> TypeError
    ; ["a", "b", "c"].sum("")            #=> "abc"
    ; [[1], [[2]], [3]].sum([])          #=> [1, [2], 3]
    (terpri)(princ "...")(terpri)(princ "testing list sum")

    (assert_equal (dot (list nil) sum) 0)
    (assert_equal (dot (list nil) sum 0.0) 0.0)
    (assert_equal (dot (list 1 2 3) sum) 6)
    (assert_equal (dot (list 3 5.5) sum) 8.5)
    (assert_equal (dot (list 2.5 3.0) sum 0.0 (lambda (e / ) (* e e))) 15.25)
    ; (assert_equal (dot (list "a" "b" "c") sum "") "abc")
    ; (assert_equal (dot (list (list 1) (list (list 2)) (list 3)) sum (list nil)) (list 1 (list 2) 3))
  ))

  ; take
  ((lambda ( / a)
    ; a = [1, 2, 3, 4, 5, 0]
    ; a.take(3)             #=> [1, 2, 3]
    (terpri)(princ "...")(terpri)(princ "testing list take")

    (setq a (list 1 2 3 4 5 0))

    (assert_equal (dot a take 3) (list 1 2 3))
    (assert_equal a (list 1 2 3 4 5 0))
  ))

  ; take_while
  ((lambda ( / a)
    ; a = [1, 2, 3, 4, 5, 0]
    ; a.take_while { |i| i < 3 }  #=> [1, 2]
    (terpri)(princ "...")(terpri)(princ "testing list take_while")

    (setq a (list 1 2 3 4 5 0))

    (assert_equal (dot a take_while (lambda (i / ) (< i 3))) (list 1 2))
    (assert_equal a (list 1 2 3 4 5 0))
  ))

  ; ; to_a
  ; ((lambda ( / a)
  ;   (terpri)(princ "...")(terpri)(princ "testing list to_a")

  ;   ; (setq a (list "a" "b" "c"))
  ; ))

  ; ; to_ary
  ; ((lambda ( / a)
  ;   (terpri)(princ "...")(terpri)(princ "testing list to_ary")

  ;   ; (setq a (list "a" "b" "c"))
  ; ))

  ; ; to_h
  ; ((lambda ( / a)
  ;   (terpri)(princ "...")(terpri)(princ "testing list to_h")

  ;   ; (setq a (list "a" "b" "c"))
  ; ))

  ; to_s
  ((lambda ( / a)
    ; [ "a", "b", "c" ].to_s     #=> "[\"a\", \"b\", \"c\"]" 
    (terpri)(princ "...")(terpri)(princ "testing list to_s")

    (setq a (list "a" "b" "c"))

    (assert_equal (dot a to_s) "(\"a\" \"b\" \"c\")")
    (assert_equal a (list "a" "b" "c"))
  ))

  ; transpose
  ((lambda ( / a)
    ; a = [[1,2], [3,4], [5,6]]
    ; a.transpose   #=> [[1, 3, 5], [2, 4, 6]]
    (terpri)(princ "...")(terpri)(princ "testing list transpose")

    (setq a (list (list 1 2) (list 3 4) (list 5 6)))

    (assert_equal (dot a transpose) (list (list 1 3 5) (list 2 4 6)))
    (assert_equal a (list (list 1 2) (list 3 4) (list 5 6)))

    (setq a
      (list
        (list
          (list
            "000" "001" "002"
          )
          (list
            "010" "011" "012"
          )
          (list
            "020" "021" "022"
          )
        )
        (list
          (list
            "100" "101" "102"
          )
          (list
            "110" "111" "112"
          )
          (list
            "120" "121" "122"
          )
        )
        (list
          (list
            "200" "201" "202"
          )
          (list
            "210" "211" "212"
          )
          (list
            "220" "221" "222"
          )
        )
      )
    )

    (assert_equal (dot a transpose)
      (list
        (list
          (list
            "000" "001" "002"
          )
          (list
            "100" "101" "102"
          )
          (list
            "200" "201" "202"
          )
        )
        (list
          (list
            "010" "011" "012"
          )
          (list
            "110" "111" "112"
          )
          (list
            "210" "211" "212"
          )
        )
        (list
          (list
            "020" "021" "022"
          )
          (list
            "120" "121" "122"
          )
          (list
            "220" "221" "222"
          )
        )
      )
    )
    (assert_equal a
      (list
        (list
          (list
            "000" "001" "002"
          )
          (list
            "010" "011" "012"
          )
          (list
            "020" "021" "022"
          )
        )
        (list
          (list
            "100" "101" "102"
          )
          (list
            "110" "111" "112"
          )
          (list
            "120" "121" "122"
          )
        )
        (list
          (list
            "200" "201" "202"
          )
          (list
            "210" "211" "212"
          )
          (list
            "220" "221" "222"
          )
        )
      )
    )
  ))

  ; uniq
  ((lambda ( / a)
    ; a = [ "a", "a", "b", "b", "c" ]
    ; a.uniq   # => ["a", "b", "c"]
    ; b = [["student","sam"], ["student","george"], ["teacher","matz"]]
    ; b.uniq { |s| s.first } # => [["student", "sam"], ["teacher", "matz"]]
    (terpri)(princ "...")(terpri)(princ "testing list uniq")

    (setq a (list "a" "a" "b" "b" "c"))

    (assert_equal (dot a uniq) (list "a" "b" "c"))
    (assert_equal a (list "a" "a" "b" "b" "c"))

    (setq a (list (list "student" "sam") (list "student" "george") (list "teacher" "matz")))

    (assert_equal (dot a uniq (lambda (s / ) (car s))) (list (list "student" "sam") (list "teacher" "matz")))
    (assert_equal a (list (list "student" "sam") (list "student" "george") (list "teacher" "matz")))
  ))

  ; uniq!
  ((lambda ( / a)
    ; a = [ "a", "a", "b", "b", "c" ]
    ; a.uniq!   # => ["a", "b", "c"]
    ; b = [ "a", "b", "c" ]
    ; b.uniq!   # => nil
    ; c = [["student","sam"], ["student","george"], ["teacher","matz"]]
    ; c.uniq! { |s| s.first } # => [["student", "sam"], ["teacher", "matz"]]
    (terpri)(princ "...")(terpri)(princ "testing list uniq!")

    (setq a (list "a" "a" "b" "b" "c"))

    (assert_equal (dot a uniq!) (list "a" "b" "c"))
    (assert_equal a (list "a" "b" "c"))

    (assert_equal (dot a uniq!) nil)
    (assert_equal a (list "a" "b" "c"))

    (setq a (list (list "student" "sam") (list "student" "george") (list "teacher" "matz")))

    (assert_equal (dot a uniq! (lambda (s / ) (car s))) (list (list "student" "sam") (list "teacher" "matz")))
    (assert_equal a (list (list "student" "sam") (list "teacher" "matz")))
  ))

  ; unshift
  ((lambda ( / a)
    ; a = [ "b", "c", "d" ]
    ; a.unshift("a")   #=> ["a", "b", "c", "d"]
    ; a.unshift(1, 2)  #=> [ 1, 2, "a", "b", "c", "d"]
    (terpri)(princ "...")(terpri)(princ "testing list unshift")

    (setq a (list "b" "c" "d"))

    (assert_equal (dot a unshift "a") (list "a" "b" "c" "d"))
    (assert_equal a (list "a" "b" "c" "d"))

    (assert_equal (dot a unshift 1 2) (list 1 2 "a" "b" "c" "d"))
    (assert_equal a (list 1 2 "a" "b" "c" "d"))
  ))

  ; values_at
  ((lambda ( / a)
    ; a = %w{ a b c d e f }
    ; a.values_at(1, 3, 5)          # => ["b", "d", "f"]
    ; a.values_at(1, 3, 5, 7)       # => ["b", "d", "f", nil]
    ; a.values_at(-1, -2, -2, -7)   # => ["f", "e", "e", nil]
    ; a.values_at(4..6, 3...6)      # => ["e", "f", nil, "d", "e", "f"]
    (terpri)(princ "...")(terpri)(princ "testing list values_at")

    (setq a (list "a" "b" "c" "d" "e" "f"))

    (assert_equal (dot a values_at 1 3 5) (list "b" "d" "f"))
    (assert_equal a (list "a" "b" "c" "d" "e" "f"))

    (assert_equal (dot a values_at 1 3 5 7) (list "b" "d" "f" nil))
    (assert_equal a (list "a" "b" "c" "d" "e" "f"))

    (assert_equal (dot a values_at -1 -2 -2 -7) (list "f" "e" "e" nil))
    (assert_equal a (list "a" "b" "c" "d" "e" "f"))

    (assert_equal (dot a values_at 4 5 6 3 4 5 6) (list "e" "f" nil "d" "e" "f" nil))
    (assert_equal a (list "a" "b" "c" "d" "e" "f"))
  ))

  ; zip
  ((lambda ( / a b)
    ; a = [ 4, 5, 6 ]
    ; b = [ 7, 8, 9 ]
    ; [1, 2, 3].zip(a, b)   #=> [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
    ; [1, 2].zip(a, b)      #=> [[1, 4, 7], [2, 5, 8]]
    ; a.zip([1, 2], [8])    #=> [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
    (terpri)(princ "...")(terpri)(princ "testing list zip")

    (setq a (list 4 5 6))
    (setq b (list 7 8 9))

    (assert_equal (dot (list 1 2 3) zip a b) (list (list 1 4 7) (list 2 5 8) (list 3 6 9)))
    (assert_equal (dot (list 1 2) zip a b) (list (list 1 4 7) (list 2 5 8)))

    (assert_equal (dot a zip (list 1 2) (list 8)) (list (list 4 1 8) (list 5 2 nil) (list 6 nil nil)))
    (assert_equal a (list 4 5 6))

    ((lambda ( / old_str_val)
      (setq
        old_str_val str
        str ""
      )

      (assert_equal (dot (list 1 2 3) zip (list 4 5 6) (lambda (sub / ) (setq str (strcat str "(" (NATIVE_FUNCTION_APPLY 'strcat (NATIVE_FUNCTION_MAPCAR 'itoa (valof sub))) ")")))) nil)
      (assert_equal str "(14)(25)(36)")

      (setq str old_str_val)
    ))
  ))

  ; ; method
  ; ((lambda ( / a)
  ;   (terpri)(princ "...")(terpri)(princ "testing list method")

  ;   ; (setq a (list "a" "b" "c"))
  ; ))
)

(testlist)

(if all_tests_passed
  (progn
    (terpri)(princ "...")(terpri)(princ "All tests passed")
  )
)

))

; Author: Lucas Winningham
; Date:   2017Mar24

; All methods contained herein are my best replication of Ruby 2.4.0 Array and Enumerator for lists in Lisp specifically for use with AutoCAD
; Unless otherwise specified, all methods function identically to those in Ruby's Array and Enumerator objects
;   Does not return Enumerators; however, the Enumerator object methods will be accessible for lists

; TODO: method descriptions
; TODO: create argument type checking functions
; TODO: type check arguments using arugment type checking functions

; commands to return to interpreter
'(lambda ( / )
  ;
  ; redefine list functions
  ;
  (defun append (list1 list2 / )
    (newlist (NATIVE_FUNCTION_APPEND (valof list1) (valof list2)))
  )

  (defun apply (fn lst / )
    (newlist (NATIVE_FUNCTION_APPLY fn (valof lst)))
  )

  (defun assoc (item alist / )
    (newlist (NATIVE_FUNCTION_ASSOC item (valof alist)))
  )

  (defun car (lst / )
    (NATIVE_FUNCTION_CAR (valof lst))
  )

  (defun cdr (lst / )
    (NATIVE_FUNCTION_CDR (valof lst))
  )
  
  (defun caar (lst / )
    (NATIVE_FUNCTION_CAAR (valof lst))
  )
  
  (defun cadr (lst / )
    (NATIVE_FUNCTION_CADR (valof lst))
  )
  
  (defun cdar (lst / )
    (NATIVE_FUNCTION_CDAR (valof lst))
  )
  
  (defun cddr (lst / )
    (NATIVE_FUNCTION_CDDR (valof lst))
  )
  
  (defun caaar (lst / )
    (NATIVE_FUNCTION_CAAAR (valof lst))
  )
  
  (defun caadr (lst / )
    (NATIVE_FUNCTION_CAADR (valof lst))
  )
  
  (defun cadar (lst / )
    (NATIVE_FUNCTION_CADAR (valof lst))
  )
  
  (defun caddr (lst / )
    (NATIVE_FUNCTION_CADDR (valof lst))
  )
  
  (defun cdaar (lst / )
    (NATIVE_FUNCTION_CDAAR (valof lst))
  )
  
  (defun cdadr (lst / )
    (NATIVE_FUNCTION_CDADR (valof lst))
  )
  
  (defun cddar (lst / )
    (NATIVE_FUNCTION_CDDAR (valof lst))
  )
  
  (defun cdddr (lst / )
    (NATIVE_FUNCTION_CDDDR (valof lst))
  )
  
  (defun caaaar (lst / )
    (NATIVE_FUNCTION_CAAAAR (valof lst))
  )
  
  (defun caaadr (lst / )
    (NATIVE_FUNCTION_CAAADR (valof lst))
  )
  
  (defun caadar (lst / )
    (NATIVE_FUNCTION_CAADAR (valof lst))
  )
  
  (defun caaddr (lst / )
    (NATIVE_FUNCTION_CAADDR (valof lst))
  )
  
  (defun caddar (lst / )
    (NATIVE_FUNCTION_CADDAR (valof lst))
  )
  
  (defun cadaar (lst / )
    (NATIVE_FUNCTION_CADAAR (valof lst))
  )
  
  (defun cadadr (lst / )
    (NATIVE_FUNCTION_CADADR (valof lst))
  )
  
  (defun cadddr (lst / )
    (NATIVE_FUNCTION_CADDDR (valof lst))
  )
  
  (defun cdaaar (lst / )
    (NATIVE_FUNCTION_CDAAAR (valof lst))
  )
  
  (defun cdaadr (lst / )
    (NATIVE_FUNCTION_CDAADR (valof lst))
  )
  
  (defun cdadar (lst / )
    (NATIVE_FUNCTION_CDADAR (valof lst))
  )
  
  (defun cdaddr (lst / )
    (NATIVE_FUNCTION_CDADDR (valof lst))
  )
  
  (defun cddaar (lst / )
    (NATIVE_FUNCTION_CDDAAR (valof lst))
  )
  
  (defun cddadr (lst / )
    (NATIVE_FUNCTION_CDDADR (valof lst))
  )
  
  (defun cdddar (lst / )
    (NATIVE_FUNCTION_CDDDAR (valof lst))
  )
  
  (defun cddddr (lst / )
    (NATIVE_FUNCTION_CDDDDR (valof lst))
  )
  
  (defun cons (new_first_element lst / )
    (newlist (NATIVE_FUNCTION_CONS new_first_element (valof lst)))
  )
  
  ; takes a lambda wrapper as expr argument from interpreter
  (defun foreach (name lst expr / )
    ((lambda ( / i item)
      (setq i 0)

      (while (< i (length lst))
        (setq item (nth i lst))

        (apply expr (NATIVE_FUNCTION_LIST (valof item)))

        (setq i (1+ i))
      )
    ))
  )
  
  (defun last (lst / )
    (NATIVE_FUNCTION_LAST (valof lst))
  )
  
  (defun length (lst / )
    (NATIVE_FUNCTION_LENGTH (valof lst))
  )

  (defun list (&rest / )
    (if (and (equal (NATIVE_FUNCTION_LENGTH &rest) 1) (equal (NATIVE_FUNCTION_CAR &rest) nil))
      (newlist nil)
    ;else
      (newlist &rest)
    )
  )
  
  (defun listp (lst / )
    (NATIVE_FUNCTION_LISTP (valof lst))
  )
  
  (defun member (expr lst / )
    (newlist (NATIVE_FUNCTION_MEMBER expr (valof lst)))
  )
  
  (defun mapcar (fn &rest / )
    ((lambda ( / stop new_list)
      (setq
        stop (length (NATIVE_FUNCTION_CAR &rest))
        new_list nil
      )

      ((lambda ( / i lst len)
        (setq i 1)

        (while (< i (NATIVE_FUNCTION_LENGTH &rest))
          (setq
            lst (NATIVE_FUNCTION_NTH i &rest)
            len (length lst)
          )

          (if (< len stop)
            (setq stop len)
          )

          (setq i (1+ i))
        )
      ))

      ((lambda ( / i col_list)
        (setq i 0)

        (while (< i stop)
          (setq col_list nil)

          ((lambda ( / j rest_list)
            (setq j 0)

            (while (< j (NATIVE_FUNCTION_LENGTH &rest))
              (setq
                rest_list (NATIVE_FUNCTION_NTH j &rest)
                col_list (NATIVE_FUNCTION_APPEND col_list (nth i rest_list))
                j (1+ j)
              )
            )
          ))

          (setq new_list (NATIVE_FUNCTION_APPEND new_list (apply fn col_list)))

          (setq i (1+ i))
        )
      ))

      (newlist new_list)
    ))
  )
  
  (defun nth (n lst / )
    (NATIVE_FUNCTION_NTH n (valof lst))
  )
  
  (defun reverse (lst / )
    (newlist (NATIVE_FUNCTION_REVERSE (valof lst)))
  )
  
  (defun subst (newitem olditem lst / )
    (newlist (NATIVE_FUNCTION_SUBST newitem olditem (valof lst)))
  )

  ;
  ; trace redefined list functions
  ;
  (if debug_trace
    (progn
      (trace append)
      (trace apply)
      (trace assoc)
      (trace car)
      (trace cdr)
      (trace caar)
      (trace cadr)
      (trace cdar)
      (trace cddr)
      (trace caaar)
      (trace caadr)
      (trace cadar)
      (trace caddr)
      (trace cdaar)
      (trace cdadr)
      (trace cddar)
      (trace cdddr)
      (trace caaaar)
      (trace caaadr)
      (trace caadar)
      (trace caaddr)
      (trace cadaar)
      (trace cadadr)
      (trace caddar)
      (trace cadddr)
      (trace cdaaar)
      (trace cdaadr)
      (trace cdadar)
      (trace cdaddr)
      (trace cddaar)
      (trace cddadr)
      (trace cdddar)
      (trace cddddr)
      (trace cons)
      (trace foreach)
      (trace last)
      (trace length)
      (trace list)
      (trace listp)
      (trace mapcar)
      (trace member)
      (trace nth)
      (trace reverse)
      (trace subst)
    )
  )

  ;
  ; list object constructor
  ;
  (defun newlist (lst / )
    (NATIVE_FUNCTION_LIST
      ; initial list
      (valof lst)

      ; type
      'LISTOBJECT

      ; methods
      (lambda (self method params / l methods
                error_integer
                normalize_index
                rotate_index

                any?
                assoc
                at
                bsearch
                bsearch_index
                clear
                collect
                collect!
                compact
                compact!
                concat
                count
                cycle
                delete
                delete_at
                delete_if
                drop
                drop_while
                each
                each_index
                empty?
                eql?
                fetch
                fill
                find_index
                first
                flatten
                flatten!
                frozen?
                hash
                include?
                index
                initialize_copy
                insert
                inspect
                join
                keep_if
                last
                ; length
                map
                map!
                max
                min
                pack
                permutation
                pop
                product
                push
                rassoc
                reject
                reject!
                repeated_combination
                repeated_permutation
                replace
                reverse
                reverse!
                reverse_each
                rindex
                rotate
                rotate!
                sample
                select
                select!
                size
                slice
                slice!
                sort
                sort!
                sort_by!
                sum
                take
                take_while
                to_a
                to_ary
                to_h
                to_s
                transpose
                uniq
                uniq!
                unshift
                values_at
                zip
              )

        ; trace methods
        (if debug_trace
          (progn
            (trace error_integer)
            (trace normalize_index)
            (trace rotate_index)

            (trace any?)
            (trace assoc)
            (trace at)
            (trace collect)
            (trace collect!)
            (trace compact)
            (trace compact!)
            (trace concat)
            (trace count)
            (trace cycle)
            (trace delete)
            (trace delete_at)
            (trace delete_if)
            (trace drop)
            (trace drop_while)
            (trace each)
            (trace each_index)
            (trace empty?)
            (trace eql?)
            (trace fetch)
            (trace fill)
            (trace find_index)
            (trace first)
            (trace flatten)
            (trace flatten!)
            (trace frozen?)
            (trace hash)
            (trace include?)
            (trace index)
            (trace initialize_copy)
            (trace insert)
            (trace inspect)
            (trace join)
            (trace keep_if)
            (trace last)
            (trace length)
            (trace map)
            (trace map!)
            (trace max)
            (trace min)
            (trace pack)
            (trace permutation)
            (trace pop)
            (trace product)
            (trace push)
            (trace rassoc)
            (trace reject)
            (trace reject!)
            (trace repeated_combination)
            (trace repeated_permutation)
            (trace replace)
            (trace reverse)
            (trace reverse!)
            (trace reverse_each)
            (trace rindex)
            (trace rotate)
            (trace rotate!)
            (trace sample)
            (trace select)
            (trace select!)
            (trace shift)
            (trace shuffle)
            (trace shuffle!)
            (trace size)
            (trace slice)
            (trace slice!)
            (trace sort)
            (trace sort!)
            (trace sort_by!)
            (trace sum)
            (trace take)
            (trace take_while)
            (trace to_a)
            (trace to_ary)
            (trace to_h)
            (trace to_s)
            (trace transpose)
            (trace uniq)
            (trace uniq!)
            (trace unshift)
            (trace values_at)
            (trace zip)
          )
        )

        (setq l (NATIVE_FUNCTION_CAR (eval self)))
        (setq methods (NATIVE_FUNCTION_CADDR (eval self)))

        ;
        ; helpers
        ;

        ; takes object to check if native INT object
        ; takes lower and upper bound symbols to error against
        ; raises errors through configuration of lower and upper bounds, otherwise returns nil
        (defun error_integer (lower_bound index upper_bound method_called / )
          (if (not (equal (type index) 'INT))
            (raise "list method '" method_called "' given integer argument not of type INT -> " index)
          )

          (cond
            ((equal lower_bound 'ZERO)
              (if (< index 0)
                (raise "list method '" method_called "' given non-positive integer argument -> " index)
              )
            )
            ((equal lower_bound 'NEGLEN)
              (if (< index (- 0 (NATIVE_FUNCTION_LENGTH l)))
                (raise "list method '" method_called "' given integer argument less than negative length of list -> " index)
              )
            )
          )

          (cond
            ((equal upper_bound 'LEN)
              (if (> index (NATIVE_FUNCTION_LENGTH l))
                (raise "list method '" method_called "' given integer argument greater than length of list -> " index)
              )
            )
          )

          nil
        )

        ; takes index integer
        ; returns index within range of -length to length-1
        (defun normalize_index (index / remainder)
          (setq remainder (rem index (NATIVE_FUNCTION_LENGTH l)))

          (if (and (equal remainder 0) (< index 0))
            (- 0 (NATIVE_FUNCTION_LENGTH l))
          ;else
            remainder
          )
        )

        ; takes index integer
        ; returns addition of index and length of self if negative, otherwise returns same index
        ; usually used with normalize_index
        (defun rotate_index (index / )
          (if (< index 0)
            (+ index (NATIVE_FUNCTION_LENGTH l))
            index
          )
        )

        ;
        ; methods
        ;

        (defun any? ( / block)
          ; any? [{ |object| block }] → true or false
          ; See also Enumerable#any?
          ; any? [{ |object| block }] → true or false
          ; Passes each element of the collection to the given block.
          ; The method returns true if the block ever returns a value other than false or nil.
          ; If the block is not given, Ruby adds an implicit block of { |object| object } that will cause any? to return true if at least one of the collection members is not false or nil.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (not (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR))
              (raise "list method 'any?' given block not of type SUBR -> " block)
            ;else
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )

          (if (not block)
            (setq block '(lambda (item / ) item))
          )

          ((lambda ( / i found item)
            (setq
              i 0
              found nil
            )

            (while (and (not found) (< i (NATIVE_FUNCTION_LENGTH l)))
              (setq item (NATIVE_FUNCTION_NTH i l))

              (if (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST item))
                (setq found T)
              )

              (setq i (1+ i))
            )

            found
          ))
        )

        (defun assoc ( / obj)
          ; assoc(object) → element_ary or nil
          ; Searches through an array whose elements are also arrays comparing object with the first element of each contained array using object.==.
          ; Returns the first contained array that matches (that is, the first associated array), or nil if no match is found.

          (setq obj nil)

          (if (not params)
            (raise "list method 'assoc' not given obj argument")
          )

          (setq obj (NATIVE_FUNCTION_CAR params))
          
          ((lambda ( / i found ret_list sub_list)
            (setq
              i 0
              found nil
              ret_list nil
            )

            (while (and (not found) (< i (NATIVE_FUNCTION_LENGTH l)))
              (setq sub_list (NATIVE_FUNCTION_NTH i l))

              (if (equal (type (valof sub_list)) 'LIST)
                (if (equal obj (car sub_list))
                  (setq
                    ret_list (valof sub_list)
                    found T
                  )
                )
              )

              (setq i (1+ i))
            )

            (newlist ret_list)
          ))
        )

        (defun at ( / index)
          ; at(index) → object or nil
          ; Returns the element at index.
          ; A negative index counts from the end of self.
          ; Returns nil if the index is out of range.
          ; See also #[].

          (setq index nil)

          (if (not params)
            (raise "list method 'at' not given index argument")
          )

          (setq index (NATIVE_FUNCTION_CAR params))

          (error_integer 'UNLIMITED index 'UNLIMITED "at")

          (setq index (rotate_index index))

          (if (< index 0)
            nil
          ;else
            (NATIVE_FUNCTION_NTH index l)
          )
        )


        ; TODO: implement
        (defun bsearch ( / block)
          ; bsearch {|x| block } → elem
          ; By using binary search, finds a value from this array which meets the given condition in O(log n) where n is the size of the array.
          ; You can use this method in two use cases: a find-minimum mode and a find-any mode.
          ; In either case, the elements of the array must be monotone (or sorted) with respect to the block.
          ; In find-minimum mode (this is a good choice for typical use case), the block must return true or false, and there must be an index i (0 <= i <= ary.size) so that:
          ;   the block returns false for any element whose index is less than i, and
          ;   the block returns true for any element whose index is greater than or equal to i.
          ; This method returns the i-th element. If i is equal to ary.size, it returns nil.
          ; In find-any mode (this behaves like libc’s bsearch(3)), the block must return a number, and there must be two indices i and j (0 <= i <= j <= ary.size) so that:
          ;   the block returns a positive number for ary if 0 <= k < i,
          ;   the block returns zero for ary if i <= k < j, and
          ;   the block returns a negative number for ary if j <= k < ary.size.
          ; Under this condition, this method returns any element whose index is within i…j.
          ; If i is equal to j (i.e., there is no element that satisfies the block), this method returns nil.
          ; You must not mix the two modes at a time; the block must always return either true/false, or always return a number.
          ; It is undefined which value is actually picked up at each iteration.

          nil
        )

        ; TODO: implement
        (defun bsearch_index ( / block)
          ; bsearch_index {|x| block } → int or nil
          ; By using binary search, finds an index of a value from this array which meets the given condition in O(log n) where n is the size of the array.
          ; It supports two modes, depending on the nature of the block and they are exactly the same as in the case of bsearch method with the only difference being that this method returns the index of the element instead of the element itself.
          ; For more details consult the documentation for bsearch.

          nil
        )

        (defun clear ( / )
          ; clear → ary
          ; Removes all elements from self.

          (set self (newlist nil))

          (eval self)
        )

        (defun collect ( / block)
          ; collect { |item| block } → new_ary
          ; collect → Enumerator
          ; Invokes the given block once for each element of self.
          ; Creates a new array containing the values returned by the block.
          ; See also Enumerable#collect.
          ; If no block is given, an Enumerator is returned instead.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (not (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR))
              (raise "list method 'collect' given block not of type SUBR -> " block)
            ;else
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )

          (if block
            (newlist (NATIVE_FUNCTION_MAPCAR block l))
          ;else
            (eval self)
          )
        )

        (defun collect! ( / )
          ; collect! {|item| block } → ary
          ; collect! → Enumerator
          ; Invokes the given block once for each element of self, replacing the element with the value returned by the block.
          ; See also Enumerable#collect.
          ; If no block is given, an Enumerator is returned instead.

          (set self (collect))
        )

        ; TODO: implement
        (defun combination ( / n block)
          ; combination(n) { |c| block } → ary
          ; combination(n) → Enumerator
          ; When invoked with a block, yields all combinations of length n of elements from the array and then returns the array itself.
          ; The implementation makes no guarantees about the order in which the combinations are yielded.
          ; If no block is given, an Enumerator is returned instead.

          nil
        )

        (defun compact ( / )
          ; compact → new_ary
          ; Returns a copy of self with all nil elements removed.

          ((lambda ( / i ret_list item)
            (setq
              i 0
              ret_list nil
            )

            (while (< i (NATIVE_FUNCTION_LENGTH l))
              (setq item (NATIVE_FUNCTION_NTH i l))
              
              (if item
                (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))
              )

              (setq i (1+ i))
            )

            (newlist ret_list)
          ))
        )

        (defun compact! ( / )
          ; compact! → ary or nil
          ; Removes nil elements from the array.
          ; Returns nil if no changes were made, otherwise returns the array.

          ((lambda ( / naught final)
            (setq naught (NATIVE_FUNCTION_LENGTH (valof self)))

            (set self (compact))

            (setq final (NATIVE_FUNCTION_LENGTH (valof self)))

            (if (equal naught final)
              nil
            ;else
              (eval self)
            )
          ))
        )

        (defun concat ( / other_lists)
          ; concat(other_ary1, other_ary2,...) → ary
          ; Appends the elements of +other_ary+s to self.

          (setq other_lists params)

          (if other_lists
            ((lambda ( / i new_list sub_list)
              (setq
                i 0
                new_list l
              )

              (while (< i (NATIVE_FUNCTION_LENGTH other_lists))
                (setq sub_list (NATIVE_FUNCTION_NTH i other_lists))

                (if (not (equal (NATIVE_FUNCTION_TYPE sub_list) 'LIST))
                  (raise "list method 'concat' given association list with association not of type LIST -> " other_lists)
                )

                (setq new_list (NATIVE_FUNCTION_APPEND new_list (valof sub_list)))

                (setq i (1+ i))
              )

              (set self (newlist new_list))
            ))
          )

          (eval self)
        )

        (defun count ( / block)
          ; count → int
          ; count(obj) → int
          ; count { |item| block } → int
          ; Returns the number of elements.
          ; If an argument is given, counts the number of elements which equal obj using ==.
          ; If a block is given, counts the number of elements for which the block returns a true value.

          (setq block nil)

          (if params
            (progn
              ; determine if block or obj
              (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
                ; is block
                (cond
                  ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                    (setq block (NATIVE_FUNCTION_CAR params))
                  )

                  ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                    (setq block '(NATIVE_FUNCTION_CAR params))
                  )

                  (T
                    nil
                  )
                )
              ;else
                ; is object, set block to examine equality of items in list to obj
                (setq block '(lambda (item / ) (equal item (NATIVE_FUNCTION_CAR params))))
              )

              ((lambda ( / i count item)
                (setq
                  i 0
                  count 0
                )

                (while (< i (NATIVE_FUNCTION_LENGTH L))
                  (setq item (NATIVE_FUNCTION_NTH i l))
                  
                  (if (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST item))
                    (setq count (1+ count))
                  )

                  (setq i (1+ i))
                )

                count
              ))
            )
          ;else
            (NATIVE_FUNCTION_LENGTH l)
          )
        )

        ; DONT: cycle forever
        (defun cycle ( / n block)
          ; cycle(n=nil) { |obj| block } → nil
          ; cycle(n=nil) → Enumerator
          ; Calls the given block for each element n times or forever if nil is given.
          ; Does nothing if a non-positive number is given or the array is empty.
          ; Returns nil if the loop has finished without getting interrupted.
          ; If no block is given, an Enumerator is returned instead.

          (setq n nil)
          (setq block nil)

          (if (not params)
            (raise "list method 'cycle' not given integer argument")
          )

          (setq n (NATIVE_FUNCTION_CAR params))

          (error_integer 'UNLIMITED n 'UNLIMITED "cycle")

          (if (NATIVE_FUNCTION_CADR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CADR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CADR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CADR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CADR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CADR params))
                )

                (T
                  nil
                )
              )
            )
          )

          (if block
            (progn
              (if (> n 0)
                ((lambda ( / count)
                  (setq count 0)

                  (while (< count n)
                    (NATIVE_FUNCTION_MAPCAR block l)

                    (setq count (1+ count))
                  )
                ))
              )

              nil
            )
          ;else
            (eval self)
          )
        )

        (defun delete ( / obj block)
          ; delete(obj) → item or nil
          ; delete(obj) { block } → item or result of block
          ; Deletes all items from self that are equal to obj.
          ; Returns the last deleted item, or nil if no matching item is found.
          ; If the optional code block is given, the result of the block is returned if the item is not found.
          ; (To remove nil elements and get an informative return value, use #compact!)

          (setq obj nil)
          (setq block nil)

          (if (not params)
            (raise "list method 'delete' not given obj argument")
          )

          (setq obj (NATIVE_FUNCTION_CAR params))

          (if (NATIVE_FUNCTION_CADR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CADR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CADR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CADR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CADR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CADR params))
                )

                (T
                  nil
                )
              )
            )
          )

          ((lambda ( / i found new_list ret_object item)
            (setq
              i 0
              found nil
              new_list nil
              ret_object nil
            )

            (while (< i (NATIVE_FUNCTION_LENGTH l))
              (setq item (NATIVE_FUNCTION_NTH i l))
              
              (if (equal item obj)
                (setq
                  found T
                  ret_object item
                )
              ;else
                (setq new_list (NATIVE_FUNCTION_APPEND new_list (NATIVE_FUNCTION_LIST item)))
              )

              (setq i (1+ i))
            )

            (set self (newlist new_list))

            (if (and (not found) block)
              (NATIVE_FUNCTION_APPLY block nil)
            ;else
              ret_object
            )
          ))
        )

        (defun delete_at ( / index)
          ; delete_at(index) → obj or nil
          ; Deletes the element at the specified index, returning that element, or nil if the index is out of range.
          ; See also #slice!

          (setq index nil)

          (if (not params)
            (raise "list method 'delete_at' not given index argument")
          )

          (setq index (NATIVE_FUNCTION_CAR params))

          (error_integer 'UNLIMITED index 'UNLIMITED "delete_at")

          (if (equal index (normalize_index index))
            ((lambda ( / i new_list ret_object item)
              (setq
                i 0
                index (rotate_index index)
                new_list nil
                ret_object (NATIVE_FUNCTION_NTH index l)
              )

              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_NTH i l))
                
                (if (not (equal i index))
                  (setq new_list (NATIVE_FUNCTION_APPEND new_list (NATIVE_FUNCTION_LIST item)))
                )

                (setq i (1+ i))
              )

              (set self (newlist new_list))

              ret_object
            ))
          ;else
            nil
          )
        )

        (defun delete_if ( / block)
          ; delete_if { |item| block } → ary
          ; delete_if → Enumerator
          ; Deletes every element of self for which block evaluates to true.
          ; The array is changed instantly every time the block is called, not after the iteration is over.
          ; See also #reject!
          ; If no block is given, an Enumerator is returned instead.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )
          
          (if block
            ((lambda ( / i new_list rest_list item)
              (setq
                i 0
                new_list nil
                rest_list (NATIVE_FUNCTION_CDR l)
              )

              (while (< i (NATIVE_FUNCTION_LENGTH (NATIVE_FUNCTION_CAR (eval self))))
                (setq item (NATIVE_FUNCTION_NTH i (NATIVE_FUNCTION_CAR (eval self))))

                (if (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST item))
                  (set self (NATIVE_FUNCTION_LIST (NATIVE_FUNCTION_APPEND new_list rest_list) 'LISTOBJECT methods))
                ;else
                  (progn
                    (setq new_list (NATIVE_FUNCTION_APPEND new_list (NATIVE_FUNCTION_LIST item)))
                    (setq i (1+ i))
                  )
                )
                (setq rest_list (NATIVE_FUNCTION_CDR rest_list))
              )
            ))
          )

          (eval self)
        )

        ; TODO: implement
        (defun dig ( / indices)
          ; dig(idx, ...) → object
          ; Extracts the nested value specified by the sequence of idx objects by calling dig at each step, returning nil if any intermediate step is nil.

          nil
        )

        (defun drop ( / n)
          ; drop(n) → new_ary
          ; Drops first n elements from ary and returns the rest of the elements in an array.
          ; If a negative number is given, raises an ArgumentError.
          ; See also #take

          (setq n nil)

          (if (not params)
            (raise "list method 'drop' not given integer argument")
          )

          (setq n (NATIVE_FUNCTION_CAR params))

          (error_integer 'ZERO n 'UNLIMITED "drop")

          ((lambda ( / i ret_list item)
            (setq 
              i 0
              ret_list nil
            )

            (while (< i (NATIVE_FUNCTION_LENGTH l))
              (setq item (NATIVE_FUNCTION_NTH i l))

              (if (>= i n)
                (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))
              )

              (setq i (1+ i))
            )

            (newlist ret_list)
          ))
        )

        (defun drop_while ( / block)
          ; drop_while { |obj| block } → new_ary
          ; drop_while → Enumerator
          ; Drops elements up to, but not including, the first element for which the block returns nil or false and returns an array containing the remaining elements.
          ; If no block is given, an Enumerator is returned instead.
          ; See also #take_while

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )
          
          (if block
            ((lambda ( / i ret_list drop item)
              (setq
                i 0
                ret_list nil
                drop T
              )
              
              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_NTH i l))

                (if (not (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST item)))
                  (setq drop nil)
                )
                
                (if (not drop)
                  (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))
                )

                (setq i (1+ i))
              )
              
              (newlist ret_list)
            ))
          ;else
            (eval self)
          )
        )

        (defun each ( / block)
          ; each { |item| block } → ary
          ; each → Enumerator
          ; Calls the given block once for each element in self, passing that element as a parameter.
          ; Returns the array itself.
          ; If no block is given, an Enumerator is returned.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )
          
          (if block
            (NATIVE_FUNCTION_MAPCAR block l)
          )

          (eval self)
        )

        (defun each_index ( / block)
          ; each_index { |index| block } → ary
          ; each_index → Enumerator
          ; Same as #each, but passes the index of the element instead of the element itself.
          ; An Enumerator is returned if no block is given.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )

          (if block
            ((lambda ( / i index_list)
              (setq
                i 0
                index_list nil
              )

              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq
                  index_list (NATIVE_FUNCTION_APPEND index_list (NATIVE_FUNCTION_LIST i))
                  i (1+ i)
                )
              )
              
              (NATIVE_FUNCTION_MAPCAR block index_list)
            ))
          )

          (eval self)
        )

        (defun empty? ( / )
          ; empty? → true or false
          ; Returns true if self contains no elements.

          (equal l nil)
        )

        (defun eql? ( / other)
          ; eql?(other) → true or false
          ; Returns true if self and other are the same object, or are both arrays with the same content (according to Object#eql?).

          (setq other nil)

          (if (not params)
            (raise "list method 'eql?' not given argument")
          )

          (setq other (NATIVE_FUNCTION_CAR params))

          (or (equal self other) (equal l (valof other)))
        )

        (defun fetch ( / index default block)
          ; fetch(index) → obj
          ; fetch(index, default) → obj
          ; fetch(index) { |index| block } → obj
          ; Tries to return the element at position index, but throws an IndexError exception if the referenced index lies outside of the array bounds.
          ; This error can be prevented by supplying a second argument, which will act as a default value.
          ; Alternatively, if a block is given it will only be executed when an invalid index is referenced.
          ; Negative values of index count from the end of the array.

          (setq index nil)
          (setq default nil)
          (setq block nil)

          (if (not params)
            (raise "list method 'fetch' not given index argument")
          )

          (setq index (NATIVE_FUNCTION_CAR params))

          (error_integer 'UNLIMITED index 'UNLIMITED "fetch")

          (if (NATIVE_FUNCTION_CADR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CADR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CADR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CADR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CADR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CADR params))
                )

                (T
                  nil
                )
              )
            ;else
              (if (NATIVE_FUNCTION_CADDR params)
                (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CADDR params))) 'SUBR)
                  (cond
                    ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CADDR params)) 'LIST)
                      (setq block (NATIVE_FUNCTION_CADDR params))
                    )

                    ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CADDR params)) 'SUBR)
                      (setq block '(NATIVE_FUNCTION_CADDR params))
                    )

                    (T
                      nil
                    )
                  )
                ;else
                  (setq default (NATIVE_FUNCTION_CADR params))
                )
              ;else
                (setq default (NATIVE_FUNCTION_CADR params))
              )
            )
          )

          (if (equal index (normalize_index index))
            (NATIVE_FUNCTION_NTH (rotate_index index) l)
          ;else
            (cond
              (block
                (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST index))
                (eval self)
              )

              (default
                default
              )

              (T
                (raise "list method 'fetch' given index argument outside array bounds")
              )
            )
          )
        )

        ; TODO: implement
        (defun fill ( / args)
          ; fill(obj) → ary
          ; fill(obj, start [, length]) → ary
          ; fill(obj, range ) → ary
          ; fill { |index| block } → ary
          ; fill(start [, length] ) { |index| block } → ary
          ; fill(range) { |index| block } → ary
          ; The first three forms set the selected elements of self (which may be the entire array) to obj.
          ; A start of nil is equivalent to zero.
          ; A length of nil is equivalent to the length of the array.
          ; The last three forms fill the array with the value of the given block, which is passed the absolute index of each element to be filled.
          ; Negative values of start count from the end of the array, where -1 is the last element.

          nil
        )

        (defun find_index ( / obj block)
          ; find_index(obj) → int or nil
          ; find_index { |item| block } → int or nil
          ; find_index → Enumerator
          ; Returns the index of the first object in ary such that the object is == to obj.
          ; If a block is given instead of an argument, returns the index of the first object for which the block returns true.
          ; Returns nil if no match is found.
          ; See also #rindex.
          ; An Enumerator is returned if neither a block nor argument is given.

          (setq obj nil)
          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            ;else
              (setq obj (NATIVE_FUNCTION_CAR params))
            )
          )

          (cond
            (obj
              ((lambda ( / i found ret_index item)
                (setq
                  i 0
                  found nil
                  ret_index nil
                )

                (while (< i (NATIVE_FUNCTION_LENGTH l))
                  (setq item (NATIVE_FUNCTION_NTH i l))
                  
                  (if (equal item obj)
                    (setq
                      found T
                      ret_index i
                    )
                  )

                  (setq i (1+ i))
                )

                ret_index
              ))
            )

            (block
              ((lambda ( / i found ret_index item)
                (setq
                  i 0
                  found nil
                  ret_index nil
                )

                (while (< i (NATIVE_FUNCTION_LENGTH l))
                  (setq item (NATIVE_FUNCTION_NTH i l))
                  
                  (if (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST item))
                    (setq
                      found T
                      ret_index i
                    )
                  )

                  (setq i (1+ i))
                )

                ret_index
              ))
            )

            (T
              (eval self)
            )
          )
        )

        (defun first ( / n)
          ; first → obj or nil
          ; first(n) → new_ary
          ; Returns the first element, or the first n elements, of the array.
          ; If the array is empty, the first form returns nil, and the second form returns an empty array.
          ; See also #last for the opposite effect.

          (setq n nil)

          (if params
            (progn
              (setq n (NATIVE_FUNCTION_CAR params))

              (error_integer 'ZERO n 'UNLIMITED "first")
            )
          )

          (if n
            ((lambda ( / i ret_list item)
              (setq
                i 0
                ret_list nil
              )

              (while (and (< i n) (< i (NATIVE_FUNCTION_LENGTH l)))
                (setq item (NATIVE_FUNCTION_NTH i l))
                
                (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))

                (setq i (1+ i))
              )

              (newlist ret_list)
            ))
          ;else
            (NATIVE_FUNCTION_CAR l)
          )
        )

        (defun flatten ( / level)
          ; flatten → new_ary
          ; flatten(level) → new_ary
          ; Returns a new array that is a one-dimensional flattening of self (recursively).
          ; That is, for every element that is an array, extract its elements into the new array.
          ; The optional level argument determines the level of recursion to flatten.

          (setq level nil)

          (if params
            (progn
              (setq level (NATIVE_FUNCTION_CAR params))

              (error_integer 'UNLIMITED level 'UNLIMITED "flatten")
            )
          )

          ((lambda ( / flatten_list)
            (defun flatten_list (l level / )
              (cond
                ((> level 0)
                  ((lambda ( / i ret_list item)
                    (setq
                      i 0
                      ret_list nil
                    )

                    (while (< i (NATIVE_FUNCTION_LENGTH l))
                      (setq item (NATIVE_FUNCTION_NTH i l))

                      (if (listp item)
                        (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (flatten_list (valof item) (1- level))))
                      ;else
                        (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST (valof item))))
                      )

                      (setq i (1+ i))
                    )

                    ret_list
                  ))
                )

                ((equal level 0)
                  l
                )

                (T
                  ((lambda ( / i ret_list item)
                    (setq
                      i 0
                      ret_list nil
                    )

                    (while (< i (NATIVE_FUNCTION_LENGTH l))
                      (setq item (NATIVE_FUNCTION_NTH i l))

                      (if (listp item)
                        (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (flatten_list (valof item) nil)))
                      ;else
                        (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST (valof item))))
                      )

                      (setq i (1+ i))
                    )

                    ret_list
                  ))
                )
              )
            )

            (newlist (flatten_list l level))
          ))
        )

        (defun flatten! ( / )
          ; flatten! → ary or nil
          ; flatten!(level) → ary or nil
          ; Flattens self in place.
          ; Returns nil if no modifications were made (i.e., the array contains no subarrays.)
          ; The optional level argument determines the level of recursion to flatten.

          ((lambda ( / naught final)
            (setq naught (NATIVE_FUNCTION_LENGTH (valof self)))

            (set self (flatten))

            (setq final (NATIVE_FUNCTION_LENGTH (valof self)))

            (if (equal naught final)
              nil
            ;else
              (eval self)
            )
          ))
        )

        ; DONT: implement
        (defun frozen? ( / )
          ; frozen? → true or false
          ; Return true if this array is frozen (or temporarily frozen while being sorted).
          ; See also Object#frozen?
          ; frozen? → true or false
          ; Returns the freeze status of obj.

          nil
        )

        ; DONT: implement
        (defun hash ( / )
          ; hash → integer
          ; Compute a hash-code for this array.
          ; Two arrays with the same content will have the same hash code (and will compare using eql?).
          ; See also Object#hash.
          ; hash → integer
          ; Generates an Integer hash value for this object.
          ; This function must have the property that a.eql?(b) implies a.hash == b.hash.
          ; The hash value is used along with eql? by the Hash class to determine if two objects reference the same hash key.
          ; Any hash value that exceeds the capacity of an Integer will be truncated before being used.
          ; The hash value for an object may not be identical across invocations or implementations of Ruby.
          ; If you need a stable identifier across Ruby invocations and implementations you will need to generate one with a custom method.

          nil
        )

        (defun include? ( / obj)
          ; include?(object) → true or false
          ; Returns true if the given object is present in self (that is, if any element == object), otherwise returns false.

          (setq obj nil)
          
          (if (not params)
            (raise "list method 'include?' not given obj argument")
          )

          (setq obj (NATIVE_FUNCTION_CAR params))

          (or (not (not (NATIVE_FUNCTION_MEMBER (valof obj) l))) (not (not (NATIVE_FUNCTION_MEMBER obj l))))
        )

        (defun index ( / obj block)
          ; index(obj) → int or nil
          ; index { |item| block } → int or nil
          ; index → Enumerator
          ; Returns the index of the first object in ary such that the object is == to obj.
          ; If a block is given instead of an argument, returns the index of the first object for which the block returns true.
          ; Returns nil if no match is found.
          ; See also #rindex.
          ; An Enumerator is returned if neither a block nor argument is given.

          (setq obj nil)
          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            ;else
              (setq obj (NATIVE_FUNCTION_CAR params))
            )
          )

          (cond
            (obj
              ((lambda ( / i found ret_index item)
                (setq
                  i 0
                  found nil
                  ret_index nil
                )

                (while (and (not found) (< i (NATIVE_FUNCTION_LENGTH l)))
                  (setq item (NATIVE_FUNCTION_NTH i l))
                  
                  (if (equal item obj)
                    (setq
                      found T
                      ret_index i
                    )
                  )

                  (setq i (1+ i))
                )

                ret_index
              ))
            )

            (block
              ((lambda ( / i found ret_index item)
                (setq
                  i 0
                  found nil
                  ret_index nil
                )

                (while (and (not found) (< i (NATIVE_FUNCTION_LENGTH l)))
                  (setq item (NATIVE_FUNCTION_NTH i l))
                  
                  (if (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST item))
                    (setq
                      found T
                      ret_index i
                    )
                  )

                  (setq i (1+ i))
                )

                ret_index
              ))
            )

            (T
              (eval self)
            )
          )
        )

        (defun initialize_copy ( / other_list)
          ; initialize_copy(other_ary) → ary
          ; Replaces the contents of self with the contents of other_ary, truncating or expanding if necessary.

          (setq other_list nil)
          
          (if (not params)
            (raise "list method 'initialize_copy' not given other_list argument")
          )

          (setq other_list (NATIVE_FUNCTION_CAR params))

          (set self (newlist other_list))
        )

        (defun insert ( / index objs)
          ; insert(index, obj...) → ary
          ; Inserts the given values before the element with the given index.
          ; Negative indices count backwards from the end of the array, where -1 is the last element.
          ; If a negative index is used, the given values will be inserted after that element, so using an index of -1 will insert the values at the end of the array.

          (setq index nil)
          (setq objs nil)
          
          (if (not params)
            (raise "list method 'insert' not given index argument")
          )

          (setq index (NATIVE_FUNCTION_CAR params))

          (error_integer 'NEGLEN index 'UNLIMITED "insert")

          (setq objs (NATIVE_FUNCTION_CDR params))

          (if (equal index (rotate_index index))
            ((lambda ( / i new_list item)
              (setq
                i 0
                new_list nil
              )

              (while (or (< i index) (< i (NATIVE_FUNCTION_LENGTH l)))
                (setq item (NATIVE_FUNCTION_NTH i l))

                (setq new_list (NATIVE_FUNCTION_APPEND new_list (NATIVE_FUNCTION_LIST item)))

                (setq i (1+ i))

                (if (equal i index)
                  ((lambda ( / i item)
                    (setq i 0)

                    (while (< i (NATIVE_FUNCTION_LENGTH objs))
                      (setq item (NATIVE_FUNCTION_NTH i objs))

                      (setq new_list (NATIVE_FUNCTION_APPEND new_list (NATIVE_FUNCTION_LIST item)))

                      (setq i (1+ i))
                    )
                  ))
                )
              )

              (set self (newlist new_list))
            ))
          ;else
            ((lambda ( / i new_list item)
              (setq
                index (rotate_index index)
                i 0
                new_list nil
              )

              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_NTH i l))

                (setq new_list (NATIVE_FUNCTION_APPEND new_list (NATIVE_FUNCTION_LIST item)))

                (setq i (1+ i))

                (if (equal i (1+ index))
                  ((lambda ( / i item)
                    (setq i 0)

                    (while (< i (NATIVE_FUNCTION_LENGTH objs))
                      (setq item (NATIVE_FUNCTION_NTH i objs))

                      (setq new_list (NATIVE_FUNCTION_APPEND new_list (NATIVE_FUNCTION_LIST item)))

                      (setq i (1+ i))
                    )
                  ))
                )
              )

              (set self (newlist new_list))
            ))
          )
        )

        ; TODO: using vanilla lisp, delete the file
        ; TODO: errors
        (defun inspect ( / )
          ; inspect → string
          ; to_s → string
          ; Creates a string representation of self.

          ((lambda ( / unobtrusive_file_path file file_line_read delete_success)
            (setq
              unobtrusive_file_path "c:\\~~~OK~TO~DELETE~ME~~~.~~~"
              file (open unobtrusive_file_path "r")
            )

            ; (if file
            ;   error, show paths
            ; )

            (setq file (open unobtrusive_file_path "w"))

            (prin1 l file)

            (setq
              file (close file)
              file (open unobtrusive_file_path "r")
              file_line_read (read-line file)
              file (close file)
              ; delete_success (delete-file unobtrusive_file_path)
            )

            ; (if (not delete_success)
            ;   error, show paths
            ; )

            file_line_read
          ))
        )

        ; TODO: concatenate return string using vanilla lisp (not strcat)
        ; TODO: using vanilla lisp, delete the file
        ; TODO: errors
        (defun join ( / separator)
          ; join(separator=$,) → str
          ; Returns a string created by converting each element of the array to a string, separated by the given separator.
          ; If the separator is nil, it uses current $,.
          ; If both the separator and $, are nil, it uses empty string.

          (setq separator "")
          
          (if params
            (setq separator (NATIVE_FUNCTION_CAR params))
          )

          (if (not (stringp separator))
            (raise "list method 'join' given separator argument not of type string")
          )

          ((lambda ( / i ret_string item)
            (setq
              i 0
              ret_string ""
            )

            (while (< i (NATIVE_FUNCTION_LENGTH l))
              (setq item (NATIVE_FUNCTION_NTH i l))

              (if (stringp item)
                (setq ret_string (strcat ret_string item))
              ;else
                ((lambda ( / unobtrusive_file_path file file_line_read delete_success)
                  (setq
                    unobtrusive_file_path "c:\\~~~OK~TO~DELETE~ME~~~.~~~"
                    file (open unobtrusive_file_path "r")
                  )

                  ; (if file
                  ;   error, show paths
                  ; )

                  (setq file (open unobtrusive_file_path "w"))

                  (prin1 item file)

                  (setq
                    file (close file)
                    file (open unobtrusive_file_path "r")
                    file_line_read (read-line file)
                    file (close file)
                    ; delete_success (delete-file unobtrusive_file_path)
                  )

                  ; (if (not delete_success)
                  ;   error, show paths
                  ; )

                  (setq ret_string (strcat ret_string file_line_read))
                ))
              )

              (setq i (1+ i))

              (if (< i (NATIVE_FUNCTION_LENGTH l))
                (setq ret_string (strcat ret_string separator))
              )
            )

            ret_string
          ))
        )

        (defun keep_if ( / block)
          ; keep_if { |item| block } → ary
          ; keep_if → Enumerator
          ; Deletes every element of self for which the given block evaluates to false.
          ; See also #select!
          ; If no block is given, an Enumerator is returned instead.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )
          
          (if block
            ((lambda ( / i new_list item)
              (setq
                i 0
                new_list nil
              )
              
              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_NTH i l))
                
                (if (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST item))
                  (setq new_list (NATIVE_FUNCTION_APPEND new_list (NATIVE_FUNCTION_LIST item)))
                )

                (setq i (1+ i))
              )
              
              (set self (newlist new_list))
            ))
          )

          (eval self)
        )

        (defun last ( / n)
          ; last → obj or nil
          ; last(n) → new_ary
          ; Returns the last element(s) of self.
          ; If the array is empty, the first form returns nil.
          ; See also #first for the opposite effect.

          (setq n nil)

          (if params
            (progn
              (setq n (NATIVE_FUNCTION_CAR params))

              (error_integer 'ZERO n 'UNLIMITED "last")
            )
          )

          (if n
            ((lambda ( / i ret_list item)
              (setq
                i 0
                ret_list nil
              )

              (while (and (< i n) (< i (NATIVE_FUNCTION_LENGTH l)))
                (setq item (NATIVE_FUNCTION_NTH (- (NATIVE_FUNCTION_LENGTH l) (1+ i)) l))
                
                (setq ret_list (NATIVE_FUNCTION_CONS item ret_list))

                (setq i (1+ i))
              )

              (newlist ret_list)
            ))
          ;else
            (NATIVE_FUNCTION_LAST l)
          )
        )

        ; TODO: uncomment after figuring out function scope in interpreter
        ; (defun length ( / )
        ;   ; length → int
        ;   ; Returns the number of elements in self.
        ;   ; May be zero.

        ;   (NATIVE_FUNCTION_LENGTH l)
        ; )

        (defun map ( / block)
          ; map { |item| block } → new_ary
          ; map → Enumerator
          ; Invokes the given block once for each element of self.
          ; Creates a new array containing the values returned by the block.
          ; See also Enumerable#collect.
          ; If no block is given, an Enumerator is returned instead.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )
          
          (if block
            (newlist (NATIVE_FUNCTION_MAPCAR block l))
          ;else
            (eval self)
          )
        )

        (defun map! ( / )
          ; map! {|item| block } → ary
          ; map! → Enumerator
          ; Invokes the given block once for each element of self, replacing the element with the value returned by the block.
          ; See also Enumerable#collect.
          ; If no block is given, an Enumerator is returned instead.

          (set self (map))
        )

        ; TODO: implement
        (defun max ( / n block)
          ; max → obj
          ; max { |a, b| block } → obj
          ; max(n) → array
          ; max(n) { |a, b| block } → array
          ; Returns the object in ary with the maximum value.
          ; The first form assumes all objects implement Comparable; the second uses the block to return a <=> b.
          ; If the n argument is given, maximum n elements are returned as an array.

          nil
        )

        ; TODO: implement
        (defun min ( / n block)
          ; min → obj
          ; min {| a,b | block } → obj
          ; min(n) → array
          ; min(n) {| a,b | block } → array
          ; Returns the object in ary with the minimum value.
          ; The first form assumes all objects implement Comparable; the second uses the block to return a <=> b.
          ; If the n argument is given, minimum n elements are returned as an array.

          nil
        )

        ; TODO: implement
        (defun pack ( / a_template_string a_buffer_string)
          ; pack( aTemplateString ) → aBinaryString
          ; pack( aTemplateString, buffer: aBufferString ) → aBufferString
          ; Packs the contents of arr into a binary sequence according to the directives in aTemplateString (see the table below) Directives “A,” “a,” and “Z” may be followed by a count, which gives the width of the resulting field.
          ; The remaining directives also may take a count, indicating the number of array elements to convert.
          ; If the count is an asterisk (“*”), all remaining array elements will be converted.
          ; Any of the directives “sSiIlL” may be followed by an underscore (“_”) or exclamation mark (“!”) to use the underlying platform’s native size for the specified type; otherwise, they use a platform-independent size.
          ; Spaces are ignored in the template string.
          ; See also String#unpack.
          ; If aBufferString is specified and its capacity is enough, pack uses it as the buffer and returns it.
          ; When the offset is specified by the beginning of aTemplateString, the result is filled after the offset.
          ; If original contents of aBufferString exists and it’s longer than the offset, the rest of offsetOfBuffer are overwritten by the result.
          ; If it’s shorter, the gap is filled with “\0”.
          ; Note that “buffer:” option does not guarantee not to allocate memory in pack.
          ; If the capacity of aBufferString is not enough, pack allocates memory.
          ; Directives for pack.
          ; Integer       | Array   |
          ; Directive     | Element | Meaning
          ; ----------------------------------------------------------------------------
          ; C             | Integer | 8-bit unsigned (unsigned char)
          ; S             | Integer | 16-bit unsigned, native endian (uint16_t)
          ; L             | Integer | 32-bit unsigned, native endian (uint32_t)
          ; Q             | Integer | 64-bit unsigned, native endian (uint64_t)
          ; J             | Integer | pointer width unsigned, native endian (uintptr_t)
          ;               |         | (J is available since Ruby 2.3.)
          ;               |         |
          ; c             | Integer | 8-bit signed (signed char)
          ; s             | Integer | 16-bit signed, native endian (int16_t)
          ; l             | Integer | 32-bit signed, native endian (int32_t)
          ; q             | Integer | 64-bit signed, native endian (int64_t)
          ; j             | Integer | pointer width signed, native endian (intptr_t)
          ;               |         | (j is available since Ruby 2.3.)
          ;               |         |
          ; S_ S!         | Integer | unsigned short, native endian
          ; I I_ I!       | Integer | unsigned int, native endian
          ; L_ L!         | Integer | unsigned long, native endian
          ; Q_ Q!         | Integer | unsigned long long, native endian (ArgumentError
          ;               |         | if the platform has no long long type.)
          ;               |         | (Q_ and Q! is available since Ruby 2.1.)
          ; J!            | Integer | uintptr_t, native endian (same with J)
          ;               |         | (J! is available since Ruby 2.3.)
          ;               |         |
          ; s_ s!         | Integer | signed short, native endian
          ; i i_ i!       | Integer | signed int, native endian
          ; l_ l!         | Integer | signed long, native endian
          ; q_ q!         | Integer | signed long long, native endian (ArgumentError
          ;               |         | if the platform has no long long type.)
          ;               |         | (q_ and q! is available since Ruby 2.1.)
          ; j!            | Integer | intptr_t, native endian (same with j)
          ;               |         | (j! is available since Ruby 2.3.)
          ;               |         |
          ; S> s> S!> s!> | Integer | same as the directives without ">" except
          ; L> l> L!> l!> |         | big endian
          ; I!> i!>       |         | (available since Ruby 1.9.3)
          ; Q> q> Q!> q!> |         | "S>" is same as "n"
          ; J> j> J!> j!> |         | "L>" is same as "N"
          ;               |         |
          ; S< s< S!< s!< | Integer | same as the directives without "<" except
          ; L< l< L!< l!< |         | little endian
          ; I!< i!<       |         | (available since Ruby 1.9.3)
          ; Q< q< Q!< q!< |         | "S<" is same as "v"
          ; J< j< J!< j!< |         | "L<" is same as "V"
          ;               |         |
          ; n             | Integer | 16-bit unsigned, network (big-endian) byte order
          ; N             | Integer | 32-bit unsigned, network (big-endian) byte order
          ; v             | Integer | 16-bit unsigned, VAX (little-endian) byte order
          ; V             | Integer | 32-bit unsigned, VAX (little-endian) byte order
          ;               |         |
          ; U             | Integer | UTF-8 character
          ; w             | Integer | BER-compressed integer

          ; Float        | Array   |
          ; Directive    | Element | Meaning
          ; ---------------------------------------------------------------------------
          ; D d          | Float   | double-precision, native format
          ; F f          | Float   | single-precision, native format
          ; E            | Float   | double-precision, little-endian byte order
          ; e            | Float   | single-precision, little-endian byte order
          ; G            | Float   | double-precision, network (big-endian) byte order
          ; g            | Float   | single-precision, network (big-endian) byte order

          ; String       | Array   |
          ; Directive    | Element | Meaning
          ; ---------------------------------------------------------------------------
          ; A            | String  | arbitrary binary string (space padded, count is width)
          ; a            | String  | arbitrary binary string (null padded, count is width)
          ; Z            | String  | same as ``a'', except that null is added with *
          ; B            | String  | bit string (MSB first)
          ; b            | String  | bit string (LSB first)
          ; H            | String  | hex string (high nibble first)
          ; h            | String  | hex string (low nibble first)
          ; u            | String  | UU-encoded string
          ; M            | String  | quoted printable, MIME encoding (see RFC2045)
          ; m            | String  | base64 encoded string (see RFC 2045, count is width)
          ;              |         | (if count is 0, no line feed are added, see RFC 4648)
          ; P            | String  | pointer to a structure (fixed-length string)
          ; p            | String  | pointer to a null-terminated string

          ; Misc.        | Array   |
          ; Directive    | Element | Meaning
          ; ---------------------------------------------------------------------------
          ; @            | ---     | moves to absolute position
          ; X            | ---     | back up a byte
          ; x            | ---     | null byte

          nil
        )

        ; TODO: implement
        (defun permutation ( / n block)
          ; permutation { |p| block } → ary
          ; permutation → Enumerator
          ; permutation(n) { |p| block } → ary
          ; permutation(n) → Enumerator
          ; When invoked with a block, yield all permutations of length n of the elements of the array, then return the array itself.
          ; If n is not specified, yield all permutations of all elements.
          ; The implementation makes no guarantees about the order in which the permutations are yielded.
          ; If no block is given, an Enumerator is returned instead.

          nil
        )

        (defun pop ( / n)
          ; pop → obj or nil
          ; pop(n) → new_ary
          ; Removes the last element from self and returns it, or nil if the array is empty.
          ; If a number n is given, returns an array of the last n elements (or less) just like array.slice!(-n, n) does.
          ; See also #push for the opposite effect.

          (setq n nil)

          (if params
            (progn
              (setq n (NATIVE_FUNCTION_CAR params))

              (error_integer 'ZERO n 'UNLIMITED "pop")
            )
          )

          (if n
            ((lambda ( / i new_list ret_list item)
              (setq
                i 0
                new_list nil
                ret_list nil
              )

              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_NTH i l))
                
                (if (< i (- (NATIVE_FUNCTION_LENGTH l) n))
                  (setq new_list (NATIVE_FUNCTION_APPEND new_list (NATIVE_FUNCTION_LIST item))) 
                ;else
                  (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))
                )

                (setq i (1+ i))
              )

              (set self (newlist new_list))

              (newlist ret_list)
            ))
          ;else
            ((lambda ( / i new_list item)
              (setq
                i 0
                new_list nil
              )

              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_NTH i l))

                (setq i (1+ i))
                
                (if (< i (NATIVE_FUNCTION_LENGTH l))
                  (setq new_list (NATIVE_FUNCTION_APPEND new_list (NATIVE_FUNCTION_LIST item)))
                )
              )

              (set self (newlist new_list))

              (NATIVE_FUNCTION_LAST l)
            ))
          )
        )

        (defun product ( / other_lists block)
          ; product(other_ary, ...) → new_ary
          ; product(other_ary, ...) { |p| block } → ary
          ; Returns an array of all combinations of elements from all arrays.
          ; The length of the returned array is the product of the length of self and the argument arrays.
          ; If given a block, product will yield all combinations and return self instead.

          (setq other_lists nil)
          (setq block nil)

          (if (NATIVE_FUNCTION_LAST params)
            (if (equal (type (NATIVE_FUNCTION_LAST params)) 'LISTOBJECT)
              (setq other_lists params)
            ;else
              (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_LAST params))) 'SUBR)
                (progn
                  (cond
                    ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_LAST params)) 'LIST)
                      (setq block (NATIVE_FUNCTION_LAST params))
                    )

                    ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_LAST params)) 'SUBR)
                      (setq block '(NATIVE_FUNCTION_LAST params))
                    )

                    (T
                      nil
                    )
                  )

                  ((lambda ( / i item)
                    (setq i 0)

                    (while (< i (1- (NATIVE_FUNCTION_LENGTH params)))
                      (setq item (NATIVE_FUNCTION_NTH i params))

                      (setq other_lists (NATIVE_FUNCTION_APPEND other_lists (NATIVE_FUNCTION_LIST item)))

                      (setq i (1+ i))
                    )
                  ))
                )
              ;else
                (raise "list method 'product' given last argument not of type LIST or SUBR")
              )
            )
          )

          (if other_lists
            ((lambda ( / sub_product i all_list ret_list item sub_list)
              ; takes two lists to create product
              ; assumes each list has each of its elements wrapped in list
              (defun sub_product (list1 list2 / i sub_list1 ret_list item)
                (setq
                  i 0
                  ret_list nil
                )

                (while (< i (NATIVE_FUNCTION_LENGTH list1))
                  (setq sub_list1 (NATIVE_FUNCTION_NTH i list1))

                  ((lambda ( / i sub_list2)
                    (setq i 0)

                    (while (< i (NATIVE_FUNCTION_LENGTH list2))
                      (setq sub_list2 (NATIVE_FUNCTION_NTH i list2))

                      (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST (NATIVE_FUNCTION_APPEND sub_list1 sub_list2))))

                      (setq i (1+ i))
                    )
                  ))

                  (setq i (1+ i))
                )

                ret_list
              )

              (setq
                i 1
                all_list (NATIVE_FUNCTION_APPEND (NATIVE_FUNCTION_LIST l) (NATIVE_FUNCTION_MAPCAR 'VALOF other_lists))
                ret_list (NATIVE_FUNCTION_MAPCAR 'NATIVE_FUNCTION_LIST (NATIVE_FUNCTION_LAST all_list))
              )

              (while (and ret_list (< i (NATIVE_FUNCTION_LENGTH all_list)))
                (setq sub_list (NATIVE_FUNCTION_NTH (- (NATIVE_FUNCTION_LENGTH all_list) (1+ i)) all_list))

                (if (not (equal (NATIVE_FUNCTION_TYPE sub_list) 'LIST))
                  (raise "list method 'product' given argument not of type LIST")
                )

                (setq ret_list (sub_product (NATIVE_FUNCTION_MAPCAR 'NATIVE_FUNCTION_LIST (valof sub_list)) ret_list))

                (setq i (1+ i))
              )

              (if block
                (progn
                  (NATIVE_FUNCTION_MAPCAR block ret_list)
                  (eval self)
                )
              ;else
                (newlist (NATIVE_FUNCTION_MAPCAR 'LIST ret_list))
              )
            ))
          ;else
            ((lambda ( / i ret_list item)
              (setq
                i 0
                ret_list nil
              )

              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_NTH i l))
                
                (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST (list item))))

                (setq i (1+ i))
              )

              (newlist ret_list)
            ))
          )
        )

        (defun push ( / objs)
          ; push(obj, ... ) → ary
          ; Append — Pushes the given object(s) on to the end of this array.
          ; This expression returns the array itself, so several appends may be chained together.
          ; See also #pop for the opposite effect.

          (setq objs params)

          (set self (newlist (NATIVE_FUNCTION_APPEND l objs)))

          ; ((lambda ( / i ret_list item)
          ;   (setq
          ;     i 0
          ;     ret_list l
          ;   )

          ;   (while (< i (NATIVE_FUNCTION_LENGTH objs))
          ;     (setq item (NATIVE_FUNCTION_NTH i objs))

          ;     (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))

          ;     (setq i (1+ i))
          ;   )

          ;   (set self (newlist ret_list))
          ; ))
        )

        (defun rassoc ( / obj)
          ; rassoc(obj) → element_ary or nil
          ; Searches through the array whose elements are also arrays.
          ; Compares obj with the second element of each contained array using obj.==.
          ; Returns the first contained array that matches obj.
          ; See also #assoc.

          (setq obj nil)

          (if (not params)
            (raise "list method 'assoc' not given obj argument")
          )

          (setq obj (NATIVE_FUNCTION_CAR params))
          
          ((lambda ( / i found ret_list sub_list)
            (setq
              i 0
              found nil
              ret_list nil
            )

            (while (and (not found) (< i (NATIVE_FUNCTION_LENGTH l)))
              (setq sub_list (NATIVE_FUNCTION_NTH i l))

              (if (equal (type (valof sub_list)) 'LIST)
                (if (equal obj (cadr sub_list))
                  (setq
                    ret_list (valof sub_list)
                    found T
                  )
                )
              )

              (setq i (1+ i))
            )

            (newlist ret_list)
          ))
        )

        (defun reject ( / block)
          ; reject {|item| block } → new_ary
          ; reject → Enumerator
          ; Returns a new array containing the items in self for which the given block is not true.
          ; The ordering of non-rejected elements is maintained.
          ; See also #delete_if
          ; If no block is given, an Enumerator is returned instead.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )
          
          (if block
            ((lambda ( / i ret_list item)
              (setq
                i 0
                ret_list nil
              )

              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_NTH i l))

                (if (not (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST item)))
                  (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))
                )

                (setq i (1+ i))
              )

              (newlist ret_list)
            ))
          ;else
            (eval self)
          )
        )

        (defun reject!( / block)
          ; reject! { |item| block } → ary or nil
          ; reject! → Enumerator
          ; Deletes every element of self for which the block evaluates to true, if no changes were made returns nil.
          ; The array may not be changed instantly every time the block is called.
          ; See also Enumerable#reject and #delete_if.
          ; If no block is given, an Enumerator is returned instead.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )
          
          (if block
            ((lambda ( / naught final)
              (setq naught (NATIVE_FUNCTION_LENGTH (valof self)))

              (set self (reject))

              (setq final (NATIVE_FUNCTION_LENGTH (valof self)))

              (if (equal naught final)
                nil
              ;else
                (eval self)
              )
            ))
          ;else
            (eval self)
          )
        )

        (defun replace ( / other_list)
          ; replace(other_ary) → ary
          ; Replaces the contents of self with the contents of other_ary, truncating or expanding if necessary.

          (setq other_list nil)
          
          (if (not params)
            (raise "list method 'replace' not given other_list argument")
          )

          (setq other_list (NATIVE_FUNCTION_CAR params))

          (set self (newlist other_list))
        )

        ; TODO: implement
        (defun repeated_combination ( / n block)
          ; repeated_combination(n) { |c| block } → ary
          ; repeated_combination(n) → Enumerator
          ; When invoked with a block, yields all repeated combinations of length n of elements from the array and then returns the array itself.
          ; The implementation makes no guarantees about the order in which the repeated combinations are yielded.
          ; If no block is given, an Enumerator is returned instead.

          nil
        )

        ; TODO: implement
        (defun repeated_permutation ( / n block)
          ; repeated_permutation(n) { |p| block } → ary
          ; repeated_permutation(n) → Enumerator
          ; When invoked with a block, yield all repeated permutations of length n of the elements of the array, then return the array itself.
          ; The implementation makes no guarantees about the order in which the repeated permutations are yielded.
          ; If no block is given, an Enumerator is returned instead.

          nil
        )

        (defun reverse ( / )
          ; reverse → new_ary
          ; Returns a new array containing self‘s elements in reverse order.

          (newlist (NATIVE_FUNCTION_REVERSE l))
        )

        (defun reverse! ( / )
          ; reverse! → ary
          ; Reverses self in place.

          (set self (reverse))
        )

        (defun reverse_each ( / block)
          ; reverse_each { |item| block } → ary
          ; reverse_each → Enumerator
          ; Same as #each, but traverses self in reverse order.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )
          
          (if block
            (NATIVE_FUNCTION_MAPCAR block (NATIVE_FUNCTION_REVERSE l))
          )

          (eval self)
        )

        (defun rindex ( / obj block)
          ; rindex(obj) → int or nil
          ; rindex { |item| block } → int or nil
          ; rindex → Enumerator
          ; Returns the index of the last object in self == to obj.
          ; If a block is given instead of an argument, returns the index of the first object for which the block returns true, starting from the last object.
          ; Returns nil if no match is found.
          ; See also #index.
          ; If neither block nor argument is given, an Enumerator is returned instead.

          (setq obj nil)
          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            ;else
              (setq obj (NATIVE_FUNCTION_CAR params))
            )
          )

          (cond
            (obj
              ((lambda ( / i found ret_index item)
                (setq
                  i (1- (NATIVE_FUNCTION_LENGTH l))
                  found nil
                  ret_index nil
                )

                (while (and (not found) (>= i 0))
                  (setq item (NATIVE_FUNCTION_NTH i l))
                  
                  (if (equal item obj)
                    (setq
                      found T
                      ret_index i
                    )
                  )

                  (setq i (1- i))
                )

                ret_index
              ))
            )

            (block
              ((lambda ( / i found ret_index item)
                (setq
                  i (1- (NATIVE_FUNCTION_LENGTH l))
                  found nil
                  ret_index nil
                )

                (while (and (not found) (>= i 0))
                  (setq item (NATIVE_FUNCTION_NTH i l))
                  
                  (if (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST item))
                    (setq
                      found T
                      ret_index i
                    )
                  )

                  (setq i (1- i))
                )

                ret_index
              ))
            )

            (T
              (eval self)
            )
          )
        )

        (defun rotate ( / count)
          ; rotate(count=1) → new_ary
          ; Returns a new array by rotating self so that the element at count is the first element of the new array.
          ; If count is negative then it rotates in the opposite direction, starting from the end of self where -1 is the last element.

          (setq count 1)

          (if params
            (setq count (NATIVE_FUNCTION_CAR params))
          )

          (error_integer 'UNLIMITED count 'UNLIMITED "rotate")

          (setq count (normalize_index count))

          (setq count (rotate_index count))

          ((lambda ( / i pre_list post_list item)
            (setq
              i 0
              pre_list nil
              post_list nil
            )

            (while (< i (NATIVE_FUNCTION_LENGTH l))
              (setq item (NATIVE_FUNCTION_NTH i l))

              (if (< i count)
                (setq pre_list (NATIVE_FUNCTION_APPEND pre_list (NATIVE_FUNCTION_LIST item)))
              ;else
                (setq post_list (NATIVE_FUNCTION_APPEND post_list (NATIVE_FUNCTION_LIST item)))
              )

              (setq i (1+ i))
            )

            (newlist (NATIVE_FUNCTION_APPEND post_list pre_list))
          ))
        )

        (defun rotate! ( / )
          ; rotate!(count=1) → ary
          ; Rotates self in place so that the element at count comes first, and returns self.
          ; If count is negative then it rotates in the opposite direction, starting from the end of the array where -1 is the last element.

          (set self (rotate))
        )

        ; TODO: implement using Math module
        ; DONT: take range
        (defun sample ( / n)
          ; sample → obj
          ; sample(random: rng) → obj
          ; sample(n) → new_ary
          ; sample(n, random: rng) → new_ary
          ; Choose a random element or n random elements from the array.
          ; The elements are chosen by using random and unique indices into the array in order to ensure that an element doesn’t repeat itself unless the array already contained duplicate elements.
          ; If the array is empty the first form returns nil and the second form returns an empty array.
          ; The optional rng argument will be used as the random number generator.

          (setq n nil)

          (if params
            (progn
              (setq n (NATIVE_FUNCTION_CAR params))

              (error_integer 'ZERO n 'UNLIMITED "sample")
            )
          )

          (if (> n (NATIVE_FUNCTION_LENGTH l))
            (setq n (NATIVE_FUNCTION_LENGTH l))
          )

          (if n
            ((lambda ( / i copy ret_list rand_index item)
              (setq
                i 0
                copy l
                ret_list nil
              )

              (while (< i n)
                (setq rand_index (fix (* (rand) (NATIVE_FUNCTION_LENGTH copy))))

                (setq item (NATIVE_FUNCTION_NTH rand_index copy))

                (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))

                ((lambda ( / i pre_list post_list item)
                  (setq
                    i 0
                    pre_list nil
                    post_list nil
                  )

                  (while (< i (NATIVE_FUNCTION_LENGTH copy))
                    (setq item (NATIVE_FUNCTION_NTH i copy))

                    (cond
                      ((< i rand_index)
                        (setq pre_list (NATIVE_FUNCTION_APPEND pre_list (NATIVE_FUNCTION_LIST item)))
                      )

                      ((> i rand_index)
                        (setq post_list (NATIVE_FUNCTION_APPEND post_list (NATIVE_FUNCTION_LIST item)))
                      )
                    )

                    (setq i (1+ i))
                  )

                  (setq copy (NATIVE_FUNCTION_APPEND post_list pre_list))
                ))

                (setq i (1+ i))
              )

              (newlist ret_list)
            ))
          ;else
            (NATIVE_FUNCTION_NTH (fix (* (rand) (NATIVE_FUNCTION_LENGTH l))) l)
          )
        )

        (defun select ( / block)
          ; select { |item| block } → new_ary
          ; select → Enumerator
          ; Returns a new array containing all elements of ary for which the given block returns a true value.
          ; If no block is given, an Enumerator is returned instead.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )
          
          (if block
            ((lambda ( / i ret_list item)
              (setq
                i 0
                ret_list nil
              )
              
              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_NTH i l))
                
                (if (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST item))
                  (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))
                )

                (setq i (1+ i))
              )
              
              (newlist ret_list)
            ))
          ;else
            (eval self)
          )
        )

        (defun select!( / block)
          ; select! {|item| block } → ary or nil
          ; select! → Enumerator
          ; Invokes the given block passing in successive elements from self, deleting elements for which the block returns a false value.
          ; The array may not be changed instantly every time the block is called.
          ; If changes were made, it will return self, otherwise it returns nil.
          ; See also #keep_if
          ; If no block is given, an Enumerator is returned instead.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )
          
          (if block
            ((lambda ( / naught final)
              (setq naught (NATIVE_FUNCTION_LENGTH (valof self)))

              (set self (select))

              (setq final (NATIVE_FUNCTION_LENGTH (valof self)))

              (if (equal naught final)
                nil
              ;else
                (eval self)
              )
            ))
          ;else
            (eval self)
          )
        )

        (defun shift ( / n)
          ; shift → obj or nil
          ; shift(n) → new_ary
          ; Removes the first element of self and returns it (shifting all other elements down by one).
          ; Returns nil if the array is empty.
          ; If a number n is given, returns an array of the first n elements (or less) just like array.slice!(0, n) does.
          ; With ary containing only the remainder elements, not including what was shifted to new_ary.
          ; See also #unshift for the opposite effect.

          (setq n nil)

          (if params
            (progn
              (setq n (NATIVE_FUNCTION_CAR params))

              (error_integer 'ZERO n 'UNLIMITED "sample")
            )
          )

          (if (> n (NATIVE_FUNCTION_LENGTH l))
            (setq n (NATIVE_FUNCTION_LENGTH l))
          )

          (if n
            ((lambda ( / i copy ret_list item)
              (setq
                i 0
                copy l
                ret_list nil
              )

              (while (< i n)
                (setq item (NATIVE_FUNCTION_NTH i l))

                (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))

                (setq copy (NATIVE_FUNCTION_CDR copy))

                (setq i (1+ i))
              )

              (set self (newlist copy))

              (newlist ret_list)
            ))
          ;else
            (progn
              (set self (newlist (NATIVE_FUNCTION_CDR l)))
              (NATIVE_FUNCTION_CAR l)
            )
          )
        )

        ; TODO: implement using Math module rand method
        ; DONT: take range
        (defun shuffle ( / )
          ; shuffle → new_ary
          ; shuffle(random: rng) → new_ary
          ; Returns a new array with elements of self shuffled.

          ((lambda ( / i copy ret_list rand_index item)
            (setq
              i 0
              copy l
              ret_list nil
            )

            (while (< i (NATIVE_FUNCTION_LENGTH l))
              (setq rand_index (fix (* (rand) (NATIVE_FUNCTION_LENGTH copy))))

              (setq item (NATIVE_FUNCTION_NTH rand_index copy))

              (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))

              ((lambda ( / i pre_list post_list item)
                (setq
                  i 0
                  pre_list nil
                  post_list nil
                )

                (while (< i (NATIVE_FUNCTION_LENGTH copy))
                  (setq item (NATIVE_FUNCTION_NTH i copy))

                  (cond
                    ((< i rand_index)
                      (setq pre_list (NATIVE_FUNCTION_APPEND pre_list (NATIVE_FUNCTION_LIST item)))
                    )

                    ((> i rand_index)
                      (setq post_list (NATIVE_FUNCTION_APPEND post_list (NATIVE_FUNCTION_LIST item)))
                    )
                  )

                  (setq i (1+ i))
                )

                (setq copy (NATIVE_FUNCTION_APPEND post_list pre_list))
              ))

              (setq i (1+ i))
            )

            (newlist ret_list)
          ))
        )

        (defun shuffle! ( / )
          ; shuffle! → ary
          ; shuffle!(random: rng) → ary
          ; Shuffles elements in self in place.

          (set self (shuffle))
        )

        (defun size ( / )
          ; size()
          ; Alias for: length
        
          (NATIVE_FUNCTION_LENGTH l)
        )

        ; DONT: take range
        (defun slice ( / index start length)
          ; slice(index) → obj or nil
          ; slice(start, length) → new_ary or nil
          ; slice(range) → new_ary or nil
          ; Element Reference — Returns the element at index, or returns a subarray starting at the start index and continuing for length elements, or returns a subarray specified by range of indices.
          ; Negative indices count backward from the end of the array (-1 is the last element).
          ; For start and range cases the starting index is just before an element.
          ; Additionally, an empty array is returned when the starting index for an element range is at the end of the array.
          ; Returns nil if the index (or starting index) are out of range.

          (setq index nil)
          (setq start nil)
          (setq length nil)

          (cond
            ((NATIVE_FUNCTION_CDR params)
              (setq
                start (NATIVE_FUNCTION_CAR params)
                length (NATIVE_FUNCTION_CADR params)
              )

              (error_integer 'UNLIMITED start 'UNLIMITED "slice")
              (error_integer 'UNLIMITED length 'UNLIMITED "slice")

              (if (equal start (normalize_index start))
                ((lambda ( / i ret_list item)
                  (setq
                    i 0
                    start (rotate_index start)
                    ret_list nil
                  )

                  (while (< i (NATIVE_FUNCTION_LENGTH l))
                    (setq item (NATIVE_FUNCTION_NTH i l))
                    
                    (if (and (>= i start) (< i (+ start length)))
                      (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))
                    )

                    (setq i (1+ i))
                  )

                  ret_list
                ))
              ;else
                nil
              )
            )

            (params
              (setq index (NATIVE_FUNCTION_CAR params))

              (error_integer 'UNLIMITED index 'UNLIMITED "slice")

              (if (equal index (normalize_index index))
                (NATIVE_FUNCTION_NTH index l)
              ;else
                nil
              )
            )

            (T
              (raise "list method 'slice' not given argument")
            )
          )
        )

        ; DONT: take range
        (defun slice! ( / )
          ; slice!(index) → obj or nil
          ; slice!(start, length) → new_ary or nil
          ; slice!(range) → new_ary or nil
          ; Deletes the element(s) given by an index (optionally up to length elements) or by a range.
          ; Returns the deleted object (or objects), or nil if the index is out of range.

          (setq index nil)
          (setq start nil)
          (setq length nil)

          (cond
            ((NATIVE_FUNCTION_CDR params)
              (setq
                start (NATIVE_FUNCTION_CAR params)
                length (NATIVE_FUNCTION_CADR params)
              )

              (error_integer 'UNLIMITED start 'UNLIMITED "slice")
              (error_integer 'UNLIMITED length 'UNLIMITED "slice")

              (if (equal start (normalize_index start))
                ((lambda ( / i new_list ret_list item)
                  (setq
                    i 0
                    start (rotate_index start)
                    new_list nil
                    ret_list nil
                  )

                  (while (< i (NATIVE_FUNCTION_LENGTH l))
                    (setq item (NATIVE_FUNCTION_NTH i l))
                    
                    (if (or (< i start) (>= i (+ start length)))
                      (setq new_list (NATIVE_FUNCTION_APPEND new_list (NATIVE_FUNCTION_LIST item)))
                    ;else
                      (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))
                    )

                    (setq i (1+ i))
                  )

                  (set self (newlist new_list))

                  ret_list
                ))
              ;else
                nil
              )
            )

            (params
              (setq index (NATIVE_FUNCTION_CAR params))

              (error_integer 'UNLIMITED index 'UNLIMITED "slice")

              (if (equal index (normalize_index index))
                ((lambda ( / i new_list ret_object item)
                  (setq
                    i 0
                    index (rotate_index index)
                    new_list nil
                    ret_object (NATIVE_FUNCTION_NTH index l)
                  )

                  (while (< i (NATIVE_FUNCTION_LENGTH l))
                    (setq item (NATIVE_FUNCTION_NTH i l))
                    
                    (if (not (equal i index))
                      (setq new_list (NATIVE_FUNCTION_APPEND new_list (NATIVE_FUNCTION_LIST item)))
                    )

                    (setq i (1+ i))
                  )

                  (set self (newlist new_list))

                  ret_object
                ))
              ;else
                nil
              )
            )

            (T
              (raise "list method 'slice' not given argument")
            )
          )
        )

        (defun sort ( / block)
          ; sort → new_ary
          ; sort { |a, b| block } → new_ary
          ; Returns a new array created by sorting self.
          ; Comparisons for the sort will be done using the <=> operator or using an optional code block.
          ; The block must implement a comparison between a and b and return an integer less than 0 when b follows a, 0 when a and b are equivalent, or an integer greater than 0 when a follows b.
          ; The result is not guaranteed as stable. When comparison of two elements returns 0, the order of the elements is unpredictable.
          ; See also Enumerable#sort_by.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )

          (if (not block)
            (setq block '(lambda (x y / ) (cond ((equal x y) 0) ((< x y) -1) ((> x y) 1))))
          )

          ((lambda ( / quick_sort partition_lo partition_hi)
            (defun quick_sort (lst / )
              (cond
                ((null lst)
                  nil
                )

                (t
                  (NATIVE_FUNCTION_APPEND
                    (quick_sort (partition_lo (NATIVE_FUNCTION_CAR lst) (NATIVE_FUNCTION_CDR lst)))
                    (NATIVE_FUNCTION_CONS (NATIVE_FUNCTION_CAR lst) nil) 
                    (quick_sort (partition_hi (NATIVE_FUNCTION_CAR lst) (NATIVE_FUNCTION_CDR lst)))
                  )
                )
              )
            )

            (defun partition_lo (a b)
              (cond
                ((or (null a) (null b))
                  nil
                )

                ((< (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST a (NATIVE_FUNCTION_CAR b))) 0)
                  (partition_lo a (NATIVE_FUNCTION_CDR b))
                )

                (t
                  (NATIVE_FUNCTION_CONS (NATIVE_FUNCTION_CAR b) (partition_lo a (NATIVE_FUNCTION_CDR b)))
                )
              )
            )

            (defun partition_hi (a b)
              (cond
                ((or (null a) (null b))
                  nil
                )

                ((>= (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST a (NATIVE_FUNCTION_CAR b))) 0)
                  (partition_hi a (NATIVE_FUNCTION_CDR b))
                )

                (t
                  (NATIVE_FUNCTION_CONS (NATIVE_FUNCTION_CAR b) (partition_hi a (NATIVE_FUNCTION_CDR b)))
                )
              )
            )

            (newlist (quick_sort l))
          ))
        )

        (defun sort! ( / )
          ; sort! → ary
          ; sort! { |a, b| block } → ary
          ; Sorts self in place.
          ; Comparisons for the sort will be done using the <=> operator or using an optional code block.
          ; The block must implement a comparison between a and b and return an integer less than 0 when b follows a, 0 when a and b are equivalent, or an integer greater than 0 when a follows b.
          ; The result is not guaranteed as stable. When comparison of two elements returns 0, the order of the elements is unpredictable.
          ; See also Enumerable#sort_by.

          (set self (sort))
        )

        (defun sort_by! ( / block)
          ; sort_by! { |obj| block } → ary
          ; sort_by! → Enumerator
          ; Sorts self in place using a set of keys generated by mapping the values in self through the given block.
          ; The result is not guaranteed as stable. When two keys are equal, the order of the corresponding elements is unpredictable.
          ; If no block is given, an Enumerator is returned instead.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )

          (if block
            ((lambda ( / quick_sort partition_lo partition_hi given_block)
              (setq
                given_block block
                block '(lambda (x y / )

                  (terpri)(princ "before")
                  (terpri)(princ x)
                  (terpri)(princ y)
                  (setq
                    x (NATIVE_FUNCTION_APPLY given_block (NATIVE_FUNCTION_LIST x))
                    y (NATIVE_FUNCTION_APPLY given_block (NATIVE_FUNCTION_LIST y))
                  )

                  (terpri)(princ "after")
                  (terpri)(princ x)
                  (terpri)(princ y)

                  (cond
                    ((equal x y) 0)
                    ((< x y) -1)
                    ((> x y) 1)
                  )
                )
              )

              (defun quick_sort (lst / )
                (cond
                  ((null lst)
                    nil
                  )

                  (t
                    (NATIVE_FUNCTION_APPEND
                      (quick_sort (partition_lo (NATIVE_FUNCTION_CAR lst) (NATIVE_FUNCTION_CDR lst)))
                      (NATIVE_FUNCTION_CONS (NATIVE_FUNCTION_CAR lst) nil) 
                      (quick_sort (partition_hi (NATIVE_FUNCTION_CAR lst) (NATIVE_FUNCTION_CDR lst)))
                    )
                  )
                )
              )

              (defun partition_lo (a b)
                (cond
                  ((or (null a) (null b))
                    nil
                  )

                  ((< (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST a (NATIVE_FUNCTION_CAR b))) 0)
                    (partition_lo a (NATIVE_FUNCTION_CDR b))
                  )

                  (t
                    (NATIVE_FUNCTION_CONS (NATIVE_FUNCTION_CAR b) (partition_lo a (NATIVE_FUNCTION_CDR b)))
                  )
                )
              )

              (defun partition_hi (a b)
                (cond
                  ((or (null a) (null b))
                    nil
                  )

                  ((>= (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST a (NATIVE_FUNCTION_CAR b))) 0)
                    (partition_hi a (NATIVE_FUNCTION_CDR b))
                  )

                  (t
                    (NATIVE_FUNCTION_CONS (NATIVE_FUNCTION_CAR b) (partition_hi a (NATIVE_FUNCTION_CDR b)))
                  )
                )
              )

              (set self (newlist (quick_sort l)))
            ))
          ;else
            (eval self)
          )
        )

        (defun sum ( / init block)
          ; sum(init=0) → number
          ; sum(init=0) {|e| expr } → number
          ; Returns the sum of elements. For example, [e1, e2, e3].sum returns init + e1 + e2 + e3.
          ; If a block is given, the block is applied to each element before addition.
          ; If ary is empty, it returns init.
          ; The (arithmetic) mean value of an array can be obtained as follows.
          ;   mean = ary.sum(0.0) / ary.length
          ; This method can be used for non-numeric objects by explicit init argument.
          ;   ["a", "b", "c"].sum("")            #=> "abc"
          ;   [[1], [[2]], [3]].sum([])          #=> [1, [2], 3]
          ; However, #join and #flatten is faster than #sum for array of strings and array of arrays.
          ;   ["a", "b", "c"].join               #=> "abc"
          ;   [[1], [[2]], [3]].flatten(1)       #=> [1, [2], 3]
          ; #sum method may not respect method redefinition of "+" methods such as Integer#+.

          (setq init 0)
          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            ;else
              (if (NATIVE_FUNCTION_CADR params)
                (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CADR params))) 'SUBR)
                  (cond
                    ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CADR params)) 'LIST)
                      (setq block (NATIVE_FUNCTION_CADR params))
                    )

                    ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CADR params)) 'SUBR)
                      (setq block '(NATIVE_FUNCTION_CADR params))
                    )

                    (T
                      nil
                    )
                  )
                ;else
                  (setq init (NATIVE_FUNCTION_CAR params))
                )
              ;else
                (setq init (NATIVE_FUNCTION_CAR params))
              )
            )
          )

          (if block
            ((lambda ( / i sum item)
              (setq
                i 0
                sum init
              )
              
              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_NTH i l))
                
                (setq sum (+ sum (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST item))))

                (setq i (1+ i))
              )
              
              sum
            ))
          ;else
            ((lambda ( / i sum item)
              (setq
                i 0
                sum init
              )
              
              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_NTH i l))
                
                (setq sum (+ sum item))

                (setq i (1+ i))
              )
              
              sum
            ))
          )
        )

        (defun take ( / n)
          ; take(n) → new_ary
          ; Returns first n elements from the array.
          ; If a negative number is given, raises an ArgumentError.
          ; See also #drop

          (setq n nil)

          (if (not params)
            (raise "list method 'take' not given integer argument")
          )

          (setq n (NATIVE_FUNCTION_CAR params))

          (error_integer 'ZERO n 'UNLIMITED "take")

          ((lambda ( / i ret_list item)
            (setq 
              i 0
              ret_list nil
            )

            (while (< i (NATIVE_FUNCTION_LENGTH l))
              (setq item (NATIVE_FUNCTION_NTH i l))

              (if (< i n)
                (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))
              )

              (setq i (1+ i))
            )

            (newlist ret_list)
          ))
        )

        (defun take_while ( / )
          ; take_while { |obj| block } → new_ary
          ; take_while → Enumerator
          ; Passes elements to the block until the block returns nil or false, then stops iterating and returns an array of all prior elements.
          ; If no block is given, an Enumerator is returned instead.
          ; See also #drop_while

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )
          
          (if block
            ((lambda ( / i ret_list take item)
              (setq
                i 0
                ret_list nil
                take T
              )
              
              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_NTH i l))

                (if (not (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST item)))
                  (setq take nil)
                )
                
                (if take
                  (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))
                )

                (setq i (1+ i))
              )
              
              (newlist ret_list)
            ))
          ;else
            (eval self)
          )
        )

        ; TODO: implement
        (defun to_a ( / )
          ; to_a → ary
          ; Returns self.
          ; If called on a subclass of Array, converts the receiver to an Array object.
          
          nil
        )

        ; TODO: implement
        (defun to_ary ( / )
          to_ary → ary
          Returns self.
          
          nil
        )

        ; TODO: implement
        (defun to_h ( / )
          ; to_h → hash
          ; Returns the result of interpreting ary as an array of [key, value] pairs.
          
          nil
        )

        (defun to_s ( / )
          ; to_s()
          ; Alias for: inspect

          (inspect)
        )

        (defun transpose ( / )
          ; transpose → new_ary
          ; Assumes that self is an array of arrays and transposes the rows and columns.
          ; If the length of the subarrays don’t match, an IndexError is raised.
          
          ((lambda ( / i width sub_list)
            (setq
              i 0
              width nil
            )

            (while (< i (NATIVE_FUNCTION_LENGTH l))
              (setq sub_list (NATIVE_FUNCTION_NTH i l))

              (if (not (equal (type (valof sub_list)) 'LIST))
                (raise "list method 'tranpose' called on list not of at least two dimensions")
              )

              (if width
                (if (not (equal (NATIVE_FUNCTION_LENGTH (valof sub_list)) width))
                  (raise "list method 'tranpose' called on list not of uniform nxm")
                )
              ;else
                (setq width (NATIVE_FUNCTION_LENGTH (valof sub_list)))
              )

              (setq i (1+ i))
            )
          ))

          ; Credit to: http://stackoverflow.com/questions/39943232/matrix-transpose-common-lisp

          ((lambda ( / cars cdrs trans)
            (defun cars (matrix / )
              (if (null matrix)
                nil
              ;else
                (cons (car (car matrix)) (cars (cdr matrix)))
              )
            )

            (defun cdrs (matrix / )
              (if (null matrix)
                nil
              ;else
                (cons (cdr (car matrix)) (cdrs (cdr matrix)))
              )
            )
            
            (defun trans (matrix / )
              (cond
                ((null matrix)
                  nil
                )

                ((null (car matrix))
                  nil
                )

                (t
                  (cons (cars matrix) (trans (cdrs matrix)))
                )
              )
            )

            (newlist (trans l))
          ))
        )

        (defun uniq ( / block)
          ; uniq → new_ary
          ; uniq { |item| ... } → new_ary
          ; Returns a new array by removing duplicate values in self.
          ; If a block is given, it will use the return value of the block for comparison.
          ; It compares values using their hash and eql? methods for efficiency.
          ; self is traversed in order, and the first occurrence is kept.

          (setq block nil)

          (if (NATIVE_FUNCTION_CAR params)
            (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_CAR params))) 'SUBR)
              (cond
                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'LIST)
                  (setq block (NATIVE_FUNCTION_CAR params))
                )

                ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_CAR params)) 'SUBR)
                  (setq block '(NATIVE_FUNCTION_CAR params))
                )

                (T
                  nil
                )
              )
            )
          )

          (if block
            ((lambda ( / i ret_list item)
              (setq 
                i 1
                ret_list (NATIVE_FUNCTION_LIST (NATIVE_FUNCTION_CAR l))
              )

              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST (NATIVE_FUNCTION_NTH i l))))

                ((lambda ( / j found sub_item)
                  (setq
                    j 0
                    found nil
                  )

                  (while (and (not found) (< j (NATIVE_FUNCTION_LENGTH ret_list)))
                    (setq sub_item (NATIVE_FUNCTION_APPLY block (NATIVE_FUNCTION_LIST (NATIVE_FUNCTION_NTH j ret_list))))

                    (if (equal sub_item item)
                      (setq found T)
                    )

                    (setq j (1+ j))
                  )

                  (if (not found)
                    (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST (NATIVE_FUNCTION_NTH i l))))
                  )
                ))

                (setq i (1+ i))
              )

              (newlist ret_list)
            ))
          ;else
            ((lambda ( / i ret_list item)
              (setq 
                i 1
                ret_list (NATIVE_FUNCTION_LIST (NATIVE_FUNCTION_CAR l))
              )

              (while (< i (NATIVE_FUNCTION_LENGTH l))
                (setq item (NATIVE_FUNCTION_NTH i l))

                (if (not (NATIVE_FUNCTION_MEMBER item ret_list))
                  (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))
                )

                (setq i (1+ i))
              )

              (newlist ret_list)
            ))
          )
        )

        (defun uniq! ( / )
          ; uniq! → ary or nil
          ; uniq! { |item| ... } → ary or nil
          ; Removes duplicate elements from self.
          ; If a block is given, it will use the return value of the block for comparison.
          ; It compares values using their hash and eql? methods for efficiency.
          ; self is traversed in order, and the first occurrence is kept.
          ; Returns nil if no changes are made (that is, no duplicates are found).

          ((lambda ( / naught final)
            (setq naught (NATIVE_FUNCTION_LENGTH (valof self)))

            (set self (uniq))

            (setq final (NATIVE_FUNCTION_LENGTH (valof self)))

            (if (equal naught final)
              nil
            ;else
              (eval self)
            )
          ))
        )

        (defun unshift ( / objs)
          ; unshift(obj, ...) → ary
          ; Prepends objects to the front of self, moving other elements upwards.
          ; See also #shift for the opposite effect.

          (setq objs params)

          (set self (newlist (NATIVE_FUNCTION_APPEND objs l)))
        )

        ; DONT: take range
        (defun values_at ( / selectors)
          ; values_at(selector, ...) → new_ary
          ; Returns an array containing the elements in self corresponding to the given selector(s).
          ; The selectors may be either integer indices or ranges.
          ; See also #select.

          (setq selectors params)

          (newlist (NATIVE_FUNCTION_MAPCAR
            '(lambda (i / )
              (if (equal i (normalize_index i))
                (NATIVE_FUNCTION_NTH (rotate_index i) l)
              ;else
                nil
              )
            )
            selectors)
          )

          ; ((lambda ( / i ret_list item)
          ;   (setq
          ;     i 0
          ;     ret_list l
          ;   )

          ;   (while (< i (NATIVE_FUNCTION_LENGTH objs))
          ;     (setq item (NATIVE_FUNCTION_NTH i objs))

          ;     (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST item)))

          ;     (setq i (1+ i))
          ;   )

          ;   (set self (newlist ret_list))
          ; ))
        )

        (defun zip ( / args block)
          ; zip(arg, ...) → new_ary
          ; zip(arg, ...) { |arr| block } → nil
          ; Converts any arguments to arrays, then merges elements of self with corresponding elements from each argument.
          ; This generates a sequence of ary.size n-element arrays, where n is one more than the count of arguments.
          ; If the size of any argument is less than the size of the initial array, nil values are supplied.
          ; If a block is given, it is invoked for each output array, otherwise an array of arrays is returned.

          (setq args nil)
          (setq block nil)

          (if (NATIVE_FUNCTION_LAST params)
            (if (equal (type (NATIVE_FUNCTION_LAST params)) 'LISTOBJECT)
              (setq args params)
            ;else
              (if (equal (NATIVE_FUNCTION_TYPE (eval (NATIVE_FUNCTION_LAST params))) 'SUBR)
                (progn
                  (cond
                    ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_LAST params)) 'LIST)
                      (setq block (NATIVE_FUNCTION_LAST params))
                    )

                    ((equal (NATIVE_FUNCTION_TYPE (NATIVE_FUNCTION_LAST params)) 'SUBR)
                      (setq block '(NATIVE_FUNCTION_LAST params))
                    )

                    (T
                      nil
                    )
                  )

                  ((lambda ( / i item)
                    (setq i 0)

                    (while (< i (1- (NATIVE_FUNCTION_LENGTH params)))
                      (setq item (NATIVE_FUNCTION_NTH i params))

                      (setq args (NATIVE_FUNCTION_APPEND args (NATIVE_FUNCTION_LIST item)))

                      (setq i (1+ i))
                    )
                  ))
                )
              ;else
                (raise "list method 'zip' given last argument not of type LIST or SUBR")
              )
            )
          )

          ((lambda ( / i ret_list item sub_list)
            (setq
              i 0
              ret_list nil
            )

            (while (< i (NATIVE_FUNCTION_LENGTH l))
              (setq item (NATIVE_FUNCTION_NTH i l))

              (setq sub_list (NATIVE_FUNCTION_LIST item))

              ((lambda ( / j arg_sub_list item)
                (setq j 0)

                (while (< j (NATIVE_FUNCTION_LENGTH args))
                  (setq arg_sub_list (NATIVE_FUNCTION_NTH j args))

                  (if (not (equal (NATIVE_FUNCTION_TYPE arg_sub_list) 'LIST))
                    (raise "list method 'zip' given argument not of type LIST")
                  )

                  (setq item (NATIVE_FUNCTION_NTH i (valof arg_sub_list)))

                  (setq sub_list (NATIVE_FUNCTION_APPEND sub_list (NATIVE_FUNCTION_LIST item)))

                  (setq j (1+ j))
                )

                (setq sub_list (newlist sub_list))
              ))

              (setq ret_list (NATIVE_FUNCTION_APPEND ret_list (NATIVE_FUNCTION_LIST sub_list)))

              (setq i (1+ i))
            )

            (if block
              (progn
                (NATIVE_FUNCTION_MAPCAR block ret_list)
                nil
              )
            ;else
              (newlist ret_list)
            )
          ))
        )

        ; finally, run the requested method
        ((eval method))
      )
    )
  )
)

; ; TODO: error on negative n
; (defun l-method-shift (sym n / i ret)
;   (setq ret nil)
  
;   (set sym (reverse (eval sym)))
;   (setq ret (reverse (l-method-pop sym n)))
;   (set sym (reverse (eval sym)))
  
;   ret
; )

; ; CANT: take range
; (defun l-method-shuffle (l / )
;   (l-method-sample l (length l))
; )

; ; CANT: take range
; (defun l-method-shuffle! (sym / )
;   (set sym (l-method-shuffle (eval sym)))
; )

; (defun l-method-size (l / )
;   (length l)
; )

; ; TODO: throw errors
; ; CANT: take range
; (defun l-method-fill (sym start n object fn / l i new_l begin end stop)
;   (setq
;     l (eval sym)
;     i 0
;     new_l nil
;   )
  
;   (if start
;     (if (>= start 0)
;       (setq begin start)
;     ;else
;       (if (>= (+ (length l) start) 0)
;         (setq begin (+ (length l) start))
;       ;else
;         (setq begin 0)
;       )
;     )
;   ;else
;     (setq begin 0)
;   )
  
;   (if n
;     (if (> n 0)
;       (setq end (+ begin n))
;     ;else
;       (setq end nil)
;     )
;   ;else
;     (setq end (length l))
;   )
  
;   (if (< end (length l))
;     (setq stop (length l))
;   ;else
;     (setq stop end)
;   )
  
;   (if end
;     (cond
;       (fn
;         (while (< i stop)
;           (if (and (>= i begin) (< i end))
;             (l-method-push 'new_l (apply fn (list i)))
;           ;else
;             (l-method-push 'new_l (nth i l))
;           )
          
;           (setq i (1+ i))
;         )
;       )

;       (object
;         (while (< i stop)
;           (if (and (>= i begin) (< i end))
;             (l-method-push 'new_l object)
;           ;else
;             (l-method-push 'new_l (nth i l))
;           )
          
;           (setq i (1+ i))
;         )
;       )
      
;       (T
;         nil ;error, neither object nor fn were given
;       )
;     )
;   ;else
;     (setq new_l l)
;   )
  
;   (set sym new_l)
; )

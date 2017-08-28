; Command: (load "ObjectInterpreter.lsp")
; Command: (interpret '(lambda ( / hi hi2)(defun hi (arg0 arg1 arg2 arg3 &rest / loc1 loc2)(foreach item &rest (print item)))(hi 0 1 2 3 4 5 6 7)(defun hi2 (arg0 &rest / loc1 loc2)(foreach item &rest (print item)))(hi2 0 1 2 3 4 5 6 7 8 9 10 11 12 13)))(princ)

; (interpret '(lambda ( / )
;   (defun hi (arg0 arg1 arg2 arg3 &rest / loc1 loc2)
;     (foreach item &rest (print item))
;   )
;   (hi 0 1 2 3 4 5 6 7)

;   (defun hi2 (arg0 &rest / loc1 loc2)
;     (foreach item &rest (print item)))
;   (hi2 0 1 2 3 4 5 6 7 8 9 10 11 12 13)
;   )
; )(princ)

(defun reset ( / )
  ; object reset
  (load "ObjectReset.lsp")
  (load "ObjectListReset.lsp")

  ; error reset
  (if NATIVE_FUNCTION_*ERROR*
    (setq *error* NATIVE_FUNCTION_*ERROR*)
  )

  (setq NATIVE_FUNCTION_*ERROR* nil)
)

(defun reset_before_error (msg / )
  (reset)
  (terpri)
  (princ "; error: ")
  (princ msg)
)

(defun interpret (commands / rest_assoc stack_level swap handle_save handle_swap save_rest swap_rest print_commands return_interpreter_result)
  (setq 
    stack_level nil
    rest_assoc nil
  )

  ; takes list of requested command contents, runs them together and interprets/swaps command contents
  (defun swap (contents / replaced_contents)
    (setq replaced_contents nil)

    (if (not stack_level)
      ((lambda ( / i cumulative_contents command)
        (setq
          i 0
          cumulative_contents nil
        )

        (while (< i (NATIVE_FUNCTION_LENGTH contents))
          (setq command (NATIVE_FUNCTION_NTH i contents))

          ; skip past lambda and ( / )
          (setq cumulative_contents (NATIVE_FUNCTION_APPEND cumulative_contents (NATIVE_FUNCTION_CDDR command)))

          (setq i (1+ i))
        )

        (setq
          contents cumulative_contents
          stack_level 0
        )
      ))
    )

    ((lambda ( / recurse? i processed_command command_name function_name argument_list rest_index argument_index static_list rest_list command)
      (defun recurse? (command / is_list in_function is_iif is_arguments)
        (setq is_list (equal (NATIVE_FUNCTION_TYPE command) 'LIST))

        (if is_list
          (setq in_function (equal command_name 'DEFUN))
        )

        ; (if (and is_list (equal (NATIVE_FUNCTION_LENGTH command) 1) (equal (NATIVE_FUNCTION_TYPE (car command)) 'LIST))
        ;   (setq is_iif (equal (NATIVE_FUNCTION_CAAR command) 'LAMBDA))
        ; )

        (setq is_arguments (and in_function function_name (not argument_list)))

        (and is_list (not is_iif) (not is_arguments))
      )

      (setq i 0)

      ; variables for recognizing function definitions with &rest parameter
      (setq
        command_name nil
        function_name nil
        argument_list nil
      )

      ; variables for replacing &rest arguments
      (setq
        rest_index nil
        argument_index nil
        static_list nil
        rest_list nil
      )

      (while (< i (NATIVE_FUNCTION_LENGTH contents))
        (setq command (NATIVE_FUNCTION_NTH i contents))

        (if (recurse? command)
          (setq
            stack_level (1+ stack_level)
            processed_command (swap command)
          )
        ;else
          (cond
            ; first get the name of the command of the list contents
            ((not command_name)
              (setq command_name command)

              (if (NATIVE_FUNCTION_ASSOC command_name rest_assoc)
                (setq rest_index (NATIVE_FUNCTION_CADR (NATIVE_FUNCTION_ASSOC command_name (NATIVE_FUNCTION_REVERSE rest_assoc))))
              )

              (setq processed_command command)
            )

            ; if a function definition
            ((equal command_name 'DEFUN)
              (cond
                ; get function name
                ((not function_name)
                  (setq function_name command)
                )

                ; next get argument list
                ((not argument_list)
                  (setq argument_list command)

                  ; throw onto rest argument association list stack if &rest is part of it
                  (if (NATIVE_FUNCTION_MEMBER '&rest argument_list)
                    ((lambda ( / i index argument)
                      (setq
                        i 0
                        index nil
                      )

                      (while (< i (NATIVE_FUNCTION_LENGTH argument_list))
                        (setq argument (NATIVE_FUNCTION_NTH i argument_list))

                        (if (not index)
                          (if (equal argument '&rest)
                            (setq index i)
                          )
                        )

                        (setq i (1+ i))
                      )

                      (setq rest_assoc (NATIVE_FUNCTION_APPEND rest_assoc (NATIVE_FUNCTION_LIST (NATIVE_FUNCTION_LIST function_name index stack_level))))
                    ))
                  )
                )
              )

              (setq processed_command command)
            )

            (T
              (setq processed_command command)
            )
          )
        )

        (if rest_index
          (if (and argument_index static_list rest_list)
            (progn
              (if (equal command_name 'DOT)
                (progn 
                  (cond
                    ; object argument
                    ((equal argument_index 0)
                      (if (not (equal (type processed_command) 'LIST))
                        (setq processed_command (NATIVE_FUNCTION_LIST 'QUOTE processed_command))
                      )
                    )

                    ; method argument
                    ((equal argument_index 1)
                      (if (not (equal (type processed_command) 'LIST))
                        (setq processed_command (NATIVE_FUNCTION_LIST 'QUOTE processed_command))
                      )
                    )
                  )
                )
              )

              (if (>= argument_index rest_index)
                (setq rest_list (NATIVE_FUNCTION_APPEND rest_list (NATIVE_FUNCTION_LIST processed_command)))
              ;else
                (setq static_list (NATIVE_FUNCTION_APPEND static_list (NATIVE_FUNCTION_LIST processed_command)))
              )

              (setq replaced_contents (NATIVE_FUNCTION_APPEND static_list (NATIVE_FUNCTION_LIST rest_list)))

              (setq argument_index (1+ argument_index))
            )
          ;else
            ; intialize components
            (setq
              argument_index 0
              static_list (NATIVE_FUNCTION_LIST command_name)
              rest_list (NATIVE_FUNCTION_LIST NATIVE_FUNCTION_LIST)
            )
          )
        ;else
          (setq replaced_contents (NATIVE_FUNCTION_APPEND replaced_contents (NATIVE_FUNCTION_LIST processed_command)))
        )

        (setq i (1+ i))
      )
    ))

    ; pop off all rest parameter associations at this stack level to maintain scope
    ((lambda ( / i association new_rest_assoc)
      (setq
        i 0
        new_rest_assoc nil
      )

      (while (< i (NATIVE_FUNCTION_LENGTH rest_assoc))
        (setq association (NATIVE_FUNCTION_NTH i rest_assoc))

        (if (>= stack_level (NATIVE_FUNCTION_CADDR association))
          (setq new_rest_assoc (NATIVE_FUNCTION_APPEND new_rest_assoc (NATIVE_FUNCTION_LIST association)))
        )

        (setq i (1+ i))
      )

      (setq rest_assoc new_rest_assoc)
    ))

    (setq stack_level (1- stack_level))

    replaced_contents
  )

  (defun print_commands (commands indent / i indent command)
    (setq i 0)

    (while (< i (NATIVE_FUNCTION_LENGTH commands))
      (setq command (NATIVE_FUNCTION_NTH i commands))

        (if (equal (type command) 'LIST)
          (progn
            (terpri)
            (repeat (1+ indent) (princ "  "))
            (princ "(")
            (print_commands command (1+ indent))
            (princ ")")
          )
        ;else
          (progn (princ " ") (princ command) (princ " "))
        )

      (setq i (1+ i))
    )
  )

  ; reset environment
  (reset)

  ; trap errors to reset environment
  (if (not NATIVE_FUNCTION_*ERROR*)
    (setq NATIVE_FUNCTION_*ERROR* *error*)
  )
  (setq *error* reset_before_error)

  ; object setup
  (load "ObjectSetup.lsp")
  (load "ObjectListSetup.lsp")

  ; get newly replaced commands
  (setq commands (swap (NATIVE_FUNCTION_LIST (load "Object.lsp") (load "ObjectList.lsp") commands)))
  (setq commands (NATIVE_FUNCTION_APPEND (NATIVE_FUNCTION_LIST 'LAMBDA nil) commands))

  ; print commands before running
  ; (terpri)(print_commands commands 0)

  ; run the interpreted commands
  (setq return_interpreter_result (NATIVE_FUNCTION_APPLY commands nil))

  ; reset environment
  (reset)

  ; return interpreted result
  ; TODO: figure out why the hell this needs to be a list
  (list return_interpreter_result)
  ; return_interpreter_result
)

(princ)

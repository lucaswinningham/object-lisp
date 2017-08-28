(defun stringp (object / )
	(not (not (NATIVE_FUNCTION_MEMBER (type object) (list 'STR 'STROBJECT))))
)

(if debug_trace
	(progn
		(trace to_s)
		(trace newstring)
	)
)

; takes an object to write to a file as if it were the console
; returns string read back from file
; TODO: using vanilla lisp, delete the file
; TODO: errors
(defun to_s (object / )
	(if (stringp object)
		(valof object)
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

		  (prin1 object file)

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
)

; (defun newstring (str / )
; )

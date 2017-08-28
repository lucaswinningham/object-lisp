(setq debug nil)
(setq debug_trace nil)

(load "ObjectInterpreter.lsp")

(if debug
  (interpret (load "ObjectTest.lsp"))
)

(princ)

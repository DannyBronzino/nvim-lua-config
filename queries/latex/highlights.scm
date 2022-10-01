;;extends

((generic_command
  command: (command_name) @text.emphasis @conceal (#set! conceal "t")
  arg: (curly_group (_) @operator))
  (#eq? @_name "\\textquote"))

((generic_command
  command: (command_name) @text.emphasis @conceal (#set! conceal "m")
  arg: (curly_group (_) @operator))
  (#eq? @_name "\\mentalquote"))

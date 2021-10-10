type token =
  | VAR of (string)
  | EOL

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> ParserTypeP1.exp

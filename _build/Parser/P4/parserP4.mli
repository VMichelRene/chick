type token =
  | VAR of (string)
  | INF
  | EQ
  | EOL

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> ParserTypeP4.exp

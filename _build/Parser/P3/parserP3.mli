type token =
  | VAR of (string)
  | PLUS
  | LPAREN
  | RPAREN
  | EOL

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> ParserTypeP3.exp

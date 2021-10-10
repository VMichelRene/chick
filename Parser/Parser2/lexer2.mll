{
open Parser2        (* liste des tokens *) 
exception Eof
}
rule token = parse
    [' ' '\t']              { token lexbuf }     (* skip blanks *)
  | ['\n' ]                 { EOL }
  | ['a'-'z' 'A'-'Z']+ as s { VAR s }
  | '+'                     { PLUS }
  | '*'                     { TIMES }
  | '{'                     { LACCOLADE }
  | '}'                     { RACCOLADE }
  | '('                     { LPAREN }
  | ')'                     { RPAREN }
  | "<="                     { INF }
  | '='                     { EQ }
  
| eof                     { raise Eof }

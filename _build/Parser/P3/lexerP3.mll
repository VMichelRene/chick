{
open ParserP3        (* liste des tokens *) 
exception Eof
}
rule token = parse
    [' ' '\t']              { token lexbuf }     (* skip blanks *)
  | ['\n' ]                 { EOL }
  | ['a'-'z' 'A'-'Z']+ as s { VAR s }
  | '+'                     { PLUS }
  | '('                     { LPAREN }
  | ')'                     { RPAREN }
  
| eof                     { raise Eof }

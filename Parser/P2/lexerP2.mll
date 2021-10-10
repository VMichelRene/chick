{
open ParserP2        (* liste des tokens *) 
exception Eof
}
rule token = parse
    [' ' '\t']                { token lexbuf }     (* skip blanks *)
  | ['\n' ]                   { EOL }
  | [^'+''*''('')''\n']+ as s { VAR s }
  | '+'                       { PLUS }
  | '*'                       { TIMES }
  | '('                       { LPAREN }
  | ')'                       { RPAREN }
  
| eof                     { raise Eof }

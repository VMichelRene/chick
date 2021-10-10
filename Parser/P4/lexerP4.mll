{
open ParserP4        (* liste des tokens *) 
exception Eof
}
rule token = parse
    [' ' '\t']              { token lexbuf }     (* skip blanks *)
  | ['\n' ]                 { EOL }
  | [^'<''=''\n']+ as s     { VAR s }
  | "<="                    { INF }
  | '='                     { EQ }
  
| eof                     { raise Eof }

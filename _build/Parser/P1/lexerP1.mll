{
open ParserP1        (* liste des tokens *) 
exception Eof
}
rule token = parse
    [' ' '\t']              { token lexbuf }     (* skip blanks *)
  | ['\n' ]                 { EOL }
  | ['a'-'z' 'A'-'Z']+ as s { VAR s }
| eof                     { raise Eof }

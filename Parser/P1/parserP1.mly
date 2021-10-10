%{
open Printf 
open ParserTypeP1
let sVar    a   = M1 a
%}
%token <string> VAR
%token EOL
%start main             /* the entry point */
%type <ParserTypeP1.exp> main
%%
main:
    expr EOL                   { $1 }
;
expr:
  | VAR                        { sVar $1 }
;

%{
open Printf 
open ParserTypeP4

let sVar       a   = M1 a
let sInf       a b = Inf (a,b)
let sEq        a b = Eq (a,b) 

%}
%token <string> VAR
%token INF EQ
%token EOL
%left INF EQ
%start main             /* the entry point */
%type <ParserTypeP4.exp> main
%%
main:
    expr EOL                   { $1 }
;
expr:
  | VAR                     { sVar $1 }
  | expr INF expr           { sInf $1 $3 }
  | expr EQ expr            { sEq $1 $3 } 
;

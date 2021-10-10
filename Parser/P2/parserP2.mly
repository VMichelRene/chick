%{
open Printf 
open ParserTypeP2
let sVar       a   = M1 a
let sPlus      a b = Loi1 (a,b)
let sTimes     a b = Loi2 (a,b)

%}
%token <string> VAR
%token PLUS TIMES 
%token LPAREN RPAREN
%token EOL
%left PLUS          /* medium precedence */
%left TIMES          /* medium precedence */
%start main             /* the entry point */
%type <ParserTypeP2.exp> main
%%
main:
    expr EOL                   { $1 }
;
expr:
  | VAR                        { sVar $1 }
  | LPAREN expr RPAREN        { $2 }
  | expr PLUS expr           { sPlus $1 $3}
  | expr TIMES expr          { sTimes $1 $3}
;

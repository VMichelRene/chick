%{
open Printf 
open ParserType2
(*
let sVar a = sprintf "Var(%s)" a
let sInf a b = sprintf "<=(%s,%s)" a b 
let sEq    a b = sprintf "=(%s,%s)" a b 
let sTimes  a b = sprintf "*(%s,%s)" a b 
*)
let sVar       a   = V a
let sInf       a b = Inf (a,b)
let sEq        a b = Egal (a,b) 
let sPlus      a b = Loi1 (a,b)
let sTimes     a b = Loi2 (a,b)
let sAccolade  a   = LoiUnaire1 a


%}
%token <string> VAR
%token PLUS TIMES INF EQ
%token LACCOLADE RACCOLADE
%token LPAREN RPAREN
%token EOL
%left PLUS          /* medium precedence */
%left TIMES          /* medium precedence */
%left INF EQ
%start main             /* the entry point */
%type <ParserType2.exp> main
%%
main:
    expr EOL                   { $1 }
;
expr1:
  | VAR                        { sVar $1 }
  | LACCOLADE expr1 RACCOLADE  { sAccolade $2 }
  | LPAREN expr1 RPAREN        { $2 }
  | expr1 PLUS expr1           { sPlus $1 $3}
  | expr1 TIMES expr1          { sTimes $1 $3}
;
expr:
  | expr1                     { $1 }
  | expr1 INF expr1           { sInf $1 $3 }
  | expr1 EQ expr1            { sEq $1 $3 } 
;

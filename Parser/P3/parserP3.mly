%{
open Printf 
open ParserTypeP3
let sVar       a   = M1 a
let sPlus      a b = Loi (a,b)

%}
%token <string> VAR
%token PLUS 
%token LPAREN RPAREN
%token EOL
%left PLUS    
%start main             /* the entry point */
%type <ParserTypeP3.exp> main
%%
main:
    expr EOL                   { $1 }
;
expr:
  | VAR                       { sVar $1 }
  | LPAREN expr RPAREN        { $2 }
  | expr PLUS expr            { sPlus $1 $3}
;

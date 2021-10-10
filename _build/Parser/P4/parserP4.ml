type token =
  | VAR of (string)
  | INF
  | EQ
  | EOL

open Parsing;;
let _ = parse_error;;
# 2 "Parser/P4/parserP4.mly"
open Printf 
open ParserTypeP4

let sVar       a   = M1 a
let sInf       a b = Inf (a,b)
let sEq        a b = Eq (a,b) 

# 18 "Parser/P4/parserP4.ml"
let yytransl_const = [|
  258 (* INF *);
  259 (* EQ *);
  260 (* EOL *);
    0|]

let yytransl_block = [|
  257 (* VAR *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\000\000"

let yylen = "\002\000\
\002\000\001\000\003\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\005\000\000\000\000\000\000\000\001\000\
\003\000\004\000"

let yydgoto = "\002\000\
\004\000\005\000"

let yysindex = "\004\000\
\005\255\000\000\000\000\000\000\254\254\005\255\005\255\000\000\
\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000"

let yygindex = "\000\000\
\000\000\253\255"

let yytablesize = 6
let yytable = "\006\000\
\007\000\008\000\009\000\010\000\001\000\003\000"

let yycheck = "\002\001\
\003\001\004\001\006\000\007\000\001\000\001\001"

let yynames_const = "\
  INF\000\
  EQ\000\
  EOL\000\
  "

let yynames_block = "\
  VAR\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 18 "Parser/P4/parserP4.mly"
                               ( _1 )
# 77 "Parser/P4/parserP4.ml"
               : ParserTypeP4.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 21 "Parser/P4/parserP4.mly"
                            ( sVar _1 )
# 84 "Parser/P4/parserP4.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 22 "Parser/P4/parserP4.mly"
                            ( sInf _1 _3 )
# 92 "Parser/P4/parserP4.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 23 "Parser/P4/parserP4.mly"
                            ( sEq _1 _3 )
# 100 "Parser/P4/parserP4.ml"
               : 'expr))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : ParserTypeP4.exp)

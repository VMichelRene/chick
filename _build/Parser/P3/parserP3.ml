type token =
  | VAR of (string)
  | PLUS
  | LPAREN
  | RPAREN
  | EOL

open Parsing;;
let _ = parse_error;;
# 2 "Parser/P3/parserP3.mly"
open Printf 
open ParserTypeP3
let sVar       a   = M1 a
let sPlus      a b = Loi (a,b)

# 17 "Parser/P3/parserP3.ml"
let yytransl_const = [|
  258 (* PLUS *);
  259 (* LPAREN *);
  260 (* RPAREN *);
  261 (* EOL *);
    0|]

let yytransl_block = [|
  257 (* VAR *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\000\000"

let yylen = "\002\000\
\002\000\001\000\003\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\000\000\005\000\000\000\000\000\000\000\
\001\000\003\000\004\000"

let yydgoto = "\002\000\
\005\000\006\000"

let yysindex = "\006\000\
\005\255\000\000\000\000\005\255\000\000\000\255\255\254\005\255\
\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\252\255"

let yytablesize = 8
let yytable = "\007\000\
\008\000\008\000\010\000\011\000\009\000\003\000\001\000\004\000"

let yycheck = "\004\000\
\002\001\002\001\004\001\008\000\005\001\001\001\001\000\003\001"

let yynames_const = "\
  PLUS\000\
  LPAREN\000\
  RPAREN\000\
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
# 17 "Parser/P3/parserP3.mly"
                               ( _1 )
# 78 "Parser/P3/parserP3.ml"
               : ParserTypeP3.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 20 "Parser/P3/parserP3.mly"
                              ( sVar _1 )
# 85 "Parser/P3/parserP3.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 21 "Parser/P3/parserP3.mly"
                              ( _2 )
# 92 "Parser/P3/parserP3.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 22 "Parser/P3/parserP3.mly"
                              ( sPlus _1 _3)
# 100 "Parser/P3/parserP3.ml"
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : ParserTypeP3.exp)

type token =
  | VAR of (string)
  | EOL

open Parsing;;
let _ = parse_error;;
# 2 "Parser/P1/parserP1.mly"
open Printf 
open ParserTypeP1
let sVar    a   = M1 a
# 12 "Parser/P1/parserP1.ml"
let yytransl_const = [|
  258 (* EOL *);
    0|]

let yytransl_block = [|
  257 (* VAR *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\000\000"

let yylen = "\002\000\
\002\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\003\000\000\000\001\000"

let yydgoto = "\002\000\
\004\000\005\000"

let yysindex = "\255\255\
\000\255\000\000\000\000\000\000\001\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000"

let yytablesize = 3
let yytable = "\001\000\
\003\000\000\000\006\000"

let yycheck = "\001\000\
\001\001\255\255\002\001"

let yynames_const = "\
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
# 12 "Parser/P1/parserP1.mly"
                               ( _1 )
# 64 "Parser/P1/parserP1.ml"
               : ParserTypeP1.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 15 "Parser/P1/parserP1.mly"
                               ( sVar _1 )
# 71 "Parser/P1/parserP1.ml"
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : ParserTypeP1.exp)

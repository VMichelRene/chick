(* Anneau *)
open Printf

module Make (L1 : L.S) (L2 : L.S) (E : E.S) = struct 
  type t =
    | Elt of E.t
    | L1  of (t * t)
    | L2  of (t * t)

 let rec to_s  = function
    | Elt a    -> E.to_s a 
    | L1 (a,b) -> sprintf "(%s %s %s)" (to_s a) L1.s (to_s b)
    | L2 (a,b) -> sprintf "(%s %s %s)" (to_s a) L2.s (to_s b)
 let sort = Outils.id

 open ParserTypeP2
  let from_s  s =
    let rec aux = function
       | M1 a           -> Elt (E.from_s a) 
       | Loi1 (a, b)    -> L1 (aux a,aux b)
       | Loi2 (a, b)    -> L2 (aux a,aux b)
     in
        sprintf "%s\n" s
    |>  Lexing.from_string
    |>  ParserP2.main LexerP2.token
    |>  aux

end


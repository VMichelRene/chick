open Printf

module Make (L : L.S) (E : E.S) = struct 
  type t =
    | Elt of E.t
    | L  of (t * t)

 let rec to_s  = function
    | Elt a    -> E.to_s a 
    | L (a,b)  -> sprintf "(%s %s %s)" (to_s a) L.s (to_s b)
 let sort = Outils.id


 open ParserTypeP3
  let from_s  s =
    let rec aux = function
       | M1 a           -> Elt (E.from_s a) 
       | Loi  (a, b)    -> L   (aux a,aux b)
     in
        sprintf "%s\n" s
    |>  Lexing.from_string
    |>  ParserP3.main LexerP3.token
    |>  aux

 let createL (a,b) = L (a,b)

 let p1 = function L (a,_) -> a
 let p2 = function L (_,b) -> b
end


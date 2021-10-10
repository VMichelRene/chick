open Printf
(* Ensemble basique *)
module E1 = struct
    type t      = string
    let to_s    = sprintf "%s"
    let nom     = "\\mathcal E"

open ParserTypeP1
  let from_s  s = 
    let rec aux = function
       | M1 a            -> a 
     in
        sprintf "%s\n" s
    |>  Lexing.from_string
    |>  ParserP1.main LexerP1.token
    |>  aux

end


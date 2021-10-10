(* Magma + Relation d'équivalence *)
open Printf
exception Erreur

module Make (R : R.S) (L : L.S) (E : E.S) = struct 
  (* on utilise un Magma *)
  module M =Magma_commutatif.Make (L) (E)

  type t =
    | Elt  of     M.t
    | Re   of (M.t * M.t)
    | Egal of (M.t * M.t)      (* la relation d'équivalence fournit l'égalité *)

  (* Reflexivité *)
  let reflexivite = function 
     | (Elt a) -> Re (a,a)
     | _ -> raise Erreur
  (* Transitivité *)
  let transitive = function 
     | (Re (x1,y1),Re (x2,y2))  when y1=x2 -> Re (x1,y2)
     | _ -> raise Erreur
  (* Antisymetrie *)
  let antisymetrie = function 
     | (Re (x1,y1),Re (x2,y2))  when x1=y2 && x2=y1 -> Egal (x1,y1)
     | _ -> raise Erreur


  let to_s  = function
     |Elt    a    -> M.to_s a 
     |Re    (a,b) -> sprintf "%s %s %s" (M.to_s a) R.s (M.to_s b)
     |Egal  (a,b) -> sprintf "%s = %s"  (M.to_s a)     (M.to_s b)

 open ParserTypeP4
  let from_s  s =
    let rec aux = function
       | M1 a                -> Elt  (M.from_s a) 
       | Inf (M1 a, M1 b)    -> Re   (M.from_s a,M.from_s b)
       | Eq  (M1 a, M1 b)    -> Egal (M.from_s a,M.from_s b)
     in
        sprintf "%s\n" s
    |>  Lexing.from_string
    |>  ParserP4.main LexerP4.token
    |>  aux

  let createElt          = function (Elt a, Elt b) -> Elt (M.createL (a,b)) 
  let createRe           = function (Elt a, Elt b) -> Re (a,b) 
  let createEgal         = function (Elt a, Elt b) -> Egal (a,b) 

  let p1   = function Elt a   -> Elt (M.p1 a)    (* p1 a*b = a *) 
  let p2   = function Elt a   -> Elt (M.p2 a)    (* p1 a*b = a *) 

  let sort = function
     |Elt    a    -> Elt  (M.sort a) 
     |Re    (a,b) -> Re   (M.sort a, M.sort b)
     |Egal  (a,b) -> Egal (M.sort a, M.sort b)

     (* subRe1((a*b)<=c,Re(a*b=b*a)) -> (b*a)<=c *)
  let subRe1 = function
    | (Re    (x1,y1),Egal (x2,y2)) when x1=x2 -> createRe    (Elt y2,Elt y1)
    | (Egal  (x1,y1),Egal (x2,y2)) when x1=x2 -> createEgal  (Elt y2,Elt y1)

  let subRe2 = function
    | (Re    (x1,y1),Egal (x2,y2)) when y1=x2 -> createRe    (Elt x1,Elt y2)
    | (Egal  (x1,y1),Egal (x2,y2)) when y1=x2 -> createEgal  (Elt x1,Elt y2)

end

(* Remarque au sujet du parser : 
   le Magma connait que la première loi 
   qui est représentée par un + dans les chaines
   par conséquent on doit utiliser le "+" et pas le '*'

   let e1=M.from_s "(E+F)<=((F+G)+(A+B))+(B+C)" in
   donne  ((E \star F) \le (((F \star G) \star (A \star B)) \star (B \star C)))

   let e1=M.from_s "E=((F+G)+(A+B))+(B+C)" in
   donne (E = (((F \star G) \star (A \star B)) \star (B \star C)))
*)



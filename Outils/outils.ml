open Printf

(* outils *)
(************************************************)
(*                                              *)
(************************************************)
let id  x = x
let cst x =fun _ -> x

(************************************************)
(* list_two_left                             *)
(************************************************)

(* 
  Comme list_fold_left mais avec comme ammorce a1

  let list_two_left f = function
    | []    -> None
    | x::tl -> Some (List.fold_left f x tl) 
    

  list_two_left comme opérateur sur une liste
  voir test_outils.ml pour les exemples.
  list_two_left f [a1;a2;a3;] = f(f(f a1 a2) a3)

  Cette fonction existe sous JaneStreet : reduce  
*)
  let list_two_left f l =
    let rec aux h = function
      | []       -> None 
      | x::[]    -> Some (h x)
      | x::tl    -> aux (f (h x)) tl
    in
    aux id l 

(************************************************)
(* ope                                          *)
(************************************************)
  let ope f g l =
        List.map g l
    |>  list_two_left f

(************************************************)
(* Dans le module Core.Std.Option               *)
(************************************************)
let value ~default = function
  | None   -> default
  | Some x -> x

  (************************************************)
(*Outils Gaux  evite de compiler avec gtk       *)
(************************************************)
let may f = function
    None   -> ()
  | Some o -> f o

let may_left f a = function
    None   -> a
  | Some o -> f a o

(************************************************)
(*ajoute un caractère apres chaque element sauf le dernier *)
(************************************************)
(*
# list_to_string_add_sep "," (sprintf "%d") [1;2;3];; 
- : string = "1,2,3"


Il existe aussi 
  String.concat "+" ["1"; "2"; "3"]
- : string = "1+2+3"

(* conversion du caractère en chaine *)
let s=String.make 1 c in

   Version sans la fonction ope 
let list_to_string_add_sep s f le = 
  let rec g s = function
      []     -> "" 
    | e::[]  -> f e 
    | e::tl  -> (f e)^s^(g s tl)
  in 
  g s le
*)

let list_to_string_add_sep s f le = 
     ope (fun a b -> sprintf "%s%s%s" a s b) f le
  |> value ~default:"" 

(************************************************)
(* enlève les blancs devant et derrière         *)
(************************************************)
(*
# blanc " 123  3456   ";;
- : string = "123  3456"
*)
let blanc buff =
 let rec f_blcDroite buff =
  if buff="" || buff=" " then ""
   else (
   let i_length=String.length buff in
   if buff.[i_length-1]=' ' then
    f_blcDroite (String.sub buff 0 (i_length-1))
   else buff
  )
 in
 let rec f_blcGauche buff =
  if buff="" || buff=" " then ""
  else (
   let i_length=String.length buff in
   if buff.[0]=' ' then
    f_blcGauche (String.sub buff 1 (i_length-1))
   else buff
  )
  in
  f_blcDroite (f_blcGauche buff )

(************************************************)
(* enlève les doublons                          *)
(************************************************)
let rec doublon l_x =
match l_x with
 | [] -> []
 | x::tl ->
    if List.exists ((=) x) tl then doublon tl else x::  doublon tl
(************************************************)
(*
# decoupe ',' "123,36786 ,  67 , 5 ";;
- : string list = ["123"; "36786 "; "  67 "; " 5 "]

# decoupe ' ' "123/36786 67/5  13/7 ";;
- : string list = ["123/36786"; "67/5"; ""; "13/7"; ""]
*)
let decoupe c_sep s =
  let rec decoupe s =
    try (
      let isep=String.rindex s c_sep in
      let ipos=isep+1 in
      let l=String.length s in
      let sr=String.sub s ipos (l-ipos) in
      let sb=String.sub s 0 isep in
      sr::decoupe sb
    ) with Not_found -> [s]
  in
  List.rev (decoupe s)

let rec enumFor iCpt iFin =
 if iCpt=iFin
   then [iFin]
 else if iCpt < iFin
   then iCpt::enumFor (iCpt+1) iFin
 else List.rev (enumFor iFin iCpt)

(************************************************)
(* Min d'une liste d'entier                      *)
(************************************************)

let minl li = 
  let rec aux m = function
    | []      -> m 
    | i::tl   -> aux (min m i) tl 
  in
  aux max_int li

let maxl li = 
  let rec aux m = function
    | []      -> m 
    | i::tl   -> aux (max m i) tl 
  in
  aux min_int li


(* v -> chaine de caractères (0,0,0,-1,0) *)
let p_v v =
     Array.to_list v
  |> list_to_string_add_sep "," (sprintf "%3d")

let p_v_delta v1 v2 =
  let l1=Array.to_list v1 in
  let l2=Array.to_list v2 in
  List.map2 (fun e1 e2 -> if e2==e1 then "   " else sprintf "%3d" e2) l1 l2
  |> list_to_string_add_sep "," (sprintf "%s")

(************************************************)
(*Projection canonique                          *)
(************************************************)
let pi_1=fst
let pi_2=snd
(************************************************)
(*                                              *)
(************************************************)

let proj1_sur_2 list1 =
 List.map pi_1 list1

let proj2_sur_2 list1 =
 List.map pi_2 list1

(************************************************)
(*Complete une liste avec des zeros             *)
(************************************************)

let complete size l =
  let rec aux i l = if i==0 then l else aux (i-1) l@[0] in
  aux (size-(List.length l)) l

(************************************************)
(*Donne le plus petit entier disponible         *)
(* A optimiser set                              *)
(************************************************)
let new_min l = 
  let rec aux v =
    if List.exists ((=) v) l then aux (v+1) else v
  in
  aux 0 

(************************************************)
(*Append recursivité terminale contrairement à @*)
(************************************************)
let append l1 l2 =
  let rec aux acc l1 l2 =
    match (l1,l2) with
    | ([],[])     -> List.rev acc    (* List.rev tail recursive *)
    | ([],h::tl)  -> aux (h :: acc) [] tl
    | (h::tl,l)   -> aux (h :: acc) tl l
  in
  aux [] l1 l2
(*
filteri (fun i _ -> i<2) [0;1;2;3;4];;
- : int list = [0; 1]
 *)
let filteri f l =
     List.fold_left (fun (l,i) e -> 
       if f i e then (e::l,i+1) else (l,i+1)
     ) ([],0) l
  |> pi_1
  |> List.rev 

(* 
# combine [1;2];;
- : (int * int) list = [(1, 1); (2, 2)]
*)
let dup_combine l = List.combine l l 
(* Cumule le nombre d'element de l' présent dans la liste l 
# nb_elt [1;2;3;4;2] [1;2];;
- : int = 3
*)
let nb_elt l l' =
  List.fold_left ( fun i e' ->
    List.fold_left ( fun i e -> 
      if e=e' then (i+1) else i 
    ) i l
  ) 0 l'

(* Donne le nombre d'element de l' présent dans la liste l 
# nb_exist [1;2;3;1;4;2;5] [1;2;4];;
- : int = 3
*)
let nb_exists l l' =
  List.fold_left ( fun i e' ->
          if (List.exists ((=)e') l) then i+1 else i
  ) 0 l'



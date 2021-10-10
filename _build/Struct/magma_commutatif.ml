(* Magma avec une loi commutative *)
open Printf

module Make (L : L.S) (E : E.S) = struct 
  include Magma.Make (L) (E)
  module M =Magma.Make (L) (E)

    (* du fait de la commutativite on peut trier b*a = a*b *)
    let rec sort = function
       | M.Elt a -> M.Elt a
       | M.L   (a,b) ->
          let a'=sort a and
              b'=sort b in
            if String.compare (M.to_s a') (M.to_s b') > 0
            then M.L (b',a') else M.L (a',b')

end


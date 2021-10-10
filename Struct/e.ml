(* signature d'un ensemble *)
module type S = sig
    type  t                     
    val from_s  : string-> t   
    val to_s    : t-> string  
    (*val sort    : t -> t*)
    val nom     : string
end

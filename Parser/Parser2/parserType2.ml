type exp = 
    V          of string
  | Inf        of exp*exp
  | Egal       of exp*exp
  | Loi1       of exp*exp
  | Loi2       of exp*exp
  | LoiUnaire1 of exp

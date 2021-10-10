type exp = 
    M1          of string
  | Inf        of exp*exp
  | Eq         of exp*exp

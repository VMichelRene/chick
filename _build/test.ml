open Printf
exception ErreurTrace
exception ErreurDemo

(* utilise un magma avec une loi commutative qui comporte une relation d'equivalence *) 
module M =Magma_commutatif_re_equiv.Make 
  (struct let s="\\le" end)     (* <= *)
  (struct let s="\\star" end)   (* * *)
  (Ens.E1)

(* Règle 1 a*b <= a *)
let r1 ab = M.createRe (ab,M.p1 ab)
(* Règle 2 a*b <= b *)
let r2 ab = M.createRe (ab,M.p2 ab)
(* Règle 3 x<=a et x<=b => x<=a*b *)
let r3 = function
   (M.Re (x1,a),M.Re (x2,b))  when x1=x2  -> M.createRe (M.Elt x1,M.createElt (M.Elt a,M.Elt b))

(********************************)
(* Trace des lois               *)
(********************************)
(* antisymetrie a<=b et b<=a => a=b *)
let antisymetrie n3 ((n1,i1),(n2,i2)) = 
  let i3=M.antisymetrie (i1,i2) in
  printf "$\underbrace{%s}_{%s} \land \underbrace{%s}_{%s} \Rightarrow $\overbrace{%s}^{%s}$ Règle antisymetrique\\\\\n" 
     (M.to_s  i1) n1 
     (M.to_s  i2) n2 
     (M.to_s  i3) n3
  ;
  (n3,i3)

(* loi R1 a*b<=a *)
let r1 n2 (n1,i1) = 
  let i2=r1 i1 in
  printf "$\overbrace{%s}^{%s}$ Règle 1\\\\ \n" (M.to_s i2) n2;
  (n2,i2)


(* loi R2 a*b<=b *)
let r2 n2 (n1,i1) = 
  let i2=r2 i1 in
  printf "$\overbrace{%s}^{%s}$ Règle 2\\\\ \n" (M.to_s i2) n2;
  (n2,i2)

(* loi R3 x<=a et x<=b => x<=a*b *)

let r3 n3 ((n1,i1),(n2,i2)) = 
  let i3=r3 (i1,i2) in
  printf "$\underbrace{%s}_{%s} \land \underbrace{%s}_{%s} \Rightarrow $\overbrace{%s}^{%s}$ Règle 3\\\\\n" 
     (M.to_s i1) n1 
     (M.to_s i2) n2 
     (M.to_s i3) n3
  ;
  (n3,i3)

(* Utilitaires              *)
let s_conv s     = M.to_s (M.from_s s)
let create n s   = (n,M.from_s s)
let ctrl (_,i) s = M.to_s i=   s_conv s

(****************************)
(* Point de la démo         *)
(****************************)
(* Point montrons que *)
let point_x niveau s_msg s=
    let s_niveau =
      let rec aux s i =
         if i=0 then s else aux (s^" \\bullet") (i-1)
      in
      aux "\\bullet " niveau
    in
    printf "\\begin{left}\n";
    printf "$%s$%s $%s$ \\\\ \n" s_niveau s_msg s;
    printf "\\end{left}\n"

let point_mq niveau s=
     s_conv s 
  |> point_x niveau "Montrons que" 

let point_sy niveau s=
     s_conv s 
  |> point_x niveau "Synthèse" 

let entete () =
  printf "\\begin{center}\n"

let pied () =
  printf "\\end{center}\n"

(****************************)
(* Commutativite            *)
(****************************)

let demo_commutativite () =
  printf "Démonstration guidée de la commutativité\n";
  printf "$\\mathbf{ %s }$ \\\\ \n" (s_conv "a+b = b+a");
  point_mq 0 "a+b <= b+a"; 
  entete (); 
  let i0=create "e0" "a+b" in
  let i1=r1 "e1" i0 in
  let i2=r2 "e2" i0 in
  let i3=r3 "e3" (i2,i1) in
  ctrl i3 "a+b <= b+a";   
  pied (); 

  point_mq 0 "b+a <= a+b"; 
  entete (); 
  let i4=create "e4" "b+a" in 
  let i5=r1 "e5" i4 in
  let i6=r2 "e6" i4 in
  let i7=r3 "e7" (i6,i5) in
  ctrl i7 "b+a <= a+b";   
  pied (); 

  point_sy 0 "a+b = b+a"; 
  entete (); 
  let i8=antisymetrie "e8" (i3,i7) in
  ctrl i8 "a+b = b+a";   
  pied (); 
  ()
(****************************)
(* Main                     *)
(****************************)
let _ =
  demo_commutativite () 

Require Import Bool.

(* 1. zadatak *)
(* a) *)
Goal forall (x y : bool),
  (x && negb y) || (negb x && negb y) || (negb x && y) = negb x || negb y.
Proof.
  destruct x,y; simpl; reflexivity.
Qed.

(* b) *)
Goal forall (x y z : bool),
  negb (negb x && y && z) && negb (x && y && negb z)
  && (x && negb y && z) = x && negb y && z.
Proof.
  destruct x,y,z; simpl; reflexivity.
Qed.



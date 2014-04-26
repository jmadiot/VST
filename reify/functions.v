Require Import types.
Require Import sep.
Require Import progs.list_dt.
Require Import MirrorShard.Expr MirrorShard.Env.
Require Import assert_lemmas. (* for nullval *)
Definition all_types_r := repr (listToRepr types.our_types EmptySet_type).

Section typed.

Variable user_types : list Expr.type.

Let all_types := all_types_r user_types.


Import SeparationLogic.
Import Coqlib.
Import field_mapsto.

(* NB when you add a new function you have to update some proofs in preproc.v,
   Which have "do n" statements where n = length of functions list *)

Definition tc_environ_signature :=
Expr.Sig all_types (cons tycontext_tv (cons environ_tv nil)) tvProp tc_environ.

Definition eq_val_signature :=
Expr.Sig all_types (cons val_tv (cons val_tv nil))
tvProp (@eq val).


Definition force_ptr_signature := 
Expr.Sig all_types (cons val_tv nil) val_tv
force_ptr.

Definition app_val_signature :=
Expr.Sig all_types (cons list_val_tv (cons list_val_tv nil))
list_val_tv (@app val).

Definition eval_id_signature :=
Expr.Sig all_types (cons ident_tv (cons environ_tv nil))
val_tv eval_id.

Definition and_signature :=
Expr.Sig all_types (cons tvProp (cons tvProp nil))
tvProp and.

Definition eq_list_val_signature :=
Expr.Sig all_types (cons list_val_tv (cons list_val_tv nil))
tvProp (@eq (list val)).

Definition align_signature :=
Expr.Sig all_types (Z_tv :: Z_tv :: nil) Z_tv align.

Definition cons_val_signature :=
Expr.Sig all_types (cons val_tv (cons list_val_tv nil))
list_val_tv (@cons val).

Definition make_environ_signature (rho:environ) :=
Expr.Sig all_types nil environ_tv rho.

Definition make_share_signature (sh : share) :=
Expr.Sig all_types nil share_tv sh.

Definition make_list_int_signature (li :list int) :=
Expr.Sig all_types nil list_int_tv li.

Definition make_int_signature i :=
Expr.Sig all_types nil int_tv i.

Definition make_val_signature v :=
Expr.Sig all_types nil val_tv v.

Definition int_sub_signature :=
Expr.Sig all_types (int_tv :: int_tv :: nil) int_tv Int.sub.

Definition Vint_signature :=
Expr.Sig all_types (int_tv :: nil) val_tv Vint.

Definition map_Vint_signature := 
Expr.Sig all_types (list_int_tv :: nil) list_val_tv (map Vint).

Definition typed_true_signature :=
Expr.Sig all_types (c_type_tv :: val_tv :: nil) tvProp typed_true.

Definition int_add_signature :=
Expr.Sig all_types (int_tv :: int_tv :: nil) int_tv Int.add.

Definition O_signature :=
Expr.Sig all_types nil nat_tv O.

Definition S_signature :=
Expr.Sig all_types (nat_tv :: nil) nat_tv S.

Definition Z_lt_signature :=
Expr.Sig all_types (Z_tv :: Z_tv :: nil) tvProp Z.lt.

Definition Z_le_signature :=
Expr.Sig all_types (Z_tv :: Z_tv :: nil) tvProp Z.le.

Definition Z_gt_signature :=
Expr.Sig all_types (Z_tv :: Z_tv :: nil) tvProp Z.gt.

Definition Z_ge_signature :=
Expr.Sig all_types (Z_tv :: Z_tv :: nil) tvProp Z.ge.

Definition Zpos_signature :=
Expr.Sig all_types (positive_tv :: nil) Z_tv Zpos.

Definition Zneg_signature :=
Expr.Sig all_types (positive_tv :: nil) Z_tv Zneg.

Definition Z0_signature :=
Expr.Sig all_types nil Z_tv Z0.

Definition xI_signature :=
Expr.Sig all_types (positive_tv :: nil) positive_tv xI.

Definition xO_signature :=
Expr.Sig all_types (positive_tv :: nil) positive_tv xO.

Definition xH_signature :=
Expr.Sig all_types nil positive_tv xH.

Definition int_lt_signature :=
Expr.Sig all_types (int_tv :: int_tv :: nil) bool_tv Int.lt.

Definition int_ltu_signature :=
Expr.Sig all_types (int_tv :: int_tv :: nil) bool_tv Int.ltu.

Definition int_mul_signature :=
Expr.Sig all_types (int_tv :: int_tv :: nil) int_tv Int.mul.

Definition int_neg_signature :=
Expr.Sig all_types (int_tv :: nil) int_tv Int.neg.

Definition Z_add_signature :=
Expr.Sig all_types (Z_tv :: Z_tv :: nil) Z_tv Z.add.

Definition Z_sub_signature :=
Expr.Sig all_types (Z_tv :: Z_tv :: nil) Z_tv Z.sub.

Definition Z_mul_signature :=
Expr.Sig all_types (Z_tv :: Z_tv :: nil) Z_tv Z.mul.

Definition Z_div_signature :=
Expr.Sig all_types (Z_tv :: Z_tv :: nil) Z_tv Z.div.

Definition Z_mod_signature :=
Expr.Sig all_types (Z_tv :: Z_tv :: nil) Z_tv Zmod.

Definition Z_max_signature :=
Expr.Sig all_types (Z_tv :: Z_tv :: nil) Z_tv Z.max.

Definition Z_opp_signature :=
Expr.Sig all_types (Z_tv :: nil) Z_tv Z.opp.

Definition Ceq_signature :=
Expr.Sig all_types nil comparison_tv Ceq.

Definition Cne_signature :=
Expr.Sig all_types nil comparison_tv Cne.

Definition Clt_signature :=
Expr.Sig all_types nil comparison_tv Clt.

Definition Cle_signature :=
Expr.Sig all_types nil comparison_tv Cle.

Definition Cgt_signature :=
Expr.Sig all_types nil comparison_tv Cgt.

Definition Cge_signature :=
Expr.Sig all_types nil comparison_tv Cge.

Definition int_cmp_signature :=
Expr.Sig all_types (comparison_tv :: int_tv :: int_tv :: nil) bool_tv Int.cmp.

Definition int_cmpu_signature :=
Expr.Sig all_types (comparison_tv :: int_tv :: int_tv :: nil) bool_tv Int.cmpu.

Definition int_repr_signature :=
Expr.Sig all_types (Z_tv :: nil) int_tv Int.repr.

Definition int_signed_signature :=
Expr.Sig all_types (int_tv :: nil) Z_tv Int.signed.

Definition int_unsigned_signature :=
Expr.Sig all_types (int_tv :: nil) Z_tv Int.unsigned.

Definition two_power_nat_signature :=
Expr.Sig all_types (nat_tv :: nil) Z_tv two_power_nat.

Definition int_max_unsigned_signature :=
Expr.Sig all_types nil Z_tv Int.max_unsigned.

Definition True_signature :=
Expr.Sig all_types nil tvProp True.

Definition False_signature :=
Expr.Sig all_types nil tvProp False.

Definition denote_tc_assert_b_signature :=
Expr.Sig all_types (tc_assert_tv :: environ_tv :: nil) bool_tv denote_tc_assert_b.

Definition nullval_signature :=
Expr.Sig all_types nil val_tv assert_lemmas.nullval.

Require Import lseg_lemmas.

Definition tptr_signature :=
Expr.Sig all_types (c_type_tv :: nil) c_type_tv Clightdefs.tptr.

Definition nil_val_signature :=
Expr.Sig all_types nil list_val_tv (@nil val).

(* these depend on sample_ls. hopefully we can eventually do away with these *)
Require Import progs.reverse.
Definition reverse_t_struct_list_signature :=
Expr.Sig all_types nil c_type_tv reverse.t_struct_list.

Definition reverse__tail_signature :=
Expr.Sig all_types nil ident_tv reverse._tail.

(* This way we don't have to deal with tons of close-parens at the end 
 * Important, since functions is a long list. *)
Import ListNotations.

Definition computable_functions :=
[ two_power_nat_signature 
; O_signature
; force_ptr_signature
; app_val_signature
; int_max_unsigned_signature 
; and_signature
; align_signature
; cons_val_signature 
; int_sub_signature 
; Vint_signature 
; map_Vint_signature 
; typed_true_signature 
; int_add_signature
; S_signature
; Z_lt_signature
; Z_le_signature
; Z_gt_signature
; Z_ge_signature
; Zpos_signature
; Zneg_signature
; Z0_signature
; xI_signature
; xO_signature
; xH_signature
; int_lt_signature
; int_ltu_signature
; int_mul_signature
; int_neg_signature
; Z_add_signature
; Z_sub_signature
; Z_mul_signature
; Z_div_signature
; Z_mod_signature
; Z_max_signature
; Z_opp_signature
; Ceq_signature
; Cne_signature
; Clt_signature
; Cle_signature
; Cgt_signature
; Cge_signature
; int_cmp_signature
; int_cmpu_signature
; int_repr_signature
; int_signed_signature
; int_unsigned_signature
; nullval_signature
; tptr_signature
; nil_val_signature
; reverse_t_struct_list_signature
; reverse__tail_signature
].

Definition non_computable_functions :=
[ tc_environ_signature
; eval_id_signature
; True_signature
; False_signature
].

Definition our_functions := 
computable_functions ++ non_computable_functions.


Definition computable_prefix_length := length computable_functions.

(* By convention denote_tc_assert_b MUST be at index zero,
   because do_computation will always look there for it. *)
(* Or not? I forget why we're not doing that anymore *)

(* Definition denote_tc_assert_b_f := 0%nat. *)
Definition two_power_nat_f := 0%nat.
Definition O_f := S (two_power_nat_f).
Definition force_ptr_f := S (O_f).
Definition app_val_f := S (force_ptr_f).
Definition int_max_unsigned_f := S (app_val_f).
Definition and_f := S (int_max_unsigned_f).
Definition align_f := S (and_f).
Definition cons_val_f := S (align_f).
Definition int_sub_f := S (cons_val_f).
Definition vint_f := S (int_sub_f).
Definition map_Vint_f := S (vint_f).
Definition typed_true_f := S (map_Vint_f).
Definition int_add_f := S (typed_true_f).
Definition S_f := S (int_add_f).
Definition Z_lt_f := S (S_f).
Definition Z_le_f := S (Z_lt_f).
Definition Z_gt_f := S (Z_le_f).
Definition Z_ge_f := S (Z_gt_f).
Definition Zpos_f := S (Z_ge_f).
Definition Zneg_f := S (Zpos_f).
Definition Z0_f := S (Zneg_f).
Definition xI_f := S (Z0_f).
Definition xO_f := S (xI_f).
Definition xH_f := S (xO_f).
Definition int_lt_f := S (xH_f).
Definition int_ltu_f := S (int_lt_f).
Definition int_mul_f := S (int_ltu_f).
Definition int_neg_f := S (int_mul_f).
Definition Z_add_f := S (int_neg_f).
Definition Z_sub_f := S (Z_add_f).
Definition Z_mul_f := S (Z_sub_f).
Definition Z_div_f := S (Z_mul_f).
Definition Z_mod_f := S (Z_div_f).
Definition Z_max_f := S (Z_mod_f).
Definition Z_opp_f := S (Z_max_f).
Definition Ceq_f := S (Z_opp_f).
Definition Cne_f := S (Ceq_f).
Definition Clt_f := S (Cne_f).
Definition Cle_f := S (Clt_f).
Definition Cgt_f := S (Cle_f).
Definition Cge_f := S (Cgt_f).
Definition int_cmp_f := S (Cge_f).
Definition int_cmpu_f := S (int_cmp_f).
Definition int_repr_f := S (int_cmpu_f).
Definition int_signed_f := S (int_repr_f).
Definition int_unsigned_f := S (int_signed_f).
Definition nullval_f := S (int_unsigned_f).
Definition tptr_f := S (nullval_f).
Definition nil_val_f := S (tptr_f).
(* for sample_ls *)
Definition reverse_t_struct_list_f := S (nil_val_f).
Definition reverse__tail_f := S (reverse_t_struct_list_f).


(* Past this point are functions that should not compute into Consts *)
Definition tc_environ_f := length computable_functions.
Definition eval_id_f := S (tc_environ_f).
Definition True_f := S (eval_id_f).
Definition False_f := S (True_f).


(*Separation Logic predicates *)
Definition field_at_psig :=
Sep.PSig all_types (share_tv :: c_type_tv :: ident_tv :: val_tv :: val_tv :: nil)
field_at.

(* The following SL predicates are partially applied to avoid dependency
   Someday there should maybe be an automated way of instantiating them. *)
(* From verif_reverse.v; a sample list specification for testing *)
Require Import progs.reverse.
Instance sample_ls: listspec t_struct_list _tail.
Proof. eapply mk_listspec; reflexivity. Defined.

(* list (elemtype sample_ls) = list val *)
(* We have to hnf on our partially-applied functions; otherwise, they will
   get hnf'd during reificaiton and mirror-shard will fail to match them *)
Definition lseg_sample_ls_psig : Sep.predicate all_types.
refine
(Sep.PSig all_types (share_tv :: list_val_tv :: val_tv :: val_tv :: nil) _).
simpl.
let sls := eval hnf in sample_ls in
apply (lseg sls).
Defined.

(*Definition lseg_sample_ls_psig :=
Sep.PSig all_types (share_tv :: list_val_tv :: val_tv :: val_tv :: nil)
(lseg sample_ls).

Check lseg_sample_ls_psig.*)

(* reptype_structlist (all_but_link sample_ls list_fields) = val *)
(*Definition list_cell_sample_ls_psig :=
Sep.PSig all_types (share_tv :: val_tv :: val_tv :: nil)
(list_cell sample_ls).*)

Definition list_cell_sample_ls_psig : Sep.predicate all_types.
refine
(Sep.PSig all_types (share_tv :: val_tv :: val_tv :: nil) _).
simpl.
let sls := eval hnf in sample_ls in
apply (list_cell sls).
Defined.

(* we're going on the assumption that peq will compute down to val *)
(*
Eval compute in (malloc_lemmas.reptype_structlist
                (all_but_link sample_ls list_fields)).

Definition sample_lseg_psig :=
Sep.PSig all_types (share_tv :: list_val_tv :: val_tv :: val_tv :: nil)
(lseg sample_ls).
*)
(* need to add instantiations of listspec _ _ and list (elemtype _)
   give listspec as argument   *)

(*Junk for testing*)
Parameter P : nat -> mpred.
Parameter Q : nat -> mpred.

Definition sep_predicates : list (Sep.predicate all_types) :=
field_at_psig  ::
lseg_sample_ls_psig ::
list_cell_sample_ls_psig 
     :: Sep.PSig all_types (tvType 11 :: nil)  P  
        :: Sep.PSig all_types (tvType 11 :: nil) Q :: nil.
 
(*End junk, go back to following when tests are done*)
(*Definition sep_predicates : list (Sep.predicate all_types) := field_at_f :: nil.*)

Definition field_at_p := 0%nat.
Definition lseg_sample_ls_p := 1%nat.
Definition list_cell_sample_ls_p := 2%nat.

End typed.

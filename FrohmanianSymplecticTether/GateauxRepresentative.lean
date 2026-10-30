/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license.
Author: Benjamin Stanley Frohman.

# Gâteaux representatives on the `ℝ³` model: refutation of pointwise uniqueness and the
# regular-representative derivative

`IsGateauxRepresentative F ω d` tests `d` only through the integrals `∫ ⟨d, ε⟩` over
divergence-free directions `ε`. Changing `d` on a Lebesgue-null set leaves every such integral
unchanged, so a representative is never pointwise unique:

* `isGateauxRepresentative_add_null` : adding a field that vanishes a.e. keeps a representative;
* `not_gateauxRepresentativeUnique` : `IsGateauxRepresentative F ω dH → ¬ GateauxRepresentativeUnique F ω dH`;
* `not_streamFunctionRepresentative` : `StreamFunctionRepresentative ω` is false for every `ω`;
* `isGateauxRepresentative_of_not_differentiable` : if `ω` is not differentiable everywhere,
  every field is a representative of every functional.

The correct uniqueness statement is among regular representatives (`RegularRep`: continuous,
differentiable, divergence-free, square-integrable); two of these are equal
(`regularRep_unique`, from `gateaux_representative_unique`). `RegularFunctionalDerivative` is the
choice among regular representatives, `KineticEnergyCurlIdentityReg` the curl identity for it,
and `kineticEnergyCurlIdentityReg_of_regularStream` proves it from the single named `Prop`
`RegularStreamRepresentative` (existence on `ℝ³` of a regular Biot–Savart stream function that
represents the kinetic energy and has `curl ψ = u`).
-/
module

public import FrohmanianSymplecticTether.VelocityTether
public import Mathlib.MeasureTheory.Function.L2Space

@[expose] public section

namespace FrohmanianTether

open MeasureTheory ArnoldGeometric NavierStokes3D

/-- A field supported at the origin (nonzero there). -/
noncomputable def originBump : T3 → EuclideanSpace ℝ (Fin 3) :=
  Set.indicator {0} (fun _ => EuclideanSpace.single 0 1)

theorem originBump_ae_zero : originBump =ᵐ[NavierStokes3D.volume] 0 := by
  have hnull : NavierStokes3D.volume ({0} : Set T3) = 0 := by
    show MeasureTheory.volume ({0} : Set T3) = 0
    exact measure_singleton 0
  rw [Filter.EventuallyEq, ae_iff]
  refine measure_mono_null (fun x hx => ?_) hnull
  by_contra h
  apply hx
  simp [originBump, Set.indicator_of_notMem h]

theorem originBump_ne_zero : originBump ≠ 0 := by
  intro h
  have := congrFun h 0
  simp [originBump] at this

/-- Adding an a.e.-zero field to a Gâteaux representative gives a Gâteaux representative. -/
theorem isGateauxRepresentative_add_null {F : CoadjointOrbit → ℝ} {ω : CoadjointOrbit}
    {dH g : T3 → EuclideanSpace ℝ (Fin 3)} (h : IsGateauxRepresentative F ω dH)
    (hg : g =ᵐ[NavierStokes3D.volume] 0) :
    IsGateauxRepresentative F ω (fun x => dH x + g x) := by
  unfold IsGateauxRepresentative at h ⊢
  intro ε hω hε
  have hint : (∫ x, pairing (dH x + g x) (ε.val x) ∂NavierStokes3D.volume) =
      ∫ x, pairing (dH x) (ε.val x) ∂NavierStokes3D.volume := by
    apply integral_congr_ae
    filter_upwards [hg] with x hx
    simp [hx]
  have := h ε hω hε
  rw [hint]; exact this

/-- **Refutation.** Whenever `dH` is a Gâteaux representative, it is not the only one. -/
theorem not_gateauxRepresentativeUnique {F : CoadjointOrbit → ℝ} {ω : CoadjointOrbit}
    {dH : T3 → EuclideanSpace ℝ (Fin 3)} (h : IsGateauxRepresentative F ω dH) :
    ¬ GateauxRepresentativeUnique F ω dH := by
  intro hu
  have heq := hu _ (isGateauxRepresentative_add_null h originBump_ae_zero)
  apply originBump_ne_zero
  funext x
  have := congrFun heq x
  simpa using this

/-- **Refutation.** `StreamFunctionRepresentative ω` is false for every `ω`. -/
theorem not_streamFunctionRepresentative (ω : CoadjointOrbit) :
    ¬ StreamFunctionRepresentative ω := by
  rintro ⟨ψ, hrep, huniq, -⟩
  exact not_gateauxRepresentativeUnique hrep huniq

/-- If `ω` is not differentiable at every point, `IsGateauxRepresentative F ω d` holds for every
`F` and `d` (its quantifier over differentiability witnesses is empty). -/
theorem isGateauxRepresentative_of_not_differentiable {F : CoadjointOrbit → ℝ}
    {ω : CoadjointOrbit} (hω : ¬ ∀ i x, DifferentiableAt ℝ (fun y => ω.val y i) x)
    (d : T3 → EuclideanSpace ℝ (Fin 3)) : IsGateauxRepresentative F ω d :=
  fun _ hω' _ => absurd hω' hω

/-! ## Regular representatives -/

/-- Regular field: continuous, coordinatewise differentiable, divergence-free, `L²`. -/
structure RegularField (d : T3 → EuclideanSpace ℝ (Fin 3)) : Prop where
  cont : Continuous d
  diff : ∀ i x, DifferentiableAt ℝ (fun y => d y i) x
  div_free : ∀ x, NavierStokes3D.div d x = 0
  memL2 : MemLp d 2 NavierStokes3D.volume

/-- `d` is a regular Gâteaux representative of `F` at `ω`. -/
def RegularRep (F : CoadjointOrbit → ℝ) (ω : CoadjointOrbit)
    (d : T3 → EuclideanSpace ℝ (Fin 3)) : Prop :=
  IsGateauxRepresentative F ω d ∧ RegularField d

theorem regularField_sub {d d' : T3 → EuclideanSpace ℝ (Fin 3)}
    (h : RegularField d) (h' : RegularField d') : RegularField (fun x => d x - d' x) where
  cont := h.cont.sub h'.cont
  diff := fun i x => by
    have := (h.diff i x).sub (h'.diff i x)
    simpa using this
  div_free := fun x => by
    have := div_add_smul d d' (-1) x (fun i => h.diff i x) (fun i => h'.diff i x)
    simp only [neg_one_smul, ← sub_eq_add_neg, h.div_free x, h'.div_free x] at this
    simpa using this
  memL2 := h.memL2.sub h'.memL2

theorem pairing_integrable {f g : T3 → EuclideanSpace ℝ (Fin 3)}
    (hf : MemLp f 2 NavierStokes3D.volume) (hg : MemLp g 2 NavierStokes3D.volume) :
    Integrable (fun x => pairing (f x) (g x)) NavierStokes3D.volume := by
  refine (MeasureTheory.L2.integrable_inner (𝕜 := ℝ) (hf.toLp f) (hg.toLp g)).congr ?_
  filter_upwards [MemLp.coeFn_toLp hf, MemLp.coeFn_toLp hg] with x h1 h2
  simp only [pairing, h1, h2]

/-- **Uniqueness among regular representatives** (on differentiable `ω`). -/
theorem regularRep_unique {F : CoadjointOrbit → ℝ} {ω : CoadjointOrbit}
    (hω : ∀ i x, DifferentiableAt ℝ (fun y => ω.val y i) x)
    {d d' : T3 → EuclideanSpace ℝ (Fin 3)} (h : RegularRep F ω d) (h' : RegularRep F ω d') :
    d = d' := by
  have hw := regularField_sub h.2 h'.2
  refine gateaux_representative_unique d d' h.1 h'.1 hω hw.diff hw.div_free ?_ hw.cont ?_ ?_
  · simpa using hw.memL2.integrable_norm_pow (by norm_num)
  · exact pairing_integrable h.2.memL2 hw.memL2
  · exact pairing_integrable h'.2.memL2 hw.memL2

open Classical in
/-- Functional derivative by choice among regular representatives, else `0`. -/
noncomputable def RegularFunctionalDerivative (F : CoadjointOrbit → ℝ) (ω : CoadjointOrbit) :
    T3 → EuclideanSpace ℝ (Fin 3) :=
  if h : ∃ d, RegularRep F ω d then Classical.choose h else 0

theorem regularFunctionalDerivative_eq {F : CoadjointOrbit → ℝ} {ω : CoadjointOrbit}
    (hω : ∀ i x, DifferentiableAt ℝ (fun y => ω.val y i) x)
    {d : T3 → EuclideanSpace ℝ (Fin 3)} (h : RegularRep F ω d) :
    RegularFunctionalDerivative F ω = d := by
  have hex : ∃ d, RegularRep F ω d := ⟨d, h⟩
  rw [RegularFunctionalDerivative, dif_pos hex]
  exact regularRep_unique hω (Classical.choose_spec hex) h

/-- Curl identity `curl(dH/dω) = u` for the regular-representative derivative. -/
def KineticEnergyCurlIdentityReg (ω : CoadjointOrbit) : Prop :=
  curl (RegularFunctionalDerivative KineticEnergyHamiltonian ω) = velocity_from_vorticity ω

/-- Analytic input on `ℝ³`: a regular Gâteaux representative `ψ` of the kinetic energy at `ω`
with `curl ψ = u`, where `u = BiotSavart ω`. -/
def RegularStreamRepresentative (ω : CoadjointOrbit) : Prop :=
  ∃ ψ, RegularRep KineticEnergyHamiltonian ω ψ ∧ curl ψ = velocity_from_vorticity ω

theorem kineticEnergyCurlIdentityReg_of_regularStream (ω : CoadjointOrbit)
    (hω : ∀ i x, DifferentiableAt ℝ (fun y => ω.val y i) x)
    (h : RegularStreamRepresentative ω) : KineticEnergyCurlIdentityReg ω := by
  obtain ⟨ψ, hrep, hcurl⟩ := h
  unfold KineticEnergyCurlIdentityReg
  rw [regularFunctionalDerivative_eq hω hrep]
  exact hcurl

end FrohmanianTether

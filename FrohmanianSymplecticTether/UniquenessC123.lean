/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/

module

public import FrohmanianSymplecticTether.Uniqueness

/-!
# C1–C3 alone do not determine the tether kernel; two-sided feedback does

* `scaled_tether_admissible`: for `c ≥ 1`, `c · TetherKernel` is symmetric and satisfies C1, C3,
  and C2 whenever `TetherKernel` does.
* `c1_c3_not_unique`: if `TetherKernel` satisfies C2 and is nonzero somewhere on the diagonal,
  then `2 · TetherKernel` is a symmetric C1–C3 correction different from `TetherKernel`.
  So uniqueness needs an extra condition.
* `uniqueness_of_two_sided_feedback`: replace saturation by the minimality bound
  `B ω F F ≥ -κ ∫ |ω|² ‖Π_u δF‖²`. Together with C3 this forces the diagonal of `B`, and
  polarization gives `B = TetherKernel`.
-/

open MeasureTheory ForMathlib ArnoldGeometric

namespace FrohmanianTether

variable {kappa : ℝ}

/-- `c · TetherKernel` with `c ≥ 1` is symmetric, C1, C3, and C2 when `TetherKernel` is. -/
public theorem scaled_tether_admissible (hκ : 0 < kappa) (c : ℝ) (hc : 1 ≤ c)
    (hC2T : DegenerateWRTKineticEnergy (TetherKernel kappa)) :
    let B := fun ω F G => c * TetherKernel kappa ω F G
    (∀ ω F G, B ω F G = B ω G F) ∧ InvariantUnderCoadjointAction B ∧
      DegenerateWRTKineticEnergy B ∧ ProducesControllableNegativeFeedback kappa B := by
  refine ⟨fun ω F G => by show c * _ = c * _; rw [tetherKernel_comm], fun g F G ω => by
    simp only [tetherKernel_C1 g F G ω], fun F ω => by simp only [hC2T F ω, mul_zero],
    fun F ω => ?_⟩
  show c * _ ≤ _
  rw [tetherKernel_quadratic_form]
  have hI : 0 ≤ ∫ x, ‖ω.val x‖ ^ 2 *
      ‖Pi_u (velocity_from_vorticity ω) (FunctionalDerivative F ω) x‖ ^ 2 ∂NavierStokes3D.volume :=
    integral_nonneg fun _ => mul_nonneg (sq_nonneg _) (sq_nonneg _)
  generalize (∫ x, ‖ω.val x‖ ^ 2 *
      ‖Pi_u (velocity_from_vorticity ω) (FunctionalDerivative F ω) x‖ ^ 2 ∂NavierStokes3D.volume) = I at hI ⊢
  have : 0 ≤ (c - 1) * (kappa * I) := mul_nonneg (by linarith) (mul_nonneg hκ.le hI)
  nlinarith

/-- C1–C3 and symmetry do not single out `TetherKernel`. -/
public theorem c1_c3_not_unique (hκ : 0 < kappa)
    (hC2T : DegenerateWRTKineticEnergy (TetherKernel kappa))
    (hne : ∃ ω F, TetherKernel kappa ω F F ≠ 0) :
    ∃ B : CoadjointOrbit → Functional → Functional → ℝ,
      (∀ ω F G, B ω F G = B ω G F) ∧ InvariantUnderCoadjointAction B ∧
      DegenerateWRTKineticEnergy B ∧ ProducesControllableNegativeFeedback kappa B ∧
      ∃ ω F G, B ω F G ≠ TetherKernel kappa ω F G := by
  obtain ⟨h1, h2, h3, h4⟩ := scaled_tether_admissible hκ 2 (by norm_num) hC2T
  obtain ⟨ω, F, hF⟩ := hne
  refine ⟨_, h1, h2, h3, h4, ω, F, F, ?_⟩
  intro h
  apply hF
  linarith

/-- Minimality: `B` dissipates no more than C3 requires. -/
public def FeedbackAtMost (kappa : ℝ) (B : CoadjointOrbit → Functional → Functional → ℝ) : Prop :=
  ∀ (F : Functional) (ω : CoadjointOrbit),
    -kappa * ∫ x, ‖ω.val x‖ ^ 2 *
        ‖Pi_u (velocity_from_vorticity ω) (FunctionalDerivative F ω) x‖ ^ 2 ∂NavierStokes3D.volume ≤ B ω F F

/-- C3 plus the minimality bound determine the quadratic form. -/
public theorem saturates_of_two_sided_feedback
    (B : CoadjointOrbit → Functional → Functional → ℝ)
    (hC3 : ProducesControllableNegativeFeedback kappa B) (hmin : FeedbackAtMost kappa B) :
    SaturatesTetherQuadratic kappa B := by
  intro F ω
  rw [tetherKernel_quadratic_form]
  exact le_antisymm (hC3 F ω) (hmin F ω)

/-- Uniqueness from C3, minimality and polarization, without assuming saturation. -/
public theorem uniqueness_of_two_sided_feedback
    (B : CoadjointOrbit → Functional → Functional → ℝ)
    (hC3 : ProducesControllableNegativeFeedback kappa B) (hmin : FeedbackAtMost kappa B)
    (h_polarB : Polarizes B) (h_polarT : Polarizes (TetherKernel kappa)) :
    ∀ ω F G, B ω F G = TetherKernel kappa ω F G := by
  intro ω F G
  have hs := saturates_of_two_sided_feedback B hC3 hmin
  have hB := h_polarB ω F G
  have hT := h_polarT ω F G
  have := hs F ω; have := hs G ω; have := hs (fun ω' => F ω' + G ω') ω
  linarith

/-- `TetherKernel` meets the minimality bound, so the class is nonempty. -/
public theorem tetherKernel_feedbackAtMost : FeedbackAtMost kappa (TetherKernel kappa) :=
  fun F ω => le_of_eq (tetherKernel_quadratic_form F ω).symm

end FrohmanianTether

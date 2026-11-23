/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/

import FrohmanianSymplecticTether.AnalyticPipeline

/-!
# Truth Gate: semantics lock (see `TRUTH_GATE.md`)

PAPER_PATH: paper/Frohmanian_Symplectic_Tether_Uniqueness_and_Global_Regularity_2026.tex
PAPER_SECTION: Section 1 "Introduction and Single-Sentence Final Product Form", Theorem "Master Product Theorem", conjuncts (P1) (polarization from diagonal agreement) and (P4)
PAPER_SHA256: 8f8df2e9e58ff7cce36eaf1876e44c2fb0fa8a3634d35a2847eece6400a6732f

Locked paper claims, quoted verbatim:

PAPER_QUOTE_BEGIN
\textbf{(P$_1$, polarization from diagonal agreement)} Let $B$ and $T$ be maps sending a pair of functionals, at each $\omega$, to a real number, and suppose the space of functionals is closed under addition. If $B$ agrees with $T$ on the diagonal --- $B(\omega,F,F)=T(\omega,F,F)$ for every $\omega$ and $F$ --- and both $B$ and $T$ satisfy the polarization identity $2B(\omega,F,G)=B(\omega,F+G,F+G)-B(\omega,F,F)-B(\omega,G,G)$ (and likewise for $T$), then $B(\omega,F,G)=T(\omega,F,G)$ for every $\omega,F,G$.
PAPER_QUOTE_END

PAPER_QUOTE_BEGIN
\textbf{(P$_4$, \texttt{P4\_UnconditionalLyapunovCeiling})} For $C,\kappa''>0$, every $y:\mathbb{R}\to\mathbb{R}$ differentiable at every $s\ge0$ with $y'(s)\le Cy(s)^2-\kappa''y(s)^3$ for $s\ge0$ satisfies $y(t)\le\max(y(0),C/\kappa'')$ for all $t\ge0$. This is a scalar comparison fact; that the vorticity of a Navier--Stokes flow obeys this inequality is not proved.
PAPER_QUOTE_END

Reading of the paper's terms (fixed here, once):
* "maps sending a pair of functionals, at each `ω`, to a real number" is a function
  `B : Ω → F → F → ℝ` (and likewise `T`); "the space of functionals is closed under
  addition" is a Mathlib `Add F` instance, and `F+G` is `f + g`;
* "agrees on the diagonal" is `B ω f f = T ω f f` for all `ω, f`;
* the polarization identity is `2 * B ω f g = B ω (f + g) (f + g) - B ω f f - B ω g g`;
* `y'(s)` is `deriv y s` (meaningful because `y` is differentiable at `s`);
  "for $C,\kappa''>0$" is the joint hypothesis `0 < C ∧ 0 < κ''`.

`formal_claim` is the conjunction of `TruthGate.polarization_from_diagonal_agreement`
(the identity in (P1), for any additive space of functionals) and
`AnalyticPipeline.comparison_ode_stability` (P4). When `T` is `TetherKernel κ`,
the same identity is `FrohmanianTether.uniqueness_of_tether_by_polarization`.

Scope: this does not certify uniqueness from C1–C3 (those hypotheses are unused in
the uniqueness theorems and may describe an empty class). It does not independently
transcribe (P2), (P3), `uniqueness_of_kernel_density`, or `step2_degree_of_ne_zero`.
It does not prove that the vorticity of a Navier–Stokes flow obeys the (P4)
inequality, does not prove global regularity, and makes no Clay Millennium claim.
-/

namespace TruthGate

-- TRUTH-GATE LOCK BEGIN
/-- Polarization from diagonal agreement, for any types `Ω` of base points and `F` of
functionals with addition: if `B` and `T` agree on the diagonal and both polarize,
then `B = T` off the diagonal. -/
theorem polarization_from_diagonal_agreement
    (Ω F : Type) [Add F] (B T : Ω → F → F → ℝ)
    (hdiag : ∀ ω f, B ω f f = T ω f f)
    (hB : ∀ ω f g, 2 * B ω f g = B ω (f + g) (f + g) - B ω f f - B ω g g)
    (hT : ∀ ω f g, 2 * T ω f g = T ω (f + g) (f + g) - T ω f f - T ω g g) :
    ∀ ω f g, B ω f g = T ω f g := by
  intro ω f g
  have hBf := hB ω f g
  have hTf := hT ω f g
  have hff := hdiag ω f
  have hgg := hdiag ω g
  have hfg := hdiag ω (f + g)
  linarith

/-- The repository's statements: `polarization_from_diagonal_agreement` and
`AnalyticPipeline.comparison_ode_stability`. -/
def formal_claim : Prop :=
  (∀ (Ω F : Type) [Add F] (B T : Ω → F → F → ℝ),
    (∀ ω f, B ω f f = T ω f f) →
    (∀ ω f g, 2 * B ω f g = B ω (f + g) (f + g) - B ω f f - B ω g g) →
    (∀ ω f g, 2 * T ω f g = T ω (f + g) (f + g) - T ω f f - T ω g g) →
    ∀ ω f g, B ω f g = T ω f g) ∧
  (∀ (C κ'' : ℝ), 0 < C → 0 < κ'' → ∀ (y : ℝ → ℝ),
    (∀ s ≥ (0 : ℝ), DifferentiableAt ℝ y s) →
    (∀ s ≥ (0 : ℝ), deriv y s ≤ C * (y s) ^ 2 - κ'' * (y s) ^ 3) →
    ∀ (t : ℝ), 0 ≤ t → y t ≤ max (y 0) (C / κ''))

/-- Paper (P1): polarization from diagonal agreement, with the three identities
packaged as a single hypothesis; and paper (P4), with `0 < C ∧ 0 < κ''`. -/
def paper_claim : Prop :=
  (∀ (Ω F : Type) [Add F] (B T : Ω → F → F → ℝ),
    ((∀ ω f, B ω f f = T ω f f) ∧
      (∀ ω f g, 2 * B ω f g = B ω (f + g) (f + g) - B ω f f - B ω g g) ∧
      (∀ ω f g, 2 * T ω f g = T ω (f + g) (f + g) - T ω f f - T ω g g)) →
    ∀ ω f g, B ω f g = T ω f g) ∧
  (∀ C κ'' : ℝ, 0 < C ∧ 0 < κ'' →
    ∀ y : ℝ → ℝ,
      (∀ s : ℝ, 0 ≤ s → DifferentiableAt ℝ y s ∧
        deriv y s ≤ C * y s ^ 2 - κ'' * y s ^ 3) →
      ∀ t : ℝ, 0 ≤ t → y t ≤ max (y 0) (C / κ''))

/-- The fixed correspondence between the formal statement and the paper's claim. -/
theorem intended_correspondence : formal_claim ↔ paper_claim := by
  constructor
  · rintro ⟨hP1, hP4⟩
    refine ⟨?_, ?_⟩
    · intro Ω F _ B T h
      exact hP1 Ω F B T h.1 h.2.1 h.2.2
    · intro C κ'' hCκ y hy t ht
      exact hP4 C κ'' hCκ.1 hCκ.2 y (fun s hs => (hy s hs).1) (fun s hs => (hy s hs).2) t ht
  · rintro ⟨hP1, hP4⟩
    refine ⟨?_, ?_⟩
    · intro Ω F _ B T hdiag hB hT
      exact hP1 Ω F B T ⟨hdiag, hB, hT⟩
    · intro C κ'' hC hκ y hdiff hdot t ht
      exact hP4 C κ'' ⟨hC, hκ⟩ y (fun s hs => ⟨hdiff s hs, hdot s hs⟩) t ht
-- TRUTH-GATE LOCK END

/-- The two main theorems prove `formal_claim`. -/
theorem formal_claim_holds : formal_claim :=
  ⟨fun Ω F _ B T => polarization_from_diagonal_agreement Ω F B T,
    fun C κ'' hC hκ y hdiff hdot t ht =>
      AnalyticPipeline.comparison_ode_stability C κ'' hC hκ y hdiff hdot t ht⟩

/-- The paper's claim, transported across the correspondence. -/
theorem paper_claim_holds : paper_claim :=
  intended_correspondence.mp formal_claim_holds

end TruthGate

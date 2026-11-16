/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/

import FrohmanianSymplecticTether.AnalyticPipeline

/-!
# Truth Gate: semantics lock (see `TRUTH_GATE.md`)

PAPER_PATH: paper/Frohmanian_Symplectic_Tether_Uniqueness_and_Global_Regularity_2026.tex
PAPER_SECTION: Section 1 "Introduction and Single-Sentence Final Product Form", Theorem "Master Product Theorem", conjunct (P4)
PAPER_SHA256: 437fff4d53f1377c16ee25ac42cc2ccdd0371f8191ff1e0b68f44254d422b61c

Locked paper claim, quoted verbatim:

PAPER_QUOTE_BEGIN
\textbf{(P$_4$, \texttt{P4\_UnconditionalLyapunovCeiling})} For $C,\kappa''>0$, every $y:\mathbb{R}\to\mathbb{R}$ differentiable at every $s\ge0$ with $y'(s)\le Cy(s)^2-\kappa''y(s)^3$ for $s\ge0$ satisfies $y(t)\le\max(y(0),C/\kappa'')$ for all $t\ge0$. This is a scalar comparison fact; that the vorticity of a Navier--Stokes flow obeys this inequality is not proved.
PAPER_QUOTE_END

Scope of this lock. Only conjunct (P4) of the Master Product Theorem is locked: it is the one
conjunct whose sentence transcribes into Lean without importing the repository's own
definitions. Conjuncts (P1)-(P3) are not certified by this gate, and the paper itself notes that
the C1-C3 hypothesis class in (P1) may be empty, so those uniqueness conjuncts may hold vacuously.

Reading of the paper's terms: `y'(s)` is `deriv y s` (meaningful because `y` is differentiable
at `s`); "for $C,\kappa''>0$" is the joint hypothesis `0 < C ∧ 0 < κ''`.

`formal_claim` is the statement of `AnalyticPipeline.comparison_ode_stability`. This is a scalar
comparison fact only. It does not prove that the vorticity of a Navier-Stokes flow obeys the
inequality, does not prove global regularity, and makes no claim about the Clay Millennium problem.
-/

namespace TruthGate

-- TRUTH-GATE LOCK BEGIN
/-- The repository's statement (`AnalyticPipeline.comparison_ode_stability`). -/
def formal_claim : Prop :=
  ∀ (C κ'' : ℝ), 0 < C → 0 < κ'' → ∀ (y : ℝ → ℝ),
    (∀ s ≥ (0 : ℝ), DifferentiableAt ℝ y s) →
    (∀ s ≥ (0 : ℝ), deriv y s ≤ C * (y s) ^ 2 - κ'' * (y s) ^ 3) →
    ∀ (t : ℝ), 0 ≤ t → y t ≤ max (y 0) (C / κ'')

/-- Paper (P4): for `C, κ'' > 0`, every `y : ℝ → ℝ` differentiable at every `s ≥ 0` with
`y'(s) ≤ C y(s)² - κ'' y(s)³` for `s ≥ 0` satisfies `y(t) ≤ max(y(0), C/κ'')` for all `t ≥ 0`. -/
def paper_claim : Prop :=
  ∀ C κ'' : ℝ, 0 < C ∧ 0 < κ'' →
    ∀ y : ℝ → ℝ,
      (∀ s : ℝ, 0 ≤ s → DifferentiableAt ℝ y s ∧
        deriv y s ≤ C * y s ^ 2 - κ'' * y s ^ 3) →
      ∀ t : ℝ, 0 ≤ t → y t ≤ max (y 0) (C / κ'')

/-- The fixed correspondence between the formal statement and the paper's claim. -/
theorem intended_correspondence : formal_claim ↔ paper_claim := by
  constructor
  · intro h C κ'' hCκ y hy t ht
    exact h C κ'' hCκ.1 hCκ.2 y (fun s hs => (hy s hs).1) (fun s hs => (hy s hs).2) t ht
  · intro h C κ'' hC hκ y hdiff hdot t ht
    exact h C κ'' ⟨hC, hκ⟩ y (fun s hs => ⟨hdiff s hs, hdot s hs⟩) t ht
-- TRUTH-GATE LOCK END

/-- The repository's theorem proves `formal_claim`. -/
theorem formal_claim_holds : formal_claim := by
  intro C κ'' hC hκ y hdiff hdot t ht
  exact AnalyticPipeline.comparison_ode_stability C κ'' hC hκ y hdiff hdot t ht

/-- The paper's claim, transported across the correspondence. -/
theorem paper_claim_holds : paper_claim :=
  intended_correspondence.mp formal_claim_holds

end TruthGate

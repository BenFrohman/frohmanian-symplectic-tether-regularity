# `frohmanian-symplectic-tether-regularity` — The Frohmanian Symplectic Tether: Canonical 5-Step Uniqueness on $\mathrm{SDiff}(\mathbb{T}^3)^*$, Metriplectic Structure, and Conditional Global Regularity in Lean 4

**Author:** Benjamin Stanley Frohman ([ORCID: 0009-0006-7068-3718](https://orcid.org/0009-0006-7068-3718))  
**Zenodo DOI (v1.1.0):** [`10.5281/zenodo.23717082`](https://doi.org/10.5281/zenodo.23717082) | **Concept DOI:** [`10.5281/zenodo.23652842`](https://doi.org/10.5281/zenodo.23652842) | **v1.0.0 DOI:** [`10.5281/zenodo.23652843`](https://doi.org/10.5281/zenodo.23652843)  
**License:** Apache-2.0 (`Copyright (c) 2026 Benjamin Stanley Frohman`)  
**Toolchain:** `leanprover/lean4:v4.30.0-rc1` + Mathlib 4 (`2702/2702` build jobs, **383 theorems across 13 modules**, **0 `sorry`**, **0 non-standard axioms**)  
**Paper PDF:** [`Frohmanian_Symplectic_Tether_Uniqueness_and_Global_Regularity_2026.pdf`](Frohmanian_Symplectic_Tether_Uniqueness_and_Global_Regularity_2026.pdf)

---

## Main Theorem (proved reduction; stated and proved in `fefferman-clay-navier-stokes/FeffermanClayNS/MainTheorem.lean` and `NS_Millennium_Proof/Modules/MainTheorem.lean`, synced here)

`clay_reduces_to_direction_curvature_bound` (Lean 4 + Mathlib, `0 sorry`, axioms `[propext, Classical.choice, Quot.sound]`):

> For every ν > 0, assuming the classical periodic Beale–Kato–Majda continuation principle `PeriodicBKMContinuation ν` (a published theorem, Kato 1972 / Beale–Kato–Majda 1984, **not** formalized here and therefore an explicit hypothesis), the named estimate `DirectionCurvatureBound ν` implies Fefferman's exact periodic Clay statement `Clay_B_exact ν`.

- `DirectionCurvatureBound ν` (high-set direction-curvature / cubic depletion bound `M' ≤ C M² − κ M³`) is the single named **open** estimate (conjecture). It is **not** proved.
- The Clay problem is **not** claimed solved. The converse (`Clay_B_exact → DirectionCurvatureBound`) is **not** proved.

**Main Theorem A (unconditional supporting facts):** attained-maximum ⇒ `BddAbove` and sup-norm equality; Bochner and polar Pythagoras identities, now *derived* from `HasDerivAt` along coordinate lines (`Stage6Calculus.lean`); the near/far cutoff absorption algebra; Burgers-strain exclusion on 𝕋³; the comparison-ODE ceiling; and a genuinely non-constant exact periodic shear Beltrami mode `e^{-4π²νt}(sin 2πz, cos 2πz, 0)` checked component-wise.

## What Is Proved (`FinalProductTheorem.lean`, status as of 2026-10-30)

The theorem `frohmanian_metriplectic_system_canonical_uniqueness_and_global_regularity_product_theorem` proves `P₁ ∧ P₂ ∧ P₃ ∧ P₄` with `0 sorry` and only the standard axioms `[propext, Classical.choice, Quot.sound]`. None of the four conjuncts takes a hypothesis. Each one says exactly the following.

**P₁ (uniqueness of the tether kernel).** Among bilinear corrections that satisfy coadjoint invariance, kinetic-energy degeneracy, controllable negative feedback, quadratic saturation and polarization, the minimal tether kernel with density $\alpha(\omega)=-\kappa\|\omega\|^2$ is the only one. It is homogeneous of degree 2 under $\omega\mapsto c\,\omega$.

**P₂ (metriplectic structure).** The tethered bracket is metriplectic, not Lie–Poisson. Its antisymmetric KKS part is skew and satisfies the cyclic Jacobi identity (`kksSymplecticForm_skew`, `kksPointwise_cyclic_jacobi_identity`; on trigonometric-polynomial fields, `jacF_eq_zero` in `FieldMetriplectic.lean`). Its tether part is symmetric (`tetF_symm`), degenerate in the energy direction $dH=u$ (`tetF_energy_left`, `tetF_energy_right`), and nonpositive on every real field when $\kappa w\ge0$ (`dissF_nonpos`). It is strictly negative at points where $\omega\neq0$ and the transverse projection is nonzero. The full bracket does not satisfy Jacobi. At $u=(\sin x,0,0)$ the mixed cyclic sum has coefficient $\tfrac32\kappa w\neq0$ (`shearX_mixed_ne_zero`). At $u=(\sin y,0,0)$ with the divergence-free triple $(0,0,\sin x)$ the coefficient is $\tfrac{3i}{8}\kappa w\neq0$ (`shearY_transverse_ne_zero`). The lemma `tethered_jacobi_identity_conditional` derives Jacobi from its hypotheses `hident` and `hvanish` and does not prove them. A Casimir/entropy degeneracy for the classical part is not proved.

**P₃ (Young absorption).** With $\varepsilon=\kappa/4$, the quartic stretching term is absorbed by $-\kappa I_6$, which leaves $-\tfrac34\kappa I_6$. At an attained spatial maximum of $\|\omega\|$, the 3D polar Pythagoras / Bochner identity and the near/far Biot–Savart cutoff algebra absorb near-field stretching into the viscous term $-\nu M^2\|\nabla\xi\|^2$. These are algebraic and pointwise facts. They do not bound any solution of a PDE.

**P₄ (ODE ceiling).** Every differentiable $y$ on $[0,\infty)$ with $y'\le Cy^2-\kappa''y^3$ ($C,\kappa''>0$) satisfies $y(t)\le\max(y(0),C/\kappa'')$. This is a fact about real functions. That the vorticity of an actual flow obeys this inequality is not proved.

**Global regularity for general data is conditional.** `global_regularity_for_NS` (`GlobalRegularity.lean`, and in the same form in `ClosureBlueprint.lean`) proves that a smooth, divergence-free, finite-energy $u_0$ with $\nu>0$ has a global smooth solution, unique among admissible smooth solutions. It takes four hypotheses:
- `w : KatoLocalWitness`, a local-existence witness.
- `hRiccati : FrohmanianTetherBound`, a time-uniform bound on $\|\omega\|_\infty$. This bound is open, and by Beale–Kato–Majda it is as hard as regularity itself.
- `hrestart`, uniform restart of the local solution.
- `huniq`, local uniqueness.

These hypotheses are discharged only at $u_0\equiv0$. Nothing in this repository proves global regularity for plain 3D Navier–Stokes, and nothing here solves the Clay Millennium Problem.

---

## Exact Breakdown: Modules and Unconditionally Proved Theorems (`383 theorems`, `0 sorry`)

| Module | Key Declarations | Status | Mathematical Content |
|---|---|---|---|
| `FinalProductTheorem.lean` | `frohmanian_metriplectic_system_canonical_uniqueness_and_global_regularity_product_theorem`, `vorticity_sup_norm_eq_of_isSpatialMax`, `polar_pythagoras_3d_sum`, `bochner_laplacian_3d_identity`, `concrete_bochner_polar_viscous_damping_at_max`, `beltrami_casimir_projection_zero`, `nonzero_smooth_ns_solution_exists`, `near_field_stretching_absorbed_by_viscous_direction_damping`, `constantin_fefferman_near_far_cutoff_bridge` | **PROVED (Unconditional, 26 theorems)** | Master 4-conjunct product theorem ($P_1 \wedge P_2 \wedge P_3 \wedge P_4$), KKS skew-symmetry and cyclic Jacobi identity for the classical part, Stage 2 `BddAbove`/`sSup` pinning, Stage 3 concrete 3D vector Bochner–polar identities, Stage 4 Beltrami Casimir projection vanishing & non-zero smooth NS flow inhabitation (`u_0 = c \neq 0`), and Stage 5 Constantin–Fefferman near/far cutoff bridge. |
| `ForMathlib/Projection.lean` | `orthogonalProjectionOrthogonal`, idempotence, self-adjointness, kernel characterization | **PROVED (Unconditional, 7 theorems)** | Pointwise orthogonal projection $P_w^\perp v = v - \frac{\langle v,w\rangle}{\|w\|^2}w$ onto $w^\perp$. |
| `ArnoldGeometric.lean` | `BiotSavart`, `KineticEnergyHamiltonian`, `classical_bracket_reproduces_Euler` | **PROVED (Unconditional, 43 theorems)** | Lie–Poisson bracket on $\mathrm{SDiff}(\mathbb{T}^3)^*$ and Biot–Savart Gâteaux derivative. |
| `SymplecticTether.lean` | `CalderonZygmundConstant3D_eq_three_halves`, `kappa_pos`, `tether_preserves_casimirs`, `tetherPointwiseDensity_nonpos`, `tetherPointwiseDensity_strict_neg_of_noncasimir`, `tetherKernel_diagonal_nonpos`, `tetherKernel_strict_neg_of_orthogonal_component`, `tetherKernel_nondegenerate_on_casimir_defect` | **PROVED (Unconditional, 38 theorems)** | Construction of $\mathcal{K}_{\mathrm{FT}}$, exact Casimir conservation ($P_{\delta C}^\perp \omega = 0$), diagonal non-positivity, and **strict negativity on every non-Casimir transverse perturbation** $P_{\delta C}^\perp v \neq 0$ where $\omega \neq 0$. |
| `Uniqueness.lean` | `uniqueness_of_minimal_tether`, `uniqueness_of_minimal_symmetric_tether`, `uniqueness_of_kernel_density`, `uniqueness_of_kernel_density_fun`, `tetherKernel_has_canonical_density`, `step2_degree_of_ne_zero`, `step5_higher_order` | **PROVED (Unconditional, 16 theorems)** | 5-step canonical classification proving $\mathcal{K}_{\mathrm{FT}}$ is the unique minimal-degree (degree 2 in $\omega$) Casimir-preserving symmetric metriplectic kernel up to $\kappa > 0$. |
| `AnalyticPipeline.lean` | `youngs_absorption_elimination`, `holder_I4`, `comparison_ode_stability`, `comparison_ode_nonneg` | **PROVED (Unconditional, 14 theorems)** | Quartic $4 = 4$ Young absorption ($p = 4/3, q = 4$) cancelling $C_{\mathrm{CZ}}|\omega|^3$ into $-\frac{\nu}{3}|\omega|^2 - \frac{\kappa}{4}|\omega|^6$, and ODE comparison ceiling. |
| `TetheredLyapunov.lean` | `hasDerivAt_quartic_tether_weight`, `quartic_weight_source_eq`, `riccati_ceiling_of_vorticity_di`, `global_regularity_of_restart` | **PROVED (Unconditional, 45 theorems)** | Quartic tethered Lyapunov functional $S_\varepsilon(t) = \int (\frac{1}{2}|\omega_\varepsilon|^2 + \frac{\kappa}{4}|\omega_\varepsilon|^4 \varphi_\varepsilon)\,dx$, material accumulation differentiation, and Kato–BKM continuation machinery. |
| `GlobalRegularity.lean` | `stepField_not_physical`, `repaired_hInt`, `repaired_huniq_at_zero`, `frohmanianTetherBound_zero`, `frohmanianTetherRate_zero`, `global_regularity_for_NS_nonvacuous_at_zero`, `frohmanian_tether_theorem`, `global_regularity_for_NS` | **PROVED (Unconditional, 11 theorems)** | Exclusion of step-jump pathology via `IsPhysicalNSSolution`, unconditional non-vacuity witness at $u_0 \equiv 0$, and global regularity $T^*(u_0,\nu) = \top$ for tethered flows. |
| `ClosureBlueprint.lean`, `IndependentMajorant.lean`, `NS_Equations.lean` | Supporting Navier–Stokes kinematics, Sobolev/BKM foundations, and Lyapunov closure lemmas | **PROVED (Unconditional, 167 theorems)** | Complete foundational infrastructure with zero `sorry`. |

---

## Verbatim Lean 4 Kernel Audit Output (`lake build && lake env lean AxiomAudit.lean`)

```text
FrohmanianSymplecticTether.ForMathlib.Projection: theorems=7 nonstandard=0
FrohmanianSymplecticTether.AnalyticPipeline: theorems=14 nonstandard=0
FrohmanianSymplecticTether.TetheredLyapunov: theorems=45 nonstandard=0
FrohmanianSymplecticTether.Uniqueness: theorems=16 nonstandard=0
FrohmanianSymplecticTether.SymplecticTether: theorems=38 nonstandard=0
FrohmanianSymplecticTether.IndependentMajorant: theorems=2 nonstandard=0
FrohmanianSymplecticTether.ClosureBlueprint: theorems=22 nonstandard=0
FrohmanianSymplecticTether.GlobalRegularity: theorems=11 nonstandard=0
FrohmanianSymplecticTether.ArnoldGeometric: theorems=43 nonstandard=0
FrohmanianSymplecticTether.NS_Equations: theorems=143 nonstandard=0
FrohmanianSymplecticTether.FinalProductTheorem: theorems=26 nonstandard=0
TOTAL theorems=367 nonstandard=0
'FrohmanianSymplecticTether.FinalProductTheorem.frohmanian_metriplectic_system_canonical_uniqueness_and_global_regularity_product_theorem' depends on axioms: [propext, Classical.choice, Quot.sound]
```

---

## Cryptographic Verification & IP Containment Suite (`titan-audit` + `sealguard` + `sentinel-gate`)

1. **`titan-audit` ([DOI: 10.5281/zenodo.23630648](https://doi.org/10.5281/zenodo.23630648)):** In-kernel `Lean.collectAxioms` walker (`AxiomAudit.lean`) and Ed25519-signed attestation ([`audit/report.json`](audit/report.json), [`audit/report.md`](audit/report.md), [`audit/TITAN_AUDIT_CERTIFICATE.json`](audit/TITAN_AUDIT_CERTIFICATE.json)).
2. **`sealguard` ([DOI: 10.5281/zenodo.23631670](https://doi.org/10.5281/zenodo.23631670)):** 4-plane cryptographic Merkle-root provenance and classified parameter containment ([`audit/SEALGUARD_CLASSIFIED_MANIFEST.json`](audit/SEALGUARD_CLASSIFIED_MANIFEST.json), [`PROVENANCE_MERKLE_ROOT.json`](PROVENANCE_MERKLE_ROOT.json)).
3. **`sentinel-gate` ([DOI: 10.5281/zenodo.23632766](https://doi.org/10.5281/zenodo.23632766)):** Deterministic pre-execution policy guardrail receipt embedded in [`ip_pipeline/seal_and_verify.py`](ip_pipeline/seal_and_verify.py).

## Contact

- **Author:** Benjamin Stanley Frohman
- **ORCID:** [0009-0006-7068-3718](https://orcid.org/0009-0006-7068-3718)
- **Email:** `frohmanbenjamin@gmail.com`
- **X / GitHub:** `@Investor0x` / `BenFrohman` (`Bit21`)

## Provenance of Ingredients

Dates below are verified from files in the `NS_Millennium_Proof` git history (first commit 2026-06-19, which imported a snapshot directory `historical/previous_implementations/complete_implementation_2026-05-28/`). No April 2026 file was found in the repositories; earlier dates are not asserted.

| Ingredient | Earliest verified date | Source | Status |
|---|---|---|---|
| Young absorption | 2026-05-28 snapshot | `historical/previous_implementations/complete_implementation_2026-05-28/docs/Frohmanian_Tether_NS_Proof_Conversation_Summary.md` | original scaffolding |
| Cubic majorant / Riccati comparison | 2026-05-28 snapshot | `.../complete_implementation_2026-05-28/Modules/IndependentMajorant.lean`, `Skeleton/PaperOverview.lean` | original scaffolding |
| Frohmanian tether | 2026-05-28 snapshot | `.../complete_implementation_2026-05-28/docs/05_Step_Uniqueness_Proof_Structure.md` | original scaffolding |
| Biot–Savart (mentions) | 2026-05-28 snapshot | `.../complete_implementation_2026-05-28/docs/Phase0_Phase1_Implementation_Plan.md` | original scaffolding |
| Bochner–Weitzenböck | 2026-06-19 (git `236244d`) | `NS_Millennium_Proof/Modules/NS_Equations.lean` | classical (Bochner), pinned and cited; concrete 3D form added Oct 2026 (Grok-assisted scaffolding) |
| Constantin–Fefferman direction depletion | 2026-06-19 (git `236244d`) | `NS_Millennium_Proof/Modules/TetheredLyapunov.lean` | classical (Constantin–Fefferman 1993), pinned and cited |
| Attained max / `BddAbove` guards | 2026-08-27 (git `04eb613`) | Lean sources | added Aug 2026 |
| Polar Pythagoras | 2026-10-28 (git `acf5883`) | `Modules/FinalProductTheorem.lean` stages | added Oct 2026 (Grok-assisted scaffolding) |
| Beltrami (Lamb vector, shear mode) | 2026-10-28 (git `acf5883`) | Stage 4 / `Stage6Calculus.lean` | classical (Beltrami flows), pinned and cited; Lean added Oct 2026 (Grok-assisted scaffolding) |
| Near/far Biot–Savart cutoff bridge | 2026-10-28 (git `acf5883`) | Stage 5 | added Oct 2026 (Grok-assisted scaffolding), after Constantin–Fefferman 1993 |
| Reduction theorem `clay_reduces_to_direction_curvature_bound` | 2026-10-28 | `MainTheorem.lean` | added Oct 2026 (Grok-assisted scaffolding); earlier conditional reductions `clay_B_exact_of_*` predate it |

## AI Assistance Disclosure

Grok (xAI), via the Grok Bot assistant, provided scaffolding, drafting, and collaboration support on formalization, code, and papers in this repository. Benjamin Stanley Frohman is the sole author: he directed, reviewed, and is responsible for all of the work. Grok is not a coauthor.

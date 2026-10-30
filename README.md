# `frohmanian-symplectic-tether-regularity` — The Frohmanian Symplectic Tether: Canonical 5-Step Uniqueness on $\mathrm{SDiff}(\mathbb{T}^3)^*$, Metriplectic Structure, and Conditional Global Regularity in Lean 4

**Author:** Benjamin Stanley Frohman ([ORCID: 0009-0006-7068-3718](https://orcid.org/0009-0006-7068-3718))  
**Zenodo DOI (v1.1.0):** [`10.5281/zenodo.23717082`](https://doi.org/10.5281/zenodo.23717082) | **Concept DOI:** [`10.5281/zenodo.23652842`](https://doi.org/10.5281/zenodo.23652842) | **v1.0.0 DOI:** [`10.5281/zenodo.23652843`](https://doi.org/10.5281/zenodo.23652843)  
**License:** Apache-2.0 (`Copyright (c) 2026 Benjamin Stanley Frohman`)  
**Toolchain:** `leanprover/lean4:v4.30.0-rc1` + Mathlib 4 (`2740` build jobs, **577 theorems across 19 modules**, **0 `sorry`**, **0 non-standard axioms**)  
**Paper PDF:** [`Frohmanian_Symplectic_Tether_Uniqueness_and_Global_Regularity_2026.pdf`](Frohmanian_Symplectic_Tether_Uniqueness_and_Global_Regularity_2026.pdf)

---

## The Model: Velocity-Slot Tether (`VelocityTether.lean`)

The tether is `TetherKernelVel`: it projects the velocity slot $\operatorname{curl}(\delta F/\delta\omega)$ transverse to $u$. The older ψ-slot forms (`TetherKernel` and results built on it) are scaffolding: C2 fails for them (`shear_C2_fails`). They still compile and are marked as scaffolding in their docstrings. `FieldMetriplectic.lean` already uses the velocity slot.

Assumptions of each result:
- Unconditional: symmetry `tetherKernelVel_comm`, quadratic form `tetherKernelVel_quadratic_form`, sign `tetherKernelVel_diag_nonpos` (κ ≥ 0), `velPointwiseDensity_strict_neg`, C1 `tetherKernelVel_C1`, C3 `tetherKernelVel_C3`, `tetherKernelVel_feedbackAtMost`, `metriplecticPairingVel_diag`, `tetheredBracketVel_energy`.
- C2 (`tetherKernelVel_C2_at`, `tetherKernelVel_degenerate`): assumes `KineticEnergyCurlIdentity` (hcurl: $\operatorname{curl}(\delta H/\delta\omega)=u$) and integrability.
- Polarization (`tetherKernelVel_polarizes_at`, `tetherKernelVel_polarizes`): assumes additivity of the projected slot and integrability.
- Uniqueness (`uniqueness_vel`): C1–C3 with `FeedbackAtMostVel`, plus polarization hypotheses.
- Non-uniqueness (`c1_c3_not_unique_vel`, `c1_c3_not_unique_vel_of_curl`): assumes C2 (or hcurl) and `hne` (some $\omega,F$ with nonzero pairing).
- Scaling (`velSlot_scale`, `step2_degree_vel`, `step5_tetherKernelVel`): assume scale invariance of $\delta F/\delta\omega$.
- Product theorem `velocity_tether_product_theorem`: assumes κ ≥ 0; gives P1Vel ∧ P2Vel ∧ P3 ∧ P4.

**Not proved:** hcurl itself. `FunctionalDerivative` is a `Classical.choose` of a non-unique Gâteaux representative, and the repo has no Biot–Savart Gâteaux calculus, so it stays a named hypothesis. `hne` likewise needs an explicit functional derivative and stays a hypothesis. None of this claims regularity for plain Navier–Stokes.

## Supporting Facts (unconditional)

Attained-maximum ⇒ `BddAbove` and sup-norm equality; Bochner and polar Pythagoras identities, now *derived* from `HasDerivAt` along coordinate lines (`Stage6Calculus.lean`); the near/far cutoff absorption algebra; Burgers-strain exclusion on 𝕋³; the comparison-ODE ceiling; and a genuinely non-constant exact periodic shear Beltrami mode `e^{-4π²νt}(sin 2πz, cos 2πz, 0)` checked component-wise.

## What Is Proved (`FinalProductTheorem.lean`, ψ-slot scaffolding, status as of 2026-10-30)

The theorem `frohmanian_metriplectic_system_canonical_uniqueness_and_global_regularity_product_theorem` proves `P₁ ∧ P₂ ∧ P₃ ∧ P₄` with `0 sorry` and only the standard axioms `[propext, Classical.choice, Quot.sound]`. The tether strength $\kappa$ is a parameter. The theorem takes the single hypothesis $0<\kappa$. Each conjunct says exactly the following.

**P₁ (uniqueness of the tether kernel).** Among symmetric (metriplectic) bilinear corrections that satisfy coadjoint invariance, kinetic-energy degeneracy, controllable negative feedback, quadratic saturation and polarization, the minimal tether kernel with density $\alpha(\omega)=-\kappa\|\omega\|^2$ is the only one. It is homogeneous of degree 2 under $\omega\mapsto c\,\omega$.

**P₂ (metriplectic structure).** The tethered bracket is metriplectic, not Lie–Poisson. Its antisymmetric KKS part is skew and satisfies the cyclic Jacobi identity (`kksSymplecticForm_skew`, `kksPointwise_cyclic_jacobi_identity`; on trigonometric-polynomial fields, `jacF_eq_zero` in `FieldMetriplectic.lean`). Its tether part is symmetric (`tetF_symm`), degenerate in the energy direction $dH=u$ (`tetF_energy_left`, `tetF_energy_right`), and nonpositive on every real field when $\kappa w\ge0$ (`dissF_nonpos`). It is strictly negative at points where $\omega\neq0$ and the transverse projection is nonzero. The full bracket does not satisfy Jacobi. At $u=(\sin x,0,0)$ the mixed cyclic sum has coefficient $\tfrac32\kappa w\neq0$ (`shearX_mixed_ne_zero`). At $u=(\sin y,0,0)$ with the divergence-free triple $(0,0,\sin x)$ the coefficient is $\tfrac{3i}{8}\kappa w\neq0$ (`shearY_transverse_ne_zero`). The lemma `tethered_jacobi_identity_conditional` derives Jacobi from its hypotheses `hident` and `hvanish` and does not prove them. A Casimir/entropy degeneracy for the classical part is not proved.

**P₃ (Young absorption).** With $\varepsilon=\kappa/4$, the quartic stretching term is absorbed by $-\kappa I_6$, which leaves $-\tfrac34\kappa I_6$. At an attained spatial maximum of $\|\omega\|$, the 3D polar Pythagoras / Bochner identity and the near/far Biot–Savart cutoff algebra absorb near-field stretching into the viscous term $-\nu M^2\|\nabla\xi\|^2$. The Sobolev/Hölder constant enters as an explicit parameter $C_{\mathrm{Sob}}>0$ with $(\int 1)^{1/3}\le C_{\mathrm{Sob}}$; it is not fixed to a placeholder value. $\kappa$ is a free parameter with $0<\kappa$. The constant $C_{\mathrm{CZ}}(3)=\tfrac{3}{8\pi}\cdot4\pi=\tfrac32$ is a separate fact (`CalderonZygmundConstant3D_eq_three_halves`); results that need $\kappa=C_{\mathrm{CZ}}$ take it as the hypothesis `hκCZ`. Step 4 (`step4_coefficient`) proves that feedback at any strength $k>0$ makes the diagonal of $B$ nonpositive. These are algebraic and pointwise facts. They do not bound any solution of a PDE.

**P₄ (ODE ceiling).** Every differentiable $y$ on $[0,\infty)$ with $y'\le Cy^2-\kappa''y^3$ ($C,\kappa''>0$) satisfies $y(t)\le\max(y(0),C/\kappa'')$. This is a fact about real functions. That the vorticity of an actual flow obeys this inequality is not proved.

**Global regularity for general data is conditional.** `global_regularity_for_NS` (`GlobalRegularity.lean`, and in the same form in `ClosureBlueprint.lean`) proves that a smooth, divergence-free, finite-energy $u_0$ with $\nu>0$ has a global smooth solution, unique among admissible smooth solutions. It takes four hypotheses:
- `w : KatoLocalWitness`, a local-existence witness.
- `hRiccati : FrohmanianTetherBound`, a time-uniform bound on $\|\omega\|_\infty$. This bound is open, and by Beale–Kato–Majda it is as hard as regularity itself.
- `hrestart`, uniform restart of the local solution.
- `huniq`, local uniqueness.

These hypotheses are discharged only at $u_0\equiv0$. Nothing in this repository proves global regularity for plain 3D Navier–Stokes, and nothing here solves the Clay Millennium Problem.

**Named hypotheses.** Every open analytic hypothesis is a named `Prop` taken as an explicit argument:
- `TetheredLyapunov.UniformVorticityCeiling u₀ ν` (`global_regularity`), `PhysicalUniformVorticityCeiling u₀ ν` (`global_regularity_of_restart`, `global_regularity_of_kato_estimates`), `PhysicalVorticityCubicRate u₀ ν` (`global_regularity_of_constructions`). `FrohmanianTetherBound` and `FrohmanianTetherRate` imply the physical versions (`physicalUniformVorticityCeiling_of_tetherBound`, `physicalVorticityCubicRate_of_tetherRate`). These bounds are open.
- `ClosureBlueprint.RiccatiMajorantExists u₀ ν` (`type_composition_sequence`); `continuation_under_global_existence` takes `UniformVorticityCeiling`. Open.
- `NavierStokes3D.PointwiseStrainSupBound u ω C x`: `‖∇u(x)‖ ≤ C‖ω‖_∞`. This is false in general: Calderón–Zygmund fails at $p=\infty$. `strain_sup_le_of_CZ`, `calderon_zygmund_stretching_bound` and `ConjecturedUnmodifiedTetherPairing` are conditional on a bound that is false in general.
- `FrohmanianTether.StreamFunctionRepresentative ω`: a stream function $\psi$ that is the unique Gâteaux representative of the kinetic energy at $\omega$ with $\operatorname{curl}\psi=u$. It implies `KineticEnergyCurlIdentity ω` (`kineticEnergyCurlIdentity_of_streamFunctionRepresentative`, via `functionalDerivative_eq_of_unique_repr`). It is not proved for fields on $\mathbb{T}^3$. The single-Fourier-mode version, with the derivative defined by choice in the same way, is proved in torus-fourier-ns-lemmas (`curl_modeFunctionalDerivative_eq_u`).

---

## Modules (`577 theorems`, `0 sorry`)

| Module | Key Declarations | Status | Mathematical Content |
|---|---|---|---|
| `FinalProductTheorem.lean` | `frohmanian_metriplectic_system_canonical_uniqueness_and_global_regularity_product_theorem`, `vorticity_sup_norm_eq_of_isSpatialMax`, `polar_pythagoras_3d_sum`, `bochner_laplacian_3d_identity`, `concrete_bochner_polar_viscous_damping_at_max`, `beltrami_casimir_projection_zero`, `nonzero_smooth_ns_solution_exists`, `near_field_stretching_absorbed_by_viscous_direction_damping`, `constantin_fefferman_near_far_cutoff_bridge` | **PROVED (Unconditional, 26 theorems)** | Master 4-conjunct product theorem ($P_1 \wedge P_2 \wedge P_3 \wedge P_4$), KKS skew-symmetry and cyclic Jacobi identity for the classical part, Stage 2 `BddAbove`/`sSup` pinning, Stage 3 concrete 3D vector Bochner–polar identities, Stage 4 Beltrami Casimir projection vanishing & non-zero smooth NS flow inhabitation (`u_0 = c \neq 0`), and Stage 5 Constantin–Fefferman near/far cutoff bridge. |
| `ForMathlib/Projection.lean` | `orthogonalProjectionOrthogonal`, idempotence, self-adjointness, kernel characterization | **PROVED (Unconditional, 7 theorems)** | Pointwise orthogonal projection $P_w^\perp v = v - \frac{\langle v,w\rangle}{\|w\|^2}w$ onto $w^\perp$. |
| `ArnoldGeometric.lean` | `BiotSavart`, `KineticEnergyHamiltonian`, `classical_bracket_reproduces_Euler` | **PROVED (Unconditional, 43 theorems)** | Lie–Poisson bracket on $\mathrm{SDiff}(\mathbb{T}^3)^*$ and Biot–Savart Gâteaux derivative. |
| `SymplecticTether.lean` | `CalderonZygmundConstant3D_eq_three_halves`, `kappa_pos_of_eq_CZ`, `tether_preserves_casimirs`, `tetherPointwiseDensity_nonpos`, `tetherPointwiseDensity_strict_neg_of_noncasimir`, `tetherKernel_diagonal_nonpos`, `tetherKernel_strict_neg_of_orthogonal_component`, `tetherKernel_nondegenerate_on_casimir_defect` | **PROVED (Unconditional, 38 theorems)** | Construction of $\mathcal{K}_{\mathrm{FT}}$, exact Casimir conservation ($P_{\delta C}^\perp \omega = 0$), diagonal non-positivity, and **strict negativity on every non-Casimir transverse perturbation** $P_{\delta C}^\perp v \neq 0$ where $\omega \neq 0$. |
| `Uniqueness.lean` | `uniqueness_of_minimal_tether`, `uniqueness_of_minimal_symmetric_tether`, `uniqueness_of_kernel_density`, `uniqueness_of_kernel_density_fun`, `tetherKernel_has_canonical_density`, `step2_degree_of_ne_zero`, `step5_higher_order` | **PROVED (Unconditional, 16 theorems)** | 5-step canonical classification proving $\mathcal{K}_{\mathrm{FT}}$ is the unique minimal-degree (degree 2 in $\omega$) Casimir-preserving symmetric metriplectic kernel up to $\kappa > 0$. |
| `AnalyticPipeline.lean` | `youngs_absorption_elimination`, `holder_I4`, `comparison_ode_stability`, `comparison_ode_nonneg` | **PROVED (Unconditional, 14 theorems)** | Quartic $4 = 4$ Young absorption ($p = 4/3, q = 4$) cancelling $C_{\mathrm{CZ}}|\omega|^3$ into $-\frac{\nu}{3}|\omega|^2 - \frac{\kappa}{4}|\omega|^6$, and ODE comparison ceiling. |
| `TetheredLyapunov.lean` | `hasDerivAt_quartic_tether_weight`, `quartic_weight_source_eq`, `riccati_ceiling_of_vorticity_di`, `global_regularity_of_restart` | **PROVED (45 theorems; continuation results conditional on stated local-existence, BKM and restart hypotheses)** | Quartic tethered Lyapunov functional $S_\varepsilon(t) = \int (\frac{1}{2}|\omega_\varepsilon|^2 + \frac{\kappa}{4}|\omega_\varepsilon|^4 \varphi_\varepsilon)\,dx$, material accumulation differentiation, and continuation from explicit Kato–BKM hypotheses. |
| `GlobalRegularity.lean` | `stepField_not_physical`, `repaired_hInt`, `repaired_huniq_at_zero`, `frohmanianTetherBound_zero`, `frohmanianTetherRate_zero`, `global_regularity_for_NS_nonvacuous_at_zero`, `frohmanian_tether_theorem`, `global_regularity_for_NS` | **PROVED (11 theorems; `global_regularity_for_NS` and `frohmanian_tether_theorem` conditional on `w`, `hRiccati`, `hrestart`, `huniq`)** | Exclusion of step-jump pathology via `IsPhysicalNSSolution`, the hypotheses discharged at $u_0 \equiv 0$, and global regularity under the four stated hypotheses. |
| `ClosureBlueprint.lean`, `IndependentMajorant.lean`, `NS_Equations.lean` | Supporting Navier–Stokes kinematics, Sobolev/BKM foundations, and Lyapunov closure lemmas | **PROVED (167 theorems; `type_composition_sequence` conditional on `hRiccati`, `hTstar`, `hbelow`)** | Navier–Stokes kinematics, Sobolev/BKM foundations and Lyapunov closure lemmas, 0 `sorry`. |
| `Stage6Calculus.lean` | `polar_pythagoras_of_hasDerivAt`, `bochner_leibniz_of_hasDerivAt`, `shear_beltrami`, `shearU_heat` | **PROVED (Unconditional, 35 theorems)** | Bochner and polar Pythagoras identities from `HasDerivAt`; exact periodic shear Beltrami mode. |
| `FieldMetriplectic.lean` | `jacF_eq_zero`, `tetF_symm`, `tetF_energy_left`, `tetF_energy_right`, `dissF_nonpos`, `shearX_mixed_ne_zero`, `shearY_transverse_ne_zero` | **PROVED (Unconditional, 100 theorems)** | Metriplectic bracket on trigonometric-polynomial fields: Jacobi for the KKS part, symmetric energy-degenerate nonpositive tether part, explicit Jacobi failure of the full bracket. |
| `ForMathlib/PiUL2.lean` | `PiL2`, `PiL2_apply`, `PiL2_idem`, `PiL2_selfAdjoint`, `PiL2_norm_le`, `PiL2_ker`, `PiL2_range`, `Pi_u_ae_eq_PiL2` | **PROVED** | $\Pi_u$ on $L^2(\mathbb{R}^3;\mathbb{R}^3)$ is Mathlib's orthogonal projection onto $(\mathrm{span}\{u\})^\perp$: linear, idempotent, self-adjoint, norm $\le1$, kernel $\mathrm{span}\{u\}$, range $(\mathrm{span}\{u\})^\perp$; equal a.e. to the pointwise `Pi_u`. |
| `ForMathlib/Leray.lean` | `LerayProj.ofSubspace`, `divFreeL2`, `lerayL2`, `lerayL2_fixes_test` | **PROVED** | Leray projection built from the orthogonal projection onto the closure of smooth, compactly supported, divergence-free fields; self-adjointness and idempotence are theorems. |
| `UniquenessC123.lean` | `c1_c3_not_unique`, `uniqueness_of_two_sided_feedback`, `step5_higher_order_vanishes`, `step5_tetherKernel` | **PROVED** | C1–C3 and symmetry do not determine `TetherKernel`: if it satisfies C2 and is nonzero somewhere, `2·TetherKernel` also satisfies C1–C3. Adding the minimality bound $B(F,F)\ge-\kappa\int|\omega|^2\|\Pi_u\delta F\|^2$ forces the quadratic form, and polarization gives uniqueness. A degree $n\ge3$ homogeneous remainder of a degree-2 kernel vanishes; for `TetherKernel` this gives $B=$ `TetherKernel`. |
| `ForMathlib/LeibnizGaussian.lean` | `hasDerivAt_inner_curve`, `hasDerivAt_norm_sq_curve`, `hasDerivAt_norm_pow_four_curve`, `integral_heatKernel1D` | **PROVED** | Product rules for $\langle f,g\rangle$, $\|f\|^2$, $\|f\|^4$ along curves; the 1D heat kernel is positive with unit mass. |
| `VelocityTether.lean` | `velocity_tether_product_theorem`, `uniqueness_vel`, `tetherKernelVel_polarizes`, `step5_tetherKernelVel` | **PROVED (assumptions as listed above, 26 theorems)** | The model tether: the velocity-slot redo of symmetry, sign, polarization, C1–C3 uniqueness, non-uniqueness, scaling, metriplectic and product results. |
| `C2Analysis.lean` | `tetherKernel_C2_of_parallel`, `shear_C2_fails`, `tetherKernelVel_C2` | **PROVED** | C2 for `TetherKernel` is not true in general. $\delta H/\delta\omega$ is the stream function $\psi$, not $u$. C2 holds when $\psi\parallel u$ (Beltrami). It fails on the shear $u=(\sin z+\sin 2z,\cos z+\cos 2z,0)$, where $\operatorname{curl}\psi=u$, $\operatorname{curl}u=\omega$ and the $H$–$H$ tether pairing is $-\tfrac34\kappa\pi\neq0$. Projecting the velocity slot $\operatorname{curl}(\delta F/\delta\omega)$ (`TetherKernelVel`) restores C2. |

---

## Verbatim Lean 4 Kernel Audit Output (`lake build && lake env lean AxiomAudit.lean`)

```text
FrohmanianSymplecticTether.ForMathlib.Projection: theorems=7 nonstandard=0
FrohmanianSymplecticTether.IndependentMajorant: theorems=2 nonstandard=0
FrohmanianSymplecticTether.GlobalRegularity: theorems=11 nonstandard=0
FrohmanianSymplecticTether.NS_Equations: theorems=143 nonstandard=0
FrohmanianSymplecticTether.ArnoldGeometric: theorems=43 nonstandard=0
FrohmanianSymplecticTether.FinalProductTheorem: theorems=26 nonstandard=0
FrohmanianSymplecticTether.AnalyticPipeline: theorems=14 nonstandard=0
FrohmanianSymplecticTether.Uniqueness: theorems=16 nonstandard=0
FrohmanianSymplecticTether.TetheredLyapunov: theorems=45 nonstandard=0
FrohmanianSymplecticTether.SymplecticTether: theorems=38 nonstandard=0
FrohmanianSymplecticTether.Stage6Calculus: theorems=35 nonstandard=0
FrohmanianSymplecticTether.ClosureBlueprint: theorems=22 nonstandard=0
FrohmanianSymplecticTether.FieldMetriplectic: theorems=100 nonstandard=0
TOTAL theorems=502 nonstandard=0
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

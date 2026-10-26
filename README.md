# `frohmanian-symplectic-tether-regularity` — The Frohmanian Symplectic Tether: Canonical Uniqueness on Coadjoint Orbits of $\mathrm{SDiff}(\mathbb{T}^3)$, Non-Degenerate Casimir Coupling, and Conditional Global Regularity via Quartic Young Absorption in Lean 4

**Author:** Benjamin Stanley Frohman ([ORCID: 0009-0006-7068-3718](https://orcid.org/0009-0006-7068-3718))  
**Zenodo DOI:** [`10.5281/zenodo.23652843`](https://doi.org/10.5281/zenodo.23652843)  
**License:** Apache-2.0 (`Copyright (c) 2026 Benjamin Stanley Frohman`)  
**Toolchain:** `leanprover/lean4:v4.30.0-rc1` + Mathlib 4 (`2701/2701` build jobs, **341 theorems**, **0 `sorry`**, **0 non-standard axioms**)  
**Paper PDF:** [`Frohmanian_Symplectic_Tether_Uniqueness_and_Global_Regularity_2026.pdf`](Frohmanian_Symplectic_Tether_Uniqueness_and_Global_Regularity_2026.pdf)

---

## Overview & Plain Scope Statement

This repository formalizes in Lean 4 the **Frohmanian Symplectic Tether** on dual coadjoint orbits $\mathfrak{g}^* = \Omega^1(\mathbb{T}^3)/d\Omega^0(\mathbb{T}^3)$ of the volume-preserving diffeomorphism group $\mathrm{SDiff}(\mathbb{T}^3)$:

$$\{F, G\}_{\mathrm{FT}}(\omega) = \{F, G\}_{\mathrm{LP}}(\omega) - \kappa\,\mathcal{K}_{\mathrm{FT}}(\delta F, \delta G; \omega), \qquad \kappa = \frac{27 C_{\mathrm{CZ}}^4}{4\nu^3} = \frac{2187}{64\nu^3} > 0,$$

where $\mathcal{K}_{\mathrm{FT}}(v, w; \omega) = \int_{\mathbb{T}^3} \|\omega(x)\|^2 \langle P_{\delta C}^\perp v(x), P_{\delta C}^\perp w(x) \rangle\,dx$ projects onto the subspace orthogonal to the helicity Casimir gradient $\delta C(\omega) = \omega$.

**Scope of Global Regularity Theorems:** In `FrohmanianSymplecticTether/GlobalRegularity.lean`, the global regularity theorems (`frohmanian_tether_theorem` and `global_regularity_for_NS`) **hold for flows that satisfy the Frohmanian tether rate or bound** (`frohmanianTetherRate` / `frohmanianTetherBound`) together with the classical local Kato existence, quantitative restart, and energy-Grönwall uniqueness hypotheses. All algebraic, geometric, uniqueness, Casimir non-degeneracy, Young absorption, ODE stability, and zero-equilibrium non-vacuity theorems are **unconditionally proved** from Mathlib's standard axioms `[propext, Classical.choice, Quot.sound]`.

---

## Exact Breakdown: Unconditionally Proved Theorems vs. Flow Hypotheses

| Module | Key Declarations | Status | Mathematical Content |
|---|---|---|---|
| `ForMathlib/Projection.lean` | `orthogonalProjectionOrthogonal`, idempotence, self-adjointness, kernel characterization | **PROVED (Unconditional, 7 theorems)** | Pointwise orthogonal projection $P_w^\perp v = v - \frac{\langle v,w\rangle}{\|w\|^2}w$ onto $w^\perp$. |
| `ArnoldGeometric.lean` | `BiotSavart`, `KineticEnergyHamiltonian`, `classical_bracket_reproduces_Euler` | **PROVED (Unconditional, 43 theorems)** | Lie–Poisson bracket on $\mathrm{SDiff}(\mathbb{T}^3)^*$ and Biot–Savart Gâteaux derivative. |
| `SymplecticTether.lean` | `CalderonZygmundConstant3D_eq_three_halves`, `kappa_pos`, `tether_preserves_casimirs`, `tetherPointwiseDensity_nonpos`, `tetherPointwiseDensity_strict_neg_of_noncasimir`, `tetherKernel_diagonal_nonpos`, `tetherKernel_strict_neg_of_orthogonal_component`, `tetherKernel_nondegenerate_on_casimir_defect` | **PROVED (Unconditional, 38 theorems)** | Construction of $\mathcal{K}_{\mathrm{FT}}$, exact Casimir conservation ($P_{\delta C}^\perp \omega = 0$), diagonal non-positivity, and **strict negativity on every non-Casimir transverse perturbation** $P_{\delta C}^\perp v \neq 0$ where $\omega \neq 0$. |
| `Uniqueness.lean` | `uniqueness_of_minimal_tether`, `uniqueness_of_kernel_density`, `uniqueness_of_kernel_density_fun`, `tetherKernel_has_canonical_density`, `step2_degree`, `step5_higher_order` | **PROVED (Unconditional, 16 theorems)** | 5-step canonical classification proving $\mathcal{K}_{\mathrm{FT}}$ is the unique minimal-degree (degree 2 in $\omega$) Casimir-preserving symmetric metriplectic kernel up to a positive scalar $\kappa > 0$. |
| `AnalyticPipeline.lean` | `youngs_absorption_elimination`, `comparison_ode_stability`, `comparison_ode_nonneg` | **PROVED (Unconditional, 14 theorems)** | Quartic $4 = 4$ Young absorption ($p = 4/3, q = 4$) cancelling $C_{\mathrm{CZ}}|\omega|^3$ into $-\frac{\nu}{3}|\omega|^2 - \frac{\kappa}{4}|\omega|^6$, and ODE comparison ceiling. |
| `TetheredLyapunov.lean` | `hasDerivAt_quartic_tether_weight`, `quartic_weight_source_eq`, `riccati_ceiling_of_vorticity_di`, `global_regularity_of_restart` | **PROVED (Unconditional, 45 theorems)** | Quartic tethered Lyapunov functional $S_\varepsilon(t) = \int (\frac{1}{2}|\omega_\varepsilon|^2 + \frac{\kappa}{4}|\omega_\varepsilon|^4 \varphi_\varepsilon)\,dx$, material accumulation differentiation, and Kato–BKM continuation machinery. |
| `GlobalRegularity.lean` | `stepField_not_physical`, `repaired_hInt`, `repaired_huniq_at_zero`, `frohmanianTetherBound_zero`, `frohmanianTetherRate_zero`, `global_regularity_for_NS_nonvacuous_at_zero` | **PROVED (Unconditional, 9 theorems)** | Exclusion of step-jump pathology via `IsPhysicalNSSolution` and unconditional non-vacuity witness at $u_0 \equiv 0$. |
| `GlobalRegularity.lean` | `frohmanian_tether_theorem`, `global_regularity_for_NS` | **PROVED FOR FLOWS SATISFYING TETHER RATE/BOUND (2 theorems)** | Proves $T^*(u_0, \nu) = \top$ and $u(t) \in C^\infty$ for all $t \ge 0$ for flows satisfying `frohmanianTetherBound` or `frohmanianTetherRate` plus local Kato/restart/uniqueness hypotheses. |

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
TOTAL theorems=341 nonstandard=0
'FrohmanianTether.CalderonZygmundConstant3D_eq_three_halves' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.kappa_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.tetherKernel_quadratic_form' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.tetherKernel_comm' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.tetherPointwiseDensity_nonpos' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.tetherPointwiseDensity_strict_neg_of_noncasimir' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.tetherKernel_diagonal_nonpos' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.tetherKernel_strict_neg_of_orthogonal_component' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.tetherKernel_nondegenerate_on_casimir_defect' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.uniqueness_of_minimal_tether' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.uniqueness_of_kernel_density' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.uniqueness_of_kernel_density_fun' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.tetherKernel_has_canonical_density' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.step2_degree_of_canonical_density' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.step2_degree' depends on axioms: [propext, Classical.choice, Quot.sound]
'FrohmanianTether.step5_higher_order' depends on axioms: [propext, Classical.choice, Quot.sound]
'AnalyticPipeline.youngs_absorption_elimination' depends on axioms: [propext, Classical.choice, Quot.sound]
'AnalyticPipeline.comparison_ode_stability' depends on axioms: [propext, Classical.choice, Quot.sound]
'AnalyticPipeline.comparison_ode_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
'TetheredLyapunov.hasDerivAt_quartic_tether_weight' depends on axioms: [propext, Classical.choice, Quot.sound]
'TetheredLyapunov.quartic_weight_source_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'TetheredLyapunov.global_regularity_of_restart' depends on axioms: [propext, Classical.choice, Quot.sound]
'TetheredLyapunov.global_regularity_of_constructions' depends on axioms: [propext, Classical.choice, Quot.sound]
'GlobalRegularity.frohmanian_tether_theorem' depends on axioms: [propext, Classical.choice, Quot.sound]
'GlobalRegularity.global_regularity_for_NS' depends on axioms: [propext, Classical.choice, Quot.sound]
'GlobalRegularity.global_regularity_for_NS_nonvacuous_at_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
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

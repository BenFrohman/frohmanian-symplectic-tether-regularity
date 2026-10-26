# titan-audit report: `frohmanian-symplectic-tether-regularity`

**Verdict: PASS_WITH_WARNINGS**

- Generated (UTC): 2026-10-26T00:01:12+00:00
- Tool: titan-audit 1.0.0 (Benjamin Stanley Frohman (ORCID: 0009-0006-7068-3718))
- Toolchain: `leanprover/lean4:v4.30.0-rc1`  Git HEAD: `None`
- Tree SHA-256: `898684ad2d3bdd69e77ab42bef2a864397c374467fe3d6eef113ec46d0bfb4ef` over 16 files

## Build

- Build skipped (`--no-build`); audit used existing .olean files.

## Axiom audit

- Modules: 12  Theorems: 341  Clean (only propext/Classical.choice/Quot.sound): 341
- Nonstandard: 0

| Module | Theorems | Nonstandard |
|---|---:|---:|
| `FrohmanianSymplecticTether.AnalyticPipeline` | 14 | 0 |
| `FrohmanianSymplecticTether.ArnoldGeometric` | 43 | 0 |
| `FrohmanianSymplecticTether.ClosureBlueprint` | 22 | 0 |
| `FrohmanianSymplecticTether.ForMathlib.Projection` | 7 | 0 |
| `FrohmanianSymplecticTether.GlobalRegularity` | 11 | 0 |
| `FrohmanianSymplecticTether.IndependentMajorant` | 2 | 0 |
| `FrohmanianSymplecticTether.NS_Equations` | 143 | 0 |
| `FrohmanianSymplecticTether.SymplecticTether` | 38 | 0 |
| `FrohmanianSymplecticTether.TetheredLyapunov` | 45 | 0 |
| `FrohmanianSymplecticTether.Uniqueness` | 16 | 0 |

## Source scan

Counts: real_iSup_without_BddAbove=5


### Vacuity heuristics (in build)

- real_iSup_without_BddAbove `FrohmanianSymplecticTether/NS_Equations.lean:2290` `Tstar`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.
- real_iSup_without_BddAbove `FrohmanianSymplecticTether/NS_Equations.lean:2801` `vorticity_sup_norm`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.
- real_iSup_without_BddAbove `FrohmanianSymplecticTether/NS_Equations.lean:2815` `strain_sup_norm`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.
- real_iSup_without_BddAbove `FrohmanianSymplecticTether/SymplecticTether.lean:776` `MollifiedSupNormFunctional`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.
- real_iSup_without_BddAbove `FrohmanianSymplecticTether/TetheredLyapunov.lean:502` `MollifiedSupNorm`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.

Heuristics are advisory: a flag means *look here*, not *wrong*.

## Signature

- ed25519 public key (base64): `c7BnJCTBz91GSJfR9q9g7XaE9b8u6r2wfKeXGzYuwKs=`
- Verify: `titan-audit verify report.json`

# titan-audit report: `frohmanian-symplectic-tether-regularity`

**Verdict: PASS_WITH_WARNINGS**

- Generated (UTC): 2026-10-30T19:17:27+00:00
- Tool: titan-audit 1.0.0 (Benjamin Stanley Frohman (ORCID: 0009-0006-7068-3718))
- Toolchain: `leanprover/lean4:v4.30.0-rc1`  Git HEAD: `e6da374ff5989335b1adbfc2fd8b86306f27e518`
- Tree SHA-256: `e4eb80e2edc4aa0d038511306f8135284ce970544c863b4ba538137efb863383` over 26 files

## Build

- Build skipped (`--no-build`); audit used existing .olean files.

## Axiom audit

- Modules: 22  Theorems: 614  Clean (only propext/Classical.choice/Quot.sound): 614
- Nonstandard: 0

| Module | Theorems | Nonstandard |
|---|---:|---:|
| `FrohmanianSymplecticTether.AnalyticPipeline` | 14 | 0 |
| `FrohmanianSymplecticTether.ArnoldGeometric` | 43 | 0 |
| `FrohmanianSymplecticTether.C2Analysis` | 18 | 0 |
| `FrohmanianSymplecticTether.ClosureBlueprint` | 22 | 0 |
| `FrohmanianSymplecticTether.FieldMetriplectic` | 100 | 0 |
| `FrohmanianSymplecticTether.FinalProductTheorem` | 26 | 0 |
| `FrohmanianSymplecticTether.ForMathlib.LeibnizGaussian` | 5 | 0 |
| `FrohmanianSymplecticTether.ForMathlib.Leray` | 9 | 0 |
| `FrohmanianSymplecticTether.ForMathlib.PiUL2` | 11 | 0 |
| `FrohmanianSymplecticTether.ForMathlib.Projection` | 7 | 0 |
| `FrohmanianSymplecticTether.GateauxRepresentative` | 17 | 0 |
| `FrohmanianSymplecticTether.GlobalRegularity` | 11 | 0 |
| `FrohmanianSymplecticTether.IndependentMajorant` | 2 | 0 |
| `FrohmanianSymplecticTether.NS_Equations` | 148 | 0 |
| `FrohmanianSymplecticTether.Stage6Calculus` | 35 | 0 |
| `FrohmanianSymplecticTether.SymplecticTether` | 36 | 0 |
| `FrohmanianSymplecticTether.TetheredLyapunov` | 58 | 0 |
| `FrohmanianSymplecticTether.Uniqueness` | 17 | 0 |
| `FrohmanianSymplecticTether.UniquenessC123` | 7 | 0 |
| `FrohmanianSymplecticTether.VelocityTether` | 28 | 0 |

## Source scan

Counts: real_iSup_without_BddAbove=5


### Vacuity heuristics (in build)

- real_iSup_without_BddAbove `FrohmanianSymplecticTether/NS_Equations.lean:2291` `Tstar`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.
- real_iSup_without_BddAbove `FrohmanianSymplecticTether/NS_Equations.lean:2802` `vorticity_sup_norm`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.
- real_iSup_without_BddAbove `FrohmanianSymplecticTether/NS_Equations.lean:2816` `strain_sup_norm`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.
- real_iSup_without_BddAbove `FrohmanianSymplecticTether/SymplecticTether.lean:773` `MollifiedSupNormFunctional`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.
- real_iSup_without_BddAbove `FrohmanianSymplecticTether/TetheredLyapunov.lean:504` `MollifiedSupNorm`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.

Heuristics are advisory: a flag means *look here*, not *wrong*.

## Signature

- ed25519 public key (base64): `ZOyujV1yUEldQRZEDhmXCHa4ikWGfcTD+meZYssNLpo=`
- Verify: `titan-audit verify report.json`

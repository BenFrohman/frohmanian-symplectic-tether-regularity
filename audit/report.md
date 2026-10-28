# titan-audit report: `frohmanian-symplectic-tether-regularity`

**Verdict: PASS_WITH_WARNINGS**

- Generated (UTC): 2026-10-28T23:16:44+00:00
- Tool: titan-audit 1.0.0 (Benjamin Stanley Frohman (ORCID: 0009-0006-7068-3718))
- Toolchain: `leanprover/lean4:v4.30.0-rc1`  Git HEAD: `e3d50ad88764e27473c2ed887cda8c8afee40792`
- Tree SHA-256: `ae053ed6fa22271711db3e37cacadf02cff28ca767a12f753b2ef86e6b5db551` over 18 files

## Build

- Build skipped (`--no-build`); audit used existing .olean files.

## Axiom audit

- Modules: 14  Theorems: 402  Clean (only propext/Classical.choice/Quot.sound): 402
- Nonstandard: 0

| Module | Theorems | Nonstandard |
|---|---:|---:|
| `FrohmanianSymplecticTether.AnalyticPipeline` | 14 | 0 |
| `FrohmanianSymplecticTether.ArnoldGeometric` | 43 | 0 |
| `FrohmanianSymplecticTether.ClosureBlueprint` | 22 | 0 |
| `FrohmanianSymplecticTether.FinalProductTheorem` | 26 | 0 |
| `FrohmanianSymplecticTether.ForMathlib.Projection` | 7 | 0 |
| `FrohmanianSymplecticTether.GlobalRegularity` | 11 | 0 |
| `FrohmanianSymplecticTether.IndependentMajorant` | 2 | 0 |
| `FrohmanianSymplecticTether.NS_Equations` | 143 | 0 |
| `FrohmanianSymplecticTether.Stage6Calculus` | 35 | 0 |
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

- ed25519 public key (base64): `ZOyujV1yUEldQRZEDhmXCHa4ikWGfcTD+meZYssNLpo=`
- Verify: `titan-audit verify report.json`

# titan-audit report: `frohmanian-symplectic-tether-regularity`

**Verdict: PASS_WITH_WARNINGS**

- Generated (UTC): 2026-10-30T18:33:05+00:00
- Tool: titan-audit 1.0.0 (Benjamin Stanley Frohman (ORCID: 0009-0006-7068-3718))
- Toolchain: `leanprover/lean4:v4.30.0-rc1`  Git HEAD: `af74755b3ea7a15ac880badcb0672772e489a464`
- Tree SHA-256: `4d4759604e793c6c1d9c22f6e304a2248d0085344a926f853bc97e2a8f5c5759` over 25 files

## Build

- Build skipped (`--no-build`); audit used existing .olean files.

## Axiom audit

- Modules: 21  Theorems: 587  Clean (only propext/Classical.choice/Quot.sound): 587
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
| `FrohmanianSymplecticTether.GlobalRegularity` | 11 | 0 |
| `FrohmanianSymplecticTether.IndependentMajorant` | 2 | 0 |
| `FrohmanianSymplecticTether.NS_Equations` | 143 | 0 |
| `FrohmanianSymplecticTether.Stage6Calculus` | 35 | 0 |
| `FrohmanianSymplecticTether.SymplecticTether` | 36 | 0 |
| `FrohmanianSymplecticTether.TetheredLyapunov` | 53 | 0 |
| `FrohmanianSymplecticTether.Uniqueness` | 17 | 0 |
| `FrohmanianSymplecticTether.UniquenessC123` | 7 | 0 |
| `FrohmanianSymplecticTether.VelocityTether` | 28 | 0 |

## Source scan

Counts: real_iSup_without_BddAbove=5


### Vacuity heuristics (in build)

- real_iSup_without_BddAbove `FrohmanianSymplecticTether/NS_Equations.lean:2290` `Tstar`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.
- real_iSup_without_BddAbove `FrohmanianSymplecticTether/NS_Equations.lean:2801` `vorticity_sup_norm`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.
- real_iSup_without_BddAbove `FrohmanianSymplecticTether/NS_Equations.lean:2815` `strain_sup_norm`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.
- real_iSup_without_BddAbove `FrohmanianSymplecticTether/SymplecticTether.lean:773` `MollifiedSupNormFunctional`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.
- real_iSup_without_BddAbove `FrohmanianSymplecticTether/TetheredLyapunov.lean:504` `MollifiedSupNorm`: Real iSup/sSup is 0 on unbounded ranges; downstream bounds on it may be vacuous unless BddAbove is required.

Heuristics are advisory: a flag means *look here*, not *wrong*.

## Signature

- ed25519 public key (base64): `YoEHEghXFxrXvYKQoWQb+oDunzwdxBgpk03gxrdC7WI=`
- Verify: `titan-audit verify report.json`

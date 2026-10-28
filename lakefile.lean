import Lake
open Lake DSL

package «FrohmanianSymplecticTether» where
  version := v!"1.1.0"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.30.0-rc1"

@[default_target]
lean_lib «FrohmanianSymplecticTether» where
  roots := #[`FrohmanianSymplecticTether]

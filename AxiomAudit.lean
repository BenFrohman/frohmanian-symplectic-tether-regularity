/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/

-- In-Kernel Metaprogramming Axiom Audit (`Lean.collectAxioms` over `ConstantInfo.thmInfo`).
-- Run: `lake env lean AxiomAudit.lean`
-- Fails with non-zero exit if any theorem in the `FrohmanianSymplecticTether` module tree depends on
-- axioms outside {propext, Classical.choice, Quot.sound} (such as sorryAx or Lean.trustCompiler).

import Lean
import FrohmanianSymplecticTether

open Lean Elab Command

#eval show CommandElabM Unit from do
  let env ← getEnv
  let mut stats : Std.HashMap Name (Nat × Nat) := {}
  let mut bad : Array String := #[]
  for (n, ci) in env.constants.toList do
    if n.isInternal then continue
    let some idx := env.getModuleIdxFor? n | continue
    let mod := env.header.moduleNames[idx.toNat]!
    unless (`FrohmanianSymplecticTether).isPrefixOf mod do continue
    unless ci matches .thmInfo _ do continue
    let axs ← liftCoreM <| Lean.collectAxioms n
    let nonstd := axs.filter (fun a => a ∉ [``propext, ``Classical.choice, ``Quot.sound])
    let (c, b) := stats.getD mod (0, 0)
    stats := stats.insert mod (c + 1, if nonstd.isEmpty then b else b + 1)
    unless nonstd.isEmpty do bad := bad.push s!"{n} : {nonstd}"
  for (m, (c, b)) in stats.toList do
    IO.println s!"{m}: theorems={c} nonstandard={b}"
  for s in bad do
    IO.println s
  let total := stats.fold (fun acc _ (c, _) => acc + c) 0
  IO.println s!"TOTAL theorems={total} nonstandard={bad.size}"
  unless bad.isEmpty do
    throwError "axiom audit FAILED: {bad.size} theorem(s) use non-standard axioms"

-- Explicit #print axioms checks on all primary exported theorems:
#print axioms FrohmanianTether.CalderonZygmundConstant3D_eq_three_halves
#print axioms FrohmanianTether.kappa_pos_of_eq_CZ
#print axioms FrohmanianTether.tetherKernel_quadratic_form
#print axioms FrohmanianTether.tetherKernel_comm
#print axioms FrohmanianTether.tetherPointwiseDensity_nonpos
#print axioms FrohmanianTether.tetherPointwiseDensity_strict_neg_of_noncasimir
#print axioms FrohmanianTether.tetherKernel_diagonal_nonpos
#print axioms FrohmanianTether.tetherKernel_strict_neg_of_orthogonal_component
#print axioms FrohmanianTether.tetherKernel_nondegenerate_on_casimir_defect
#print axioms FrohmanianTether.uniqueness_of_minimal_tether
#print axioms FrohmanianTether.uniqueness_of_minimal_symmetric_tether
#print axioms FrohmanianTether.uniqueness_of_kernel_density
#print axioms FrohmanianTether.uniqueness_of_kernel_density_fun
#print axioms FrohmanianTether.tetherKernel_has_canonical_density
#print axioms FrohmanianTether.step2_degree_of_canonical_density
#print axioms FrohmanianTether.step2_degree
#print axioms FrohmanianTether.step2_degree_of_ne_zero
#print axioms FrohmanianTether.step5_higher_order
#print axioms FrohmanianTether.tethered_reproduces_classical_euler
#print axioms AnalyticPipeline.youngs_absorption_elimination
#print axioms AnalyticPipeline.holder_I4
#print axioms AnalyticPipeline.comparison_ode_stability
#print axioms AnalyticPipeline.comparison_ode_nonneg
#print axioms TetheredLyapunov.hasDerivAt_quartic_tether_weight
#print axioms TetheredLyapunov.quartic_weight_source_eq
#print axioms TetheredLyapunov.global_regularity_of_restart
#print axioms TetheredLyapunov.global_regularity
#print axioms TetheredLyapunov.global_regularity_of_bkmIntegrability
#print axioms TetheredLyapunov.global_regularity_of_bkm_uniqueness
#print axioms TetheredLyapunov.Tstar_top_of_restart_without_vorticity_bound
#print axioms NavierStokes3D.beale_kato_majda_scaffold_integrability_unused
#print axioms NavierStokes3D.Tstar_eq_top_of_bkm
#print axioms TetheredLyapunov.finiteTimeVorticityBound_of_uniform
#print axioms TetheredLyapunov.physicalFiniteTimeVorticityBound_of_uniform
#print axioms TetheredLyapunov.bkmIntegrability_of_finiteTime
#print axioms TetheredLyapunov.physicalBKMIntegrability_of_finiteTime
#print axioms TetheredLyapunov.global_regularity_of_constructions
#print axioms GlobalRegularity.frohmanian_tether_theorem
#print axioms GlobalRegularity.global_regularity_for_NS
#print axioms GlobalRegularity.global_regularity_for_NS_nonvacuous_at_zero
#print axioms GlobalRegularity.stepField_not_physical
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.kksSymplecticForm_skew
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.kksPointwise_cyclic_jacobi_identity
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.FrohmanianMetriplecticPairing_diag_eq_metric
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.frohmanian_metriplectic_system_canonical_uniqueness_and_global_regularity_product_theorem
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.unitCube_nonempty
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.bddAbove_range_norm_of_attained_max
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.vorticity_sup_norm_eq_of_isSpatialMax
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.polar_pythagoras_directional_deriv
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.polar_pythagoras_3d_sum
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.bochner_laplacian_3d_identity
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.concrete_bochner_polar_viscous_damping_at_max
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.beltrami_lamb_vector_cross_zero
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.beltrami_casimir_projection_zero
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.beltrami_tetherPointwiseDensity_zero
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.constVelocity_ne_zero
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.navier_stokes_eq_constVelocity
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.nonzero_smooth_ns_solution_exists
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.near_field_stretching_absorbed_by_viscous_direction_damping
#print axioms FrohmanianSymplecticTether.FinalProductTheorem.constantin_fefferman_near_far_cutoff_bridge

#print axioms FrohmanianSymplecticTether.Stage6.polar_pythagoras_of_hasDerivAt
#print axioms FrohmanianSymplecticTether.Stage6.bochner_leibniz_of_hasDerivAt
#print axioms FrohmanianSymplecticTether.Stage6.shearU_heat
#print axioms FrohmanianSymplecticTether.Stage6.shear_beltrami
#print axioms FrohmanianSymplecticTether.Stage6.inner_eq_zero_of_hasDerivAt_of_norm_eq_one
#print axioms FrohmanianSymplecticTether.Stage6.norm_polar_deriv_sq_eq_of_hasDerivAt
#print axioms FrohmanianSymplecticTether.Stage6.hasDerivAt_inner_self_deriv_of_hasDerivAt
#print axioms FrohmanianSymplecticTether.Stage6.isShearBeltramiMode
#print axioms ForMathlib.Pi_u_ae_eq_PiL2
#print axioms ForMathlib.lerayL2_fixes_test
#print axioms FrohmanianTether.c1_c3_not_unique
#print axioms FrohmanianTether.uniqueness_of_two_sided_feedback
#print axioms FrohmanianTether.step5_higher_order_vanishes
#print axioms FrohmanianTether.step5_tetherKernel
#print axioms ForMathlib.integral_heatKernel1D
#print axioms FrohmanianTether.Pi_u_smul_self
#print axioms FrohmanianTether.tetherKernel_C2_of_parallel
#print axioms FrohmanianTether.tetherKernelVel_C2
#print axioms FrohmanianTether.curlZ_psiS
#print axioms FrohmanianTether.curlZ_uS
#print axioms FrohmanianTether.integral_quad_cos
#print axioms FrohmanianTether.pair_psi_u
#print axioms FrohmanianTether.norm_u
#print axioms FrohmanianTether.coefS_eq
#print axioms FrohmanianTether.shearTetherHH_eq
#print axioms FrohmanianTether.shear_C2_fails
#print axioms FrohmanianTether.shear_velocity_slot_coef
#print axioms FrohmanianTether.hasDerivAt_sin_mul
#print axioms FrohmanianTether.hasDerivAt_cos_mul
#print axioms FrohmanianTether.velSlot
#print axioms FrohmanianTether.tetherKernelVel_comm
#print axioms FrohmanianTether.tetherKernelVel_quadratic_form
#print axioms FrohmanianTether.tetherKernelVel_diag_nonpos
#print axioms FrohmanianTether.velPointwiseDensity_strict_neg
#print axioms FrohmanianTether.tetherKernelVel_C1
#print axioms FrohmanianTether.tetherKernelVel_C3
#print axioms FrohmanianTether.tetherKernelVel_feedbackAtMost
#print axioms FrohmanianTether.tetherKernelVel_C2_at
#print axioms FrohmanianTether.tetherKernelVel_degenerate
#print axioms FrohmanianTether.tetherKernelVel_polarizes_at
#print axioms FrohmanianTether.tetherKernelVel_polarizes
#print axioms FrohmanianTether.uniqueness_vel
#print axioms FrohmanianTether.c1_c3_not_unique_vel
#print axioms FrohmanianTether.c1_c3_not_unique_vel_of_curl
#print axioms FrohmanianTether.velSlot_scale
#print axioms FrohmanianTether.step2_degree_vel
#print axioms FrohmanianTether.step5_tetherKernelVel
#print axioms FrohmanianTether.metriplecticPairingVel_diag
#print axioms FrohmanianTether.tetheredBracketVel_energy
#print axioms FrohmanianTether.velocity_tether_product_theorem
#print axioms FrohmanianTether.not_gateauxRepresentativeUnique
#print axioms FrohmanianTether.not_streamFunctionRepresentative
#print axioms FrohmanianTether.isGateauxRepresentative_of_not_differentiable
#print axioms FrohmanianTether.regularRep_unique
#print axioms FrohmanianTether.regularFunctionalDerivative_eq
#print axioms FrohmanianTether.kineticEnergyCurlIdentityReg_of_regularStream

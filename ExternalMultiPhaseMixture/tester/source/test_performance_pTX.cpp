// Source file for gtests that evaluate MultiPhaseMixtureMedium_calcThermoProperties_pTX_C_impl() performance

#include "ExternalMultiPhaseMixtureTester.h"
#include "stopwatch.h"

// Macro for easy call to pTX function
#define CALL_CALC_THERMO_PROPERTIES_PTX() \
    MultiPhaseMixtureMedium_calcThermoProperties_pTX_C_impl( \
    p, T, X, size_X, X_unit, phase_id, material, \
    &p_overall_out, &T_overall_out, &d_overall_out, &h_overall_out, &s_overall_out, \
    d_1ph_out, h_1ph_out, s_1ph_out, Pr_1ph_out, a_1ph_out, beta_1ph_out, cp_1ph_out, cv_1ph_out, \
    kappa_1ph_out, lambda_1ph_out, eta_1ph_out, dpdT_dN_1ph_out, dpdd_TN_1ph_out, \
    &nbrOfPresentPhases_out, presentPhaseIndex_out, phaseCompositions_out, phaseFractions_out)

#if FLUIDPROP || CAPEOPEN
static void do_StanMix_test(const char *libraryName) {
    // Test toluene calculations in StanMix through FluidProp
    const char *compounds = "toluene";
    const char *setupInfo = "UnitBasis=2";

    // Inputs:
    double p = 1e+5;
    double T = 288.15;
    double X[] = { 1.0 };
    const size_t size_X = 1;
    int X_unit = Units::MASSFRACTION; // Mass fractions
    int phase_id = 0;
    void *material = getMaterial(libraryName, compounds, setupInfo);

    // Outputs:
    CALC_THERMO_PROPERTIES_OUTPUTS(size_X);

    // Library call:
    int ntimes = 100;
    stopwatch sw = stopwatch::startNew();
    for (int i = 0; i < ntimes; i++) {
        CALL_CALC_THERMO_PROPERTIES_PTX();
    }
    printf("\t\t\t\t\t\t\t\t\tTime elapsed:%6ld ms\n", sw.elapsed_ms());

    // Check outputs:
    EXPECT_NEAR(1e+5, p_overall_out, ABS_P_ERROR);
    EXPECT_NEAR(288.15, T_overall_out, ABS_T_ERROR);
    EXPECT_NEAR(866.6925, d_overall_out, ABS_D_ERROR);
    EXPECT_NEAR(-426484.4, h_overall_out, ABS_H_ERROR);
    EXPECT_NEAR(-1136.518, s_overall_out, ABS_S_ERROR);

    closeMaterial(material);
}
#endif // FLUIDPROP || CAPEOPEN

#if FLUIDPROP
TEST(test_performance_pTX, FluidProp_StanMix_0) {
    do_StanMix_test("FluidProp.FreeStanMix");
}
#endif // FLUIDPROP
#if CAPEOPEN
TEST(test_performance_pTX, CapeOpen_FluidProp_StanMix_0) {
    do_StanMix_test("CapeOpen.FluidProp Thermo System//freeStanMix");
}
TEST(test_performance_pTX, CapeOpen_StanMix_0) {
    do_StanMix_test("CapeOpen.StanMix Thermo Property Package");
}
#endif // CAPEOPEN

#if FLUIDPROP || CAPEOPEN || REFPROP
static void do_RefProp_test(const char *libraryName) {
    // Test toluene calculations in RefProp
    const char *compounds = "toluene.fld";
    const char *setupInfo = "UnitBasis=2";

    // Inputs:
    double p = 1e+5;
    double T = 288.15;
    double X[] = {1.0};
    const size_t size_X = 1;
    int X_unit = Units::MASSFRACTION; // Mass fractions
    int phase_id = 0;
    void *material = getMaterial(libraryName, compounds, setupInfo);

    // Outputs:
    CALC_THERMO_PROPERTIES_OUTPUTS(size_X);

    // Library call:
    int ntimes = 100;
    stopwatch sw = stopwatch::startNew();
    for (int i = 0; i < ntimes; i++) {
        CALL_CALC_THERMO_PROPERTIES_PTX();
    }
    printf("\t\t\t\t\t\t\t\t\tTime elapsed:%6ld ms\n", sw.elapsed_ms());

    // Check outputs:
    EXPECT_NEAR(1e+5, p_overall_out, ABS_P_ERROR);
    EXPECT_NEAR(288.15, T_overall_out, ABS_T_ERROR);
    EXPECT_NEAR(871.53, d_overall_out, ABS_D_ERROR);
    EXPECT_NEAR(-175018.14, h_overall_out, ABS_H_ERROR);
    EXPECT_NEAR(-522.2437, s_overall_out, ABS_S_ERROR);

    closeMaterial(material);
}
#endif // FLUIDPROP || CAPEOPEN || REFPROP

#if REFPROP
TEST(test_performance_pTX, RefProp_0) {
    do_RefProp_test("RefProp");
}
#endif // REFPROP
#if FLUIDPROP
TEST(test_performance_pTX, FluidProp_RefProp_0) {
    do_RefProp_test("FluidProp.RefProp");
}
#endif // FLUIDPROP
#if CAPEOPEN
TEST(test_performance_pTX, CapeOpen_FluidProp_RefProp_0) {
    do_RefProp_test("CapeOpen.FluidProp Thermo System//RefProp");
}
TEST(test_performance_pTX, CapeOpen_RefProp_0) {
    do_RefProp_test("CapeOpen.RefProp Thermo Property Package");
}
#endif // CAPEOPEN

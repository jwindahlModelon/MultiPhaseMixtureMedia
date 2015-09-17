// Source file for gtests that evaluate MultiPhaseMixtureMedium_calcThermoProperties_pTX_C_impl() performance

#include "ExternalMultiPhaseMixtureTester.h"

#if (FLUIDPROP == 1 || CAPEOPEN == 1)
static void run_test_getFluidPropPhaseProperties()
{
    // Get Material object
    void *material = getMaterial("FluidProp.PCP-SAFT", "nitrogen/argon/oxygen", "UnitBasis=2");

    char phase[2][16];
    char *phases[2] = { phase[0], phase[1] };
    
    char aggr[2][16];
    char *aggrs[2] = { aggr[0], aggr[1] };
    
    MultiPhaseMixtureMedium_getPhaseProperties_C_impl(material, phases, aggrs, 2);

    const char* ref[2] = { "Vapor", "Liquid" };
    
    EXPECT_STREQ(ref[0], phases[0]);
    EXPECT_STREQ(ref[1], phases[1]);
    EXPECT_STREQ(ref[0], aggrs[0]);
    EXPECT_STREQ(ref[1], aggrs[1]);
}
#endif // FLUIDPROP == 1 || CAPEOPEN == 1

#if (CAPEOPEN == 1)
static void run_test_getCapeOpenPhaseProperties()
{
    // Get Material object
    void *material = getMaterial("CapeOpen.FluidProp Thermo System//PCP-SAFT", "nitrogen/argon/oxygen", "UnitBasis=2");

    char phase[3][16];
    char *phases[3] = { phase[0], phase[1], phase[2] };

    char aggr[3][16];
    char *aggrs[3] = { aggr[0], aggr[1], aggr[2] };

    MultiPhaseMixtureMedium_getPhaseProperties_C_impl(material, phases, aggrs, 3);

    const char* ref[3] = { "Vapor", "Liquid", "Solid" };

    EXPECT_STREQ(ref[0], phases[0]);
    EXPECT_STREQ(ref[1], phases[1]);
    EXPECT_STREQ(ref[2], phases[2]);
    EXPECT_STREQ(ref[0], aggrs[0]);
    EXPECT_STREQ(ref[1], aggrs[1]);
    EXPECT_STREQ(ref[2], aggrs[2]);
}
#endif // CAPEOPEN == 1

#if (FLUIDPROP == 1)
TEST(test_general, FluidProp_TwoMaterialObjects)
{
    // Test to see whether instantiation of two material objects for the same fluid works correctly

    void *material1 = getMaterial("FluidProp.PCP-SAFT", "nitrogen/oxygen", "UnitBasis=2");
    void *material2 = getMaterial("FluidProp.PCP-SAFT", "nitrogen/oxygen", "UnitBasis=2");

    const double X[2] = { 0.5, 0.5 };
    double mm1 = MultiPhaseMixtureMedium_averageMolarMass_X_C_impl(X, 2, 0, material1);
    double mm2 = MultiPhaseMixtureMedium_averageMolarMass_X_C_impl(X, 2, 0, material2);

    closeMaterial(material1);
    closeMaterial(material2);

    EXPECT_NEAR(0.03, mm1, 1e-5);
    EXPECT_NEAR(0.03, mm2, 1e-5);
    EXPECT_NEAR(mm1, mm2, 1e-16);
}
#endif // FLUIDPROP == 1


#if (FLUIDPROP == 1)
TEST(test_general, FluidProp_PhaseProps)
{
    run_test_getFluidPropPhaseProperties();
}
#endif // FLUIDPROP == 1
#if (CAPEOPEN == 1)
TEST(test_general, CapeOpen_PhaseProps)
{
    run_test_getCapeOpenPhaseProperties();
}
#endif // CAPEOPEN == 1


// Source file for gtests that evaluate MultiPhaseMixtureMedium_calcThermoProperties_dTX_C_impl()

#include "ExternalMultiPhaseMixtureTester.h"
#include "CalcThermoProperties.h"

#define INPUTSPEC "dT"

#if (FLUIDPROP == 1)
TEST(test_calcThermoProperties_dTX, FluidProp_StanMix_moleBasis_Pure_0)
{
    run_test_stanmix_pure("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_dTX, FluidProp_StanMix_massBasis_0)
{
    run_test_stanmix_pure("FluidProp.freeStanMix", INPUTSPEC, Units::MASS);
}
TEST(test_calcThermoProperties_dTX, FluidProp_PCPSAFT_moleBasis_0)
{
    run_test_pcpsaft_pure("FluidProp.PCP-SAFT", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_dTX, FluidProp_PCPSAFT_massBasis_0)
{
    run_test_pcpsaft_pure("FluidProp.PCP-SAFT", INPUTSPEC, Units::MASS);
}
#endif // FLUIDPROP == 1

#if (CAPEOPEN == 1)
TEST(test_calcThermoProperties_dTX, CapeOpen_FluidProp_StanMix_moleBasis_0)
{
    run_test_stanmix_pure("CapeOpen.FluidProp Thermo System//freeStanMix", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_dTX, CapeOpen_FluidProp_StanMix_massBasis_0)
{
    run_test_stanmix_pure("CapeOpen.FluidProp Thermo System//freeStanMix", INPUTSPEC, Units::MASS);
}
TEST(test_calcThermoProperties_dTX, CapeOpen_StanMix_moleBasis_0)
{
    run_test_stanmix_pure("CapeOpen.StanMix Thermo Property Package", INPUTSPEC, Units::MOLE);

}
TEST(test_calcThermoProperties_dTX, CapeOpen_StanMix_massBasis_0)
{
    run_test_stanmix_pure("CapeOpen.StanMix Thermo Property Package", INPUTSPEC, Units::MASS);
}
TEST(test_calcThermoProperties_dTX, CapeOpen_FluidProp_PCPSAFT_moleBasis_0)
{
    run_test_pcpsaft_pure("CapeOpen.FluidProp Thermo System//PCP-SAFT", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_dTX, CapeOpen_FluidProp_PCPSAFT_massBasis_0)
{
    run_test_pcpsaft_pure("CapeOpen.FluidProp Thermo System//PCP-SAFT", INPUTSPEC, Units::MASS);
}
TEST(test_calcThermoProperties_dTX, CapeOpen_PCPSAFT_moleBasis_0)
{
    run_test_pcpsaft_pure("CapeOpen.PCP-SAFT Thermo Property Package", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_dTX, CapeOpen_PCPSAFT_massBasis_0)
{
    run_test_pcpsaft_pure("CapeOpen.PCP-SAFT Thermo Property Package", INPUTSPEC, Units::MASS);
}
#endif // CAPEOPEN == 1

/*
* Mixture tests
*/
#if (FLUIDPROP == 1)
TEST(test_calcThermoProperties_dTX, FluidProp_StanMix_moleBasis_Mixture_moleFractionBasisX)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_stanmix_mixture1("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_dTX, FluidProp_StanMix_moleBasis_Mixture_massFractionBasisX)
{
    Units::Basis X_unit = Units::MASSFRACTION; // Mass fraction based fractions
    run_test_stanmix_mixture1("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_dTX, FluidProp_StanMix_moleBasis_Mixture_moleBasisX)
{
    Units::Basis X_unit = Units::MOLE; // Mass fraction based fractions
    run_test_stanmix_mixture1("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_dTX, FluidProp_StanMix_moleBasis_Mixture_massBasisX)
{
    Units::Basis X_unit = Units::MASS; // Mass fraction based fractions
    run_test_stanmix_mixture1("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_dTX, FluidProp_StanMix_moleBasis_Mixture_moleFractionBasisX_1)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_stanmix_mixture2("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_dTX, FluidProp_GasMix_moleBasis_Mixture_moleFractionBasisX_0)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_gasmix_mixture1("FluidProp.GasMix", INPUTSPEC, Units::MOLE, X_unit);
}
#endif // FLUIDPROP == 1

#if (CAPEOPEN == 1)
/* TODO: fix bug
TEST(test_calcThermoProperties_dTX, CapeOpen_StanMix_moleBasis_Mixture_moleFractionBasisX_0) 
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_stanmix_mixture1("CapeOpen.FluidProp Thermo System//freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_dTX, CapeOpen_StanMix_moleBasis_Mixture_moleFractionBasisX_1)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_stanmix_mixture2("CapeOpen.FluidProp Thermo System//freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
*/
TEST(test_calcThermoProperties_dTX, CapeOpen_GasMix_moleBasis_Mixture_moleFractionBasisX_0) 
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_gasmix_mixture1("CapeOpen.FluidProp Thermo System//GasMix", INPUTSPEC, Units::MOLE, X_unit);
}
/* TODO: fix bug in FP
TEST(test_calcThermoProperties_dTX, CapeOpen_PCPSAFT_moleBasis_Mixture_moleFractionBasisX_1) 
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_pcpsaft_air_mixture1("CapeOpen.FluidProp Thermo System//PCP-SAFT", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_dTX, CapeOpen_PCPSAFT_massBasis_Mixture_moleFractionBasisX_1) 
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_pcpsaft_air_mixture1("CapeOpen.FluidProp Thermo System//PCP-SAFT", INPUTSPEC, Units::MASS, X_unit);
}
*/
TEST(test_calcThermoProperties_dTX, CapeOpen_REFPROP_moleBasis_Mixture_moleFractionBasisX_1) 
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_refprop_air_mixture1("CapeOpen.FluidProp Thermo System//RefProp", INPUTSPEC, Units::MOLE, X_unit);
}
#endif // CAPEOPEN == 1

/* TODO: fix memory leak
#if (REFPROP == 1)
static void do_RefProp_massBasis_test_liquid()
{
    const char *compounds = "";
    const char *libraryName = "RefProp";
    const char *setupInfo = "mixture=air.mix|path=C:/Program Files (x86)/REFPROP/";
    void *material = getMaterial(libraryName, compounds, setupInfo);

    // Inputs:

    double X[] = {0.7557,0.0127,0.2316};
    const size_t size_X = 3;
    double d=874.53;
    double T=80;
    int X_unit = Units::MASS; // Mass fractions
    int phase_id = 0;

    // Outputs:
    CALC_THERMO_PROPERTIES_OUTPUTS(size_X);

    // Library call:
    CALL_CALC_THERMO_PROPERTIES_DTX();

    // Check outputs:
    EXPECT_NEAR(1000000, p_overall_out, 500); // big diff for pressure
    EXPECT_NEAR(T, T_overall_out, ABS_T_ERROR);
    EXPECT_NEAR(d, d_overall_out, ABS_D_ERROR);
    EXPECT_NEAR(-123620, h_overall_out, 5);
    EXPECT_NEAR(2996.8, s_overall_out, 1);

    closeMaterial(material);
}

static void do_RefProp_massBasis_test_vapor()
{
    const char *compounds = "";
    const char *libraryName = "RefProp";
    const char *setupInfo = "mixture=air.mix|path=C:/Program Files (x86)/REFPROP/";
    void *material = getMaterial(libraryName, compounds, setupInfo);

    // Inputs:

    double X[] = {0.7557,0.0127,0.2316};
    const size_t size_X = 3;
    double d=2.1877;
    double T=160;
    int X_unit = Units::MASS; // Mass fractions
    int phase_id = 0;

    // Outputs:
    CALC_THERMO_PROPERTIES_OUTPUTS(size_X);

    // Library call:
    CALL_CALC_THERMO_PROPERTIES_DTX();

    // Check outputs:
    EXPECT_NEAR(99999, p_overall_out, ABS_P_ERROR);
    EXPECT_NEAR(T, T_overall_out, ABS_T_ERROR);
    EXPECT_NEAR(d, d_overall_out, ABS_D_ERROR);
    EXPECT_NEAR(159360, h_overall_out, 5);
    EXPECT_NEAR(6237.4, s_overall_out, ABS_D_ERROR);

    closeMaterial(material);
}

static void do_RefProp_massBasis_test_2phase()
{

    const char *compounds = "";
    const char *libraryName = "RefProp";
    const char *setupInfo = "mixture=air.mix|path=C:/Program Files (x86)/REFPROP/";
    void *material = getMaterial(libraryName, compounds, setupInfo);

    // Inputs:

    double X[] = {0.7557,0.0127,0.2316};
    const size_t size_X = 3;
    double d=200;
    double T=100;
    int X_unit = Units::MASS; // Mass fractions
    int phase_id = 0;

    // Outputs:
    CALC_THERMO_PROPERTIES_OUTPUTS(size_X);

    // Library call:
    CALL_CALC_THERMO_PROPERTIES_DTX();

    // Check outputs:
    EXPECT_NEAR(656510, p_overall_out, ABS_P_ERROR);
    EXPECT_NEAR(T, T_overall_out, ABS_T_ERROR);
    EXPECT_NEAR(d, d_overall_out, ABS_D_ERROR);
    EXPECT_NEAR(-66496, h_overall_out, 5);
    EXPECT_NEAR(3618.5, s_overall_out, ABS_D_ERROR);
    double vap_quality = phaseFractions_out[1]; // mole based
    EXPECT_NEAR(0.1033, vap_quality, 0.001);

    closeMaterial(material);
}
#endif // REFPROP == 1

#if (REFPROP == 1)
TEST(test_calcThermoProperties_dTX, REFProp_liquid_massBasis_0)
{
    do_RefProp_massBasis_test_liquid();
}
TEST(test_calcThermoProperties_dTX, REFProp_vapor_massBasis_0)
{
    do_RefProp_massBasis_test_vapor();
}

TEST(test_calcThermoProperties_dTX, REFProp_2phase_massBasis_0)
{
    do_RefProp_massBasis_test_2phase();
}

#endif // REFPROP == 1
*/
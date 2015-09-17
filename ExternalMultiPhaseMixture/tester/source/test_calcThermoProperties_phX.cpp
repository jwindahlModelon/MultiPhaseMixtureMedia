// Source file for gtests that evaluate MultiPhaseMixtureMedium_calcThermoProperties_phX_C_impl()


#include "ExternalMultiPhaseMixtureTester.h"
#include "CalcThermoProperties.h"

#define INPUTSPEC "ph"

#if (FLUIDPROP == 1)
TEST(test_calcThermoProperties_phX, FluidProp_StanMix_moleBasis_Pure_0)
{
    run_test_stanmix_pure("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_phX, FluidProp_StanMix_massBasis_0)
{
    run_test_stanmix_pure("FluidProp.freeStanMix", INPUTSPEC, Units::MASS);
}
TEST(test_calcThermoProperties_phX, FluidProp_PCPSAFT_moleBasis_0)
{
    run_test_pcpsaft_pure("FluidProp.PCP-SAFT", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_phX, FluidProp_PCPSAFT_massBasis_0)
{
    run_test_pcpsaft_pure("FluidProp.PCP-SAFT", INPUTSPEC, Units::MASS);
}
#endif // FLUIDPROP == 1

#if (CAPEOPEN == 1)
TEST(test_calcThermoProperties_phX, CapeOpen_FluidProp_StanMix_moleBasis_0)
{
    run_test_stanmix_pure("CapeOpen.FluidProp Thermo System//freeStanMix", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_phX, CapeOpen_FluidProp_StanMix_massBasis_0)
{
    run_test_stanmix_pure("CapeOpen.FluidProp Thermo System//freeStanMix", INPUTSPEC, Units::MASS);
}
TEST(test_calcThermoProperties_phX, CapeOpen_StanMix_moleBasis_0)
{
    run_test_stanmix_pure("CapeOpen.StanMix Thermo Property Package", INPUTSPEC, Units::MOLE);

}
TEST(test_calcThermoProperties_phX, CapeOpen_StanMix_massBasis_0)
{
    run_test_stanmix_pure("CapeOpen.StanMix Thermo Property Package", INPUTSPEC, Units::MASS);
}
TEST(test_calcThermoProperties_phX, CapeOpen_FluidProp_PCPSAFT_moleBasis_0)
{
    run_test_pcpsaft_pure("CapeOpen.FluidProp Thermo System//PCP-SAFT", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_phX, CapeOpen_FluidProp_PCPSAFT_massBasis_0)
{
    run_test_pcpsaft_pure("CapeOpen.FluidProp Thermo System//PCP-SAFT", INPUTSPEC, Units::MASS);
}
TEST(test_calcThermoProperties_phX, CapeOpen_PCPSAFT_moleBasis_0)
{
    run_test_pcpsaft_pure("CapeOpen.PCP-SAFT Thermo Property Package", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_phX, CapeOpen_PCPSAFT_massBasis_0)
{
    run_test_pcpsaft_pure("CapeOpen.PCP-SAFT Thermo Property Package", INPUTSPEC, Units::MASS);
}
#endif // CAPEOPEN == 1

/*
* Mixture tests
*/
#if (FLUIDPROP == 1)
TEST(test_calcThermoProperties_phX, FluidProp_StanMix_moleBasis_Mixture_moleFractionBasisX)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_stanmix_mixture1("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_phX, FluidProp_StanMix_moleBasis_Mixture_massFractionBasisX)
{
    Units::Basis X_unit = Units::MASSFRACTION; // Mass fraction based fractions
    run_test_stanmix_mixture1("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_phX, FluidProp_StanMix_moleBasis_Mixture_moleBasisX)
{
    Units::Basis X_unit = Units::MOLE; // Mass fraction based fractions
    run_test_stanmix_mixture1("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_phX, FluidProp_StanMix_moleBasis_Mixture_massBasisX)
{
    Units::Basis X_unit = Units::MASS; // Mass fraction based fractions
    run_test_stanmix_mixture1("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_phX, FluidProp_StanMix_moleBasis_Mixture_moleFractionBasisX_1)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_stanmix_mixture2("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_phX, FluidProp_GasMix_moleBasis_Mixture_moleFractionBasisX_0)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_gasmix_mixture1("FluidProp.GasMix", INPUTSPEC, Units::MOLE, X_unit);
}
#endif // FLUIDPROP == 1

#if (CAPEOPEN == 1)
TEST(test_calcThermoProperties_phX, CapeOpen_StanMix_moleBasis_Mixture_moleFractionBasisX_0)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_stanmix_mixture1("CapeOpen.FluidProp Thermo System//freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_phX, CapeOpen_StanMix_moleBasis_Mixture_moleFractionBasisX_1)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_stanmix_mixture2("CapeOpen.FluidProp Thermo System//freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_phX, CapeOpen_GasMix_moleBasis_Mixture_moleFractionBasisX_0)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_gasmix_mixture1("CapeOpen.FluidProp Thermo System//GasMix", INPUTSPEC, Units::MOLE, X_unit);
}
#endif // CAPEOPEN == 1

/* TODO: fix memory leak
static void do_RefProp_PerMass_test_liquid()
{
    const char *compounds = "";
    const char *libraryName = "RefProp";
    const char *setupInfo = "mixture=air.mix|path=C:/Program Files (x86)/REFPROP/";
    void *material = getMaterial(libraryName, compounds, setupInfo);

    // Inputs:

    double X[] = {0.7557,0.0127,0.2316};
    const size_t size_X = 3;
    double p = 1000000;
    double h = -100000;
    int X_unit = Units::MASS; // Mass fractions
    int phase_id = 0;

    // Outputs:
    CALC_THERMO_PROPERTIES_OUTPUTS(size_X);

    // Library call:
    CALL_CALC_THERMO_PROPERTIES_PHX();

    // Check outputs:
    EXPECT_NEAR(p, p_overall_out, ABS_P_ERROR); // big diff for pressure
    EXPECT_NEAR(91.968, T_overall_out, ABS_T_ERROR);
    EXPECT_NEAR(816.21, d_overall_out, ABS_D_ERROR);
    EXPECT_NEAR(h, h_overall_out, ABS_H_ERROR);
    EXPECT_NEAR(3271.9, s_overall_out, 1);

    closeMaterial(material);
}

static void do_RefProp_PerMass_test_vapor()
{
    const char *compounds = "";
    const char *libraryName = "RefProp";
    const char *setupInfo = "mixture=air.mix|path=C:/Program Files (x86)/REFPROP/";
    void *material = getMaterial(libraryName, compounds, setupInfo);

    // Inputs:

    double X[] = {0.7557,0.0127,0.2316};
    const size_t size_X = 3;
    double p = 100000.0;
    double h = 100000;
    int X_unit = Units::MASS; // Mass fractions
    int phase_id = 0;

    // Outputs:
    CALC_THERMO_PROPERTIES_OUTPUTS(size_X);

    // Library call:
    CALL_CALC_THERMO_PROPERTIES_PHX();

    // Check outputs:
    EXPECT_NEAR(p, p_overall_out, ABS_P_ERROR);
    EXPECT_NEAR(101.7, T_overall_out, ABS_T_ERROR);
    EXPECT_NEAR(3.4929, d_overall_out, ABS_D_ERROR);
    EXPECT_NEAR(h, h_overall_out, ABS_H_ERROR);
    EXPECT_NEAR(5775.6, s_overall_out, ABS_D_ERROR);

    closeMaterial(material);
}

static void do_RefProp_PerMass_test_2phase()
{

    const char *compounds = "";
    const char *libraryName = "RefProp";
    const char *setupInfo = "mixture=air.mix|path=C:/Program Files (x86)/REFPROP/";
    void *material = getMaterial(libraryName, compounds, setupInfo);

    // Inputs:

    double X[] = {0.7557,0.0127,0.2316};
    const size_t size_X = 3;
    double p = 656510;
    double h = -66496;
    int X_unit = Units::MASS; // Mass fractions
    int phase_id = 0;

    // Outputs:
    CALC_THERMO_PROPERTIES_OUTPUTS(size_X);

    // Library call:
    CALL_CALC_THERMO_PROPERTIES_PHX();

    // Check outputs:
    EXPECT_NEAR(p, p_overall_out, ABS_P_ERROR);
    EXPECT_NEAR(100, T_overall_out, ABS_T_ERROR);
    EXPECT_NEAR(200, d_overall_out, ABS_D_ERROR);
    EXPECT_NEAR(h, h_overall_out, ABS_P_ERROR);
    EXPECT_NEAR(3618.5, s_overall_out, ABS_D_ERROR);
    double vap_quality = phaseFractions_out[1]; // mole based
    EXPECT_NEAR(0.1033, vap_quality, 0.001);

    closeMaterial(material);
}
#endif // REFPROP == 1

#if (REFPROP == 1)
TEST(test_calcThermoProperties_phX, REFProp_PerMole_0)
{
    do_RefProp_PerMass_test_liquid();
    do_RefProp_PerMass_test_vapor();
    do_RefProp_PerMass_test_2phase();
}
#endif // REFPROP == 1
*/
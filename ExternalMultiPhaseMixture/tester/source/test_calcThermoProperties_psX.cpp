// Source file for gtests that evaluate MultiPhaseMixtureMedium_calcThermoProperties_psX_C_impl()

#include "ExternalMultiPhaseMixtureTester.h"
#include "CalcThermoProperties.h"

#define INPUTSPEC "ps"

#if (FLUIDPROP == 1)
TEST(test_calcThermoProperties_psX, FluidProp_StanMix_moleBasis_Pure_0)
{
    run_test_stanmix_pure("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_psX, FluidProp_StanMix_massBasis_0)
{
    run_test_stanmix_pure("FluidProp.freeStanMix", INPUTSPEC, Units::MASS);
}
TEST(test_calcThermoProperties_psX, FluidProp_PCPSAFT_moleBasis_0)
{
    run_test_pcpsaft_pure("FluidProp.PCP-SAFT", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_psX, FluidProp_PCPSAFT_massBasis_0)
{
    run_test_pcpsaft_pure("FluidProp.PCP-SAFT", INPUTSPEC, Units::MASS);
}
#endif // FLUIDPROP == 1

#if (CAPEOPEN == 1)
TEST(test_calcThermoProperties_psX, CapeOpen_FluidProp_StanMix_moleBasis_0)
{
    run_test_stanmix_pure("CapeOpen.FluidProp Thermo System//freeStanMix", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_psX, CapeOpen_FluidProp_StanMix_massBasis_0)
{
    run_test_stanmix_pure("CapeOpen.FluidProp Thermo System//freeStanMix", INPUTSPEC, Units::MASS);
}
TEST(test_calcThermoProperties_psX, CapeOpen_StanMix_moleBasis_0)
{
    run_test_stanmix_pure("CapeOpen.StanMix Thermo Property Package", INPUTSPEC, Units::MOLE);

}
TEST(test_calcThermoProperties_psX, CapeOpen_StanMix_massBasis_0)
{
    run_test_stanmix_pure("CapeOpen.StanMix Thermo Property Package", INPUTSPEC, Units::MASS);
}
TEST(test_calcThermoProperties_psX, CapeOpen_FluidProp_PCPSAFT_moleBasis_0)
{
    run_test_pcpsaft_pure("CapeOpen.FluidProp Thermo System//PCP-SAFT", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_psX, CapeOpen_FluidProp_PCPSAFT_massBasis_0)
{
    run_test_pcpsaft_pure("CapeOpen.FluidProp Thermo System//PCP-SAFT", INPUTSPEC, Units::MASS);
}
TEST(test_calcThermoProperties_psX, CapeOpen_PCPSAFT_moleBasis_0)
{
    run_test_pcpsaft_pure("CapeOpen.PCP-SAFT Thermo Property Package", INPUTSPEC, Units::MOLE);
}
TEST(test_calcThermoProperties_psX, CapeOpen_PCPSAFT_massBasis_0)
{
    run_test_pcpsaft_pure("CapeOpen.PCP-SAFT Thermo Property Package", INPUTSPEC, Units::MASS);
}
#endif // CAPEOPEN == 1

/*
* Mixture tests
*/
#if (FLUIDPROP == 1)
TEST(test_calcThermoProperties_psX, FluidProp_StanMix_moleBasis_Mixture_moleFractionBasisX)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_stanmix_mixture1("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_psX, FluidProp_StanMix_moleBasis_Mixture_massFractionBasisX)
{
    Units::Basis X_unit = Units::MASSFRACTION; // Mass fraction based fractions
    run_test_stanmix_mixture1("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_psX, FluidProp_StanMix_moleBasis_Mixture_moleBasisX)
{
    Units::Basis X_unit = Units::MOLE; // Mass fraction based fractions
    run_test_stanmix_mixture1("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_psX, FluidProp_StanMix_moleBasis_Mixture_massBasisX)
{
    Units::Basis X_unit = Units::MASS; // Mass fraction based fractions
    run_test_stanmix_mixture1("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_psX, FluidProp_StanMix_moleBasis_Mixture_moleFractionBasisX_1)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_stanmix_mixture2("FluidProp.freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_psX, FluidProp_GasMix_moleBasis_Mixture_moleFractionBasisX_0)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_gasmix_mixture1("FluidProp.GasMix", INPUTSPEC, Units::MOLE, X_unit);
}
#endif // FLUIDPROP == 1

#if (CAPEOPEN == 1)
TEST(test_calcThermoProperties_psX, CapeOpen_StanMix_moleBasis_Mixture_moleFractionBasisX_0)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_stanmix_mixture1("CapeOpen.FluidProp Thermo System//freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_psX, CapeOpen_StanMix_moleBasis_Mixture_moleFractionBasisX_1)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_stanmix_mixture2("CapeOpen.FluidProp Thermo System//freeStanMix", INPUTSPEC, Units::MOLE, X_unit);
}
TEST(test_calcThermoProperties_psX, CapeOpen_GasMix_moleBasis_Mixture_moleFractionBasisX_0)
{
    Units::Basis X_unit = Units::MOLEFRACTION; // Mole based fractions
    run_test_gasmix_mixture1("CapeOpen.FluidProp Thermo System//GasMix", INPUTSPEC, Units::MOLE, X_unit);
}
#endif // CAPEOPEN == 1

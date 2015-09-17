// Source file for gtests

#include "ExternalMultiPhaseMixtureTester.h"
#include "CalcThermoProperties.h"
#include "Units.h"

#if (FLUIDPROP == 1 || CAPEOPEN == 1)

/**
 * Pure tests
 */
void run_test_pure(const char *libraryName, const char *compounds, const char *inputSpec, const TestProperties props, int basis)
{
    char setupInfo[256];
    sprintf_s(setupInfo, sizeof(setupInfo), "UnitBasis=%d;CodeLogging=true", basis);

    // fixed nputs:
    double X[] = { 1.0 };
    const size_t size_X = 1;
    int X_unit = Units::MOLEFRACTION; // Mole fractions
    int phase_id = 0;
    void *material = getMaterial(libraryName, compounds, setupInfo);

    // Outputs:
    CALC_THERMO_PROPERTIES_OUTPUTS(size_X);

    if(strcmp(inputSpec, "dT") == 0)
    {
        // inputs
        double d = props._d;
        double T = props._T;

        // Library call:
        CALL_CALC_THERMO_PROPERTIES_DTX();
    }

    if(strcmp(inputSpec, "ph") == 0)
    {
        // inputs
        double p = props._p;
        double h = props._h;

        // Library call:
        CALL_CALC_THERMO_PROPERTIES_PHX();
    }

    if(strcmp(inputSpec, "ps") == 0)
    {
        // inputs
        double p = props._p;
        double s = props._s;

        // Library call:
        CALL_CALC_THERMO_PROPERTIES_PSX();
    }

    if(strcmp(inputSpec, "pT") == 0)
    {
        // inputs
        double p = props._p;
        double T = props._T;

        // Library call:
        CALL_CALC_THERMO_PROPERTIES_PTX();
    }

    // Check outputs:

    if NOT_UNKNOWN(props._p) EXPECT_NEAR(props._p, p_overall_out, ABS_P_ERROR);
    if NOT_UNKNOWN(props._T) EXPECT_NEAR(props._T, T_overall_out, ABS_T_ERROR);
    if NOT_UNKNOWN(props._d) EXPECT_NEAR(props._d, d_overall_out, ABS_D_ERROR);
    if NOT_UNKNOWN(props._h) EXPECT_NEAR(props._h, h_overall_out, ABS_H_ERROR);
    if NOT_UNKNOWN(props._s) EXPECT_NEAR(props._s, s_overall_out, ABS_S_ERROR);

    EXPECT_EQ(1, nbrOfPresentPhases_out);
    EXPECT_EQ(LIQUID_INDEX + 1, presentPhaseIndex_out[0]);
    if NOT_UNKNOWN(props._phaseFractions_out[VAPOR_INDEX]) EXPECT_NEAR(props._phaseFractions_out[VAPOR_INDEX], phaseFractions_out[VAPOR_INDEX], ABS_ERROR);
    if NOT_UNKNOWN(props._phaseFractions_out[LIQUID_INDEX]) EXPECT_NEAR(props._phaseFractions_out[LIQUID_INDEX], phaseFractions_out[LIQUID_INDEX], ABS_ERROR);

    if NOT_UNKNOWN(d_overall_out) EXPECT_NEAR(d_overall_out, d_1ph_out[LIQUID_INDEX], ABS_D_ERROR);
    if NOT_UNKNOWN(h_overall_out) EXPECT_NEAR(h_overall_out, h_1ph_out[LIQUID_INDEX], ABS_H_ERROR);
    if NOT_UNKNOWN(s_overall_out) EXPECT_NEAR(s_overall_out, s_1ph_out[LIQUID_INDEX], ABS_S_ERROR);
    if NOT_UNKNOWN(p_overall_out) EXPECT_NEAR(p_overall_out, Pr_1ph_out[LIQUID_INDEX], ABS_D_ERROR);
    if NOT_UNKNOWN(props._a_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._a_1ph_out[LIQUID_INDEX], a_1ph_out[LIQUID_INDEX], ABS_A_ERROR);
    if NOT_UNKNOWN(props._beta_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._beta_1ph_out[LIQUID_INDEX], beta_1ph_out[LIQUID_INDEX], ABS_BETA_ERROR);
    if NOT_UNKNOWN(props._cp_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._cp_1ph_out[LIQUID_INDEX], cp_1ph_out[LIQUID_INDEX], ABS_CP_ERROR);
    if NOT_UNKNOWN(props._cv_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._cv_1ph_out[LIQUID_INDEX], cv_1ph_out[LIQUID_INDEX], ABS_CV_ERROR);
    if NOT_UNKNOWN(props._kappa_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._kappa_1ph_out[LIQUID_INDEX], kappa_1ph_out[LIQUID_INDEX], ABS_KAPPA_ERROR);
    if NOT_UNKNOWN(props._lambda_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._lambda_1ph_out[LIQUID_INDEX], lambda_1ph_out[LIQUID_INDEX], ABS_ERROR);
    if NOT_UNKNOWN(props._eta_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._eta_1ph_out[LIQUID_INDEX], eta_1ph_out[LIQUID_INDEX], ABS_ERROR);
    if NOT_UNKNOWN(props._dpdT_dN_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._dpdT_dN_1ph_out[LIQUID_INDEX], dpdT_dN_1ph_out[LIQUID_INDEX], ABS_DPDT_ERROR);
    if NOT_UNKNOWN(props._dpdd_TN_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._dpdd_TN_1ph_out[LIQUID_INDEX], dpdd_TN_1ph_out[LIQUID_INDEX], ABS_DPDD_ERROR);

    closeMaterial(material);
}

/**
 * Mixture tests
 */
void run_test_mixture(const char *libraryName, const char *compounds, const char *inputSpec, const TestProperties props, int basis, const double *X, int X_unit, const size_t size_X)
{
    // Test toluene calculations in StanMix through FluidProp
    //const char *compounds = "N2/O2/H2O/Ar/CO2";

    char setupInfo[256];
    sprintf_s(setupInfo, sizeof(setupInfo), "UnitBasis=%d;CodeLogging=true", basis);

    //const size_t size_X = 10; // max 10 components
    int phase_id = 0;
    void *material = getMaterial(libraryName, compounds, setupInfo);

    // Outputs:
    CALC_THERMO_PROPERTIES_OUTPUTS(10);

    if(strcmp(inputSpec, "dT") == 0)
    {
        // inputs
        double d = props._d;
        double T = props._T;

        // Library call:
        CALL_CALC_THERMO_PROPERTIES_DTX();
    }

    if(strcmp(inputSpec, "ph") == 0)
    {
        // inputs
        double p = props._p;
        double h = props._h;

        // Library call:
        CALL_CALC_THERMO_PROPERTIES_PHX();
    }

    if(strcmp(inputSpec, "ps") == 0)
    {
        // inputs
        double p = props._p;
        double s = props._s;

        // Library call:
        CALL_CALC_THERMO_PROPERTIES_PSX();
    }

    if(strcmp(inputSpec, "pT") == 0)
    {
        // inputs
        double p = props._p;
        double T = props._T;

        // Library call:
        CALL_CALC_THERMO_PROPERTIES_PTX();
    }

    // Check outputs:
    if NOT_UNKNOWN(props._p) EXPECT_NEAR(props._p, p_overall_out, ABS_P_ERROR);
	if NOT_UNKNOWN(props._T) EXPECT_NEAR(props._T, T_overall_out, ABS_T_ERROR);
	if NOT_UNKNOWN(props._d) EXPECT_NEAR(props._d, d_overall_out, ABS_D_ERROR);
	if NOT_UNKNOWN(props._h) EXPECT_NEAR(props._h, h_overall_out, ABS_H_ERROR);
	if NOT_UNKNOWN(props._s) EXPECT_NEAR(props._s, s_overall_out, ABS_S_ERROR);
	
    if (phaseFractions_out[VAPOR_INDEX] > 0.0) // Liquid phase present
    {
        // Check vapor index
        if NOT_UNKNOWN(d_overall_out) EXPECT_NEAR(d_overall_out, d_1ph_out[VAPOR_INDEX], ABS_D_ERROR);
        if NOT_UNKNOWN(h_overall_out) EXPECT_NEAR(h_overall_out, h_1ph_out[VAPOR_INDEX], ABS_H_ERROR);
        if NOT_UNKNOWN(s_overall_out) EXPECT_NEAR(s_overall_out, s_1ph_out[VAPOR_INDEX], ABS_S_ERROR);
        if NOT_UNKNOWN(p_overall_out) EXPECT_NEAR(p_overall_out, Pr_1ph_out[VAPOR_INDEX], ABS_D_ERROR);
        if NOT_UNKNOWN(props._a_1ph_out[VAPOR_INDEX]) EXPECT_NEAR(props._a_1ph_out[VAPOR_INDEX], a_1ph_out[VAPOR_INDEX], ABS_A_ERROR);
        if NOT_UNKNOWN(props._beta_1ph_out[VAPOR_INDEX]) EXPECT_NEAR(props._beta_1ph_out[VAPOR_INDEX], beta_1ph_out[VAPOR_INDEX], ABS_BETA_ERROR);
        if NOT_UNKNOWN(props._cp_1ph_out[VAPOR_INDEX]) EXPECT_NEAR(props._cp_1ph_out[VAPOR_INDEX], cp_1ph_out[VAPOR_INDEX], ABS_CP_ERROR);
        if NOT_UNKNOWN(props._cv_1ph_out[VAPOR_INDEX]) EXPECT_NEAR(props._cv_1ph_out[VAPOR_INDEX], cv_1ph_out[VAPOR_INDEX], ABS_CV_ERROR);
        if NOT_UNKNOWN(props._kappa_1ph_out[VAPOR_INDEX]) EXPECT_NEAR(props._kappa_1ph_out[VAPOR_INDEX], kappa_1ph_out[VAPOR_INDEX], ABS_KAPPA_ERROR);
        if NOT_UNKNOWN(props._lambda_1ph_out[VAPOR_INDEX]) EXPECT_NEAR(props._lambda_1ph_out[VAPOR_INDEX], lambda_1ph_out[VAPOR_INDEX], ABS_ERROR);
        if NOT_UNKNOWN(props._eta_1ph_out[VAPOR_INDEX]) EXPECT_NEAR(props._eta_1ph_out[VAPOR_INDEX], eta_1ph_out[VAPOR_INDEX], ABS_ERROR);
        if NOT_UNKNOWN(props._dpdT_dN_1ph_out[VAPOR_INDEX]) EXPECT_NEAR(props._dpdT_dN_1ph_out[VAPOR_INDEX], dpdT_dN_1ph_out[VAPOR_INDEX], ABS_DPDT_ERROR);
        if NOT_UNKNOWN(props._dpdd_TN_1ph_out[VAPOR_INDEX]) EXPECT_NEAR(props._dpdd_TN_1ph_out[VAPOR_INDEX], dpdd_TN_1ph_out[VAPOR_INDEX], ABS_DPDD_ERROR);
        if NOT_UNKNOWN(props._phaseFractions_out[VAPOR_INDEX]) EXPECT_NEAR(props._phaseFractions_out[VAPOR_INDEX], phaseFractions_out[VAPOR_INDEX], ABS_ERROR);
    }    
    
    if (phaseFractions_out[LIQUID_INDEX] > 0.0) // Liquid phase present
    {
        // Check liquid index
        if NOT_UNKNOWN(d_overall_out) EXPECT_NEAR(d_overall_out, d_1ph_out[LIQUID_INDEX], ABS_D_ERROR);
        if NOT_UNKNOWN(h_overall_out) EXPECT_NEAR(h_overall_out, h_1ph_out[LIQUID_INDEX], ABS_H_ERROR);
        if NOT_UNKNOWN(s_overall_out) EXPECT_NEAR(s_overall_out, s_1ph_out[LIQUID_INDEX], ABS_S_ERROR);
        if NOT_UNKNOWN(p_overall_out) EXPECT_NEAR(p_overall_out, Pr_1ph_out[LIQUID_INDEX], ABS_D_ERROR);
        if NOT_UNKNOWN(props._a_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._a_1ph_out[LIQUID_INDEX], a_1ph_out[LIQUID_INDEX], ABS_A_ERROR);
        if NOT_UNKNOWN(props._beta_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._beta_1ph_out[LIQUID_INDEX], beta_1ph_out[LIQUID_INDEX], ABS_BETA_ERROR);
        if NOT_UNKNOWN(props._cp_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._cp_1ph_out[LIQUID_INDEX], cp_1ph_out[LIQUID_INDEX], ABS_CP_ERROR);
        if NOT_UNKNOWN(props._cv_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._cv_1ph_out[LIQUID_INDEX], cv_1ph_out[LIQUID_INDEX], ABS_CV_ERROR);
        if NOT_UNKNOWN(props._kappa_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._kappa_1ph_out[LIQUID_INDEX], kappa_1ph_out[LIQUID_INDEX], ABS_KAPPA_ERROR);
        if NOT_UNKNOWN(props._lambda_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._lambda_1ph_out[LIQUID_INDEX], lambda_1ph_out[LIQUID_INDEX], ABS_ERROR);
        if NOT_UNKNOWN(props._eta_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._eta_1ph_out[LIQUID_INDEX], eta_1ph_out[LIQUID_INDEX], ABS_ERROR);
        if NOT_UNKNOWN(props._dpdT_dN_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._dpdT_dN_1ph_out[LIQUID_INDEX], dpdT_dN_1ph_out[LIQUID_INDEX], ABS_DPDT_ERROR);
        if NOT_UNKNOWN(props._dpdd_TN_1ph_out[LIQUID_INDEX]) EXPECT_NEAR(props._dpdd_TN_1ph_out[LIQUID_INDEX], dpdd_TN_1ph_out[LIQUID_INDEX], ABS_DPDD_ERROR);
        if NOT_UNKNOWN(props._phaseFractions_out[LIQUID_INDEX]) EXPECT_NEAR(props._phaseFractions_out[LIQUID_INDEX], phaseFractions_out[LIQUID_INDEX], ABS_ERROR);
    }   

    if (phaseFractions_out[SOLID_INDEX] > 0.0) // Liquid phase present
    {
        // Check solid index
        if NOT_UNKNOWN(d_overall_out) EXPECT_NEAR(d_overall_out, d_1ph_out[SOLID_INDEX], ABS_D_ERROR);
        if NOT_UNKNOWN(h_overall_out) EXPECT_NEAR(h_overall_out, h_1ph_out[SOLID_INDEX], ABS_H_ERROR);
        if NOT_UNKNOWN(s_overall_out) EXPECT_NEAR(s_overall_out, s_1ph_out[SOLID_INDEX], ABS_S_ERROR);
        if NOT_UNKNOWN(p_overall_out) EXPECT_NEAR(p_overall_out, Pr_1ph_out[SOLID_INDEX], ABS_D_ERROR);
        if NOT_UNKNOWN(props._a_1ph_out[SOLID_INDEX]) EXPECT_NEAR(props._a_1ph_out[SOLID_INDEX], a_1ph_out[SOLID_INDEX], ABS_A_ERROR);
        if NOT_UNKNOWN(props._beta_1ph_out[SOLID_INDEX]) EXPECT_NEAR(props._beta_1ph_out[SOLID_INDEX], beta_1ph_out[SOLID_INDEX], ABS_BETA_ERROR);
        if NOT_UNKNOWN(props._cp_1ph_out[SOLID_INDEX]) EXPECT_NEAR(props._cp_1ph_out[SOLID_INDEX], cp_1ph_out[SOLID_INDEX], ABS_CP_ERROR);
        if NOT_UNKNOWN(props._cv_1ph_out[SOLID_INDEX]) EXPECT_NEAR(props._cv_1ph_out[SOLID_INDEX], cv_1ph_out[SOLID_INDEX], ABS_CV_ERROR);
        if NOT_UNKNOWN(props._kappa_1ph_out[SOLID_INDEX]) EXPECT_NEAR(props._kappa_1ph_out[SOLID_INDEX], kappa_1ph_out[SOLID_INDEX], ABS_KAPPA_ERROR);
        if NOT_UNKNOWN(props._lambda_1ph_out[SOLID_INDEX]) EXPECT_NEAR(props._lambda_1ph_out[SOLID_INDEX], lambda_1ph_out[SOLID_INDEX], ABS_ERROR);
        if NOT_UNKNOWN(props._eta_1ph_out[SOLID_INDEX]) EXPECT_NEAR(props._eta_1ph_out[SOLID_INDEX], eta_1ph_out[SOLID_INDEX], ABS_ERROR);
        if NOT_UNKNOWN(props._dpdT_dN_1ph_out[SOLID_INDEX]) EXPECT_NEAR(props._dpdT_dN_1ph_out[SOLID_INDEX], dpdT_dN_1ph_out[SOLID_INDEX], ABS_DPDT_ERROR);
        if NOT_UNKNOWN(props._dpdd_TN_1ph_out[SOLID_INDEX]) EXPECT_NEAR(props._dpdd_TN_1ph_out[SOLID_INDEX], dpdd_TN_1ph_out[SOLID_INDEX], ABS_DPDD_ERROR);
        if NOT_UNKNOWN(props._phaseFractions_out[SOLID_INDEX]) EXPECT_NEAR(props._phaseFractions_out[SOLID_INDEX], phaseFractions_out[SOLID_INDEX], ABS_ERROR);
    }   

    closeMaterial(material);
}

void run_test_stanmix_pure(const char *libraryName, const char *inputSpec, Units::Basis basis)
{
    const char *compounds = "toluene";

    TestProperties props;
    
    switch(basis)
    {
        case Units::MOLE:
            props._d = 9406.1546923;
            props._h = -39296.69959;
            props._s = -104.7199249;
            props._cp_1ph_out[LIQUID_INDEX] = 145.7641743;
            props._cv_1ph_out[LIQUID_INDEX] = 122.9381059;
            break;
        case Units::MASS:
            props._d = 866.6925;
            props._h = -426484.4;
            props._s = -1136.518;
            props._cp_1ph_out[LIQUID_INDEX] = 1581.968643;
            props._cv_1ph_out[LIQUID_INDEX] = 1334.238896;
            break;
    }

    props._p = 1e+5;
    props._T = 288.15;
    props._a_1ph_out[LIQUID_INDEX] = 1249.050253;
    props._beta_1ph_out[LIQUID_INDEX] = 0.000808317;
    props._lambda_1ph_out[LIQUID_INDEX] = 0.145823244;
    props._kappa_1ph_out[LIQUID_INDEX] = 8.76878e-10;
    props._eta_1ph_out[LIQUID_INDEX] = 0.000634364;
    props._dpdT_dN_1ph_out[LIQUID_INDEX] = 608164.15606824437;
    props._dpdd_TN_1ph_out[LIQUID_INDEX] = 868108.13177796965;
    props._phaseFractions_out[VAPOR_INDEX] = 0.0;
    props._phaseFractions_out[LIQUID_INDEX] = 1.0;

    run_test_pure(libraryName, compounds, inputSpec, props, basis);
}

void run_test_pcpsaft_pure(const char *libraryName, const char *inputSpec, Units::Basis basis)
{
    const char *compounds = "toluene";

    TestProperties props;
    
    switch(basis)
    {
        case Units::MOLE:
            props._d = 9349.68069;
            props._h = 10277.5361;
            props._s = -106.24285;
            props._cp_1ph_out[LIQUID_INDEX] = 154.6760097;
            props._cv_1ph_out[LIQUID_INDEX] = 122.6281181;
            break;
        case Units::MASS:
            props._d = 861.464806;
            props._h = 111544.523;
            props._s = -1153.0787;
            props._cp_1ph_out[LIQUID_INDEX] = 1678.735209;
            props._cv_1ph_out[LIQUID_INDEX] = 1330.911883;
            break;
    }

    props._p = 1e5;
    props._T = 288.15;
    props._a_1ph_out[LIQUID_INDEX] = 1156.458664; // speed of sound
    props._beta_1ph_out[LIQUID_INDEX] = 0.00106698;
    props._kappa_1ph_out[LIQUID_INDEX] = 1.0948e-09;
    props._lambda_1ph_out[LIQUID_INDEX] = 0.142371835;
    props._eta_1ph_out[LIQUID_INDEX] = 0.000603553;
    props._dpdT_dN_1ph_out[LIQUID_INDEX] = 664469.88372037816;
    props._dpdd_TN_1ph_out[LIQUID_INDEX] = 722905.26579079602;
    
    props._phaseFractions_out[VAPOR_INDEX] = 0.0;
    props._phaseFractions_out[LIQUID_INDEX] = 1.0;
    
    run_test_pure(libraryName, compounds, inputSpec, props, basis);
}

void run_test_stanmix_mixture1(const char *libraryName, const char *inputSpec, Units::Basis basis, Units::Basis x_unit)
{
    const char *compounds = "benzene/toluene";
    const int sizeX = 2;
    double X[sizeX];
    
    TestProperties props;

    switch(basis)
    {
        case Units::MOLE:
            props._d = 10438.925947454736;
            props._h = -37106.49662;
            props._s = -102.3956919;

            props._cp_1ph_out[LIQUID_INDEX] = 134.0146636;
            props._cv_1ph_out[LIQUID_INDEX] = 110.6076357;
            break;
        case Units::MASS:
            props._d = 888.6396686;
            props._h = -435893.1793;
            props._s = -1202.850923;

            props._cp_1ph_out[LIQUID_INDEX] = 1574.281678;
            props._cv_1ph_out[LIQUID_INDEX] = 1299.317326;
            break;
    }

    props._p = 1e+5;
    props._T = 288.15;

    props._dpdT_dN_1ph_out[LIQUID_INDEX] = 637683.08402296796;
    props._dpdd_TN_1ph_out[LIQUID_INDEX] = 818452.87215822330;
    props._a_1ph_out[LIQUID_INDEX] = 1226.385387;
    props._beta_1ph_out[LIQUID_INDEX] = 0.00087677;
    props._kappa_1ph_out[LIQUID_INDEX] = 9.0654127255712E-10;
    
    props._eta_1ph_out[LIQUID_INDEX] = UNKNOWN;
    props._lambda_1ph_out[LIQUID_INDEX] = UNKNOWN;
    
    props._phaseFractions_out[VAPOR_INDEX] = 1.0;
    props._phaseFractions_out[LIQUID_INDEX] = 1.0;
    props._phaseFractions_out[SOLID_INDEX] = 0.0;
            
    switch(x_unit)
    {
        
        case Units::MOLE:
            X[0] = 1;
            X[1] = 1;
            break;
        case Units::MASS:
            X[0] = 0.078114;
            X[1] = 0.092141;
            break;
        case Units::MOLEFRACTION:
            X[0] = 0.5;
            X[1] = 0.5;
            break;
        case Units::MASSFRACTION:
            X[0] = 0.45880590878388299903086546650612;
            X[1] = 0.54119409121611700096913453349388;
            break;
    }

    props._phaseCompositions.push_back(0.60946093);
    props._phaseCompositions.push_back(0.39053907);
    props._phaseCompositions.push_back(0.39346972);
    props._phaseCompositions.push_back(0.60653028);
    props._phaseCompositions.push_back(0.0); // dummy for solid phase
    props._phaseCompositions.push_back(0.0); // dummy for solid phase
    
    run_test_mixture(libraryName, compounds, inputSpec, props, basis, X, x_unit, sizeX);
}

void run_test_stanmix_mixture2(const char *libraryName, const char *inputSpec, Units::Basis basis, Units::Basis x_unit)
{
    const char *compounds = "benzene/toluene";
    
    TestProperties props;

    switch(basis)
    {
        case Units::MOLE:
            props._d = 9602.128031;
            props._h = -38858.25866;
            props._s = -104.2598807;
            props._cp_1ph_out[LIQUID_INDEX] = 143.4054971;
            props._cv_1ph_out[LIQUID_INDEX] = 120.4313426;
            break;
        case Units::MASS:
            props._d = 871.2807739;
            props._h = -428245.3898;
            props._s = -1149.017347;
            props._cp_1ph_out[LIQUID_INDEX] = 1580.429621;
            props._cv_1ph_out[LIQUID_INDEX] = 1327.238251;
            break;
    }

    props._p = 1e5;
    props._T = 288.15;
          
    props._dpdT_dN_1ph_out[LIQUID_INDEX] = 614317.06862510170;
    props._dpdd_TN_1ph_out[LIQUID_INDEX] = 857833.08741975285;
    props._a_1ph_out[LIQUID_INDEX] = 1244.50491;
    props._beta_1ph_out[LIQUID_INDEX] = 0.000821924;
    props._kappa_1ph_out[LIQUID_INDEX] = 8.8241912319924E-10;
    
    props._eta_1ph_out[LIQUID_INDEX] = UNKNOWN;
    props._lambda_1ph_out[LIQUID_INDEX] = UNKNOWN;
    
    props._phaseFractions_out[VAPOR_INDEX] = 1.0;
    props._phaseFractions_out[LIQUID_INDEX] = 1.0;
    props._phaseFractions_out[SOLID_INDEX] = 0.0;

    props._phaseCompositions.push_back(0.15638729);
    props._phaseCompositions.push_back(0.84361271);
    props._phaseCompositions.push_back(0.07063662);
    props._phaseCompositions.push_back(0.92936338);
    props._phaseCompositions.push_back(0.0); // dummy for solid phase
    props._phaseCompositions.push_back(0.0); // dummy for solid phase
    
    const int sizeX = 2;
    double X[sizeX];
    
    switch(x_unit)
    {
        case Units::MOLEFRACTION:
            X[0] = 0.1;
            X[1] = 0.9;
            break;
    }
   
    run_test_mixture(libraryName, compounds, inputSpec, props, basis, X, x_unit, sizeX);
}

void run_test_gasmix_mixture1(const char *libraryName, const char *inputSpec, Units::Basis basis, Units::Basis x_unit)
{
    const char *compounds = "N2/O2/H2O/Ar/CO2";
    
    TestProperties props;

    switch(basis)
    {
        case Units::MOLE:
            props._d = 41.740311446043435; //41.74;
            props._h = -29929.462;
            props._s = 204.109;
            props._cp_1ph_out[VAPOR_INDEX] = 29.5668686;
            props._cv_1ph_out[VAPOR_INDEX] = 21.2525686;
            break;
        case Units::MASS:
            props._d = 1.216595675;
            props._h = -1026853.114;
            props._s = 7002.802016;
            	
            props._cp_1ph_out[VAPOR_INDEX] = 1014.412865;
            props._cv_1ph_out[VAPOR_INDEX] = 729.1566546;
            break;
    
    }

    props._p = 1e+5;
    props._T = 288.15;

    props._dpdT_dN_1ph_out[VAPOR_INDEX] = 347.04147145583903;
    props._dpdd_TN_1ph_out[VAPOR_INDEX] = 82196.576946064044;
    props._a_1ph_out[VAPOR_INDEX] = 338.1612329;
    props._beta_1ph_out[VAPOR_INDEX] = 0.003470415;
    props._kappa_1ph_out[VAPOR_INDEX] = 1.0000000000000E-05;
    props._eta_1ph_out[VAPOR_INDEX] = 1.7625E-05;
    props._lambda_1ph_out[VAPOR_INDEX] = 0.024198943;
    props._phaseFractions_out[VAPOR_INDEX] = 1.0;
    props._phaseFractions_out[LIQUID_INDEX] = 0.0;
    props._phaseFractions_out[SOLID_INDEX] = 0.0;
            
    const int sizeX = 5;
    double X[sizeX];
    
    switch(x_unit)
    {
        case Units::MOLEFRACTION:
            X[0] = 0.5;
            X[1] = 0.37;
            X[2] = 0.09;
            X[3] = 0.02;
            X[4] = 0.02;
            break;
    }
    
    run_test_mixture(libraryName, compounds, inputSpec, props, basis, X, x_unit, sizeX);
}

void run_test_pcpsaft_air_mixture1(const char *libraryName, const char *inputSpec, Units::Basis basis, Units::Basis x_unit)
{
    const char *compounds = "nitrogen/argon/oxygen";
    const int sizeX = 3;
    double X[sizeX];
    
    TestProperties props;
     
    switch(basis)
    {
        case Units::MOLE:
            props._d = 40.10802861;
            props._h = 40.07217561;
            props._s = 5.175303405;
            props._cp_1ph_out[VAPOR_INDEX] = 25.52092939;
            props._cv_1ph_out[VAPOR_INDEX] = 17.16623813;
            break;
        case Units::MASS:
            props._d = 1.161298723;
            props._h = 1377.619364;
            props._s = 177.9189195;
            props._cp_1ph_out[VAPOR_INDEX] = 877.3700448;
            props._cv_1ph_out[VAPOR_INDEX] = 590.1486926;
            break;
    }

    props._p = 1e+5;
    props._T = 300.0;
    props._dpdT_dN_1ph_out[VAPOR_INDEX] = 334.45058490798385;
    props._dpdd_TN_1ph_out[VAPOR_INDEX] = 85758.107108539945;
    props._a_1ph_out[VAPOR_INDEX] = 356.9000728;
    props._beta_1ph_out[VAPOR_INDEX] = 0.003342811;
    props._kappa_1ph_out[VAPOR_INDEX] = 1.0004216480262E-05;
    props._eta_1ph_out[VAPOR_INDEX] = 1.85118E-05;
    props._lambda_1ph_out[VAPOR_INDEX] = 0.023554589;
    props._phaseFractions_out[VAPOR_INDEX] = 1.0;
    props._phaseFractions_out[LIQUID_INDEX] = 0.0;
    props._phaseFractions_out[SOLID_INDEX] = 0.0;

    switch(x_unit)
    {
        case Units::MOLEFRACTION:
            props._phaseCompositions.push_back(0.0);
            props._phaseCompositions.push_back(0.0);
            props._phaseCompositions.push_back(0.0);
            props._phaseCompositions.push_back(0.7557);
            props._phaseCompositions.push_back(0.0127);
            props._phaseCompositions.push_back(0.2316);

            X[0] = 0.7557;
            X[1] = 0.0127;
            X[2] = 0.2316;
            break;
    }

    props._phaseCompositions.push_back(0.0); // dummy for solid phase
    props._phaseCompositions.push_back(0.0); // dummy for solid phase
    
    run_test_mixture(libraryName, compounds, inputSpec, props, basis, X, x_unit, sizeX);
}

void run_test_refprop_air_mixture1(const char *libraryName, const char *inputSpec, Units::Basis basis, Units::Basis x_unit)
{
    const char *compounds = "nitrogen/argon/oxygen";
    const int sizeX = 3;
    double X[sizeX];
    
    TestProperties props;

    switch(basis)
    {
        case Units::MOLE:
            props._d = 40.10250782;
            props._h = 8688.101434;
            props._s = 199.4771313;
            props._cp_1ph_out[VAPOR_INDEX] = 29.12655459;
            props._cv_1ph_out[VAPOR_INDEX] = 20.772908;
            break;
        case Units::MASS:
            props._d = 1.161298723;
            props._h = 298682.85695766949;
            props._s = 6857.7007215338526;
            props._cp_1ph_out[VAPOR_INDEX] = 1001.3237765405178;
            props._cv_1ph_out[VAPOR_INDEX] = 714.13893532536235;
            break;
    }

    props._p = 1e+5;
    props._T = 300.0;

    props._dpdT_dN_1ph_out[VAPOR_INDEX] = 334.37113370691418;
    props._dpdd_TN_1ph_out[VAPOR_INDEX] = 85766.206598066856;
    props._a_1ph_out[VAPOR_INDEX] = 346.6487029;
    props._beta_1ph_out[VAPOR_INDEX] = 0.003342154;
    props._kappa_1ph_out[VAPOR_INDEX] = 1.0002914113154E-05;
    props._eta_1ph_out[VAPOR_INDEX] = 1.86666E-05;
    props._lambda_1ph_out[VAPOR_INDEX] = 0.025973252;
    props._phaseFractions_out[VAPOR_INDEX] = 1.0;
    props._phaseFractions_out[LIQUID_INDEX] = 0.0;
    props._phaseFractions_out[SOLID_INDEX] = 0.0;

    
    switch(x_unit)
    {
        case Units::MOLEFRACTION:
            props._phaseCompositions.push_back(0.0);
            props._phaseCompositions.push_back(0.0);
            props._phaseCompositions.push_back(0.0);
            props._phaseCompositions.push_back(0.7557);
            props._phaseCompositions.push_back(0.0127);
            props._phaseCompositions.push_back(0.2316);

            X[0] = 0.7557;
            X[1] = 0.0127;
            X[2] = 0.2316;
            
            break;
    }

    props._phaseCompositions.push_back(0.0); // dummy for solid phase
    props._phaseCompositions.push_back(0.0); // dummy for solid phase
    
    run_test_mixture(libraryName, compounds, inputSpec, props, basis, X, x_unit, sizeX);
}

/*
void run_test_tea_mixture1(const char *libraryName, Units::Basis basis, Units::Basis x_unit)
{
    //  see http://www.amsterchem.com/oothermo.html

    const char *compounds = "Methane/Ethane";
    
    TestProperties props;

    switch(basis)
    {
        case Units::MOLE:
            props._p = 1e5;
            props._T = 300.0;
            props._d = 40.28;
            props._h = 46.68;
            props._s = 204.109;
            break;
    }

    const int sizeX = 2;
    double X[sizeX];
    
    switch(x_unit)
    {
        case Units::MOLEFRACTION:
            X[0] = 0.5;
            X[1] = 0.5;
            break;
    }
    
    run_test_mixture(libraryName, compounds, INPUTSPEC, props, basis, X, x_unit, sizeX);
}
*/

#endif // FLUIDPROP == 1 || CAPEOPEN == 1 

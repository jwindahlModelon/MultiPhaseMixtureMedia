#include "BaseCalculator.h"
#include "StringHelper.h"
#include "errorhandling.h"

BaseCalculator::BaseCalculator(const MaterialCalculatorSetup *setupInfo)
{
    // initializations
    _compounds.clear();
    _compounds.push_back("");
    _numCompounds = 1;
    _basis = Units::MOLE;

    parseSetupInfo(setupInfo);
}

BaseCalculator::~BaseCalculator(void)
{
}

BaseCalculatorCache* BaseCalculator::createCache()
{
    BaseCalculatorCache *cache = new BaseCalculatorCache();
    return cache;
}

void BaseCalculator::parseSetupInfo(const MaterialCalculatorSetup *setupInfo)
{
    // set library name
    _libraryName = setupInfo->libraryName;

    // parse compounds
    _compounds = StringHelper::split(setupInfo->compounds, '/');
    _numCompounds = _compounds.size();

    // Parse settings string
    vector<string> settings = StringHelper::split(setupInfo->setupInfo, ';');
    for (vector<string>::iterator it = settings.begin(); it != settings.end(); it++)
    {
        pair<string,string> kv = StringHelper::split2(*it, '=');
        string key = kv.first;
        string value = kv.second;

        // check unit basis
        if (key == "UnitBasis")
        {
            _basis = (Units::Basis) stoi(value);
        }
    }
}

double BaseCalculator::averageMolarMass_X(const double X[], size_t size_X, Units::Basis X_unit, BaseCalculatorCache *cache) const
{
    // Base function returns an error if called - should be redeclared by the calculator object
    errorMessage("BaseCalculator", "Internal error: averageMolarMass_X is not implemented");
    return -1.0;
}

void BaseCalculator::convert2MoleFractions(const double *X, size_t sizeX, Units::Basis X_unit, double *Z) const
{
    // Convert to a vector of mole values
    switch(X_unit)
    {
    case Units::MASS:
    case Units::MASSFRACTION:
        for (size_t i = 0; i < sizeX; ++i)
            Z[i] = X[i] / _fluidConstants[i].MM;
        break;
    case Units::MOLE:
    case Units::MOLEFRACTION:
    default:
        for (size_t i = 0; i < sizeX; ++i)
            Z[i] = X[i];
        break;
    }

    // Normalize if necessary
    if (X_unit != Units::MOLEFRACTION)
    {
        double moleTotal = totalMole(Z, sizeX, Units::MOLE);
        for (size_t i = 0; i < sizeX; ++i)
            Z[i] = Z[i] / moleTotal;
    }
}
double BaseCalculator::totalMass(const double *X, size_t sizeX, Units::Basis X_unit) const
{
    // calculate total mass
    double massTotal = 0.0;
    switch (X_unit)
    {
    case Units::MASS:
    case Units::MASSFRACTION:
        for (size_t i = 0; i < sizeX; ++i)
            massTotal += X[i];
        break;
    case Units::MOLE:
    case Units::MOLEFRACTION:
    default:
        for (size_t i = 0; i < sizeX; ++i)
            massTotal += X[i] * _fluidConstants[i].MM;
        break;
    }
    return massTotal;
}
double BaseCalculator::totalMole(const double *X, size_t sizeX, Units::Basis X_unit) const
{
    // Calculate total number of mole
    double moleTotal = 0.0;
    switch (X_unit)
    {
    case Units::MASS:
    case Units::MASSFRACTION:
        for (size_t i = 0; i < sizeX; ++i)
            moleTotal += X[i] / _fluidConstants[i].MM;
        break;
    case Units::MOLE:
        for (size_t i = 0; i < sizeX; ++i)
            moleTotal += X[i];
        break;
    case Units::MOLEFRACTION:
    default:
        moleTotal = 1.0;
        break;
    }
    return moleTotal;
}

void BaseCalculator::calcThermoProperties_TFX(double T, const double phaseFraction[], Units::Basis F_unit, const double X[], Units::Basis X_unit, int solutionType, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[])
{
        // Base function returns an error if called - should be redeclared by the calculator object
        errorMessage("BaseCalculator", "Internal error: calcThermoProperties_TFX is not implemented");
}


void BaseCalculator::calcThermoProperties_pFX(double p, const double phaseFraction[], Units::Basis F_unit, const double X[], Units::Basis X_unit, int solutionType, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[])
{
        // Base function returns an error if called - should be redeclared by the calculator object
        errorMessage("BaseCalculator", "Internal error: calcThermoProperties_pFX is not implemented");
}

void BaseCalculator::calcThermoProperties_phX(double p, double h, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[])
{
        // Base function returns an error if called - should be redeclared by the calculator object
        errorMessage("BaseCalculator", "Internal error: calcThermoProperties_phX is not implemented");
}

void BaseCalculator::calcThermoProperties_duX(double d, double u, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[])
{
        // Base function returns an error if called - should be redeclared by the calculator object
        errorMessage("BaseCalculator", "Internal error: calcThermoProperties_duX is not implemented");
}


void BaseCalculator::calcThermoProperties_dTX(double d, double T, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[])
{
        // Base function returns an error if called - should be redeclared by the calculator object
        errorMessage("BaseCalculator", "Internal error: calcThermoProperties_dTX is not implemented");
}

void BaseCalculator::calcThermoProperties_psX(double p, double s, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[])
{
        // Base function returns an error if called - should be redeclared by the calculator object
        errorMessage("BaseCalculator", "Internal error: calcThermoProperties_psX is not implemented");
}

void BaseCalculator::calcThermoProperties_pTX(double p, double T, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[])
{
        // Base function returns an error if called - should be redeclared by the calculator object
        errorMessage("BaseCalculator", "Internal error: calcThermoProperties_pTX is not implemented");
}

int BaseCalculator::getNumberOfPhases() const
{
     // Base function returns an error if called - should be redeclared by the calculator object
    errorMessage("BaseCalculator", "Internal error: getNumberOfPhases() is not implemented");
    return -1;
}

void BaseCalculator::getPhaseProperties(char** phaseLabel, char** stateOfAggregation, size_t numPossiblePhases) const
{
    // Base function returns an error if called - should be redeclared by the calculator object
    errorMessage("BaseCalculator", "Internal error: getPhaseProperties is not implemented");
}
 
int BaseCalculator::getNumberOfCompounds() const
{
     // Base function returns an error if called - should be redeclared by the calculator object
    errorMessage("BaseCalculator", "Internal error: getNumberOfCompounds() is not implemented");
    return -1;
}

void BaseCalculator::setModelicaString(char** dest, const char* src) const
{
    // Copy a string into a buffer that is allocated if necessary
    size_t dest_size = strlen(src) + 1;
#if (DYMOLA == 1)
    *dest = ModelicaAllocateString(dest_size);
#endif
    strcpy_s(*dest, dest_size, src);
}

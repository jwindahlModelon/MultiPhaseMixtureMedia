/* *****************************************************************
 * Implementation of class FluidProp calculator
 *
 * Francesco Casella, Christoph Richter, Roberto Bonifetto
 * 2006 - 2014
 ********************************************************************/

#include "config.h"
#if (FLUIDPROP == 1)

#include "FluidPropCalculator.h"
#include "errorhandling.h"
#include "ModelicaUtilities.h"

#include <iostream>

#define _AFXDLL

#define VAPOR_INDEX 0
#define LIQUID_INDEX 1

double p_eps; // relative tolerance margin for subcritical pressure conditions
double T_eps; // relative tolerance margin for supercritical temperature conditions
double delta_h = 1e-2; // delta_h for one-phase/two-phase discrimination


FluidPropCalculator::FluidPropCalculator(const MaterialCalculatorSetup *setupInfo) : BaseCalculator(setupInfo) {

        if (!FluidProp.IsValid()) errorMessage("FluidPropCalculator", "Initialization of FluidProp object failed");

        warningMessage("FluidPropCalculator", "Calculation of properties under "
                       "specific phases is not supported by FluidProp. The "
                       "returned values will be an average over the present "
                       "phases.");

        string ErrorMsg;

        // set model name
        _modelName = _libraryName.substr(_libraryName.find(".") + 1);

        // set dummy fractions (equal for all compounds), real fractions are set at beginning of flash calculations
        vector<double> dummyFractions;
        for(int c = 0; c < _numCompounds; ++c)
            dummyFractions.push_back(1.0/_numCompounds);

        // set dummy fluid properties (this calls SetFluid, which is needed before calling SetUnits)
        setSubstanceProperties(&dummyFractions[0], _numCompounds, Units::MOLEFRACTION);

        // Set SI units
        if(_basis == Units::MASS)
            FluidProp.SetUnits("SI", "PerMass", "Mmol", "kg/mol", &ErrorMsg);
        else
            FluidProp.SetUnits("SI", "PerMole", "Mmol", "kg/mol", &ErrorMsg);

        checkFluidPropError(ErrorMsg, "FluidPropCalculator", "SetUnits failed");

        // Set fluid constants
        setSubstanceConstants();
}

FluidPropCalculator::~FluidPropCalculator() {
}

BaseCalculatorCache* FluidPropCalculator::createCache() {
    Cache *cache = new Cache();
    return cache;
}

void FluidPropCalculator::setSubstanceConstants()
{
    string ErrorMsg;

    // Get the results
    for(int i = 0; i < _numCompounds; ++i)
    {
        double tmp = 1.0;
        FluidProp.SetFluid(_modelName, 1, &_compounds[i], &tmp, &ErrorMsg);
        checkFluidPropError(ErrorMsg, "FluidPropCalculator", "SetFluid failed");

        FluidConstants fc;

        fc.MM = FluidProp.Mmol(&ErrorMsg);
        checkFluidPropError(ErrorMsg, "FluidPropCalculator::setSubstanceConstants", "can't compute molar mass");

        if(_modelName.compare("GasMix") == 0)
            fc.Tc = -8888.0;
        else
            fc.Tc = FluidProp.Tcrit(&ErrorMsg);
        checkFluidPropError(ErrorMsg, "FluidPropCalculator::setSubstanceConstants", "can't compute critical temperature");

        if(_modelName.compare("GasMix") == 0)
            fc.pc = -8888.0;
        else
            fc.pc = FluidProp.Pcrit(&ErrorMsg);
        checkFluidPropError(ErrorMsg, "FluidPropCalculator::setSubstanceConstants", "can't compute critical pressure");

        // Computation of critical density with slightly supercritical temperature to avoid convergence problems
        // T_eps is kept as a static variable
        for(T_eps = 1e-5;; T_eps *= 3)
        {
            if (T_eps > 1e-3) {
                // Superheating is too large
                checkFluidPropError(ErrorMsg, "FluidPropCalculator::setSubstanceConstants", "can't compute critical density");
            }
            fc.dc = FluidProp.Density("PT", fc.pc, fc.Tc*(1.0 + T_eps), &ErrorMsg);
            if (!isError(ErrorMsg)) break; // computation succeeded
        }

        // add fluidConstants record to list
        this->_fluidConstants.push_back(fc);
    }
}

void FluidPropCalculator::setSubstanceProperties(const double *X, size_t sizeX, Units::Basis X_unit)
{
    string ErrorMsg;

    double *Z = new double[sizeX];
    convert2MoleFractions(X, sizeX, X_unit, Z);

    // compounds are parsed in base class, but we need to do something different in the case of (free)StanMix
    vector<string> comp;
    if (_libraryName.find("StanMix") != string::npos)
    {
        comp.clear();

        string c1;
        for (int i = 0; i < (int) _compounds.size(); ++i)
        {
            if (i > 0)
                c1 += "/";
            c1 += _compounds[i];
        }

        comp.push_back(c1);

        if(_numCompounds > 1)
        {
            for (int i = 2; i <= _numCompounds; ++i)
            {
                comp.push_back("");
            }
        }
    }
    else
    {
        comp = _compounds;
    }

    FluidProp.SetFluid(_modelName, sizeX, &comp[0], Z, &ErrorMsg);
    checkFluidPropError(ErrorMsg, "FluidPropCalculator", "SetFluid failed");
    delete[] Z;
}

//! Computes the properties of the state vector from p and h
void FluidPropCalculator::calcThermoProperties_phX(double p, double h, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double* d_1ph_out, double* h_1ph_out, double* s_1ph_out, double* Pr_1ph_out, double* a_1ph_out, double* beta_1ph_out, double* cp_1ph_out, double* cv_1ph_out, double* kappa_1ph_out, double* lambda_1ph_out, double* eta_1ph_out,
    double* dpdT_dN_1ph_out, double* dpdd_TN_1ph_out,
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double* phaseCompositions_out, double* phaseFractions_out)
{
    string ErrorMsg;

    setSubstanceProperties(X, size_X, X_unit);

    // FluidProp variables (in SI units)
    double P_, T_, v_, d_, h_, s_, u_, q_, x_[20], y_[20],
        cv_, cp_, c_, alpha_, beta_, chi_, fi_, ksi_,
        psi_, zeta_ , theta_, kappa_, gamma_, eta_, lambda_;

    // Compute all FluidProp variables
    FluidProp.AllProps("Ph", p , h, P_, T_, v_, d_, h_, s_, u_, q_, x_, y_, cv_, cp_, c_,
        alpha_, beta_, chi_, fi_, ksi_, psi_,
        zeta_, theta_, kappa_, gamma_, eta_, lambda_, &ErrorMsg);
    checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_phX", "AllProps failed");

    // For some models we need to compute eta and lambda seperatly.
    // For TPSI, vThermo, GasMix and RefProp the AllProps should be sufficient.
    if (_modelName.compare("IF97") ||
        _modelName.compare("vThermo") ||
        _modelName.compare("GasMix") ||
        _modelName.compare("RefProp"))
    {
        eta_ = FluidProp.Viscosity("Ph", p, h, &ErrorMsg);
        checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_phX", "Viscosity failed");
        lambda_ = FluidProp.ThermCond("Ph", p, h, &ErrorMsg);
        checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_phX", "ThermCond failed");
    }

    // Fill in the output variables (in SI units)
    *p_overall_out = P_;
    *T_overall_out = T_;
    *d_overall_out = d_;
    *h_overall_out = h_;
    *s_overall_out = s_;

    // Determine present phases
    *nbrOfPresentPhases_out = 0;
    phaseFractions_out[VAPOR_INDEX] = q_;
    phaseFractions_out[LIQUID_INDEX] = 1.0 - q_;
    if (phaseFractions_out[VAPOR_INDEX] > 0.0) // Vapor phase present
    {
        presentPhaseIndex_out[*nbrOfPresentPhases_out] = VAPOR_INDEX;
        (*nbrOfPresentPhases_out)++;
    }
    if (phaseFractions_out[LIQUID_INDEX] > 0.0) // Liquid phase present
    {
        presentPhaseIndex_out[*nbrOfPresentPhases_out] = LIQUID_INDEX;
        (*nbrOfPresentPhases_out)++;
    }

    for (size_t i = 0; i < (size_t) *nbrOfPresentPhases_out; i++)
    {
        d_1ph_out[presentPhaseIndex_out[i]] = d_;
        h_1ph_out[presentPhaseIndex_out[i]] = h_;
        s_1ph_out[presentPhaseIndex_out[i]] = s_;
        Pr_1ph_out[presentPhaseIndex_out[i]] = P_;
        a_1ph_out[presentPhaseIndex_out[i]] = c_;
        beta_1ph_out[presentPhaseIndex_out[i]] = theta_;
        cp_1ph_out[presentPhaseIndex_out[i]] = cp_;
        cv_1ph_out[presentPhaseIndex_out[i]] = cv_;
        kappa_1ph_out[presentPhaseIndex_out[i]] = kappa_;
        lambda_1ph_out[presentPhaseIndex_out[i]] = lambda_;
        eta_1ph_out[presentPhaseIndex_out[i]] = eta_;

        if(_basis == Units::MASS)
            dpdT_dN_1ph_out[presentPhaseIndex_out[i]] = theta_ * d_ / psi_;
        else if(_basis == Units::MOLE)
            dpdT_dN_1ph_out[presentPhaseIndex_out[i]] = theta_ * d_ / psi_ * averageMolarMass(X, size_X, X_unit);

        dpdd_TN_1ph_out[presentPhaseIndex_out[i]] = 1.0 / psi_;
        presentPhaseIndex_out[i]++; // +1 due to modelica vectors starting at 1
    }

    double *vapCmp = FluidProp.VaporCmp("Ph", p, h, &ErrorMsg);
    checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_phX", "VaporCmp failed");
    double *liqCmp = FluidProp.LiquidCmp("Ph", p, h, &ErrorMsg);
    checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_phX", "LiquidCmp failed");

    for(int c = 0; c < _numCompounds; ++c)
    {
        phaseCompositions_out[c] = vapCmp[c];
        phaseCompositions_out[_numCompounds + c] = liqCmp[c];
    }
}

//! Computes the properties of the state vector from p and T
void FluidPropCalculator::calcThermoProperties_pTX(double p, double T, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double* d_1ph_out, double* h_1ph_out, double* s_1ph_out, double* Pr_1ph_out, double* a_1ph_out, double* beta_1ph_out, double* cp_1ph_out, double* cv_1ph_out, double* kappa_1ph_out, double* lambda_1ph_out, double* eta_1ph_out,
    double* dpdT_dN_1ph_out, double* dpdd_TN_1ph_out,
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double* phaseCompositions_out, double* phaseFractions_out)
{
    string ErrorMsg;

    setSubstanceProperties(X, size_X, X_unit);

    // FluidProp variables (in SI units)
    double P_, T_, v_, d_, h_, s_, u_, q_, x_[20], y_[20],
        cv_, cp_, c_, alpha_, beta_, chi_, fi_, ksi_,
        psi_, zeta_ , theta_, kappa_, gamma_, eta_, lambda_;

    // Compute all FluidProp variables
    FluidProp.AllProps("PT", p , T, P_, T_, v_, d_, h_, s_, u_, q_, x_, y_, cv_, cp_, c_,
        alpha_, beta_, chi_, fi_, ksi_, psi_,
        zeta_, theta_, kappa_, gamma_, eta_, lambda_, &ErrorMsg);
    checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_pTX", "AllProps failed");

    // For some models we need to compute eta and lambda seperatly.
    // For TPSI, vThermo, GasMix and RefProp the AllProps should be sufficient.
    if (_modelName.compare("IF97") ||
        _modelName.compare("vThermo") ||
        _modelName.compare("GasMix") ||
        _modelName.compare("RefProp"))
    {
        eta_ = FluidProp.Viscosity("PT", p, T, &ErrorMsg);
        checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_pTX", "Viscosity failed");
        lambda_ = FluidProp.ThermCond("PT", p, T, &ErrorMsg);
        checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_pTX", "ThermCond failed");
    }

    // Fill in the output variables (in SI units)
    *p_overall_out = P_;
    *T_overall_out = T_;
    *d_overall_out = d_;
    *h_overall_out = h_;
    *s_overall_out = s_;

    // Determine present phases
    *nbrOfPresentPhases_out = 0;
    phaseFractions_out[VAPOR_INDEX] = q_;
    phaseFractions_out[LIQUID_INDEX] = 1.0 - q_;
    if (phaseFractions_out[VAPOR_INDEX] > 0.0) // Vapor phase present
    {
        presentPhaseIndex_out[*nbrOfPresentPhases_out] = VAPOR_INDEX;
        (*nbrOfPresentPhases_out)++;
    }
    if (phaseFractions_out[LIQUID_INDEX] > 0.0) // Liquid phase present
    {
        presentPhaseIndex_out[*nbrOfPresentPhases_out] = LIQUID_INDEX;
        (*nbrOfPresentPhases_out)++;
    }

    for (size_t i = 0; i < (size_t) *nbrOfPresentPhases_out; i++)
    {
        d_1ph_out[presentPhaseIndex_out[i]] = d_;
        h_1ph_out[presentPhaseIndex_out[i]] = h_;
        s_1ph_out[presentPhaseIndex_out[i]] = s_;
        Pr_1ph_out[presentPhaseIndex_out[i]] = P_;
        a_1ph_out[presentPhaseIndex_out[i]] = c_;
        beta_1ph_out[presentPhaseIndex_out[i]] = theta_;
        cp_1ph_out[presentPhaseIndex_out[i]] = cp_;
        cv_1ph_out[presentPhaseIndex_out[i]] = cv_;
        kappa_1ph_out[presentPhaseIndex_out[i]] = kappa_;
        lambda_1ph_out[presentPhaseIndex_out[i]] = lambda_;
        eta_1ph_out[presentPhaseIndex_out[i]] = eta_;
        
        if(_basis == Units::MASS)
            dpdT_dN_1ph_out[presentPhaseIndex_out[i]] = theta_ * d_ / psi_;
        else if(_basis == Units::MOLE)
            dpdT_dN_1ph_out[presentPhaseIndex_out[i]] = theta_ * d_ / psi_ * averageMolarMass(X, size_X, X_unit);

        dpdd_TN_1ph_out[presentPhaseIndex_out[i]] = 1.0 / psi_;
        presentPhaseIndex_out[i]++; // +1 due to modelica vectors starting at 1
    }

    double *vapCmp = FluidProp.VaporCmp("PT", p, T, &ErrorMsg);
    checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_pTX", "VaporCmp failed");
    double *liqCmp = FluidProp.LiquidCmp("PT", p, T, &ErrorMsg);
    checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_pTX", "LiquidCmp failed");

    for(int c = 0; c < _numCompounds; ++c)
    {
        phaseCompositions_out[c] = vapCmp[c];
        phaseCompositions_out[_numCompounds + c] = liqCmp[c];
    }
}

// Computes the properties of the state vector from d and T
/*! Note: the phase input is currently not supported according to the standard,
    the phase input is returned in the state record
*/
void FluidPropCalculator::calcThermoProperties_dTX(double d, double T, const double* X, size_t size_X, Units::Basis X_unit,  int phase_id, BaseCalculatorCache *cache,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double* d_1ph_out, double* h_1ph_out, double* s_1ph_out, double* Pr_1ph_out, double* a_1ph_out, double* beta_1ph_out, double* cp_1ph_out, double* cv_1ph_out, double* kappa_1ph_out, double* lambda_1ph_out, double* eta_1ph_out,
    double* dpdT_dN_1ph_out, double* dpdd_TN_1ph_out,
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double* phaseCompositions_out, double* phaseFractions_out)
{
    string ErrorMsg;

    setSubstanceProperties(X, size_X, X_unit);

    // FluidProp variables (in SI units)
    double P_, T_, v_, d_, h_, s_, u_, q_, x_[20], y_[20],
        cv_, cp_, c_, alpha_, beta_, chi_, fi_, ksi_,
        psi_, zeta_ , theta_, kappa_, gamma_, eta_, lambda_;

    // Compute all FluidProp variables
    FluidProp.AllProps("Td", T , d, P_, T_, v_, d_, h_, s_, u_, q_, x_, y_, cv_, cp_, c_,
        alpha_, beta_, chi_, fi_, ksi_, psi_,
        zeta_, theta_, kappa_, gamma_, eta_, lambda_, &ErrorMsg);
    checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_dTX", "AllProps failed");

    // For some models we need to compute eta and lambda seperatly.
    // For TPSI, vThermo, GasMix and RefProp the AllProps should be sufficient.
    if (_modelName.compare("IF97") ||
        _modelName.compare("vThermo") ||
        _modelName.compare("GasMix") ||
        _modelName.compare("RefProp"))
    {
        eta_ = FluidProp.Viscosity("Td", T, d, &ErrorMsg);
        checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_dTX", "Viscosity failed");
        lambda_ = FluidProp.ThermCond("Td", T, d, &ErrorMsg);
        checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_dTX", "ThermCond failed");
    }

    // Fill in the output variables (in SI units)
    *p_overall_out = P_;
    *T_overall_out = T_;
    *d_overall_out = d_;
    *h_overall_out = h_;
    *s_overall_out = s_;

    // Determine present phases
    *nbrOfPresentPhases_out = 0;
    phaseFractions_out[VAPOR_INDEX] = q_;
    phaseFractions_out[LIQUID_INDEX] = 1.0 - q_;
    if (phaseFractions_out[VAPOR_INDEX] > 0.0) // Vapor phase present
    {
        presentPhaseIndex_out[*nbrOfPresentPhases_out] = VAPOR_INDEX;
        (*nbrOfPresentPhases_out)++;
    }
    if (phaseFractions_out[LIQUID_INDEX] > 0.0) // Liquid phase present
    {
        presentPhaseIndex_out[*nbrOfPresentPhases_out] = LIQUID_INDEX;
        (*nbrOfPresentPhases_out)++;
    }

    for (size_t i = 0; i < (size_t) *nbrOfPresentPhases_out; i++)
    {
        d_1ph_out[presentPhaseIndex_out[i]] = d_;
        h_1ph_out[presentPhaseIndex_out[i]] = h_;
        s_1ph_out[presentPhaseIndex_out[i]] = s_;
        Pr_1ph_out[presentPhaseIndex_out[i]] = P_;
        a_1ph_out[presentPhaseIndex_out[i]] = c_;
        beta_1ph_out[presentPhaseIndex_out[i]] = theta_;
        cp_1ph_out[presentPhaseIndex_out[i]] = cp_;
        cv_1ph_out[presentPhaseIndex_out[i]] = cv_;
        kappa_1ph_out[presentPhaseIndex_out[i]] = kappa_;
        lambda_1ph_out[presentPhaseIndex_out[i]] = lambda_;
        eta_1ph_out[presentPhaseIndex_out[i]] = eta_;
        
        if(_basis == Units::MASS)
            dpdT_dN_1ph_out[presentPhaseIndex_out[i]] = theta_ * d_ / psi_;
        else if(_basis == Units::MOLE)
            dpdT_dN_1ph_out[presentPhaseIndex_out[i]] = theta_ * d_ / psi_ * averageMolarMass(X, size_X, X_unit);

        dpdd_TN_1ph_out[presentPhaseIndex_out[i]] = 1.0 / psi_;
        presentPhaseIndex_out[i]++; // +1 due to modelica vectors starting at 1
    }

    double *vapCmp = FluidProp.VaporCmp("Td", T, d, &ErrorMsg);
    checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_dTX", "VaporCmp failed");
    double *liqCmp = FluidProp.LiquidCmp("Td", T, d, &ErrorMsg);
    checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_dTX", "LiquidCmp failed");

    for(int c = 0; c < _numCompounds; ++c)
    {
        phaseCompositions_out[c] = vapCmp[c];
        phaseCompositions_out[_numCompounds + c] = liqCmp[c];
    }
}

//! Computes the properties of the state vector from p and s
/*! Note: the phase input is currently not supported according to the standard,
    the phase input is returned in the state record
*/
void FluidPropCalculator::calcThermoProperties_psX(double p, double s, const double* X, size_t size_X, Units::Basis X_unit,  int phase_id, BaseCalculatorCache *cache,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double* d_1ph_out, double* h_1ph_out, double* s_1ph_out, double* Pr_1ph_out, double* a_1ph_out, double* beta_1ph_out, double* cp_1ph_out, double* cv_1ph_out, double* kappa_1ph_out, double* lambda_1ph_out, double* eta_1ph_out,
    double* dpdT_dN_1ph_out, double* dpdd_TN_1ph_out,
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double* phaseCompositions_out, double* phaseFractions_out)
{
    string ErrorMsg;

    setSubstanceProperties(X, size_X, X_unit);

    // FluidProp variables (in SI units)
    double P_, T_, v_, d_, h_, s_, u_, q_, x_[20], y_[20],
        cv_, cp_, c_, alpha_, beta_, chi_, fi_, ksi_,
        psi_, zeta_ , theta_, kappa_, gamma_, eta_, lambda_;

    // Compute all FluidProp variables
    FluidProp.AllProps("Ps", p , s, P_, T_, v_, d_, h_, s_, u_, q_, x_, y_, cv_, cp_, c_,
        alpha_, beta_, chi_, fi_, ksi_, psi_,
        zeta_, theta_, kappa_, gamma_, eta_, lambda_, &ErrorMsg);
    checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_psX", "AllProps failed");

    // For some models we need to compute eta and lambda seperatly.
    // For TPSI, vThermo, GasMix and RefProp the AllProps should be sufficient.
    if (_modelName.compare("IF97") ||
        _modelName.compare("vThermo") ||
        _modelName.compare("GasMix") ||
        _modelName.compare("RefProp"))
    {
        eta_ = FluidProp.Viscosity("Ps", p, s, &ErrorMsg);
        checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_psX", "Viscosity failed");
        lambda_ = FluidProp.ThermCond("Ps", p, s, &ErrorMsg);
        checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_psX", "ThermCond failed");
    }

    // Fill in the output variables (in SI units)
    *p_overall_out = P_;
    *T_overall_out = T_;
    *d_overall_out = d_;
    *h_overall_out = h_;
    *s_overall_out = s_;

    // Determine present phases
    *nbrOfPresentPhases_out = 0;
    phaseFractions_out[VAPOR_INDEX] = q_;
    phaseFractions_out[LIQUID_INDEX] = 1.0 - q_;
    if (phaseFractions_out[VAPOR_INDEX] > 0.0) // Vapor phase present
    {
        presentPhaseIndex_out[*nbrOfPresentPhases_out] = VAPOR_INDEX;
        (*nbrOfPresentPhases_out)++;
    }
    if (phaseFractions_out[LIQUID_INDEX] > 0.0) // Liquid phase present
    {
        presentPhaseIndex_out[*nbrOfPresentPhases_out] = LIQUID_INDEX;
        (*nbrOfPresentPhases_out)++;
    }

    for (size_t i = 0; i < (size_t) *nbrOfPresentPhases_out; i++)
    {
        d_1ph_out[presentPhaseIndex_out[i]] = d_;
        h_1ph_out[presentPhaseIndex_out[i]] = h_;
        s_1ph_out[presentPhaseIndex_out[i]] = s_;
        Pr_1ph_out[presentPhaseIndex_out[i]] = P_;
        a_1ph_out[presentPhaseIndex_out[i]] = c_;
        beta_1ph_out[presentPhaseIndex_out[i]] = theta_;
        cp_1ph_out[presentPhaseIndex_out[i]] = cp_;
        cv_1ph_out[presentPhaseIndex_out[i]] = cv_;
        kappa_1ph_out[presentPhaseIndex_out[i]] = kappa_;
        lambda_1ph_out[presentPhaseIndex_out[i]] = lambda_;
        eta_1ph_out[presentPhaseIndex_out[i]] = eta_;
       
        if(_basis == Units::MASS)
            dpdT_dN_1ph_out[presentPhaseIndex_out[i]] = theta_ * d_ / psi_;
        else if(_basis == Units::MOLE)
            dpdT_dN_1ph_out[presentPhaseIndex_out[i]] = theta_ * d_ / psi_ * averageMolarMass(X, size_X, X_unit);

        dpdd_TN_1ph_out[presentPhaseIndex_out[i]] = 1.0 / psi_;
        presentPhaseIndex_out[i]++; // +1 due to modelica vectors starting at 1
    }

    double *vapCmp = FluidProp.VaporCmp("Ps", p, s, &ErrorMsg);
    checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_psX", "VaporCmp failed");
    double *liqCmp = FluidProp.LiquidCmp("Ps", p, s, &ErrorMsg);
    checkFluidPropError(ErrorMsg, "FluidPropCalculator::calcThermoProperties_psX", "LiquidCmp failed");

    for(int c = 0; c < _numCompounds; ++c)
    {
        phaseCompositions_out[c] = vapCmp[c];
        phaseCompositions_out[_numCompounds + c] = liqCmp[c];
    }
}

//! Check if FluidProp returned an error
bool FluidPropCalculator::isError(const string ErrorMsg)
{
    if(ErrorMsg == "No errors")
        return false;
    else
        return true;
}

//! Check if FluidProp returned a license error
bool FluidPropCalculator::licenseError(const string ErrorMsg)
{
    if (ErrorMsg.find("license") != std::string::npos)
        return true;
    else
        return false;
}

void FluidPropCalculator::checkFluidPropError(const string ErrorMsg, const char* function, const char* description) {
    if (FluidPropCalculator::isError(ErrorMsg)) {
        errorMessage(function, "%s\n\tFluidProp returned: %s", description, ErrorMsg.c_str());
    }
}

double FluidPropCalculator::averageMolarMass(const double X[], size_t size_X, Units::Basis X_unit) const
{
    double massTotal = totalMass(X, size_X, X_unit);
    double moleTotal = totalMole(X, size_X, X_unit);
    return massTotal / moleTotal;
}

double FluidPropCalculator::averageMolarMass_X(const double X[], size_t size_X, Units::Basis X_unit, BaseCalculatorCache *cache) const
{
    return averageMolarMass(X, size_X, X_unit);
}

int FluidPropCalculator::getNumberOfPhases() const
{
     return 2;
}

int FluidPropCalculator::getNumberOfCompounds() const
{
     return _numCompounds;
}

void FluidPropCalculator::getPhaseProperties(char** phaseLabel, char** stateOfAggregation, size_t numPossiblePhases) const
{
    // check number of phases
    if((size_t) getNumberOfPhases() > numPossiblePhases)
    {
        errorMessage("FluidPropCalculator", "Actual number of phases is larger than expected number of phases");
        return;
    }

    // get phase names
    const char* phaseVapor = "Vapor";
    const char* phaseLiquid = "Liquid";
    
    setModelicaString(&phaseLabel[0], phaseVapor);
    setModelicaString(&phaseLabel[1], phaseLiquid);
    setModelicaString(&stateOfAggregation[0], phaseVapor);
    setModelicaString(&stateOfAggregation[1], phaseLiquid);
}
#endif //FLUIDPROP == 1

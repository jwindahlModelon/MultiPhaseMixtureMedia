// ExternalMultiPhaseMixtureTester.h : Include file for the ExternalMultiPhaseMixtureTester.

#ifndef EXTERNALMULTIPHASEMIXTURETESTER_H_
#define EXTERNALMULTIPHASEMIXTURETESTER_H_

#include <math.h>

#include "gtest/gtest.h"
#include "externalmixturemedialib.h"
#include "config.h"
#include "units.h"

//! Not a number
#ifndef NAN
#define NAN (_Nan._Double)
#endif

#define NUM_PHASES 3
#define VAPOR_INDEX 0
#define LIQUID_INDEX 1
#define SOLID_INDEX 2
#define UNKNOWN -8888.88

#define NOT_UNKNOWN(a) (a != UNKNOWN)

// Allowed error for various properties
// TODO: maybe one error margin for all values?
#define ABS_ERROR 1e-6
#define ABS_P_ERROR 1e+1
#define ABS_T_ERROR 1e-2
#define ABS_D_ERROR 1e-1
#define ABS_H_ERROR 1e+0
#define ABS_S_ERROR 1e-3
#define ABS_CP_ERROR 1e-3
#define ABS_CV_ERROR 1e-2
#define ABS_A_ERROR 1e-1
#define ABS_DPDT_ERROR 1e-1
#define ABS_DPDD_ERROR 1e0
#define ABS_BETA_ERROR 1e-7
#define ABS_KAPPA_ERROR 1e-13

// Macro for easy declaration of output params
#define CALC_THERMO_PROPERTIES_OUTPUTS(size_X) \
    double p_overall_out = NAN; \
    double T_overall_out = NAN; \
    double d_overall_out = NAN; \
    double h_overall_out = NAN; \
    double s_overall_out = NAN; \
    double d_1ph_out[NUM_PHASES] = { 0 }; \
    double h_1ph_out[NUM_PHASES] = { 0 }; \
    double s_1ph_out[NUM_PHASES] = { 0 }; \
    double Pr_1ph_out[NUM_PHASES] = { 0 }; \
    double a_1ph_out[NUM_PHASES] = { 0 }; \
    double beta_1ph_out[NUM_PHASES] = { 0 }; \
    double cp_1ph_out[NUM_PHASES] = { 0 }; \
    double cv_1ph_out[NUM_PHASES] = { 0 }; \
    double kappa_1ph_out[NUM_PHASES] = { 0 }; \
    double lambda_1ph_out[NUM_PHASES] = { 0 }; \
    double eta_1ph_out[NUM_PHASES] = { 0 }; \
    double dpdT_dN_1ph_out[NUM_PHASES] = { 0 }; \
    double dpdd_TN_1ph_out[NUM_PHASES] = { 0 }; \
    int nbrOfPresentPhases_out = -1; \
    int presentPhaseIndex_out[NUM_PHASES] = { 0 }; \
    double phaseCompositions_out[NUM_PHASES * size_X] = { 0 }; \
    double phaseFractions_out[NUM_PHASES * size_X] = { 0 }


// Macro for easy call to dTX function
#define CALL_CALC_THERMO_PROPERTIES_DTX() \
    MultiPhaseMixtureMedium_calcThermoProperties_dTX_C_impl( \
    d, T, X, size_X, X_unit, phase_id, material, \
    &p_overall_out, &T_overall_out, &d_overall_out, &h_overall_out, &s_overall_out, \
    d_1ph_out, h_1ph_out, s_1ph_out, Pr_1ph_out, a_1ph_out, beta_1ph_out, cp_1ph_out, cv_1ph_out, \
    kappa_1ph_out, lambda_1ph_out, eta_1ph_out, dpdT_dN_1ph_out, dpdd_TN_1ph_out, \
    &nbrOfPresentPhases_out, presentPhaseIndex_out, phaseCompositions_out, phaseFractions_out)


// Macro for easy call to phX function
#define CALL_CALC_THERMO_PROPERTIES_PHX() \
    MultiPhaseMixtureMedium_calcThermoProperties_phX_C_impl( \
    p, h, X, size_X, X_unit, phase_id, material, \
    &p_overall_out, &T_overall_out, &d_overall_out, &h_overall_out, &s_overall_out, \
    d_1ph_out, h_1ph_out, s_1ph_out, Pr_1ph_out, a_1ph_out, beta_1ph_out, cp_1ph_out, cv_1ph_out, \
    kappa_1ph_out, lambda_1ph_out, eta_1ph_out, dpdT_dN_1ph_out, dpdd_TN_1ph_out, \
    &nbrOfPresentPhases_out, presentPhaseIndex_out, phaseCompositions_out, phaseFractions_out)


// Macro for easy call to psX function
#define CALL_CALC_THERMO_PROPERTIES_PSX() \
    MultiPhaseMixtureMedium_calcThermoProperties_psX_C_impl( \
    p, s, X, size_X, X_unit, phase_id, material, \
    &p_overall_out, &T_overall_out, &d_overall_out, &h_overall_out, &s_overall_out, \
    d_1ph_out, h_1ph_out, s_1ph_out, Pr_1ph_out, a_1ph_out, beta_1ph_out, cp_1ph_out, cv_1ph_out, \
    kappa_1ph_out, lambda_1ph_out, eta_1ph_out, dpdT_dN_1ph_out, dpdd_TN_1ph_out, \
    &nbrOfPresentPhases_out, presentPhaseIndex_out, phaseCompositions_out, phaseFractions_out)


// Macro for easy call to pTX function
#define CALL_CALC_THERMO_PROPERTIES_PTX() \
    MultiPhaseMixtureMedium_calcThermoProperties_pTX_C_impl( \
    p, T, X, size_X, X_unit, phase_id, material, \
    &p_overall_out, &T_overall_out, &d_overall_out, &h_overall_out, &s_overall_out, \
    d_1ph_out, h_1ph_out, s_1ph_out, Pr_1ph_out, a_1ph_out, beta_1ph_out, cp_1ph_out, cv_1ph_out, \
    kappa_1ph_out, lambda_1ph_out, eta_1ph_out, dpdT_dN_1ph_out, dpdd_TN_1ph_out, \
    &nbrOfPresentPhases_out, presentPhaseIndex_out, phaseCompositions_out, phaseFractions_out)


struct TestProperties
{
    // pressure
    double _p;

    // temperature
    double _T;

    // density
    double _d;

    // enthalpy
    double _h;

    // entropy
    double _s;

    double _a_1ph_out[NUM_PHASES];
    double _beta_1ph_out[NUM_PHASES];
    double _cp_1ph_out[NUM_PHASES];
    double _cv_1ph_out[NUM_PHASES];
    double _kappa_1ph_out[NUM_PHASES];
    double _lambda_1ph_out[NUM_PHASES];
    double _eta_1ph_out[NUM_PHASES];
    double _dpdT_dN_1ph_out[NUM_PHASES];
    double _dpdd_TN_1ph_out[NUM_PHASES];

    std::vector<double> _phaseCompositions;

    // phase fractions
    double _phaseFractions_out[NUM_PHASES];

    TestProperties()
    {
        _p = 0.0;
        _T = 0.0;
        _d = 0.0;
        _h = 0.0;
        _s = 0.0;
        _phaseFractions_out[VAPOR_INDEX] = 0.0;
        _phaseFractions_out[LIQUID_INDEX] = 0.0;
        _phaseFractions_out[SOLID_INDEX] = 0.0;
        _a_1ph_out[VAPOR_INDEX] = 0.0;
        _a_1ph_out[LIQUID_INDEX] = 0.0;
        _a_1ph_out[SOLID_INDEX] = 0.0;
        _beta_1ph_out[VAPOR_INDEX] = 0.0;
        _beta_1ph_out[LIQUID_INDEX] = 0.0;
        _beta_1ph_out[SOLID_INDEX] = 0.0;
        _cp_1ph_out[VAPOR_INDEX] = 0.0;
        _cp_1ph_out[LIQUID_INDEX] = 0.0;
        _cp_1ph_out[SOLID_INDEX] = 0.0;
        _cv_1ph_out[VAPOR_INDEX] = 0.0;
        _cv_1ph_out[LIQUID_INDEX] = 0.0;
        _cv_1ph_out[SOLID_INDEX] = 0.0;
        _kappa_1ph_out[VAPOR_INDEX] = 0.0;
        _kappa_1ph_out[LIQUID_INDEX] = 0.0;
        _kappa_1ph_out[SOLID_INDEX] = 0.0;
        _lambda_1ph_out[VAPOR_INDEX] = 0.0;
        _lambda_1ph_out[LIQUID_INDEX] = 0.0;
        _lambda_1ph_out[SOLID_INDEX] = 0.0;
        _eta_1ph_out[VAPOR_INDEX] = 0.0;
        _eta_1ph_out[LIQUID_INDEX] = 0.0;
        _eta_1ph_out[SOLID_INDEX] = 0.0;
        _dpdT_dN_1ph_out[VAPOR_INDEX] = 0.0;
        _dpdT_dN_1ph_out[LIQUID_INDEX] = 0.0;
        _dpdT_dN_1ph_out[SOLID_INDEX] = 0.0;
        _dpdd_TN_1ph_out[VAPOR_INDEX] = 0.0;
        _dpdd_TN_1ph_out[LIQUID_INDEX] = 0.0;
        _dpdd_TN_1ph_out[SOLID_INDEX] = 0.0;

    }
    /*
    TestProperties(double p, double T, double d, double h, double s) : _p(p), _T(T), _d(d), _h(h), _s(s)
    {
    }

    TestProperties( double p, double T, double d, double h, double s,
                    double a_1ph_out, double beta_1ph_out, double cp_1ph_out,
                    double cv_1ph_out, double kappa_1ph_out, double lambda_1ph_out,
                    double eta_1ph_out, double dpdT_dN_1ph_out, double dpdd_TN_1ph_out) :
                    _p(p), _T(T), _d(d), _h(h), _s(s),
                    _a_1ph_out(a_1ph_out), _beta_1ph_out(beta_1ph_out), _cp_1ph_out(cp_1ph_out),
                    _cv_1ph_out(cv_1ph_out), _kappa_1ph_out(kappa_1ph_out), _lambda_1ph_out(lambda_1ph_out),
                    _eta_1ph_out(eta_1ph_out), _dpdT_dN_1ph_out(dpdT_dN_1ph_out), _dpdd_TN_1ph_out(dpdd_TN_1ph_out)
    {
    }
    */

};


#endif /*EXTERNALMULTIPHASEMIXTURETESTER_H_*/

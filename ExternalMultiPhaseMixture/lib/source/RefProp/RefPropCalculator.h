#ifndef RefPropCalculator_H_
#define RefPropCalculator_H_

#include "config.h"
#if REFPROP

#include <stdio.h>
#include "basecalculator.h"


#if defined(_WIN32)
# define USE_LOADLIBRARY
#elif __APPLE__
# define USE_DLOPEN
#elif __linux
# define USE_DLOPEN
#else

#endif

#if defined(USE_LOADLIBRARY)
# include <windows.h>
#elif defined(USE_DLOPEN)
# include <dlfcn.h>
#endif


class RefPropCalculator : public BaseCalculator {
public:

    RefPropCalculator(const MaterialCalculatorSetup *setupInfo);
    virtual ~RefPropCalculator();
    virtual BaseCalculatorCache* createCache();
    virtual int getNumberOfPhases() const;
    virtual int getNumberOfCompounds() const;

    virtual double averageMolarMass_X(const double X[], size_t size_X, Units::Basis X_unit, BaseCalculatorCache *cache) const;

    virtual void calcThermoProperties_TFX(double T, const double phaseFraction[], Units::Basis F_unit, const double X[], Units::Basis X_unit, int solutionType, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

    virtual void calcThermoProperties_pFX(double p, const double phaseFraction[], Units::Basis F_unit, const double X[], Units::Basis X_unit, int solutionType, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

    virtual void calcThermoProperties_phX(double p, double h, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

    virtual void calcThermoProperties_duX(double d, double u, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

    virtual void calcThermoProperties_dTX(double d, double T, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

    virtual void calcThermoProperties_psX(double p, double s, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

    virtual void calcThermoProperties_pTX(double p, double T, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

     /**
	 * Get phase properties.
     *
     * @param phaseLabel Pointer to a string array defining the phase labels (output)
     * @param stateOfAggregation Pointer to a string array defining the state of aggregation for each phase (supported values: Vapor,Liquid,Solid,Unknown) (output)
     * @param numPossiblePhases Size of string arrays
     */
    virtual void getPhaseProperties(char** phaseLabel, char** stateOfAggregation, size_t numPossiblePhases) const;
	
	
	// Function to add later to BaseCalculator interface -when added to interface remove RefPropCalculator::
    virtual void RefPropCalculator::fugacity_pTN(double p, double T, const double N[], int phaseId, double fugacity_out[]);
    virtual double RefPropCalculator::criticalTemperature_X(const double* X);
    virtual double RefPropCalculator::criticalPressure_X(const double* X);
    virtual double RefPropCalculator::criticalDensity_X(const double* X);

protected:
    class Cache : public BaseCalculatorCache {
    public:
        // TODO: implement necessary caching functionality
    };
    void RefPropCalculator::loadLibrary(std::string path);
    void RefPropCalculator::convert_X_to_Z(const double* X, double Z[], double &wmix) const;
    double RefPropCalculator::density_pTz(double p_SI, double T, double z[], int phaseId);
    void RefPropCalculator::calcPhase(double &vaporFraction, int &phase);
    double RefPropCalculator::convertDensity_kg_per_m3_to_mol_per_l(double z[], double d_kg_per_m3, bool moleFractionInput);
    double RefPropCalculator::convertDensity_mol_per_l_to_kg_per_m3(double z[], double d_mol_per_l, bool moleFractionInput);

    virtual void RefPropCalculator::calcTransportProperties_SinglePhase(double temperature, double density, double bulkMoleFraction[],
        double &eta, double &lambda, const char *callingFunction);

    void RefPropCalculator::calcAndSetProperties(double q, double z[], double x[], double y[], double p_overall, double h_overall, double T_overall, double d_overall, double s_overall,
        double Dl, double Dv,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[], int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[], const char *callingFunction);
    double RefPropCalculator::criticalParameters_X(const double* X, int output, const char *callingFunction);
    void RefPropCalculator::setValues(double q, double *z, double *x, double *y, double p_overall, double h_overall, double T_overall, double d_overall, double s_overall,
        double d_1ph[], double h_1ph[], double s_1ph[],
        double a_1ph[], double cp_1ph[], double cv_1ph[], double eta_1ph[], double lambda_1ph[], double kappa_1ph[], double beta_1ph[], int phase_out, double dpdT_1ph[], double dpdd_1ph[],
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[]);
    double molarMass_X(const double* X) const;
    void setFluidConstants();
    void RefPropCalculator::setPhaseValues(double q, double z[], double x[], double y[], int phase, int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);
    std::string RefPropCalculator::formatX(const double* X, const int size_X);

    void *RefPropCalculator::getFunctionPointer(const char* name);
    string *mIupacName;
    string *mCasRegistryNumber;
    string *mChemicalFormula;
    string *mCompoundId;
    double *mMolecularWeight;
    double *mNormalBoilingTemperature;

    double mMM_inv; //Molar mass inverse - used in many conversions
    double mLimits_EOS_tmin; // Equation of state min Temperature limit
    double mLimits_EOS_tmax; // Equation of state max T limit
    double mLimits_EOS_Dmax; // Equation of state min density limit
    double mLimits_EOS_pmax; // Equation of state max pressure limit
    long m_nc; // Number of components in the mixture
    static const long ncmax = 20;   // Note: ncmax is the max number of components
    double mZ_fixed[ncmax]; //Assumes fixed molar composition
    boolean mIsPureMedia; // False if mixture

# if defined(USE_LOADLIBRARY)
    HINSTANCE RefpropdllInstance;
# elif defined(USE_DLOPEN)
    void *RefpropdllInstance;
# else
#   error non-supported operating system
# endif

    /* All the RefProp DLL function pointers go in the calculator */
#   include "refPropDllDefinitions.h"

};

#endif /* REFPROP */

#endif

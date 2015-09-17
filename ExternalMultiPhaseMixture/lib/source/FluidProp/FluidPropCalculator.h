//! FluidProp calculator interface class
/*!
 * This class defines a calculator object encapsulating a FluidProp object
 *
 * The class will work if FluidProp is correctly installed, and if
 * the following files, defining the CFluidProp object, are included
 * in the C project:
 *   - FluidProp_IF.h
 *   - FluidProp_IF.cpp
 *   - FluidProp_COM.h
 *  These files are developed and maintained by TU Delft and distributed
 *  as a part of the FluidProp suite http://www.fluidprop.com
 *
 *  Compilation requires support of the COM libraries:
 *  http://en.wikipedia.org/wiki/Component_Object_Model
 *
 * To instantiate a specific FluidProp fluid, it is necessary to set
 * the libraryName and compounds package constants as in the
 * following example:
 *
 * libraryName = "FluidProp.RefProp";
 * compounds = {"H2O"};
 *
 * Instead of RefProp, it is possible to indicate TPSI, StanMix, etc.
 * Instead of H2O, it is possible to indicate any supported substance
 *
 * Francesco Casella, Christoph Richter, Roberto Bonifetto
 * 2006 - 2012
 * Copyright Politecnico di Milano, TU Braunschweig,
 * Politecnico di Torino
 ********************************************************************/

#ifndef FluidPropCalculator_H_
#define FluidPropCalculator_H_

#include "config.h"
#if (FLUIDPROP == 1)

#include "BaseCalculator.h"

#include "FluidProp_IF.h"

class FluidPropCalculator : public BaseCalculator {
private:
    std::string _modelName;
public:
    FluidPropCalculator(const MaterialCalculatorSetup *setupInfo);
    ~FluidPropCalculator();
    virtual BaseCalculatorCache* createCache();

    virtual double averageMolarMass_X(const double X[], size_t size_X, Units::Basis X_unit, BaseCalculatorCache *cache) const;

    virtual void calcThermoProperties_phX(double p, double h, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double* d_1ph_out, double* h_1ph_out, double* s_1ph_out, double* Pr_1ph_out, double* a_1ph_out, double* beta_1ph_out, double* cp_1ph_out, double* cv_1ph_out, double* kappa_1ph_out, double* lambda_1ph_out, double* eta_1ph_out,
        double* dpdT_dN_1ph_out, double* dpdd_TN_1ph_out,
        int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double* phaseCompositions_out, double* phaseFractions_out);

    virtual void calcThermoProperties_dTX(double d, double T, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double* d_1ph_out, double* h_1ph_out, double* s_1ph_out, double* Pr_1ph_out, double* a_1ph_out, double* beta_1ph_out, double* cp_1ph_out, double* cv_1ph_out, double* kappa_1ph_out, double* lambda_1ph_out, double* eta_1ph_out,
        double* dpdT_dN_1ph_out, double* dpdd_TN_1ph_out,
        int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double* phaseCompositions_out, double* phaseFractions_out);

    virtual void calcThermoProperties_psX(double p, double s, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double* d_1ph_out, double* h_1ph_out, double* s_1ph_out, double* Pr_1ph_out, double* a_1ph_out, double* beta_1ph_out, double* cp_1ph_out, double* cv_1ph_out, double* kappa_1ph_out, double* lambda_1ph_out, double* eta_1ph_out,
        double* dpdT_dN_1ph_out, double* dpdd_TN_1ph_out,
        int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double* phaseCompositions_out, double* phaseFractions_out);

    virtual void calcThermoProperties_pTX(double p, double T, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double* d_1ph_out, double* h_1ph_out, double* s_1ph_out, double* Pr_1ph_out, double* a_1ph_out, double* beta_1ph_out, double* cp_1ph_out, double* cv_1ph_out, double* kappa_1ph_out, double* lambda_1ph_out, double* eta_1ph_out,
        double* dpdT_dN_1ph_out, double* dpdd_TN_1ph_out,
        int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double* phaseCompositions_out, double* phaseFractions_out);

protected:
    class Cache : public BaseCalculatorCache {
    public:
        // TODO: implement necessary caching functionality
    };

    //! get the substance constants
    void setSubstanceConstants();

    //! Set substance properties
    /*!
      @param X mole vector
      @param sizeX size of vector X
      @param X_unit unit basis of X vector
    */
    void setSubstanceProperties(const double *X, size_t sizeX, Units::Basis X_unit);

    TFluidProp FluidProp; // Instance of FluidProp wrapper object

    static bool isError(const string ErrorMsg);
    static bool licenseError(const string ErrorMsg);
    static void checkFluidPropError(const string errorMsg, const char* function, const char* description);

    double averageMolarMass(const double X[], size_t size_X, Units::Basis X_unit) const;
    
    //! Returns number of supported phases
    /*!
      @return Number of supported phases
    */
    virtual int getNumberOfPhases() const;

    //! Returns number of compounds
    /*!
      @return Number of compounds
    */
    virtual int getNumberOfCompounds() const;

    /** 
     * Get phase properties.
     *
     * @param phaseLabel Pointer to a string array defining the phase labels (output)
     * @param stateOfAggregation Pointer to a string array defining the state of aggregation for each phase (supported values: Vapor,Liquid,Solid,Unknown) (output)
     * @param numPossiblePhases Size of string arrays
     */
    virtual void getPhaseProperties(char** phaseLabel, char** stateOfAggregation, size_t numPossiblePhases) const;

};

#endif // FLUIDPROP == 1

#endif /*FluidPropCalculator_H_*/

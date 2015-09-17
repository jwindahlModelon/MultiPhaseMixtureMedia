/**
 * @file CapeOpenCalculator.h
 * Header file with the definition of the CapeOpenCalculator class.
 */

#ifndef CapeOpenCalculator_H_
#define CapeOpenCalculator_H_

#include "config.h"
#if (CAPEOPEN == 1)

#include "COstdafx.h"
#include "BaseCalculator.h"
#include "COConsts.h"

// Forward declarations:
class ICapeOpenSocket;
class PropertyPackageManager;

/**
 * ExternalMixtureMedia calculator for thermo dynamic property packages that
 * support the CAPE-OPEN interface.
 */
class CapeOpenCalculator : public BaseCalculator
{
private:
    ICapeOpenSocket* _socket;

    static PropertyPackageManager* ppm;

    /**
     * Calculates the specified flash, using the specified properties as inputs.
     *
     * @param prop1 The first input property of the flash.
     * @param prop2 the second input property of the flash.
     * @param prop1Name The name of the first input property.
     * @param prop2Name The name of the second input property.
     * @param flashType The name of the flash type.
     */
    void doFlash(double prop1, double prop2, const BSTR prop1Name,
                 const BSTR prop2Name, COFlashTypes::Enum flashType);
    /**
     * Calculates all overall properties. Make sure that a flash has been
     * executed before calling this.
     */
    void doCalcOverall();
    /**
     * Calculates all non-overall properties under all present phases. Make sure
     * that a flash has been executed before calling this.
     *
     * @param phaseIds An array with the ids of the present phases.
     * @param nPhases The number of phase ids.
     */
    void doCalcPhases(const size_t* phaseIds, size_t nPhases);
    /** Returns number of supported phases
    *
    *  @return Number of supported phases
    */
    virtual int getNumberOfPhases() const;
    /** Returns number of compounds
    *
    *  @return Number of compounds
    *
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
    /**
     * Gets the phases and phase fractions at equilibrium. Make sure that a
     * flash has been executed before calling this.
     *
     * @param phaseIds An array for the output present phase ids.
     * @param nPhases The output number of present phases.
     * @param phaseFractions An array for the output phase fractions.
     */
    void getPhases(size_t* phaseIds, size_t& nPhases, double* phaseFractions);
    /**
     * Gets the specified overall property. Make sure that a calculation has
     * been executed before calling this.
     *
     * @param propName The name of the property.
     * @param prop The output property.
     */
    void getPropOverall(const BSTR propName, double& prop);
    /**
     * Gets the specified non-overall property. Make sure that a calculation has
     * been executed before calling this.
     *
     * @param propName The name of the property.
     * @param phaseIds An array with the ids of the present phases.
     * @param nPhases The number of phases.
     * @param prop An array for the output properties in the phases.
     */
    void getPropPhases(const BSTR propName, const size_t* phaseIds,
                       size_t nPhases, double* prop);
    /**
     * Gets the specified non-overall property per component. Make sure that a calculation has
     * been executed before calling this.
     *
     * @param propName The name of the property.
     * @param phaseIds An array with the ids of the present phases.
     * @param nPhases The number of phases.
     * @param prop An array for the output properties in the phases.
     */
    void getPropPhasesPerComponent(const BSTR propName,
                                       const size_t* phaseIds, size_t nPhases,
                                       double* prop);
    /**
     * Gets the specified property under the specified phase. Make sure that a
     * calculation has been executed before calling this.
     *
     * @param property The name of the property.
     * @param phase The name of the phase.
     * @param prop The output property.
     */
    void getProp(BSTR property, BSTR phase, double& prop);

    /**
     * Gets the specified property under the specified phase per component. Make sure that a
     * calculation has been executed before calling this.
     *
     * @param prop The name of the property.
     * @param phase The name of the phase.
     * @param val Pointer to double array holding values of properties (output).
     */
    void getPropPerComponent(BSTR prop, BSTR phase, double *val);

    /**
     * Get the basis as a CO Constant string.
     *
     */
    const BSTR getBasisAsCOBasis(void);

    /**
     * Sets the substance properties
     *
     * @param X pointer to array holding the fraction values.
     * @param size_X Number of fraction elements.
     * @param X_unit Unit basis of fraction values.
     */
    void setSubstanceProperties(const double* X, size_t size_X, Units::Basis X_unit);

    /**
     * Calculate the average molar mass
     *
     * @param X pointer to array holding the fraction values
     * @param size_X Number of fraction elements
     * @param X_unit Unit basis of fraction values
     */
    double averageMolarMass(const double X[], size_t size_X, Units::Basis X_unit) const;
public:
    CapeOpenCalculator(const MaterialCalculatorSetup* setupInfo);
    ~CapeOpenCalculator();
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
    class Cache : public BaseCalculatorCache
    {
    public:
        // TODO: implement necessary caching functionality
    };

    virtual void setSubstanceConstants();
};

#endif // CAPEOPEN == 1

#endif

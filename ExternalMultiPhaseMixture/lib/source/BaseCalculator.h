/**
 * @file BaseCalculator.h
 * Header file with the definition of the BaseCalculator class.
 */


#ifndef BASECALCULATOR_H_
#define BASECALCULATOR_H_

#include "BaseCalculatorCache.h"
#include "fluidconstants.h"
#include "externalmixturemedialib.h"
#include "Units.h"

#include <string>
#include <vector>
#include <sstream>
using namespace std;

// Setup information
typedef struct {
    const char *libraryName;
    const char *compounds;
    const char *setupInfo;
} MaterialCalculatorSetup;


class BaseCalculator
{

public:
    BaseCalculator(const MaterialCalculatorSetup *setupInfo);

    /**
     * Parses the setup info object and sets the corresponding attributes accordingly.
     *
     * @param setupInfo Setup info object.
     */
    void parseSetupInfo(const MaterialCalculatorSetup *setupInfo);

    virtual BaseCalculatorCache* createCache();
    virtual ~BaseCalculator(void);

    //! Returns number of supported phases
    /*!
      @return Number of supported phases
    */
    virtual int getNumberOfPhases() const;

    /** 
     * Get phase properties.
     *
     * @param phaseLabel Pointer to a string array defining the phase labels (output)
     * @param stateOfAggregation Pointer to a string array defining the state of aggregation for each phase (supported values: Vapor,Liquid,Solid,Unknown) (output)
     * @param numPossiblePhases Size of string arrays
     */
    virtual void getPhaseProperties(char** phaseLabel, char** stateOfAggregation, size_t numPossiblePhases) const;

    //! Returns number of compounds
    /*!
      @return Number of compounds
    */
    virtual int getNumberOfCompounds() const;

    //! Compute average molar mass
    /*!
      This function computes the properties for the specified inputs.
      @param X Fraction vector
      @param size_X size of fraction vector X
      @param X_unit Unit of fraction vector (1=mass,2=mole)
      @param cache Pointer to cache object (not used)
    */
    virtual double averageMolarMass_X(const double X[], size_t size_X, Units::Basis X_unit, BaseCalculatorCache *cache) const;

    //! Compute properties from T, F, X and solutionType
    /*!
      This function computes the properties for the specified inputs.
      @param T Temperature
      @param phaseFraction Phase fraction
      @param F_unit Unit of Phase fraction
      @param X Array of doubles holding the fraction vector
      @param X_unit Unit of fraction vector (1=mass,2=mole)
      @param solutionType Solution type defining solution if multiple solutions exists
      @param cache Pointer to BaseCalculatorCache object
      @param p_overall_out Pointer to overall pressure (output)
      @param T_overall_out Pointer to overall temperature (output)
      @param d_overall_out Pointer to overall density (output)
      @param h_overall_out Pointer to overall enthalpy (output)
      @param s_overall_out Pointer to overall entropy (output)
      @param d_1ph_out Pointer to array of single phase density (output)
      @param h_1ph_out Pointer to array of single phase enthalpy (output)
      @param s_1ph_out Pointer to array of single phase entropy (output)
      @param Pr_1ph_out Pointer to array of single phase pressure (output)
      @param a_1ph_out Pointer to array of single phase speed of sound (output)
      @param beta_1ph_out Pointer to array of single phase isobaric expansion coefficient (output)
      @param cp_1ph_out Pointer to array of single phase isobaric heat capacity (output)
      @param cv_1ph_out Pointer to array of single phase isochoric heat capacity (output)
      @param kappa_1ph_out Pointer to array of single phase isothermal compressibility (output)
      @param lambda_1ph_out Pointer to array of single phase thermal conductivity  (output)
      @param eta_1ph_out Pointer to array of single phase dynamic viscosity (output)
      @param dpdT_dN_1ph_out Pointer to array of single phase partial derivative of pressure wrt density when temperature and mole fraction is constant  (output)
      @param dpdd_TN_1ph_out Pointer to array of single phase partial derivative of pressure wrt temperature when density/specificvolume and mole fraction is constant (output)
      @param nbrOfPresentPhases_out Pointer to integer holding number of present phases (output)
      @param presentPhaseIndex_out Pointer to array of integers holding the phase index (output)
      @param phaseCompositions_out Pointer to array of doubles holding the phase composition values (output)
      @param phaseFractions_out Pointer to array of doubles holding the phase fraction values (output)
    */
    virtual void calcThermoProperties_TFX(double T, const double phaseFraction[], Units::Basis F_unit, const double X[], Units::Basis X_unit, int solutionType, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

    //! Compute properties from p, F, X and solutionType
    /*!
      This function computes the properties for the specified inputs.
      @param p Pressure
      @param phaseFraction Phase fraction
      @param F_unit Unit of Phase fraction
      @param X Array of doubles holding the fraction vector
      @param X_unit Unit of fraction vector (1=mass,2=mole)
      @param solutionType Solution type defining solution if multiple solutions exists
      @param cache Pointer to BaseCalculatorCache object
      @param p_overall_out Pointer to overall pressure (output)
      @param T_overall_out Pointer to overall temperature (output)
      @param d_overall_out Pointer to overall density (output)
      @param h_overall_out Pointer to overall enthalpy (output)
      @param s_overall_out Pointer to overall entropy (output)
      @param d_1ph_out Pointer to array of single phase density (output)
      @param h_1ph_out Pointer to array of single phase enthalpy (output)
      @param s_1ph_out Pointer to array of single phase entropy (output)
      @param Pr_1ph_out Pointer to array of single phase pressure (output)
      @param a_1ph_out Pointer to array of single phase speed of sound (output)
      @param beta_1ph_out Pointer to array of single phase isobaric expansion coefficient (output)
      @param cp_1ph_out Pointer to array of single phase isobaric heat capacity (output)
      @param cv_1ph_out Pointer to array of single phase isochoric heat capacity (output)
      @param kappa_1ph_out Pointer to array of single phase isothermal compressibility (output)
      @param lambda_1ph_out Pointer to array of single phase thermal conductivity  (output)
      @param eta_1ph_out Pointer to array of single phase dynamic viscosity (output)
      @param dpdT_dN_1ph_out Pointer to array of single phase partial derivative of pressure wrt density when temperature and mole fraction is constant  (output)
      @param dpdd_TN_1ph_out Pointer to array of single phase partial derivative of pressure wrt temperature when density/specificvolume and mole fraction is constant (output)
      @param nbrOfPresentPhases_out Pointer to integer holding number of present phases (output)
      @param presentPhaseIndex_out Pointer to array of integers holding the phase index (output)
      @param phaseCompositions_out Pointer to array of doubles holding the phase composition values (output)
      @param phaseFractions_out Pointer to array of doubles holding the phase fraction values (output)
    */
    virtual void calcThermoProperties_pFX(double p, const double phaseFraction[], Units::Basis F_unit, const double X[], Units::Basis X_unit, int solutionType, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

    //! Compute properties from p, h, X and phase
    /*!
        This function computes the properties for the specified inputs.
        @param p Pressure
        @param h Specific enthalpy
        @param X Array of doubles holding the fraction vector
        @param size_X Size of fraction vector
        @param X_unit Unit of fraction vector (1=mass,2=mole)
        @param phase_id Phase identifier
        @param cache Pointer to BaseCalculatorCache object
        @param p_overall_out Pointer to overall pressure (output)
        @param T_overall_out Pointer to overall temperature (output)
        @param d_overall_out Pointer to overall density (output)
        @param h_overall_out Pointer to overall enthalpy (output)
        @param s_overall_out Pointer to overall entropy (output)
        @param d_1ph_out Pointer to array of single phase density (output)
        @param h_1ph_out Pointer to array of single phase enthalpy (output)
        @param s_1ph_out Pointer to array of single phase entropy (output)
        @param Pr_1ph_out Pointer to array of single phase pressure (output)
        @param a_1ph_out Pointer to array of single phase speed of sound (output)
        @param beta_1ph_out Pointer to array of single phase isobaric expansion coefficient (output)
        @param cp_1ph_out Pointer to array of single phase isobaric heat capacity (output)
        @param cv_1ph_out Pointer to array of single phase isochoric heat capacity (output)
        @param kappa_1ph_out Pointer to array of single phase isothermal compressibility (output)
        @param lambda_1ph_out Pointer to array of single phase thermal conductivity  (output)
        @param eta_1ph_out Pointer to array of single phase dynamic viscosity (output)
        @param dpdT_dN_1ph_out Pointer to array of single phase partial derivative of pressure wrt density when temperature and mole fraction is constant  (output)
        @param dpdd_TN_1ph_out Pointer to array of single phase partial derivative of pressure wrt temperature when density/specificvolume and mole fraction is constant (output)
        @param nbrOfPresentPhases_out Pointer to integer holding number of present phases (output)
        @param presentPhaseIndex_out Pointer to array of integers holding the phase index (output)
        @param phaseCompositions_out Pointer to array of doubles holding the phase composition values (output)
        @param phaseFractions_out Pointer to array of doubles holding the phase fraction values (output)
    */
    virtual void calcThermoProperties_phX(double p, double h, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

    //! Compute properties from d, u, X and phase
    /*!
      This function computes the properties for the specified inputs.
      @param d Density
      @param u Specific internal energy
      @param X Array of doubles holding the fraction vector
      @param size_X Size of fraction vector
      @param X_unit Unit of fraction vector (1=mass,2=mole)
      @param phase_id Phase identifier
      @param cache Pointer to BaseCalculatorCache object
      @param p_overall_out Pointer to overall pressure (output)
      @param T_overall_out Pointer to overall temperature (output)
      @param d_overall_out Pointer to overall density (output)
      @param h_overall_out Pointer to overall enthalpy (output)
      @param s_overall_out Pointer to overall entropy (output)
      @param d_1ph_out Pointer to array of single phase density (output)
      @param h_1ph_out Pointer to array of single phase enthalpy (output)
      @param s_1ph_out Pointer to array of single phase entropy (output)
      @param Pr_1ph_out Pointer to array of single phase pressure (output)
      @param a_1ph_out Pointer to array of single phase speed of sound (output)
      @param beta_1ph_out Pointer to array of single phase isobaric expansion coefficient (output)
      @param cp_1ph_out Pointer to array of single phase isobaric heat capacity (output)
      @param cv_1ph_out Pointer to array of single phase isochoric heat capacity (output)
      @param kappa_1ph_out Pointer to array of single phase isothermal compressibility (output)
      @param lambda_1ph_out Pointer to array of single phase thermal conductivity  (output)
      @param eta_1ph_out Pointer to array of single phase dynamic viscosity (output)
      @param dpdT_dN_1ph_out Pointer to array of single phase partial derivative of pressure wrt density when temperature and mole fraction is constant  (output)
      @param dpdd_TN_1ph_out Pointer to array of single phase partial derivative of pressure wrt temperature when density/specificvolume and mole fraction is constant (output)
      @param nbrOfPresentPhases_out Pointer to integer holding number of present phases (output)
      @param presentPhaseIndex_out Pointer to array of integers holding the phase index (output)
      @param phaseCompositions_out Pointer to array of doubles holding the phase composition values (output)
      @param phaseFractions_out Pointer to array of doubles holding the phase fraction values (output)
    */    
    virtual void calcThermoProperties_duX(double d, double u, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

    //! Compute properties from d, T, X and phase
    /*!
      This function computes the properties for the specified inputs.
      @param d Density
      @param T Temperature
      @param X Array of doubles holding the fraction vector
      @param size_X Size of fraction vector
      @param X_unit Unit of fraction vector (1=mass,2=mole)
      @param phase_id Phase identifier
      @param cache Pointer to BaseCalculatorCache object
      @param p_overall_out Pointer to overall pressure (output)
      @param T_overall_out Pointer to overall temperature (output)
      @param d_overall_out Pointer to overall density (output)
      @param h_overall_out Pointer to overall enthalpy (output)
      @param s_overall_out Pointer to overall entropy (output)
      @param d_1ph_out Pointer to array of single phase density (output)
      @param h_1ph_out Pointer to array of single phase enthalpy (output)
      @param s_1ph_out Pointer to array of single phase entropy (output)
      @param Pr_1ph_out Pointer to array of single phase pressure (output)
      @param a_1ph_out Pointer to array of single phase speed of sound (output)
      @param beta_1ph_out Pointer to array of single phase isobaric expansion coefficient (output)
      @param cp_1ph_out Pointer to array of single phase isobaric heat capacity (output)
      @param cv_1ph_out Pointer to array of single phase isochoric heat capacity (output)
      @param kappa_1ph_out Pointer to array of single phase isothermal compressibility (output)
      @param lambda_1ph_out Pointer to array of single phase thermal conductivity  (output)
      @param eta_1ph_out Pointer to array of single phase dynamic viscosity (output)
      @param dpdT_dN_1ph_out Pointer to array of single phase partial derivative of pressure wrt density when temperature and mole fraction is constant  (output)
      @param dpdd_TN_1ph_out Pointer to array of single phase partial derivative of pressure wrt temperature when density/specificvolume and mole fraction is constant (output)
      @param nbrOfPresentPhases_out Pointer to integer holding number of present phases (output)
      @param presentPhaseIndex_out Pointer to array of integers holding the phase index (output)
      @param phaseCompositions_out Pointer to array of doubles holding the phase composition values (output)
      @param phaseFractions_out Pointer to array of doubles holding the phase fraction values (output)
    */
    virtual void calcThermoProperties_dTX(double d, double T, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

    //! Compute properties from p, s, X and phase
    /*!
      This function computes the properties for the specified inputs.
      @param p Pressure
      @param s Specific enthalpy
      @param X Array of doubles holding the fraction vector
      @param size_X Size of fraction vector
      @param X_unit Unit of fraction vector (1=mass,2=mole)
      @param phase_id Phase identifier
      @param cache Pointer to BaseCalculatorCache object
      @param p_overall_out Pointer to overall pressure (output)
      @param T_overall_out Pointer to overall temperature (output)
      @param d_overall_out Pointer to overall density (output)
      @param h_overall_out Pointer to overall enthalpy (output)
      @param s_overall_out Pointer to overall entropy (output)
      @param d_1ph_out Pointer to array of single phase density (output)
      @param h_1ph_out Pointer to array of single phase enthalpy (output)
      @param s_1ph_out Pointer to array of single phase entropy (output)
      @param Pr_1ph_out Pointer to array of single phase pressure (output)
      @param a_1ph_out Pointer to array of single phase speed of sound (output)
      @param beta_1ph_out Pointer to array of single phase isobaric expansion coefficient (output)
      @param cp_1ph_out Pointer to array of single phase isobaric heat capacity (output)
      @param cv_1ph_out Pointer to array of single phase isochoric heat capacity (output)
      @param kappa_1ph_out Pointer to array of single phase isothermal compressibility (output)
      @param lambda_1ph_out Pointer to array of single phase thermal conductivity  (output)
      @param eta_1ph_out Pointer to array of single phase dynamic viscosity (output)
      @param dpdT_dN_1ph_out Pointer to array of single phase partial derivative of pressure wrt density when temperature and mole fraction is constant  (output)
      @param dpdd_TN_1ph_out Pointer to array of single phase partial derivative of pressure wrt temperature when density/specificvolume and mole fraction is constant (output)
      @param nbrOfPresentPhases_out Pointer to integer holding number of present phases (output)
      @param presentPhaseIndex_out Pointer to array of integers holding the phase index (output)
      @param phaseCompositions_out Pointer to array of doubles holding the phase composition values (output)
      @param phaseFractions_out Pointer to array of doubles holding the phase fraction values (output)
    */
    virtual void calcThermoProperties_psX(double p, double s, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

    //! Compute properties from p, T, X and phase
    /*!
      This function computes the properties for the specified inputs.
      @param p Pressure
      @param T Temperature
      @param X Array of doubles holding the fraction vector
      @param size_X Size of fraction vector
      @param X_unit Unit of fraction vector (1=mass,2=mole)
      @param phase_id Phase identifier
      @param cache Pointer to BaseCalculatorCache object
      @param p_overall_out Pointer to overall pressure (output)
      @param T_overall_out Pointer to overall temperature (output)
      @param d_overall_out Pointer to overall density (output)
      @param h_overall_out Pointer to overall enthalpy (output)
      @param s_overall_out Pointer to overall entropy (output)
      @param d_1ph_out Pointer to array of single phase density (output)
      @param h_1ph_out Pointer to array of single phase enthalpy (output)
      @param s_1ph_out Pointer to array of single phase entropy (output)
      @param Pr_1ph_out Pointer to array of single phase pressure (output)
      @param a_1ph_out Pointer to array of single phase speed of sound (output)
      @param beta_1ph_out Pointer to array of single phase isobaric expansion coefficient (output)
      @param cp_1ph_out Pointer to array of single phase isobaric heat capacity (output)
      @param cv_1ph_out Pointer to array of single phase isochoric heat capacity (output)
      @param kappa_1ph_out Pointer to array of single phase isothermal compressibility (output)
      @param lambda_1ph_out Pointer to array of single phase thermal conductivity  (output)
      @param eta_1ph_out Pointer to array of single phase dynamic viscosity (output)
      @param dpdT_dN_1ph_out Pointer to array of single phase partial derivative of pressure wrt density when temperature and mole fraction is constant  (output)
      @param dpdd_TN_1ph_out Pointer to array of single phase partial derivative of pressure wrt temperature when density/specificvolume and mole fraction is constant (output)
      @param nbrOfPresentPhases_out Pointer to integer holding number of present phases (output)
      @param presentPhaseIndex_out Pointer to array of integers holding the phase index (output)
      @param phaseCompositions_out Pointer to array of doubles holding the phase composition values (output)
      @param phaseFractions_out Pointer to array of doubles holding the phase fraction values (output)
    */
    virtual void calcThermoProperties_pTX(double p, double T, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]);

protected:
    //! Fluid constants
    vector<FluidConstants> _fluidConstants;

    //! Unit basis
    Units::Basis _basis;

    string _libraryName;
    vector<string> _compounds;
    int _numCompounds;

    //! Convert to moles fractions according to given X unit
    /*!
      @param X mole vector
      @param sizeX size of vector X
      @param X_unit unit basis of X vector
    */
    void convert2MoleFractions(const double *X, size_t sizeX, Units::Basis X_unit, double *Z) const;
    double BaseCalculator::totalMass(const double *X, size_t sizeX, Units::Basis X_unit) const;
    double BaseCalculator::totalMole(const double *X, size_t sizeX, Units::Basis X_unit) const;

    void setModelicaString(char** dest, const char* src) const;

};

#endif // BASECALCULATOR_H_

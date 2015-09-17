/*!
  \file externalmixturemedialib.h
  \brief Header file to be included in the Modelica tool, with external function interfaces

  C/C++ layer for external mixture medium models

  Johan Windahl Modelon AB
  2014
*/

#ifndef EXTERNALMIXTUREMEDIALIB_H_
#define EXTERNALMIXTUREMEDIALIB_H_


// Define export
#if defined(BUILD_DLL)
# define C_API __declspec(dllexport)
#elif defined(USE_DLL)
# define C_API __declspec(dllexport)
#else
# define C_API
#endif


#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

//! This function returns a Material object which consist of a pointer to a PropertyCalculator object (one calculator object can be shared with several Material objects) and a cache instance (which may be used by the PropertyCalculator object)
/*!
  @param libraryName Name of model library to be used for calculation
  @param compounds String containing the compounds of the substance
  @param setupInfo Setup settings for calculation
*/
void* getMaterial(const char *libraryName, const char *compounds, const char *setupInfo);

//! Clean up material
/*!
  @param object Pointer to material object
*/
void closeMaterial(void* object);

// Additional properties -they have in common that they not involve an phase equilibrium calculation

//C_API double MultiPhaseMixtureMedium_criticalTemperature_X_C_impl(const double* X, void *object);
//C_API double MultiPhaseMixtureMedium_criticalPressure_X_C_impl(const double* X, void *object);
//C_API double MultiPhaseMixtureMedium_criticalDensity_X_C_impl(const double* X, void *object);

//! Compute average molar mass
/*!
  This function computes the properties for the specified inputs.
  @param X Fraction vector
  @param size_X size of fraction vector X
  @param X_unit Unit basis of fraction vector (1=mass,2=mole)
  @param object Material object
  @return Average molar mass
*/
C_API double MultiPhaseMixtureMedium_averageMolarMass_X_C_impl(const double X[], size_t size_X, int X_unit, void *object);

//! Returns number of supported phases
/*!
  @param object Material object
  @return Number of supported phases
*/
C_API int MultiPhaseMixtureMedium_getNumberOfPhases_C_impl(void *object);

//! Returns number of compounds
/*!
  @param object Material object
  @return Number of compounds
*/
C_API int MultiPhaseMixtureMedium_getNumberOfCompounds_C_impl(void *object);

// C_API void getCompoundList(const char* id[], const char* chemicalFormula[], const char** casRegistryNumber, const char** iupacName, double  molecularWeight[], double normalBoilingTemperature[]);


// Arrays is not currently allowed within record in Modelica-C interface, so splitted up properties record into arguments

//! Compute properties from T, F, X and solutionType
/*!
  This function computes the properties for the specified inputs.
  @param T Temperature
  @param phaseFraction Phase fraction
  @param F_unit Unit of Phase fraction
  @param X Array of doubles holding the fraction vector
  @param X_unit Unit of fraction vector (1=mass,2=mole)
  @param solutionType Solution type defining solution if multiple solutions exists
  @param object Pointer to material object
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
C_API void MultiPhaseMixtureMedium_calcThermoProperties_TFX_C_impl(double T, const double phaseFraction[], int F_unit, const double X[], int X_unit, int solutionType, void *object,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double phaseCompositions_out[], double phaseFractions_out[]);

//! Compute properties from p, F, X and solutionType
/*!
  This function computes the properties for the specified inputs.
  @param p Pressure
  @param phaseFraction Phase fraction
  @param F_unit Unit of Phase fraction
  @param X Array of doubles holding the fraction vector
  @param X_unit Unit of fraction vector (1=mass,2=mole)
  @param solutionType Solution type defining solution if multiple solutions exists
  @param object Pointer to material object
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
C_API void MultiPhaseMixtureMedium_calcThermoProperties_pFX_C_impl(double p, const double phaseFraction[], int F_unit, const double X[], int X_unit, int solutionType, void *object,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double phaseCompositions_out[], double phaseFractions_out[]);

//! Compute properties from d, u, X and phase
/*!
  This function computes the properties for the specified inputs.
  @param d Density
  @param u Specific internal energy
  @param X Array of doubles holding the fraction vector
  @param size_X Size of fraction vector
  @param X_unit Unit of fraction vector (1=mass,2=mole)
  @param phase_id Phase identifier
  @param object Pointer to material object
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
C_API void MultiPhaseMixtureMedium_calcThermoProperties_duX_C_impl(double d, double u, const double X[], size_t size_X, int X_unit, int phase_id, void *object,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double phaseCompositions_out[], double phaseFractions_out[]);

//! Compute properties from p, h, X and phase
/*!
  This function computes the properties for the specified inputs.
  @param p Pressure
  @param h Specific enthalpy
  @param X Array of doubles holding the fraction vector
  @param size_X Size of fraction vector
  @param X_unit Unit of fraction vector (1=mass,2=mole)
  @param phase_id Phase identifier
  @param object Pointer to material object
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
C_API void MultiPhaseMixtureMedium_calcThermoProperties_phX_C_impl(double p, double h, const double X[], size_t size_X, int X_unit, int phase_id, void *object,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double phaseCompositions_out[], double phaseFractions_out[]);

//! Compute properties from d, T, X and phase
/*!
  This function computes the properties for the specified inputs.
  @param d Density
  @param T Temperature
  @param X Array of doubles holding the fraction vector
  @param size_X Size of fraction vector
  @param X_unit Unit of fraction vector (1=mass,2=mole)
  @param phase_id Phase identifier
  @param object Pointer to material object
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
C_API void MultiPhaseMixtureMedium_calcThermoProperties_dTX_C_impl(double d, double T, const double X[], size_t size_X, int X_unit, int phase_id, void *object,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double phaseCompositions_out[], double phaseFractions_out[]);

//! Compute properties from p, s, X and phase
/*!
  This function computes the properties for the specified inputs.
  @param p Pressure
  @param s Specific enthalpy
  @param X Array of doubles holding the fraction vector
  @param size_X Size of fraction vector
  @param X_unit Unit of fraction vector (1=mass,2=mole)
  @param phase_id Phase identifier
  @param object Pointer to material object
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
C_API void MultiPhaseMixtureMedium_calcThermoProperties_psX_C_impl(double p, double s, const double X[], size_t size_X, int X_unit, int phase_id, void *object,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double phaseCompositions_out[], double phaseFractions_out[]);

//! Compute properties from p, T, X and phase
/*!
  This function computes the properties for the specified inputs.
  @param p Pressure
  @param T Temperature
  @param X Array of doubles holding the fraction vector
  @param size_X Size of fraction vector
  @param X_unit Unit of fraction vector (1=mass,2=mole)
  @param phase_id Phase identifier
  @param object Pointer to material object
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
C_API void MultiPhaseMixtureMedium_calcThermoProperties_pTX_C_impl(double p, double T, const double X[], size_t size_X, int X_unit, int phase_id, void *object,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double phaseCompositions_out[], double phaseFractions_out[]);

//! Initialize test code generation
C_API void InitTestCodeLogging();

//! Finalize test code logging
C_API void FinalizeTestCodeLogging();

//! Get phase properties.
/*!
  @param object Material object
  @param phaseLabel Pointer to a string array defining the phase labels (output)
  @param stateOfAggregation Pointer to a string array defining the state of aggregation for each phase (supported values: Vapor,Liquid,Solid,Unknown) (output)
  @param numPossiblePhases Size of string arrays
*/
C_API void MultiPhaseMixtureMedium_getPhaseProperties_C_impl(void *object, const char** phaseLabel, const char** stateOfAggregation, const size_t numPossiblePhases);

#ifdef __cplusplus
}
#endif // __cplusplus

#undef C_API

#endif /*EXTERNALMIXTUREMEDIALIB_H_*/

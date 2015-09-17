/*!
  \file externalmedialib.h
  \brief Header file to be included in the Modelica tool, with external function interfaces

  C/C++ layer for external medium models extending from
  PartialExternalTwoPhaseMedium.

  Francesco Casella, Christoph Richter, Roberto Bonifetto
  2006-2012
  Copyright Politecnico di Milano, TU Braunschweig, Politecnico di Torino
*/

#ifndef EXTERNALMEDIALIB_H_
#define EXTERNALMEDIALIB_H_
// Constants for input choices (see ExternalMedia.Common.InputChoices)
#define CHOICE_dT 1
#define CHOICE_ph 2
#define CHOICE_ps 3
#define CHOICE_pT 4

// Define struct
//! ExternalThermodynamicState property struct
/*!
  The ExternalThermodynamicState propery struct defines all the properties that
  are computed by external Modelica medium models extending from
  PartialExternalTwoPhaseMedium.
*/

typedef struct {

	//! Prandtl number
    double Pr;
	//! Temperature
	double T;
	//! Velocity of sound
	double a;
	//! Isobaric expansion coefficient
    double beta;
	//! Specific heat capacity cp
    double cp;
	//! Specific heat capacity cv
    double cv;
	//! Density
    double d;
	//! Derivative of density wrt enthalpy at constant pressure
    double ddhp;
	//! Derivative of density wrt pressure at constant enthalpy
    double ddph;
	//! Dynamic viscosity
    double eta;
	//! Specific enthalpy
    double h;
	//! Compressibility
    double kappa;
	//! Thermal conductivity
    double lambda;
	//! Pressure
    double p;
	//! Phase flag: 2 for two-phase, 1 for one-phase
    int phase;
	//! Specific entropy
    double s;
	//! Composition in each phase - mass based
	double *phaseComposition;

} ExternalThermodynamicState;

//! ExternalSaturationProperties property struct
/*!
  The ExternalSaturationProperties propery struct defines all the saturation properties
  for the dew and the bubble line that are computed by external Modelica medium models
  extending from PartialExternalTwoPhaseMedium.
*/

typedef struct {
	//! Saturation temperature
    double Tsat;
	//! Derivative of Ts wrt pressure
    double dTp;
	//! Derivative of dls wrt pressure
    double ddldp;
	//! Derivative of dvs wrt pressure
    double ddvdp;
	//! Derivative of hls wrt pressure
    double dhldp;
	//! Derivative of hvs wrt pressure
    double dhvdp;
	//! Density at bubble line (for pressure ps)
    double dl;
	//! Density at dew line (for pressure ps)
    double dv;
	//! Specific enthalpy at bubble line (for pressure ps)
    double hl;
	//! Specific enthalpy at dew line (for pressure ps)
    double hv;
	//! Saturation pressure
    double psat;
	//! Surface tension
    double sigma;
	//! Specific entropy at bubble line (for pressure ps)
    double sl;
	//! Specific entropy at dew line (for pressure ps)
    double sv;
} ExternalSaturationProperties;

// Extended interface
typedef struct{
    //! Fluid Compounds
  const char* compounds;
  int isMixture;
  const char* mixtureFile;
} PropertySetupInformation;


// Define export
#ifdef __cplusplus
#define EXPORT __declspec(dllexport)
#else
#define EXPORT
#endif // __cplusplus

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

	EXPORT double TwoPhaseMedium_getMolarMass_C_impl(const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_getCriticalTemperature_C_impl(const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_getCriticalPressure_C_impl(const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_getCriticalMolarVolume_C_impl(const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);

	EXPORT void TwoPhaseMedium_setState_ph_C_impl(double p, double h, int phase, ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT void TwoPhaseMedium_setState_pT_C_impl(double p, double T, ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT void TwoPhaseMedium_setState_dT_C_impl(double d, double T, int phase, ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT void TwoPhaseMedium_setState_ps_C_impl(double p, double s, int phase, ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);

	EXPORT double TwoPhaseMedium_prandtlNumber_C_impl(ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_temperature_C_impl(ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_velocityOfSound_C_impl(ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_isobaricExpansionCoefficient_C_impl(ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_specificHeatCapacityCp_C_impl(ExternalThermodynamicState *state,	const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_specificHeatCapacityCv_C_impl(ExternalThermodynamicState *state,	const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_density_C_impl(ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_density_derh_p_C_impl(ExternalThermodynamicState *state,	const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_density_derp_h_C_impl(ExternalThermodynamicState *state,	const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_dynamicViscosity_C_impl(ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_specificEnthalpy_C_impl(ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_isothermalCompressibility_C_impl(ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_thermalConductivity_C_impl(ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_pressure_C_impl(ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_specificEntropy_C_impl(ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_density_ph_der_C_impl(ExternalThermodynamicState *state,	const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_isentropicEnthalpy_C_impl(double p_downstream, ExternalThermodynamicState *refState,	const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);

	EXPORT void TwoPhaseMedium_setSat_p_C_impl(double p, ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT void TwoPhaseMedium_setSat_T_C_impl(double T, ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT void TwoPhaseMedium_setBubbleState_C_impl(ExternalSaturationProperties *sat, int phase, ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT void TwoPhaseMedium_setDewState_C_impl(ExternalSaturationProperties *sat, int phase, ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);

	EXPORT double TwoPhaseMedium_saturationTemperature_C_impl(double p, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_saturationTemperature_derp_C_impl(double p, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_saturationTemperature_derp_sat_C_impl(ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);

	EXPORT double TwoPhaseMedium_dBubbleDensity_dPressure_C_impl(ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_dDewDensity_dPressure_C_impl(ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_dBubbleEnthalpy_dPressure_C_impl(ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_dDewEnthalpy_dPressure_C_impl(ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_bubbleDensity_C_impl(ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_dewDensity_C_impl(ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_bubbleEnthalpy_C_impl(ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_dewEnthalpy_C_impl(ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_saturationPressure_C_impl(double T, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
    EXPORT double TwoPhaseMedium_surfaceTension_C_impl(ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_bubbleEntropy_C_impl(ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_dewEntropy_C_impl(ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);

// Defining new functions needed for mixtures
	EXPORT void TwoPhaseMedium_setState_phX_C_impl(double p, double h,const double* X, int phase, ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);	
	EXPORT void TwoPhaseMedium_setState_pTX_C_impl(double p, double T,const double* X, ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT void TwoPhaseMedium_setState_psX_C_impl(double p, double s,const double* X, int phase, ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);	
	EXPORT void TwoPhaseMedium_setState_dTX_C_impl(double d, double T,const double* X, int phase, ExternalThermodynamicState *state, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT void TwoPhaseMedium_setSat_pX_C_impl(double p,const double* X,int Xlabel,int solutionType, ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT void TwoPhaseMedium_setSat_TX_C_impl(double T,const double* X,int Xlabel,int solutionType, ExternalSaturationProperties *sat, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);

	EXPORT double TwoPhaseMedium_molarMass_X_C_impl(const double* X,const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_criticalTemperature_X_C_impl(const double* X,const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_criticalPressure_X_C_impl(const double* X,const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);
	EXPORT double TwoPhaseMedium_criticalDensity_X_C_impl(const double* X,const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo);

//Defining new functions needed for mixture -same as above but also calculate arrays which is not allowed within record structure so splitted up properties record into arguments
	EXPORT void TwoPhaseMedium_calcThermoProperties2_phX_C_impl(double p, double h,const double X[],size_t size_X, int phase,const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo,
		double* p_overall_out,double* T_overall_out,double* d_overall_out,double* h_overall_out,double* s_overall_out,
		double d_1ph_out[],double h_1ph_out[],double s_1ph_out[],double Pr_1ph_out[],double a_1ph_out[],double beta_1ph_out[],double cp_1ph_out[],double cv_1ph_out[],double kappa_1ph_out[],double lambda_1ph_out[],double eta_1ph_out[],
		double dpdT_dN_1ph_out[],double dpdd_TN_1ph_out[],
		int* nbrOfPresentPhases_out,int* presentPhaseIndex_out,double phaseCompositions_out[],double phaseFractions_out[]);

	EXPORT void TwoPhaseMedium_calcThermoProperties2_dTX_C_impl(double d, double T,const double X[],size_t size_X, int phase,const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo,
		double* p_overall_out,double* T_overall_out,double* d_overall_out,double* h_overall_out,double* s_overall_out,
		double d_1ph_out[],double h_1ph_out[],double s_1ph_out[],double Pr_1ph_out[],double a_1ph_out[],double beta_1ph_out[],double cp_1ph_out[],double cv_1ph_out[],double kappa_1ph_out[],double lambda_1ph_out[],double eta_1ph_out[],
		double dpdT_dN_1ph_out[],double dpdd_TN_1ph_out[],
		int* nbrOfPresentPhases_out,int* presentPhaseIndex_out,double phaseCompositions_out[],double phaseFractions_out[]);

	EXPORT void TwoPhaseMedium_calcThermoProperties2_psX_C_impl(double p, double s,const double X[],size_t size_X, int phase,const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo,
		double* p_overall_out,double* T_overall_out,double* d_overall_out,double* h_overall_out,double* s_overall_out,
		double d_1ph_out[],double h_1ph_out[],double s_1ph_out[],double Pr_1ph_out[],double a_1ph_out[],double beta_1ph_out[],double cp_1ph_out[],double cv_1ph_out[],double kappa_1ph_out[],double lambda_1ph_out[],double eta_1ph_out[],
		double dpdT_dN_1ph_out[],double dpdd_TN_1ph_out[],
		int* nbrOfPresentPhases_out,int* presentPhaseIndex_out,double phaseCompositions_out[],double phaseFractions_out[]);

	EXPORT void TwoPhaseMedium_calcThermoProperties2_pTX_C_impl(double p, double T,const double X[],size_t size_X, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo,
		double* p_overall_out,double* T_overall_out,double* d_overall_out,double* h_overall_out,double* s_overall_out,
		double d_1ph_out[],double h_1ph_out[],double s_1ph_out[],double Pr_1ph_out[],double a_1ph_out[],double beta_1ph_out[],double cp_1ph_out[],double cv_1ph_out[],double kappa_1ph_out[],double lambda_1ph_out[],double eta_1ph_out[],
		double dpdT_dN_1ph_out[],double dpdd_TN_1ph_out[],
		int* nbrOfPresentPhases_out,int* presentPhaseIndex_out,double phaseCompositions_out[],double phaseFractions_out[]);

	EXPORT void TwoPhaseMedium_calcThermoProperties_phX_C_impl(double p, double h,const double* X,size_t size_X, int phase,const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo,
		double* Pr_out,double* T_out,double* a_out,double* beta_out,double* cp_out,double* cv_out,double* d_out,double* ddhp_out,double* ddph_out,
		double* eta_out,double* h_out,double* kappa_out,double* lambda_out,double* p_out,int* phase_out,double* s_out,double* phaseComposition_out, size_t* size_PhaseComposition_out,double* phaseFraction_out, size_t* size_PhaseFraction_out, double* ddX_ph_out,size_t* ddX_ph__out);


	EXPORT void TwoPhaseMedium_calcThermoProperties_pTX_C_impl(double p, double T,const double* X,size_t size_X, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo,
		double* Pr_out,double* T_out,double* a_out,double* beta_out,double* cp_out,double* cv_out,double* d_out,double* ddhp_out,double* ddph_out,
		double* eta_out,double* h_out,double* kappa_out,double* lambda_out,double* p_out,int* phase_out,double* s_out,double* phaseComposition_out, size_t* size_PhaseComposition_out,double* phaseFraction_out, size_t* size_PhaseFraction_out);

	EXPORT void TwoPhaseMedium_calcThermoProperties_psX_C_impl(double p, double s,const double* X,size_t size_X, int phase,const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo,
		double* Pr_out,double* T_out,double* a_out,double* beta_out,double* cp_out,double* cv_out,double* d_out,double* ddhp_out,double* ddph_out,
		double* eta_out,double* h_out,double* kappa_out,double* lambda_out,double* p_out,int* phase_out,double* s_out,double* phaseComposition_out, size_t* size_PhaseComposition_out,double* phaseFraction_out, size_t* size_PhaseFraction_out);
	


	EXPORT void TwoPhaseMedium_calcThermoProperties_dTX_C_impl(double d, double T,const double* X,size_t size_X, int phase,const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo,
		double* Pr_out,double* T_out,double* a_out,double* beta_out,double* cp_out,double* cv_out,double* d_out,double* ddhp_out,double* ddph_out,
		double* eta_out,double* h_out,double* kappa_out,double* lambda_out,double* p_out,int* phase_out,double* s_out,double* phaseComposition_out, size_t* size_PhaseComposition_out,double* phaseFraction_out, size_t* size_PhaseFraction_out);

	EXPORT void TwoPhaseMedium_calcSaturationProperties_pX_C_impl(double p,const double* X,int Xlabel,int solutionType, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo,
		double* Tsat_out,double* dTp_out,double* ddldp_out,double* ddvdp_out,double* dhldp_out,double* dhvdp_out,double* dl_out,double* dv_out,double* hl_out,
		double* hv_out,double* psat_out,double* sigma_out,double* sl_out,double* sv_out,double* phaseComposition_out,size_t* size_phaseComposition_out);

	EXPORT void TwoPhaseMedium_calcSaturationProperties_TX_C_impl(double T,const double* X,int Xlabel,int solutionType, const char *mediumName, const char *libraryName, const char *substanceName, PropertySetupInformation *setupInfo,
		double* Tsat_out,double* dTp_out,double* ddldp_out,double* ddvdp_out,double* dhldp_out,double* dhvdp_out,double* dl_out,double* dv_out,double* hl_out,
		double* hv_out,double* psat_out,double* sigma_out,double* sl_out,double* sv_out,double* phaseComposition_out,size_t* size_phaseComposition_out);	

//	TwoPhaseMedium_calcSaturationProperties_pX_C_impl(p,X,Xlabel,solutionType, mediumName, libraryName, substanceName, setupInfo,
//                Tsat_,dTp_,ddldp_,ddvdp_,dhldp_,dhvdp_,dl_,dv_,hl_,hv_,psat_,sigma_,sl_,sv_,phaseComposition_,size(phaseComposition_,1))


#ifdef __cplusplus
}
#endif // __cplusplus

#endif /*EXTERNALMEDIALIB_H_*/

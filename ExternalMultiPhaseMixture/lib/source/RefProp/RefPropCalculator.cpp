#include "config.h"
#if REFPROP

#define _AFXDLL
//#include <AfxWin.h>
#include "RefPropCalculator.h"
#include "StringHelper.h"
#include "errorhandling.h"
#include "ModelicaUtilities.h"
#include <vector>
#include <iostream>
#include <fstream>

static const bool LOGVARIABLES = false;
static const bool LOGFUNCIONINPUTS = false;
static const long refpropcharlength = 255;
static const long filepathlength = 255;
static const long lengthofreference = 3;
static const long errormessagelength = 255;
static const long numparams = 72;
static const double kMinimumDensity_SI = 0.000001; // Minimum density in SIunits [kg]
static const double kMinimumPressure_SI = 0.0001; // Minimum pressure in SIunits [Pa]
static const double X_pure[1] = {1.0}; // X vector for pure media


RefPropCalculator::RefPropCalculator(const MaterialCalculatorSetup *setupInfo) : BaseCalculator(setupInfo) {

    mMM_inv = 0; //Molar mass inverse - used in many conversions
    mLimits_EOS_tmin = 0; // Equation of state min Temperature limit
    mLimits_EOS_tmax = 0; // Equation of state max T limit
    mLimits_EOS_Dmax = 0; // Equation of state min density limit
    mLimits_EOS_pmax = 0; // Equation of state max pressure limit

    // First create a pointer to an instance of the library
    // Then have windows load the library.
    RefpropdllInstance = NULL;

    string path = "C:/Program Files (x86)/REFPROP/";
    string mixture = "";
    long usePengRobinson = 0; // 0 - Use full equation of state (Peng-Robinson off), 2 - Use Peng-Robinson equation for all calculation
    mIsPureMedia = true;
    // Parse setup information from setupInfo.setupInfo
    vector<string> v = StringHelper::split(setupInfo->setupInfo, '|');
    for (size_t i = 0; i < v.size(); ++i) {
        pair<string,string> kv = StringHelper::split2(v[i], '=');
        string key = kv.first;
        string value = kv.second;

        if (key == "path") {
            path = value;
        }
        else if (key == "mixture") {
            mixture = value;
            mIsPureMedia = false;
        }
        else if (key == "eos") {
            if (value == "PengRobinson") {
                usePengRobinson = 2;
            }
            else if (value == "default") {
                usePengRobinson = 0;
            }
        } else {
            string msg = "setup information contains following setup info that is not recognized: " + v[i];
            warningMessage("RefPropCalculator::RefPropCalculation()", msg.c_str());
        }
    }
    loadLibrary(path);

    // Then get pointers into the dll to the actual functions.
    ABFL1dll = (fp_ABFL1dllTYPE) getFunctionPointer("ABFL1dll");
    ABFL2dll = (fp_ABFL2dllTYPE) getFunctionPointer("ABFL2dll");
    ACTVYdll = (fp_ACTVYdllTYPE) getFunctionPointer("ACTVYdll");
    AGdll = (fp_AGdllTYPE) getFunctionPointer("AGdll");
    CCRITdll = (fp_CCRITdllTYPE) getFunctionPointer("CCRITdll");
    CP0dll = (fp_CP0dllTYPE) getFunctionPointer("CP0dll");
    CRITPdll = (fp_CRITPdllTYPE) getFunctionPointer("CRITPdll");
    CSATKdll = (fp_CSATKdllTYPE) getFunctionPointer("CSATKdll");
    CV2PKdll = (fp_CV2PKdllTYPE) getFunctionPointer("CV2PKdll");
    CVCPKdll = (fp_CVCPKdllTYPE) getFunctionPointer("CVCPKdll");
    CVCPdll = (fp_CVCPdllTYPE) getFunctionPointer("CVCPdll");
    DBDTdll = (fp_DBDTdllTYPE) getFunctionPointer("DBDTdll");
    DBFL1dll = (fp_DBFL1dllTYPE) getFunctionPointer("DBFL1dll");
    DBFL2dll = (fp_DBFL2dllTYPE) getFunctionPointer("DBFL2dll");
    DDDPdll = (fp_DDDPdllTYPE) getFunctionPointer("DDDPdll");
    DDDTdll = (fp_DDDTdllTYPE) getFunctionPointer("DDDTdll");
    DEFLSHdll = (fp_DEFLSHdllTYPE) getFunctionPointer("DEFLSHdll");
    DHD1dll = (fp_DHD1dllTYPE) getFunctionPointer("DHD1dll");
    DHFLSHdll = (fp_DHFLSHdllTYPE) getFunctionPointer("DHFLSHdll");
    DIELECdll = (fp_DIELECdllTYPE) getFunctionPointer("DIELECdll");
    DOTFILLdll = (fp_DOTFILLdllTYPE) getFunctionPointer("DOTFILLdll");
    DPDD2dll = (fp_DPDD2dllTYPE) getFunctionPointer("DPDD2dll");
    DPDDKdll = (fp_DPDDKdllTYPE) getFunctionPointer("DPDDKdll");
    DPDDdll = (fp_DPDDdllTYPE) getFunctionPointer("DPDDdll");
    DPDTKdll = (fp_DPDTKdllTYPE) getFunctionPointer("DPDTKdll");
    DPDTdll = (fp_DPDTdllTYPE) getFunctionPointer("DPDTdll");
    DPTSATKdll = (fp_DPTSATKdllTYPE) getFunctionPointer("DPTSATKdll");
    DSFLSHdll = (fp_DSFLSHdllTYPE) getFunctionPointer("DSFLSHdll");
    ENTHALdll = (fp_ENTHALdllTYPE) getFunctionPointer("ENTHALdll");
    ENTROdll = (fp_ENTROdllTYPE) getFunctionPointer("ENTROdll");
    ESFLSHdll = (fp_ESFLSHdllTYPE) getFunctionPointer("ESFLSHdll");
    FGCTYdll = (fp_FGCTYdllTYPE) getFunctionPointer("FGCTYdll");
    FPVdll = (fp_FPVdllTYPE) getFunctionPointer("FPVdll");
    GERG04dll = (fp_GERG04dllTYPE) getFunctionPointer("GERG04dll");
    GETFIJdll = (fp_GETFIJdllTYPE) getFunctionPointer("GETFIJdll");
    GETKTVdll = (fp_GETKTVdllTYPE) getFunctionPointer("GETKTVdll");
    GIBBSdll = (fp_GIBBSdllTYPE) getFunctionPointer("GIBBSdll");
    HSFLSHdll = (fp_HSFLSHdllTYPE) getFunctionPointer("HSFLSHdll");
    INFOdll = (fp_INFOdllTYPE) getFunctionPointer("INFOdll");
    LIMITKdll = (fp_LIMITKdllTYPE) getFunctionPointer("LIMITKdll");
    LIMITSdll = (fp_LIMITSdllTYPE) getFunctionPointer("LIMITSdll");
    LIMITXdll = (fp_LIMITXdllTYPE) getFunctionPointer("LIMITXdll");
    MELTPdll = (fp_MELTPdllTYPE) getFunctionPointer("MELTPdll");
    MELTTdll = (fp_MELTTdllTYPE) getFunctionPointer("MELTTdll");
    MLTH2Odll = (fp_MLTH2OdllTYPE) getFunctionPointer("MLTH2Odll");
    NAMEdll = (fp_NAMEdllTYPE) getFunctionPointer("NAMEdll");
    PDFL1dll = (fp_PDFL1dllTYPE) getFunctionPointer("PDFL1dll");
    PDFLSHdll = (fp_PDFLSHdllTYPE) getFunctionPointer("PDFLSHdll");
    PEFLSHdll = (fp_PEFLSHdllTYPE) getFunctionPointer("PEFLSHdll");
    PHFL1dll = (fp_PHFL1dllTYPE) getFunctionPointer("PHFL1dll");
    PHFLSHdll = (fp_PHFLSHdllTYPE) getFunctionPointer("PHFLSHdll");
    PQFLSHdll = (fp_PQFLSHdllTYPE) getFunctionPointer("PQFLSHdll");
    PREOSdll = (fp_PREOSdllTYPE) getFunctionPointer("PREOSdll");
    PRESSdll = (fp_PRESSdllTYPE) getFunctionPointer("PRESSdll");
    PSFL1dll = (fp_PSFL1dllTYPE) getFunctionPointer("PSFL1dll");
    PSFLSHdll = (fp_PSFLSHdllTYPE) getFunctionPointer("PSFLSHdll");
    PUREFLDdll = (fp_PUREFLDdllTYPE) getFunctionPointer("PUREFLDdll");
    QMASSdll = (fp_QMASSdllTYPE) getFunctionPointer("QMASSdll");
    QMOLEdll = (fp_QMOLEdllTYPE) getFunctionPointer("QMOLEdll");
    SATDdll = (fp_SATDdllTYPE) getFunctionPointer("SATDdll");
    SATEdll = (fp_SATEdllTYPE) getFunctionPointer("SATEdll");
    SATHdll = (fp_SATHdllTYPE) getFunctionPointer("SATHdll");
    SATPdll = (fp_SATPdllTYPE) getFunctionPointer("SATPdll");
    SATSdll = (fp_SATSdllTYPE) getFunctionPointer("SATSdll");
    SATTdll = (fp_SATTdllTYPE) getFunctionPointer("SATTdll");
    SATSPLNdll = (fp_SATSPLNdllTYPE) getFunctionPointer("SATSPLNdll");
    SETAGAdll = (fp_SETAGAdllTYPE) getFunctionPointer("SETAGAdll");
    SETKTVdll = (fp_SETKTVdllTYPE) getFunctionPointer("SETKTVdll");
    SETMIXdll = (fp_SETMIXdllTYPE) getFunctionPointer("SETMIXdll");
    SETMODdll = (fp_SETMODdllTYPE) getFunctionPointer("SETMODdll");
    SETREFdll = (fp_SETREFdllTYPE) getFunctionPointer("SETREFdll");
    SETUPdll = (fp_SETUPdllTYPE) getFunctionPointer("SETUPdll");
    SPECGRdll = (fp_SPECGRdllTYPE) getFunctionPointer("SPECGRdll");
    SUBLPdll = (fp_SUBLPdllTYPE) getFunctionPointer("SUBLPdll");
    SUBLTdll = (fp_SUBLTdllTYPE) getFunctionPointer("SUBLTdll");
    SURFTdll = (fp_SURFTdllTYPE) getFunctionPointer("SURFTdll");
    SURTENdll = (fp_SURTENdllTYPE) getFunctionPointer("SURTENdll");
    TDFLSHdll = (fp_TDFLSHdllTYPE) getFunctionPointer("TDFLSHdll");
    TEFLSHdll = (fp_TEFLSHdllTYPE) getFunctionPointer("TEFLSHdll");
    THERM0dll = (fp_THERM0dllTYPE) getFunctionPointer("THERM0dll");
    THERM2dll = (fp_THERM2dllTYPE) getFunctionPointer("THERM2dll");
    THERM3dll = (fp_THERM3dllTYPE) getFunctionPointer("THERM3dll");
    THERMdll = (fp_THERMdllTYPE) getFunctionPointer("THERMdll");
    THFLSHdll = (fp_THFLSHdllTYPE) getFunctionPointer("THFLSHdll");
    TPFLSHdll = (fp_TPFLSHdllTYPE) getFunctionPointer("TPFLSHdll");
    TPRHOdll = (fp_TPRHOdllTYPE) getFunctionPointer("TPRHOdll");
    TQFLSHdll = (fp_TQFLSHdllTYPE) getFunctionPointer("TQFLSHdll");
    TRNPRPdll = (fp_TRNPRPdllTYPE) getFunctionPointer("TRNPRPdll");
    TSFLSHdll = (fp_TSFLSHdllTYPE) getFunctionPointer("TSFLSHdll");
    VIRBdll = (fp_VIRBdllTYPE) getFunctionPointer("VIRBdll");
    VIRCdll = (fp_VIRCdllTYPE) getFunctionPointer("VIRCdll");
    WMOLdll = (fp_WMOLdllTYPE) getFunctionPointer("WMOLdll");
    XMASSdll = (fp_XMASSdllTYPE) getFunctionPointer("XMASSdll");
    XMOLEdll = (fp_XMOLEdllTYPE) getFunctionPointer("XMOLEdll");

    // set number of components and default composition in media
    long ierr = 0; // An integer flag defining an error

    // Exlicitely set the fluid file PATH
    string FLD_PATH(path + "fluids/");
    string MIX_PATH(path + "mixtures/");

    char hrf[lengthofreference+1] = {"DEF"}; //reference state
    char herr[errormessagelength+1] = {"Ok"}; //Error message
    char hfmix[refpropcharlength+1];  //path to the mixture file
    string hmx(FLD_PATH + "hmx.bnc");
    strcpy_s(hfmix, hmx.c_str());

    if (mIsPureMedia) {
        string fluidFile = FLD_PATH + setupInfo->compounds; // defining the fluids in a mixture
        m_nc = 1;
        mZ_fixed[0] = 1;
        // Call SETUP to initialize the program
        SETUPdll(m_nc, (char*) fluidFile.c_str(), hfmix, hrf, ierr, herr,
            refpropcharlength*ncmax, refpropcharlength,
            lengthofreference, errormessagelength);
        if (ierr != 0) {
            errorMessage("RefPropCalculator", "Refprop error in SETUPdll:\n\t%s", herr);
        }
        warningMessage("RefPropCalculator", "SETUPdll has been called");
    } else {
        string mixtureFile = MIX_PATH + mixture;
        char componentNames[10000]; // see file pass_ftn for def of setmixdll and line 2172 in setup.for

        SETMIXdll((char*) mixtureFile.c_str(), hfmix, hrf, m_nc, componentNames, mZ_fixed, ierr, herr, refpropcharlength, refpropcharlength, lengthofreference,
            10000, refpropcharlength);
        if (ierr != 0) {
            errorMessage("RefPropCalculator", "Refprop error in SETUPMIXdll:\n\t%s", herr);
        }
        warningMessage("RefPropCalculator", "SETMIXdll has been called");
        PREOSdll(usePengRobinson); // set equation of state
    }

    // Spline calculation of phase boundary for faster flash calculations
    /*SATSPLNdll (mZ_fixed, ierr, herr, errormessagelength);
    if (ierr != 0) {
    errorMessage("RefPropCalculator", "Refprop error in SATSPLNdll:\n\t%s", herr);
    } */

    // calculate fluid constants
    setFluidConstants();
}

RefPropCalculator::~RefPropCalculator(void)
{
    if (RefpropdllInstance != NULL) {
#     if defined(USE_LOADLIBRARY)
        ::FreeLibrary(RefpropdllInstance);
#     elif defined(USE_DLOPEN)
        ::dlclose(RefpropdllInstance);
#     endif
    }
    delete[] mIupacName;
    delete[] mCasRegistryNumber;
    delete[] mChemicalFormula;
    delete[] mCompoundId;
    delete[] mMolecularWeight;
    delete[] mNormalBoilingTemperature;
}

BaseCalculatorCache* RefPropCalculator::createCache() {
    Cache *cache = new Cache();
    return cache;
}

void *RefPropCalculator::getFunctionPointer(const char* name) {
# if defined(USE_LOADLIBRARY)
    return (void *) GetProcAddress(RefpropdllInstance, name);
# elif defined(USE_DLOPEN)
    return (void *) dlsym(RefpropdllInstance, name);
# endif
}

void RefPropCalculator::loadLibrary(std::string path) {
    if (RefpropdllInstance == NULL) { // Refprop is not loaded
#     if defined(USE_LOADLIBRARY)
        string lib = "refprop.dll";
        path.append(lib);
        // Fix for unicode mode in Windows, solves problem with loading dll, http://www.cplusplus.com/forum/general/12245/
        TCHAR *param = new TCHAR[path.size()+1];
        param[path.size()] = 0;
        std::copy(path.begin(), path.end(), param);
        RefpropdllInstance = LoadLibrary(param);
        delete[] param;
#     elif defined(USE_DLOPEN)
        char *lib = "refprop.so";
        RefpropdllInstance = dlopen(lib, RTLD_LAZY);
#    endif
    } else {
        errorMessage("RefPropCalculator", "Failed to load library - loadLibrary called with RefpropdllInstance != NULL");
    }
    if (RefpropdllInstance == NULL) {
        errorMessage("RefPropCalculator", "Failed to load library");
    }
}

void RefPropCalculator::setFluidConstants() {
    _fluidConstants = vector<FluidConstants>(m_nc);
    mIupacName = new string[m_nc];
    mCasRegistryNumber = new string[m_nc];
    mChemicalFormula = new string[m_nc];
    mCompoundId = new string[m_nc];
    mMolecularWeight = new double[m_nc];
    mNormalBoilingTemperature = new double[m_nc];

    double wmm_ = 0; //molecular weight [g/mol]
    double ttrp_ = 0; //triple point temperature [K]
    double tnbpt_ = 0; //normal boiling point temperature [K]
    double tc_ = 0; //critical temperature [K]
    double pc_ = 0; // critical pressure [kPa]
    double Dc_ = 0; //critical density [mol/L]
    double Zc_ = 0; //compressibility at critical point [pc/(Rgas*Tc*Dc)]
    double acf_ = 0; //acfacentric factor [-]
    double dip_ = 0; //dipole moment [debye]
    double Rgas_ = 0; //gas constant [J/mol-K]
    long icomp = 0;

    for (long i = 0; i < m_nc; i++) {
        // get fluid constants for component i=nc
        icomp = i+1; // component number
        INFOdll(icomp, wmm_, ttrp_, tnbpt_, tc_, pc_, Dc_, Zc_, acf_, dip_, Rgas_);
        // set fluid constansts
        _fluidConstants[i].MM = wmm_ * 0.001; // Molar mass (g/mole to kg/mol)
        _fluidConstants[i].pc = pc_ * 1000; // Pressure at critical point
        _fluidConstants[i].Tc = tc_; // Temperature at critical point
        _fluidConstants[i].dc = Dc_ * wmm_; // Density at critical point - CHECK UNITS!
        _fluidConstants[i].hc = -1; // Specific enthalpy at critical point
        _fluidConstants[i].sc = -1; // Specific entropy at at critical point
        // TODO: get names from subroutine NAME (icomp, hnam, hn80, hcasn)
        mIupacName[i] = string("UNDEFINED");
        mCasRegistryNumber[i] = string("UNDEFINED");
        mChemicalFormula[i] = string("UNDEFINED");
        mCompoundId[i] = string("UNDEFINED");
        mMolecularWeight[i] = wmm_ * 0.001; // Molar mass (g/mole to kg/mol)
        mNormalBoilingTemperature[i] = tnbpt_;
    }

    // Get Equation Of State limits for composition mZ_fixed.
    // string limitType="EOS"; // Limits for equation of state for thermodynamic properties
    char limitType[lengthofreference+1] = {"EOS"}; //reference state
    LIMITSdll(limitType, mZ_fixed, mLimits_EOS_tmin, mLimits_EOS_tmax, mLimits_EOS_Dmax, mLimits_EOS_pmax, errormessagelength);

    // set EOS limits in SIunits
    mLimits_EOS_pmax = mLimits_EOS_pmax*1000;
    mLimits_EOS_Dmax = mLimits_EOS_Dmax*_fluidConstants[0].MM*1000; //TODO: not correct for mixture
    mMM_inv = 1 / _fluidConstants[0].MM;  // TODO: not correct for mixture
}

void RefPropCalculator::calcThermoProperties_TFX(double T, const double phaseFraction[], Units::Basis F_unit, const double X[], Units::Basis X_unit, int solutionType, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]) {

        double T_EOS_min, T_EOS_max, T_;
        double z[ncmax]; // Bulk properties
        double wmix;
        RefPropCalculator::convert_X_to_Z(X, z, wmix); // convert fraction from mass basis to mole basis

        // Input guards
        if (mIsPureMedia) {
            T_EOS_min = mLimits_EOS_tmin;
            T_EOS_max = mLimits_EOS_tmax;
        } else {
            double d_EOS_max, p_EOS_max;
            char limitType[lengthofreference+1] = {"EOS"}; //reference state
            LIMITSdll(limitType, z, T_EOS_min, T_EOS_max, d_EOS_max, p_EOS_max, errormessagelength);
        }

        if (T > T_EOS_max) {
            warningMessage("RefPropCalculator", "calcThermoProperties_TFX Input T=%f > T_max=%f  (K). Input T will be set to T_max", T, T_EOS_max);
        } else if (T < T_EOS_min) {
            warningMessage("RefPropCalculator", "calcThermoProperties_pTX Input T=%f < T_min=%f  (K). Input T will be set to T_min", T, T_EOS_min);
        }

        T_ = max(min(T, T_EOS_max), T_EOS_min);

        // RefProp variables
        double x_[ncmax];
        double y_[ncmax];

        for (int i = 0; i < ncmax; i++) {
            x_[i] = 0;
            y_[i] = 0;
        }
        double h_ = 0, d_ = 0, Dl_ = 0, p_ = 0, Dv_ = 0, q_ = 0, e_ = 0, s_ = 0;
        double cv_ = 0, cp_ = 0, w_ = 0;
        long ierr_ = 0;
        char herr_[errormessagelength+1];

        long kq = 0;
        switch(F_unit) {
            case Units::MASSFRACTION:
                kq = 2;
                break;
            case Units::MOLEFRACTION:
                kq = 1;
                break;
            default:
                errorMessage("RefPropCalculator", "calcThermoProperties_TFX()- unsupported value of X_unit=%d", X_unit, herr_);
        }
        q_ = phaseFraction[1]; // Vapor fraction, need to be inside [0-1]
        // Convert inputs (SIunits) to RefProp units


        TQFLSHdll(T_, q_, z, kq, p_, d_, Dl_, Dv_, x_, y_, e_, h_, s_, cv_, cp_, w_, ierr_, herr_, errormessagelength);
        if (ierr_ != 0) {
            std::string F_msg = RefPropCalculator::formatX(phaseFraction, 2);
            std::string X_msg = RefPropCalculator::formatX(X, 2);
            errorMessage("RefPropCalculator", "calcThermoProperties_TFX(T=%f(Pa),F=%s,X=%s)\nRefprop error in TQFLSdll:\n\t%s", T_, F_msg.c_str(), X_msg.c_str(), herr_);
        }

        const char *callingFunction = "RefPropCalculator.calcThermoProperties_TFX";

        RefPropCalculator::calcAndSetProperties(q_, z, x_, y_, p_, h_, T_, d_, s_, Dl_, Dv_,
            p_overall_out, T_overall_out, d_overall_out, h_overall_out, s_overall_out,
            d_1ph_out, h_1ph_out, s_1ph_out, Pr_1ph_out, a_1ph_out, beta_1ph_out, cp_1ph_out, cv_1ph_out, kappa_1ph_out, lambda_1ph_out, eta_1ph_out,
            dpdT_dN_1ph_out, dpdd_TN_1ph_out, nbrOfPresentPhases_out, presentPhaseIndex_out, phaseCompositions_out, phaseFractions_out, callingFunction);

}

void RefPropCalculator::calcThermoProperties_pFX(double p, const double phaseFraction[], Units::Basis F_unit, const double X[], Units::Basis X_unit, int solutionType, BaseCalculatorCache *cache,
        double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
        double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
        double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
        int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]) {

        double p_EOS_max;
        double z[ncmax]; // Bulk properties
        double wmix;
        RefPropCalculator::convert_X_to_Z(X, z, wmix); // convert fraction from mass basis to mole basis

        // Input guards
        if (mIsPureMedia) {
            p_EOS_max = mLimits_EOS_pmax;
        } else {
            double T_EOS_min, T_EOS_max, d_EOS_max;
            char limitType[lengthofreference+1] = {"EOS"}; //reference state
            LIMITSdll(limitType, z, T_EOS_min, T_EOS_max, d_EOS_max, p_EOS_max, errormessagelength);
            p_EOS_max = p_EOS_max*1000; // Convert to SI units;
        }

        if (p > p_EOS_max) {
            warningMessage("RefPropCalculator", "calcThermoProperties_pFX Input p=%f > p_max=%f  (Pa). Input p will be set to p_max", p, p_EOS_max);
        }
        double p_ = max(min(p, p_EOS_max), 0); // Set pressure to be inside limits

        // RefProp variables
        double x_[ncmax];
        double y_[ncmax];

        for (int i = 0; i < ncmax; i++) {
            x_[i] = 0;
            y_[i] = 0;
        }
        double h_ = 0, T_ = 0, d_ = 0, Dl_ = 0, Dv_ = 0, q_ = 0, e_ = 0, s_ = 0;
        double cv_ = 0, cp_ = 0, w_ = 0;
        long ierr_ = 0;
        char herr_[errormessagelength+1];

        long kq = 0;
        switch(F_unit) {
            case Units::MASSFRACTION:
                kq = 2;
                break;
            case Units::MOLEFRACTION:
                kq = 1;
                break;
            default:
                errorMessage("RefPropCalculator", "calcThermoProperties_pFX()- unsupported value of X_unit=%d", X_unit, herr_);
        }
        q_ = phaseFraction[1]; // Vapor fraction, need to be inside [0-1]
        // Convert inputs (SIunits) to RefProp units
        p_ = p_ / 1000; // Pa to kPa

        PQFLSHdll(p_, q_, z, kq, T_, d_, Dl_, Dv_, x_, y_, e_, h_, s_, cv_, cp_, w_, ierr_, herr_, errormessagelength);
        if (ierr_ != 0) {
            std::string F_msg = RefPropCalculator::formatX(phaseFraction, 2);
            std::string X_msg = RefPropCalculator::formatX(X, 2);
            errorMessage("RefPropCalculator", "calcThermoProperties_pFX(p=%f(Pa),F=%s,X=%s)\nRefprop error in PQFLSdll:\n\t%s", p, F_msg.c_str(), X_msg.c_str(), herr_);
        }

        const char *callingFunction = "RefPropCalculator.calcThermoProperties_pFX";

        RefPropCalculator::calcAndSetProperties(q_, z, x_, y_, p_, h_, T_, d_, s_, Dl_, Dv_,
            p_overall_out, T_overall_out, d_overall_out, h_overall_out, s_overall_out,
            d_1ph_out, h_1ph_out, s_1ph_out, Pr_1ph_out, a_1ph_out, beta_1ph_out, cp_1ph_out, cv_1ph_out, kappa_1ph_out, lambda_1ph_out, eta_1ph_out,
            dpdT_dN_1ph_out, dpdd_TN_1ph_out, nbrOfPresentPhases_out, presentPhaseIndex_out, phaseCompositions_out, phaseFractions_out, callingFunction);

}


void RefPropCalculator::calcThermoProperties_phX(double p, double h, const double X[], size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
    int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]) {
        if (LOGFUNCIONINPUTS) {
            std::string X_msg = RefPropCalculator::formatX(X, m_nc);
            warningMessage("RefPropCalculator", "calcThermoProperties_phX called with p=%f(Pa),h=%f(J/kgK),X=%s ,phase_id=%d(phase_id)", p, h, X_msg.c_str(), phase_id);
        }

        double p_EOS_max;
        double z[ncmax]; // Bulk properties
        double wmix;
        RefPropCalculator::convert_X_to_Z(X, z, wmix); // convert fraction from mass basis to mole basis

        // Input guards
        if (mIsPureMedia) {
            p_EOS_max = mLimits_EOS_pmax;
        } else {
            double T_EOS_min, T_EOS_max, d_EOS_max;
            char limitType[lengthofreference+1] = {"EOS"}; //reference state
            LIMITSdll(limitType, z, T_EOS_min, T_EOS_max, d_EOS_max, p_EOS_max, errormessagelength);
            p_EOS_max = p_EOS_max*1000; // Convert to SI units;
        }

        if (p > p_EOS_max) {
            warningMessage("RefPropCalculator", "calcThermoProperties_phX Input p=%f > p_max=%f  (Pa). Input p will be set to p_max", p, p_EOS_max);
        }
        double p_ = max(min(p, p_EOS_max), 0); // Set pressure to be inside limits

        // RefProp variables
        double x_[ncmax];
        double y_[ncmax];

        for (int i = 0; i < ncmax; i++) {
            x_[i] = 0;
            y_[i] = 0;
        }
        double h_ = 0, T_ = 0, d_ = 0, Dl_ = 0, Dv_ = 0, q_ = 0, e_ = 0, s_ = 0;
        double cv_ = 0, cp_ = 0, w_ = 0;
        long ierr_ = 0;
        char herr_[errormessagelength+1];

        // Convert inputs (SIunits) to RefProp units
        p_ = p_ / 1000; // Pa to kPa
        if (mIsPureMedia) {
            h_ = h * _fluidConstants[0].MM; // J/kgK to J/molK
        } else {
            h_ = h * wmix * 0.001; // J/kgK to J/molK
        }
        // system("pause");

        PHFLSHdll(p_, h_, z, T_, d_, Dl_, Dv_, x_, y_, q_, e_, s_, cv_, cp_, w_, ierr_, herr_, errormessagelength);
        if (ierr_ != 0) {
            std::string X_msg = RefPropCalculator::formatX(X, m_nc);
            errorMessage("RefPropCalculator", "calcThermoProperties_phX(p=%f(Pa),h=%f(J/kgK),X=%s)\nRefprop error in PHFLSdll:\n\t%s", p, h, X_msg.c_str(), herr_);
        }

        const char *callingFunction = "RefPropCalculator.calcThermoProperties_phX";

        RefPropCalculator::calcAndSetProperties(q_, z, x_, y_, p_, h_, T_,  d_, s_, Dl_, Dv_,
            p_overall_out, T_overall_out, d_overall_out, h_overall_out, s_overall_out,
            d_1ph_out, h_1ph_out, s_1ph_out, Pr_1ph_out, a_1ph_out, beta_1ph_out, cp_1ph_out, cv_1ph_out, kappa_1ph_out, lambda_1ph_out, eta_1ph_out,
            dpdT_dN_1ph_out, dpdd_TN_1ph_out, nbrOfPresentPhases_out, presentPhaseIndex_out, phaseCompositions_out, phaseFractions_out, callingFunction);

}

void RefPropCalculator::calcAndSetProperties(double q, double *z, double *x, double *y, double p_overall, double h_overall, double T_overall, double d_overall, double s_overall,
    double Dl, double Dv,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[], int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[], const char *callingFunction) {

        // Calculate phase
        int phase;
        RefPropCalculator::calcPhase(q, phase);
        RefPropCalculator::setPhaseValues(q, z, x, y, phase, nbrOfPresentPhases_out, presentPhaseIndex_out, phaseCompositions_out, phaseFractions_out);

        //  Single phase properties - RefProp has two phases
        double h_1ph[2] = { 0, 0 };
        double s_1ph[2] = { 0, 0 };
        double d_1ph[2] = { 0, 0 };
        double cv_1ph[2] = { 0, 0 };
        double cp_1ph[2] = { 0, 0 };
        double w_1ph[2] = { 0, 0 };
        double kappa_1ph[2] = { 0, 0 };
        double beta_1ph[2] = { 0, 0 };
        double eta_1ph[2] = { 0, 0 };
        double lambda_1ph[2] = { 0, 0 };
        double dpdT_1ph[2] = { 0, 0 };
        double dpdd_1ph[2] = { 0, 0 };

        // Calculate one-phase properties
        if (phase == 1) {
            int pIndex = presentPhaseIndex_out[0]-1; // -1 due to presentPhaseIndex_out is adapted to Modelica where index start at 1
            d_1ph[pIndex] = d_overall;
            // remaining properties, dpdT, dpdd, kappa, beta, eta, lambda needs to be calculated
            double p, e, hjt, A, G, d2PdD2, drhodT, drhodP, d2PT2, d2PdTD, spare3, spare4;
            double Z;
            // calculating all properties, little bit more efficient if only remaining properties were calculated
            THERM2dll(T_overall, d_overall, z, p, e, h_1ph[pIndex], s_1ph[pIndex], cv_1ph[pIndex], cp_1ph[pIndex], w_1ph[pIndex], Z, hjt
                , A, G, kappa_1ph[pIndex], beta_1ph[pIndex], dpdd_1ph[pIndex], d2PdD2, dpdT_1ph[pIndex], drhodT, drhodP, d2PT2, d2PdTD, spare3, spare4);
            // calculate transport properties
            RefPropCalculator::calcTransportProperties_SinglePhase(T_overall, d_overall, z, eta_1ph[pIndex], lambda_1ph[pIndex], callingFunction);
        }
        else if (phase == 2) {
            // Inside two-phase zone
            for (int i = 0; i < 2; i++) {
                int pIndex = i;
                if (i == 0) {
                    d_1ph[pIndex] = Dl;
                } else {
                    d_1ph[pIndex] = Dv;
                }
                double p, e, hjt, A, G, d2PdD2, drhodT, drhodP, d2PT2, d2PdTD, spare3, spare4;
                double Z;
                // THERM2 calculates all thermo properties except for transport properties and dpdt, dpdd
                THERM2dll(T_overall, d_1ph[pIndex], z, p, e, h_1ph[pIndex], s_1ph[pIndex], cv_1ph[pIndex], cp_1ph[pIndex], w_1ph[pIndex], Z, hjt
                    , A, G, kappa_1ph[pIndex], beta_1ph[pIndex], dpdd_1ph[pIndex], d2PdD2, dpdT_1ph[pIndex], drhodT, drhodP, d2PT2, d2PdTD, spare3, spare4);
                // calculate transport properties
                RefPropCalculator::calcTransportProperties_SinglePhase(T_overall, d_1ph[pIndex], z, eta_1ph[pIndex], lambda_1ph[pIndex], callingFunction);
            }
        }
        // Set properties and convert to mass-based SIunits
        RefPropCalculator::setValues(q, z, x, y, p_overall, h_overall, T_overall, d_overall, s_overall,
            d_1ph, h_1ph, s_1ph, w_1ph, cp_1ph, cv_1ph, eta_1ph, lambda_1ph, kappa_1ph, beta_1ph, phase, dpdT_1ph, dpdd_1ph,
            p_overall_out, T_overall_out, d_overall_out, h_overall_out, s_overall_out,
            d_1ph_out, h_1ph_out, s_1ph_out, Pr_1ph_out, a_1ph_out, beta_1ph_out, cp_1ph_out, cv_1ph_out, kappa_1ph_out, lambda_1ph_out, eta_1ph_out,
            dpdT_dN_1ph_out, dpdd_TN_1ph_out);
}


void RefPropCalculator::calcThermoProperties_duX(double d, double u, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
    int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]) {

        double d_EOS_max, T_EOS_max, T_EOS_min, p_EOS_max;
        double z[ncmax]; // Bulk properties
        double wmix;
        RefPropCalculator::convert_X_to_Z(X, z, wmix);

        // Input guards
        if (mIsPureMedia) {
            d_EOS_max = mLimits_EOS_Dmax;
        } else {
            char limitType[lengthofreference+1] = {"EOS"}; //reference state
            LIMITSdll(limitType, z, T_EOS_min, T_EOS_max, d_EOS_max, p_EOS_max, errormessagelength);
            d_EOS_max = d_EOS_max*wmix; // Convert to SIunits;
            p_EOS_max = p_EOS_max*1000; // Convert to SI units;
        }
        if (d > d_EOS_max) {
            warningMessage("RefPropCalculator", "calcThermoProperties_duX Input d=%f > d_max=%f  (kg/m^3). Input d will be set to d_max", d, d_EOS_max);
        }
        d = max(kMinimumDensity_SI, min(d, d_EOS_max));

        // RefProp variables
        double T_ = 0, h_ = 0, u_ = 0, p_ = 0, d_ = 0, Dl_ = 0, Dv_ = 0;
        double q_ = 0, e_ = 0, s_ = 0, cv_ = 0, cp_ = 0, w_ = 0, eta_ = 0;
        double lambda_ = 0;
        double x_[ncmax];
        double y_[ncmax];
        for (int i = 0; i<ncmax; i++) {
            x_[i] = 0;
            y_[i] = 0;
        }
        long ierr_ = 0;
        char herr_[errormessagelength+1];

        if (mIsPureMedia) {
            d_ = d*0.001*mMM_inv; // [kg/m^3] to [mol/l]
            u_ = u * _fluidConstants[0].MM; // J/kgK to J/molK
        } else {
            d_ = d/wmix; // [kg/m^3] to [mol/l]
            u_ = u * wmix * 0.001; // J/kgK to J/molK
        }

        DEFLSHdll(d_, u_, z, T_, p_, Dl_, Dv_, x_, y_, q_, h_, s_, cv_, cp_, w_, ierr_, herr_, errormessagelength);
        if (ierr_ != 0) {
            std::string X_msg = RefPropCalculator::formatX(X, m_nc);
            errorMessage("RefPropCalculator", "calcThermoProperties_duX(d=%f(kg/m3),T=%f(J/kg),X=%s)\nRefprop error in DEFLSHdll:\n\t%s", d, u, X_msg.c_str(), herr_);
        }
        const char *callingFunction = "RefPropCalculator.calcThermoProperties_duX";
        RefPropCalculator::calcAndSetProperties(q_, z, x_, y_, p_, h_, T_, d_, s_, Dl_, Dv_,
            p_overall_out, T_overall_out, d_overall_out, h_overall_out, s_overall_out,
            d_1ph_out, h_1ph_out, s_1ph_out, Pr_1ph_out, a_1ph_out, beta_1ph_out, cp_1ph_out, cv_1ph_out, kappa_1ph_out, lambda_1ph_out, eta_1ph_out,
            dpdT_dN_1ph_out, dpdd_TN_1ph_out, nbrOfPresentPhases_out, presentPhaseIndex_out, phaseCompositions_out, phaseFractions_out, callingFunction);

}

void RefPropCalculator::calcThermoProperties_dTX(double d, double T, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
    int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]) {

        double T_ = 0;
        double d_EOS_max, T_EOS_max, T_EOS_min, p_EOS_max;

        double z[ncmax]; // Bulk properties
        double wmix;
        RefPropCalculator::convert_X_to_Z(X, z, wmix);

        // Input guards
        if (mIsPureMedia) {
            d_EOS_max = mLimits_EOS_Dmax;
            T_EOS_max = mLimits_EOS_tmax;
            T_EOS_min = mLimits_EOS_tmin;
        } else {
            char limitType[lengthofreference+1] = {"EOS"}; //reference state
            LIMITSdll(limitType, z, T_EOS_min, T_EOS_max, d_EOS_max, p_EOS_max, errormessagelength);
            d_EOS_max = d_EOS_max*wmix; // Convert to SIu;
        }
        if (d > d_EOS_max) {
            warningMessage("RefPropCalculator", "calcThermoProperties_dTX Input d=%f > d_max=%f  (kg/m^3). Input d will be set to d_max", d, d_EOS_max);
        }
        if (T > T_EOS_max) {
            warningMessage("RefPropCalculator", "calcThermoProperties_dTX Input T=%f > T_max=%f  (K). Input T will be set to T_max", T, T_EOS_max);
        } else if (T < T_EOS_min) {
            warningMessage("RefPropCalculator", "calcThermoProperties_dTX Input T=%f < T_min=%f  (K). Input T will be set to T_min", T, T_EOS_min);
        }

        d = max(kMinimumDensity_SI, min(d, d_EOS_max));
        T_ = max(T_EOS_min, min(T, T_EOS_max));


        // RefProp variables
        double h_ = 0, p_ = 0, d_ = 0, Dl_ = 0, Dv_ = 0;
        double x_[ncmax];
        double y_[ncmax];
        for (int i = 0; i<ncmax; i++) {
            x_[i] = 0;
            y_[i] = 0;
        }
        double q_ = 0, e_ = 0, s_ = 0, cv_ = 0, cp_ = 0, w_ = 0, eta_ = 0;
        double lambda_ = 0;
        long ierr_ = 0;
        char herr_[errormessagelength+1];

        if (mIsPureMedia) {
            d_ = d*0.001*mMM_inv; // [kg/m^3] to [mol/l]
        } else {
            d_ = d/wmix; // [kg/m^3] to [mol/l]
        }

        TDFLSHdll(T_, d_, z, p_, Dl_, Dv_, x_, y_, q_, e_, h_, s_, cv_, cp_, w_, ierr_, herr_, errormessagelength);
        if (ierr_ != 0) {
            std::string X_msg = RefPropCalculator::formatX(X, m_nc);
            errorMessage("RefPropCalculator", "calcThermoProperties_dTX(d=%f(kg/m3),T=%f(K),X=%s)\nRefprop error in TDFLSdll:\n\t%s", d, T, X_msg.c_str(), herr_);
        }

        const char *callingFunction = "RefPropCalculator.calcThermoProperties_dTX";
        RefPropCalculator::calcAndSetProperties(q_, z, x_, y_, p_, h_, T_, d_, s_, Dl_, Dv_,
            p_overall_out, T_overall_out, d_overall_out, h_overall_out, s_overall_out,
            d_1ph_out, h_1ph_out, s_1ph_out, Pr_1ph_out, a_1ph_out, beta_1ph_out, cp_1ph_out, cv_1ph_out, kappa_1ph_out, lambda_1ph_out, eta_1ph_out,
            dpdT_dN_1ph_out, dpdd_TN_1ph_out, nbrOfPresentPhases_out, presentPhaseIndex_out, phaseCompositions_out, phaseFractions_out, callingFunction);

}

void RefPropCalculator::calcThermoProperties_pTX(double p, double T, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
    int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]) {
        double p_ = 0;
        double T_ = 0;

        // Input guards
        double p_EOS_max, T_EOS_min, T_EOS_max;
        double z[ncmax]; // Bulk properties
        double wmix;
        RefPropCalculator::convert_X_to_Z(X, z, wmix);

        // Input guards
        if (mIsPureMedia) {
            p_EOS_max = mLimits_EOS_pmax;
            T_EOS_max = mLimits_EOS_tmax;
            T_EOS_min = mLimits_EOS_tmin;
        } else {
            double d_EOS_max;
            char limitType[lengthofreference+1] = {"EOS"}; //reference state
            LIMITSdll(limitType, z, T_EOS_min, T_EOS_max, d_EOS_max, p_EOS_max, errormessagelength);
            p_EOS_max = p_EOS_max*1000; // Convert to SI units;
        }

        if (p > p_EOS_max) {
            warningMessage("RefPropCalculator", "calcThermoProperties_pTX Input p=%f > p_max=%f  (Pa). Input p will be set to p_max", p, p_EOS_max);
        }
        if (T > T_EOS_max) {
            warningMessage("RefPropCalculator", "calcThermoProperties_pTX Input T=%f > T_max=%f  (K). Input T will be set to T_max", T, T_EOS_max);
        } else if (T < T_EOS_min) {
            warningMessage("RefPropCalculator", "calcThermoProperties_pTX Input T=%f < T_min=%f  (K). Input T will be set to T_min", T, T_EOS_min);
        }

        p_ = max(min(p, p_EOS_max), kMinimumPressure_SI);
        T_ = max(min(T, T_EOS_max), T_EOS_min);


        // RefProp variables
        double h_ = 0, d_ = 0, Dl_ = 0, Dv_ = 0;
        double x_[ncmax];
        double y_[ncmax];
        double q_ = 0, e_ = 0, s_ = 0, cv_ = 0, cp_ = 0, w_ = 0, eta_ = 0, lambda_ = 0;
        long ierr_ = 0;
        char herr_[errormessagelength+1];

        // Convert inputs (SIunits) to RefProp units
        p_ = p_/1000; // Pa to kPa

        // Debug
        /*TCHAR buf[1000];
        swprintf(buf, TEXT("%lf, %lf, %lf"), p, T, mZ_fixed[0]);
        AfxMessageBox(buf);*/

        TPFLSHdll(T_, p_, z, d_, Dl_, Dv_, x_, y_, q_, e_, h_, s_, cv_, cp_, w_, ierr_, herr_, errormessagelength);
        if (ierr_ != 0) {
            std::string X_msg = RefPropCalculator::formatX(X, m_nc);
            errorMessage("RefPropCalculator", "calcThermoProperties_pTX(p=%f(Pa),T=%f(K),X=%s)\nRefprop error in TPFLSdll:\n\t%s", p_*1000, T, X_msg.c_str(), herr_);
        }
        const char *callingFunction = "RefPropCalculator.calcThermoProperties_pTX";

        RefPropCalculator::calcAndSetProperties(q_, z, x_, y_, p_, h_, T_, d_, s_, Dl_, Dv_,
            p_overall_out, T_overall_out, d_overall_out, h_overall_out, s_overall_out,
            d_1ph_out, h_1ph_out, s_1ph_out, Pr_1ph_out, a_1ph_out, beta_1ph_out, cp_1ph_out, cv_1ph_out, kappa_1ph_out, lambda_1ph_out, eta_1ph_out,
            dpdT_dN_1ph_out, dpdd_TN_1ph_out, nbrOfPresentPhases_out, presentPhaseIndex_out, phaseCompositions_out, phaseFractions_out, callingFunction);
}

void RefPropCalculator::calcThermoProperties_psX(double p, double s, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[],
    int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]) {
        if (LOGFUNCIONINPUTS) {
            std::string X_msg = RefPropCalculator::formatX(X, m_nc);
            warningMessage("RefPropCalculator", "calcThermoProperties_psX called with p=%f(Pa), s=%f(J/kgK), X=%s phase_id=%d(phase_id)", p, s, X_msg.c_str(), phase_id);
        }

        double p_EOS_max;
        double z[ncmax]; // Bulk properties
        double wmix;
        RefPropCalculator::convert_X_to_Z(X, z, wmix);

        // Input guards
        if (mIsPureMedia) {
            p_EOS_max = mLimits_EOS_pmax;
        } else {
            double T_EOS_min, T_EOS_max, d_EOS_max;
            char limitType[lengthofreference+1] = {"EOS"}; //reference state
            LIMITSdll(limitType, z, T_EOS_min, T_EOS_max, d_EOS_max, p_EOS_max, errormessagelength);
            p_EOS_max = p_EOS_max*1000; // Convert to SI units;
        }

        if (p > p_EOS_max) {
            warningMessage("RefPropCalculator", "calcThermoProperties_psX Input p=%f > p_max=%f  (Pa). Input p will be set to p_max", p, p_EOS_max);
        }

        double p_ = max(min(p, p_EOS_max), kMinimumPressure_SI);


        // RefProp variables
        double h_ = 0, T_ = 0, d_ = 0, Dl_ = 0, Dv_ = 0;
        double q_ = 0, e_ = 0, s_ = 0, cv_ = 0, cp_ = 0, w_ = 0, lambda_ = 0;
        double x_[ncmax];
        double y_[ncmax];
        for (int i = 0; i<ncmax; i++) {
            x_[i] = 0;
            y_[i] = 0;
        }
        long ierr_ = 0;
        char herr_[errormessagelength+1];

        // Convert inputs (SIunits) to RefProp units
        p_ = p_ / 1000; // Pa to kPa

        if (mIsPureMedia) {
            s_ = s * _fluidConstants[0].MM; // J/kgK to J/molK
        } else {
            s_ = s * wmix * 0.001; // J/kgK to J/molK
        }

        // Compute d,T from p,s,  which are used as input for almost all properties calculations in REFPROP
        PSFLSHdll(p_, s_, z, T_, d_, Dl_, Dv_, x_, y_, q_, e_, h_, cv_, cp_, w_, ierr_, herr_, errormessagelength);
        if (ierr_ != 0) {
            std::string X_msg = RefPropCalculator::formatX(X, m_nc);
            errorMessage("RefPropCalculator", "calcThermoProperties_psX(p=%f(Pa),s=%f(J/kgK),X=%s,phase_id=%d(phase_id))\nRefprop error in PSFLSdll:\n\t%s", p_*1000, s, X_msg.c_str(), phase_id, herr_);
        }

        const char *callingFunction = "RefPropCalculator.calcThermoProperties_psX";
        RefPropCalculator::calcAndSetProperties(q_, z, x_, y_, p_, h_, T_, d_, s_, Dl_, Dv_,
            p_overall_out, T_overall_out, d_overall_out, h_overall_out, s_overall_out,
            d_1ph_out, h_1ph_out, s_1ph_out, Pr_1ph_out, a_1ph_out, beta_1ph_out, cp_1ph_out, cv_1ph_out, kappa_1ph_out, lambda_1ph_out, eta_1ph_out,
            dpdT_dN_1ph_out, dpdd_TN_1ph_out, nbrOfPresentPhases_out, presentPhaseIndex_out, phaseCompositions_out, phaseFractions_out, callingFunction);
}


void RefPropCalculator::calcPhase(double &vaporFraction, int &phase) {
    /* Need to be,  if vaporFraction > 0 && vaporFraction < 1 then phase 2
      If instead:  if vaporFraction < 0 || vaporFraction > 1 then phase 1 : simulations will crash
      due to Flash calculation only returns correct values of Dl and Dv i if inside 2phase region */

    if (vaporFraction > 0 && vaporFraction < 1) {
        phase = 2;
    } else {
        phase = 1;
    }
}


void RefPropCalculator::setPhaseValues(double q, double z[], double x[], double y[], int phase, int* nbrOfPresentPhases_out, int presentPhaseIndex_out[], double phaseCompositions_out[], double phaseFractions_out[]) {

    //  system("pause");
    int LIQUID = 0;
    int VAPOR = 1;
    if (phase == 2) {
        *nbrOfPresentPhases_out = 2;
        // Both Liquid and vapor are present
        presentPhaseIndex_out[0] = 1;
        presentPhaseIndex_out[1] = 2;
    } else {
        // one phase is present
        *nbrOfPresentPhases_out = 1;
        if ( q < 0) {
            // Liquid phase is present
            *presentPhaseIndex_out = LIQUID+1; // +1 due to modelica index start at 1
        } else {
            // Vapor phase is present - could be overcritical
            *presentPhaseIndex_out = VAPOR+1; // +1 due to modelica index start at 1
        }
    }
    if (q < 1) {
        phaseFractions_out[LIQUID] = min(1-q, 1);
        phaseFractions_out[VAPOR] = max(0, q);
    } else {
        // If only one phase is present, RefProp sets x = y = z, so this case needs to be handled
        //TODO: handle overcritical conditions (q=999) -Now assumes that its vapor
        phaseFractions_out[LIQUID] = 0;
        phaseFractions_out[VAPOR] = 1;
    }

    // Set composition in each phase, TODO: convert to mass fraction
    for (int i = 0; i<2; i++) {
        // i= phase
        for (int j = 0; j<m_nc; j++) {
            // j= substance
            if (i == 0) {
                // liquid phase
                phaseCompositions_out[i*m_nc+j] = x[j];
            } else if (i == 1) {
                // vapor phase
                // If only one phase is present, RefProp sets x = y = z
                phaseCompositions_out[i*m_nc+j] = y[j];
            }
        }
    }
}


void RefPropCalculator::setValues(double q, double z[], double x[], double y[], double p_overall, double h_overall, double T_overall, double d_overall, double s_overall,
    double d_1ph[], double h_1ph[], double s_1ph[],
    double a_1ph[], double cp_1ph[], double cv_1ph[], double eta_1ph[], double lambda_1ph[], double kappa_1ph[], double beta_1ph[], int phase_out, double dpdT_1ph[], double dpdd_1ph[],
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double d_1ph_out[], double h_1ph_out[], double s_1ph_out[], double Pr_1ph_out[], double a_1ph_out[], double beta_1ph_out[], double cp_1ph_out[], double cv_1ph_out[], double kappa_1ph_out[], double lambda_1ph_out[], double eta_1ph_out[],
    double dpdT_dN_1ph_out[], double dpdd_TN_1ph_out[]) {

        double MM;
        double MM_inv;

        if (mIsPureMedia) {
            MM = _fluidConstants[0].MM;
            MM_inv = mMM_inv;
        } else {
            double wmix; // Molecular weight [g/mol]
            WMOLdll(z, wmix);
            MM = wmix*0.001;
            MM_inv = 1/MM;
        }
        // Assign values to output values and convert to SIunits mass-based
        *p_overall_out = p_overall*1000;                // pressure [kPa to Pa]
        *T_overall_out = T_overall;                     // temperature [K]
        *d_overall_out = d_overall*1000*MM;             // density [ mol/L to kg/m^3]
        *h_overall_out = h_overall*MM_inv;              // specific enthalpy [J/mol to J/kg]
        *s_overall_out = s_overall*MM_inv;              // specific entropy [J/(mol.K) to J/kgK]

        for (int i = 0; i<2; i++) {
            // TODO: improvement -only set from the present phase
            d_1ph_out[i] = d_1ph[i]*1000*MM;        // density [ mol/L to kg/m^3]
            h_1ph_out[i] = h_1ph[i]*MM_inv;         // specific enthalpy [J/mol to J/kg]
            s_1ph_out[i] = s_1ph[i]*MM_inv;         // specific entropy [J/(mol.K) to J/kgK]
            a_1ph_out[i] = a_1ph[i];                // speed of sound [m/s]
            beta_1ph_out[i] = beta_1ph[i];          //  isothermal expansion coefficient [1/K]
            cp_1ph_out[i] = cp_1ph[i]*MM_inv;       // specific heat capacity cp [J/molK to J/kgK]
            cv_1ph_out[i]= cv_1ph[i]*MM_inv;       // specific heat capacity cv [J/molK to J/kgK]
            kappa_1ph_out[i] = kappa_1ph[i]*0.001;  // isothermal compressibility [1/kPa to 1/Pa]
            lambda_1ph_out[i] = lambda_1ph[i];      // thermal conductivity [W/(m.K]
            eta_1ph_out[i] = eta_1ph[i]*0.000001;   // dynamic viscosity [uPa.s to Pa.s]
            dpdT_dN_1ph_out[i] = dpdT_1ph[i]*1000;  // der(p)/der(T) at const d, [kPa/K ot Pa/K]
            dpdd_TN_1ph_out[i] = dpdd_1ph[i]/MM;    // der(p)/der(d) at const T, [kPa-L/mol to Pa*m^3/kg]
        }
}

void RefPropCalculator::calcTransportProperties_SinglePhase(double temperature, double density, double bulkMoleFraction[],
    double &eta, double &lambda, const char *callingFunction) {
         /*Calculates transport properties for a single Phase
         If called in the twoPhase zone some of the properties does not make sense
         Inputs: temperature, density, bulkMoleFraction, phase
         Outputs: eta, lambda*/

        long ierr_ = 0;
        char herr_[errormessagelength+1];

        // Calculates transport properties eta and lamda (dynamic viscosity and thermal conductivity)
        TRNPRPdll(temperature, density, bulkMoleFraction, eta, lambda, ierr_, herr_, errormessagelength);
        if (ierr_ != 0) {
            double d_kg_per_m3 = RefPropCalculator::convertDensity_mol_per_l_to_kg_per_m3(bulkMoleFraction, density, true);
            std::string Z_msg = RefPropCalculator::formatX(bulkMoleFraction, m_nc);
            errorMessage("RefPropCalculator", "Called from %s.calcTransportProperties_SinglePhase\nRefprop error in TRNPRPdll called with T=%f(K),d=%f(kg/m^3), Z=%s:\n\t%s", callingFunction, temperature, d_kg_per_m3, Z_msg.c_str(), herr_);
        }
}

/*!
Converts X vector into a string that can be used for printing
@param X Mass fraction vector
@param msg  Message to be set
@param size_X size of X
*/
std::string RefPropCalculator::formatX(const double X[], const int size_X) {
    std::stringstream ss;
    for (int i = 0; i < size_X; ++i)
    {
        if (i == 0) {
            ss << "{";
        } else {
            ss << ",";
        }
        ss << X[i];
        if (i == (m_nc-1)) {
            ss << "}";
        }
    }
    std::string s = ss.str();
    return ss.str();
}

double RefPropCalculator::convertDensity_kg_per_m3_to_mol_per_l(double z[], double d_kg_per_m3, bool moleFractionInput) {
    double wmol; // molecular weight [g/mol
    double d_mol_per_l; // density [mol/l]
    if (moleFractionInput) {
        WMOLdll(z, wmol);
    } else {
        // z = massFractionInput
        double xmol[ncmax];
        XMOLEdll(z, xmol, wmol);
    }
    d_mol_per_l = d_kg_per_m3/wmol;
    return d_mol_per_l;
}

double RefPropCalculator::convertDensity_mol_per_l_to_kg_per_m3(double z[], double d_mol_per_l, bool moleFractionInput)
{
    double wmol; // molecular weight [g/mol
    double d_kg_per_m3; // density [kg/m3]
    if (moleFractionInput) {
        WMOLdll(z, wmol);
    } else {
        // z = massFractionInput
        double xmol[ncmax];
        XMOLEdll(z, xmol, wmol);
    }
    d_kg_per_m3 = wmol*d_mol_per_l;
    return d_kg_per_m3;
}

void RefPropCalculator::convert_X_to_Z(const double X[], double Z[], double &wmix) const
{
    if (mIsPureMedia) {
        Z[0] = X_pure[0];
        WMOLdll(Z, wmix);
    } else {
        double X_nonConstant[ncmax]; //Needed due to first input in XMOLEdll is not declared  as constant
        std::copy(X, X+ m_nc, X_nonConstant);
        XMOLEdll(X_nonConstant, Z, wmix);
    }
}

double RefPropCalculator::criticalTemperature_X(const double* X)
{
    const char *callingFunction = "RefPropCalculator.criticalTemperature_X";
    return RefPropCalculator::criticalParameters_X(X, 1, callingFunction);
}
double RefPropCalculator::criticalPressure_X(const double* X) {
    const char *callingFunction = "RefPropCalculator.criticalPressure_X";
    return RefPropCalculator::criticalParameters_X(X, 2, callingFunction);
}

double RefPropCalculator::criticalDensity_X(const double* X) {
    const char *callingFunction = "RefPropCalculator.criticalDensity_X";
    return RefPropCalculator::criticalParameters_X(X, 3, callingFunction);
}

/*!
Calculate critical property
@param X Mass fraction vector
@param output 1=Tc,2=Pc,3=Dc
*/
double RefPropCalculator::criticalParameters_X(const double* X, int output, const char *callingFunction) {
    double tc, pc, Dc;
    long ierr = 0;
    char herr[errormessagelength+1];
    double wmix;
    double z[ncmax];
    RefPropCalculator::convert_X_to_Z(X, z, wmix);
    CRITPdll(z, tc, pc, Dc, ierr, herr, errormessagelength);

    if (ierr != 0) {
        std::string X_msg = RefPropCalculator::formatX(z, m_nc);
        errorMessage("RefPropCalculator", "%s.criticalParamaters_X(Z=%s)\nRefprop error in CRITPdll:\n\t%s", callingFunction, X_msg.c_str(), herr);
    }
    if (output == 1) {
        return tc;
    } else if (output == 2) {
        return pc*1000;
    } else if ((output == 3)) {
        return Dc*wmix;
    } else {
        errorMessage("RefPropCalculator", "%s.criticalParamaters_X (called with invalid output parameter argument)", callingFunction);
        return 0;
    }
}

void RefPropCalculator::fugacity_pTN(double p, double T, const double N[], int phaseId, double fugacity_out[])
{
    //system("pause");
    long ierr_ = 0;
    char herr_[errormessagelength+1];
    double z[ncmax]; // Bulk properties
    double f[ncmax]; // Bulk properties
    double density_nonSI;
    convert2MoleFractions(N, m_nc, Units::MOLE, z);
    density_nonSI = density_pTz(p, T, z, phaseId);
    //double d_kg_per_m3 = RefPropCalculator::convertDensity_mol_per_l_to_kg_per_m3(z, density_nonSI, true);
    // Problem with FGCTY2dll definition - added it myself in refPropDllDefinitions.h
    //FGCTY2dll(T, density_nonSI, z, f, ierr_, herr_, errormessagelength);
    FGCTYdll(T, density_nonSI, z, f);

    //warningMessage("RefPropCalculator", "debug - inside fugacity_pTN");
    if (ierr_ != 0) {
        double d_kg_per_m3 = RefPropCalculator::convertDensity_mol_per_l_to_kg_per_m3(z, density_nonSI, true);
        std::string Z_msg = RefPropCalculator::formatX(z, m_nc);
        errorMessage("RefPropCalculator", "fugacity_pTN T=%f(K),d=%f(kg/m^3), Z=%s\nRefprop error in FGCTY2dll:\n\t%s", T, d_kg_per_m3, Z_msg.c_str(), herr_);
    }
    // Convert fugacity to SI
    for (int i = 0; i<m_nc; i++) {
        fugacity_out[i] = f[i]*1000; //kPa to Pa
    }
}

double RefPropCalculator::density_pTz(double p_SI, double T, double z[], int phaseId) {
    double density_nonSI;
    double p_EOS_max, T_EOS_min, T_EOS_max;

    // Input guards
    if (mIsPureMedia) {
        p_EOS_max = mLimits_EOS_pmax;
        T_EOS_max = mLimits_EOS_tmax;
        T_EOS_min = mLimits_EOS_tmin;
    } else {
        double d_EOS_max;
        char limitType[lengthofreference+1] = {"EOS"}; //reference state
        LIMITSdll(limitType, z, T_EOS_min, T_EOS_max, d_EOS_max, p_EOS_max, errormessagelength);
        p_EOS_max = p_EOS_max*1000; // Convert to SI units;
    }

    if (p_SI > p_EOS_max) {
        warningMessage("RefPropCalculator", "density_pTz Input p=%f > p_max=%f  (Pa). Input p will be set to p_max", p_SI, p_EOS_max);
    }
    if (T > T_EOS_max) {
        warningMessage("RefPropCalculator", "density_pTz Input T=%f > T_max=%f  (K). Input T will be set to T_max", T, T_EOS_max);
    } else if (T < T_EOS_min) {
        warningMessage("RefPropCalculator", "density_pTz Input T=%f < T_min=%f  (K). Input T will be set to T_min", T, T_EOS_min);
    }
    double p_, T_;
    p_ = max(min(p_SI, p_EOS_max), 0);
    T_ = max(min(T, T_EOS_max), T_EOS_min);

    double d_ = 0;
    long ierr_ = 0;
    char herr_[errormessagelength+1];

    // Convert inputs (SIunits) to RefProp units
    p_ = p_/1000; // Pa to kPa

    long phase = phaseId;
    long kguess = 0; // 0 = no first guess provided

    TPRHOdll(T_, p_, z, phase, kguess, density_nonSI, ierr_, herr_, errormessagelength);
    if (ierr_ != 0) {
        std::string Z_msg = RefPropCalculator::formatX(z, m_nc);
        errorMessage("RefPropCalculator", "density_pTz(T=%f(K),p=%f(Pa),z=%s)\nRefprop error in TPRHOdll:\n\t%s", T, p_*1000, Z_msg.c_str(), herr_);
    }

    return density_nonSI;
}

//! Return molar mass for mass fraction X
double RefPropCalculator::molarMass_X(const double* X) const
{
    double wmix;
    double z[ncmax];
    RefPropCalculator::convert_X_to_Z(X, z, wmix);
    return wmix*0.001;
}

//! Return molar mass for mass fraction X
double RefPropCalculator::averageMolarMass_X(const double X[], size_t size_X, Units::Basis X_unit, BaseCalculatorCache *cache) const
{
    // TODO: use X_unit, now it's assumes that X_unit=mass
    //double wmix;
    //double z[ncmax];
    //RefPropCalculator::convert_X_to_Z(X, z, wmix);
    //return wmix*0.001;
    return RefPropCalculator::molarMass_X(X);
}

int RefPropCalculator::getNumberOfPhases() const
{
    // only vapor and liquid phases are supported
    return 2;
}
int RefPropCalculator::getNumberOfCompounds() const
{
    return (int) m_nc;
}

void RefPropCalculator::getPhaseProperties(char** phaseLabel, char** stateOfAggregation, size_t numPossiblePhases) const
{
    // check number of phases
    if(getNumberOfPhases() != numPossiblePhases)
    {
        errorMessage("RefPropCalculator", "Actual number of phases is larger than expected number of phases");
        return;
    }

    // Set phase names
    const char* phaseName_1 = "Liquid";
    const char* phaseName_2 = "Vapor";
    setModelicaString(&phaseLabel[0], phaseName_1);
    setModelicaString(&phaseLabel[1], phaseName_2);

    // Set state of aggregation
    const char* stateOfAggregation_1 = "Liquid";
    const char* stateOfAggregation_2 = "Vapor";
    setModelicaString(&stateOfAggregation[0], stateOfAggregation_1);
    setModelicaString(&stateOfAggregation[1], stateOfAggregation_2);
}

#endif /* REFPROP */

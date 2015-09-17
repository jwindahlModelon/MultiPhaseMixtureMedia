/**
 * @file CapeOpenCalculator.cpp
 * Source file with the implementation of the CapeOpenCalculator class.
 */

#include "CapeOpenCalculator.h"

#include "config.h"
#if (CAPEOPEN == 1)

#include "COstdafx.h"
#include "Variant.h"
#include "CapeOpenSocket_1_0.h"
#include "COUtilities.h"
#include "PropertyPackageManager.h"
#include "AMaterialObject.h"
#include "errorhandling.h"
#include "ModelicaUtilities.h"

#include <vector>
#include <comutil.h>

using namespace ATL;

CComModule _Module;
extern __declspec(selectany) CAtlModule* _pAtlModule = &_Module;

PropertyPackageManager *CapeOpenCalculator::ppm = new PropertyPackageManager();

CapeOpenCalculator::CapeOpenCalculator(const MaterialCalculatorSetup* setupInfo)
                  : BaseCalculator(setupInfo)
{
    // Get the property package name from the library name
    string packageName = _libraryName.substr(_libraryName.find(".")+1);

    if (packageName.find("StanMix")     != string::npos ||
        packageName.find("PCP-SAFT")    != string::npos ||
        packageName.find("TPSI")        != string::npos ||
        packageName.find("vThermo")     != string::npos ||
        packageName.find("GasMix")      != string::npos ||
        packageName.find("IF97")        != string::npos ||
        packageName.find("RefProp")     != string::npos)
    {
        warningMessage("CapeOpenCalculator", "Calculation of properties under "
                       "specific phases is not supported by this property "
                       "package. The returned values will be an average over "
                       "the present phases.\n");
    }

    // Get the property package by its name
    LPDISPATCH pack;
    HRESULT hr = ppm->getPropertyPackage(packageName, &pack);
    if (FAILED(hr))
    {
        errorMessage("CapeOpenCalculator", "Unable to load the specified "
                     "property package.\nCAPE-OPEN error:\n\t%s",
                     COUtilities::GetCOErrorAsString(pack, hr).c_str());
        return;
    }

    // The socket handles the property package from here.
    _socket = new CapeOpenSocket_1_0(pack);
    pack->Release();

    // Set the substance on the material object
    CVariant compIds;
    compIds.MakeArray(_numCompounds, VT_BSTR);
    compIds.SetStringAt(0, _bstr_t(setupInfo->compounds));

    for(int i = 0; i < _numCompounds; ++i)
    {
        compIds.SetStringAt(i, _bstr_t(_compounds[i].c_str()));
    }

    // set component ids of material object
    _socket->GetMaterialObject()->setComponentIds(compIds.Value());

    // Get the phase ids in order to determine which constants should be available
    CVariant phaseNames;
    //phaseNames.MakeArray(COPhases1Ph::Count, VT_R8);
    _socket->GetSupportedPhases(phaseNames);

    _socket->GetMaterialObject()->setVaporPhasePossible(false);
    _socket->GetMaterialObject()->setLiquidPhasePossible(false);
    _socket->GetMaterialObject()->setSolidPhasePossible(false);

    std::wstring error;
    if (phaseNames.CheckArray(VT_BSTR, error))
    {
        // Add the packages to the list.
        for (int i = 0; i < phaseNames.GetCount(); ++i)
        {
            BSTR phaseName = phaseNames.GetStringAt(i);

            if(lstrcmpi(phaseName, COPhases1Ph::VAPOR) == 0)
                _socket->GetMaterialObject()->setVaporPhasePossible(true);
            if(lstrcmpi(phaseName, COPhases1Ph::LIQUID) == 0)
                _socket->GetMaterialObject()->setLiquidPhasePossible(true);
            if(lstrcmpi(phaseName, COPhases1Ph::SOLID) == 0)
                _socket->GetMaterialObject()->setSolidPhasePossible(true);
        }
    }

    // set the fluid constants
    this->setSubstanceConstants();
}

CapeOpenCalculator::~CapeOpenCalculator()
{
    delete _socket;
}

BaseCalculatorCache* CapeOpenCalculator::createCache()
{
    Cache *cache = new Cache();
    return cache;
}

void CapeOpenCalculator::setSubstanceConstants()
{
    // Let the property package calc the constant props
    CVariant props;

    if(_socket->GetMaterialObject()->getLiquidPhasePossible())
        props.MakeArray(COPropsConst::Count, VT_BSTR);
    else
        props.MakeArray(1, VT_BSTR);

    for (int i = 0; i < COPropsConst::Count; i++)
    {
        if(wcscmp(COPropsConst::At[i], COPropsConst::TCRIT) == 0 || wcscmp(COPropsConst::At[i], COPropsConst::PCRIT) == 0)
        {
            if(_socket->GetMaterialObject()->getLiquidPhasePossible())
            {
                props.SetStringAt(i, COPropsConst::At[i]);
            }
            else
            {
                warningMessage("CapeOpenCalculator", "Fluid constant \"%S\" is unavailable for %s.",
                       COPropsConst::At[i], _libraryName.c_str());
            }
        }
        else
        {
            props.SetStringAt(i, COPropsConst::At[i]);
        }
    }

    CVariant results;
    results.MakeArray(COPropsConst::Count * _numCompounds, VT_VARIANT);

    _socket->GetConstants(props, results);

    // Get the results
    for(int i = 0; i < _numCompounds; ++i)
    {
        FluidConstants fc;
        fc.MM = V_R8(&results.GetVariantAt(COPropsConst::MMOL_ID * _numCompounds + i)); // result is expected in kg/mol (SI)!

        if(_socket->GetMaterialObject()->getLiquidPhasePossible())
        {
            fc.Tc = V_R8(&results.GetVariantAt(COPropsConst::TCRIT_ID * _numCompounds + i));
            fc.pc = V_R8(&results.GetVariantAt(COPropsConst::PCRIT_ID * _numCompounds + i));
        }
        this->_fluidConstants.push_back(fc);
    }

    // set molar mass of material object (mixtures: temporarily set to molar mass of first compound, total/average is calculated in setSubstanceProperties())
    _socket->GetMaterialObject()->setMM(_fluidConstants[0].MM);

    // TODO: Get the other constants using a flash
    /*
    this->doFlash(this->_fluidConstants.pc, this->_fluidConstants.Tc,
                  COPropsOverall::PRESSURE, COPropsOverall::TEMPERATURE,
                  COFlashTypes::TP);
    this->doCalcOverall();
    this->getPropOverall(COPropsOverall::DENSITY, this->_fluidConstants.dc);
    this->getPropOverall(COPropsOverall::ENTHALPY, this->_fluidConstants.hc);
    this->getPropOverall(COPropsOverall::ENTROPY, this->_fluidConstants.sc);
    */
}

void CapeOpenCalculator::setSubstanceProperties(const double* X, size_t size_X, Units::Basis X_unit)
{
    // set molar mass of material object
    _socket->GetMaterialObject()->setMM(averageMolarMass(X, size_X, X_unit));

    double *Z = new double[size_X];
    convert2MoleFractions(X, size_X, X_unit, Z);

    // set fractions of material object
    _socket->SetProp(COPropsFlash::FRACTION, COPhasesOverall::OVERALL, NULL, Z, size_X);

    delete[] Z;
}


void CapeOpenCalculator::calcThermoProperties_phX(double p, double h, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double* d_1ph_out, double* h_1ph_out, double* s_1ph_out, double* Pr_1ph_out, double* a_1ph_out, double* beta_1ph_out, double* cp_1ph_out, double* cv_1ph_out, double* kappa_1ph_out, double* lambda_1ph_out, double* eta_1ph_out,
    double* dpdT_dN_1ph_out, double* dpdd_TN_1ph_out,
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double* phaseCompositions_out, double* phaseFractions_out)
{
    // Set fraction properties
    setSubstanceProperties(X, size_X, X_unit);

    // Flash calculation.
    this->doFlash(p, h, COPropsOverall::PRESSURE, COPropsOverall::ENTHALPY, COFlashTypes::PH_ID);

    // Calculate overall properties.
    this->doCalcOverall();
    this->getPropOverall(COPropsOverall::PRESSURE, *p_overall_out);
    this->getPropOverall(COPropsOverall::TEMPERATURE, *T_overall_out);
    this->getPropOverall(COPropsOverall::DENSITY, *d_overall_out);
    this->getPropOverall(COPropsOverall::ENTHALPY, *h_overall_out);
    this->getPropOverall(COPropsOverall::ENTROPY, *s_overall_out);

    // Get the phase(s) present at equilibrium.
    size_t phaseIds[COPhases1Ph::Count];
    size_t nPhases;
    this->getPhases(phaseIds, nPhases, phaseFractions_out);
    for (size_t i = 0; i < nPhases; i++)
    {
        // +1 due to modelica vectors starting at 1.
        presentPhaseIndex_out[i] = (int)(phaseIds[i] + 1);
    }
    *nbrOfPresentPhases_out = (int)nPhases;

    // Calculate remaining properties over the phases.
    this->doCalcPhases(phaseIds, nPhases);
    this->getPropPhases(COProps1Ph::DENSITY, phaseIds, nPhases, d_1ph_out);
    this->getPropPhases(COProps1Ph::ENTHALPY, phaseIds, nPhases, h_1ph_out);
    this->getPropPhases(COProps1Ph::ENTROPY, phaseIds, nPhases, s_1ph_out);
    this->getPropPhases(COProps1Ph::PRESSURE, phaseIds, nPhases, Pr_1ph_out);
    this->getPropPhases(COProps1Ph::SOUND_SPEED, phaseIds, nPhases, a_1ph_out);
    this->getPropPhases(COProps1Ph::THETA, phaseIds, nPhases, beta_1ph_out);
    this->getPropPhases(COProps1Ph::HEAT_CAPACITY, phaseIds, nPhases, cp_1ph_out);
    this->getPropPhases(COProps1Ph::HEAT_CAPACITY_CV, phaseIds, nPhases, cv_1ph_out);
    this->getPropPhases(COProps1Ph::COMPRESSIBILITY, phaseIds, nPhases, kappa_1ph_out);
    this->getPropPhases(COProps1Ph::LAMBDA, phaseIds, nPhases, lambda_1ph_out);
    this->getPropPhases(COProps1Ph::ETA, phaseIds, nPhases, eta_1ph_out);
    this->getPropPhasesPerComponent(COProps1Ph::FRACTION, phaseIds, nPhases, phaseCompositions_out);

    this->getPropPhases(COProps1Ph::PSI, phaseIds, nPhases, dpdd_TN_1ph_out);
    for (size_t i = 0; i < nPhases; i++)
    {
        dpdd_TN_1ph_out[phaseIds[i]] = 1.0 / dpdd_TN_1ph_out[phaseIds[i]];

        if(_basis == Units::MASS)
            dpdT_dN_1ph_out[phaseIds[i]] = beta_1ph_out[phaseIds[i]] * d_1ph_out[phaseIds[i]] * dpdd_TN_1ph_out[phaseIds[i]];
        else if(_basis == Units::MOLE)
            dpdT_dN_1ph_out[phaseIds[i]] = beta_1ph_out[phaseIds[i]] * d_1ph_out[phaseIds[i]] * dpdd_TN_1ph_out[phaseIds[i]] * averageMolarMass(X, size_X, X_unit);
    }
}

void CapeOpenCalculator::calcThermoProperties_pTX(double p, double T, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double* d_1ph_out, double* h_1ph_out, double* s_1ph_out, double* Pr_1ph_out, double* a_1ph_out, double* beta_1ph_out, double* cp_1ph_out, double* cv_1ph_out, double* kappa_1ph_out, double* lambda_1ph_out, double* eta_1ph_out,
    double* dpdT_dN_1ph_out, double* dpdd_TN_1ph_out,
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double* phaseCompositions_out, double* phaseFractions_out)
{
    // Set fraction properties
    setSubstanceProperties(X, size_X, X_unit);

    // Flash calculation.
    this->doFlash(p, T, COPropsOverall::PRESSURE, COPropsOverall::TEMPERATURE, COFlashTypes::TP_ID);

    // Calculate overall properties.
    this->doCalcOverall();
    this->getPropOverall(COPropsOverall::PRESSURE, *p_overall_out);
    this->getPropOverall(COPropsOverall::TEMPERATURE, *T_overall_out);
    this->getPropOverall(COPropsOverall::DENSITY, *d_overall_out);
    this->getPropOverall(COPropsOverall::ENTHALPY, *h_overall_out);
    this->getPropOverall(COPropsOverall::ENTROPY, *s_overall_out);

    // Get the phase(s) present at equilibrium.
    size_t phaseIds[COPhases1Ph::Count];
    size_t nPhases;
    this->getPhases(phaseIds, nPhases, phaseFractions_out);
    for (size_t i = 0; i < nPhases; i++)
    {
        // +1 due to modelica vectors starting at 1.
        presentPhaseIndex_out[i] = (int)(phaseIds[i] + 1);
    }
    *nbrOfPresentPhases_out = (int)nPhases;

    // Calculate remaining properties over the phases.
    this->doCalcPhases(phaseIds, nPhases);
    this->getPropPhases(COProps1Ph::DENSITY, phaseIds, nPhases, d_1ph_out);
    this->getPropPhases(COProps1Ph::ENTHALPY, phaseIds, nPhases, h_1ph_out);
    this->getPropPhases(COProps1Ph::ENTROPY, phaseIds, nPhases, s_1ph_out);
    this->getPropPhases(COProps1Ph::PRESSURE, phaseIds, nPhases, Pr_1ph_out);
    this->getPropPhases(COProps1Ph::SOUND_SPEED, phaseIds, nPhases, a_1ph_out);
    this->getPropPhases(COProps1Ph::THETA, phaseIds, nPhases, beta_1ph_out);
    this->getPropPhases(COProps1Ph::HEAT_CAPACITY, phaseIds, nPhases, cp_1ph_out);
    this->getPropPhases(COProps1Ph::HEAT_CAPACITY_CV, phaseIds, nPhases, cv_1ph_out);
    this->getPropPhases(COProps1Ph::COMPRESSIBILITY, phaseIds, nPhases, kappa_1ph_out);
    this->getPropPhases(COProps1Ph::LAMBDA, phaseIds, nPhases, lambda_1ph_out);
    this->getPropPhases(COProps1Ph::ETA, phaseIds, nPhases, eta_1ph_out);
    this->getPropPhasesPerComponent(COProps1Ph::FRACTION, phaseIds, nPhases, phaseCompositions_out);

    this->getPropPhases(COProps1Ph::PSI, phaseIds, nPhases, dpdd_TN_1ph_out);
    for (size_t i = 0; i < nPhases; i++)
    {
        dpdd_TN_1ph_out[phaseIds[i]] = 1.0 / dpdd_TN_1ph_out[phaseIds[i]];

        if(_basis == Units::MASS)
            dpdT_dN_1ph_out[phaseIds[i]] = beta_1ph_out[phaseIds[i]] * d_1ph_out[phaseIds[i]] * dpdd_TN_1ph_out[phaseIds[i]];
        else if(_basis == Units::MOLE)
            dpdT_dN_1ph_out[phaseIds[i]] = beta_1ph_out[phaseIds[i]] * d_1ph_out[phaseIds[i]] * dpdd_TN_1ph_out[phaseIds[i]] * averageMolarMass(X, size_X, X_unit);
    }
}

void CapeOpenCalculator::calcThermoProperties_dTX(double d, double T, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double* d_1ph_out, double* h_1ph_out, double* s_1ph_out, double* Pr_1ph_out, double* a_1ph_out, double* beta_1ph_out, double* cp_1ph_out, double* cv_1ph_out, double* kappa_1ph_out, double* lambda_1ph_out, double* eta_1ph_out,
    double* dpdT_dN_1ph_out, double* dpdd_TN_1ph_out,
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double* phaseCompositions_out, double* phaseFractions_out)
{
    // Set fraction properties
    setSubstanceProperties(X, size_X, X_unit);

    // Flash calculation.
    this->doFlash(d, T, COPropsOverall::DENSITY, COPropsOverall::TEMPERATURE, COFlashTypes::DT_ID);

    // Calculate overall properties.
    this->doCalcOverall();
    this->getPropOverall(COPropsOverall::PRESSURE, *p_overall_out);
    this->getPropOverall(COPropsOverall::TEMPERATURE, *T_overall_out);
    this->getPropOverall(COPropsOverall::DENSITY, *d_overall_out);
    this->getPropOverall(COPropsOverall::ENTHALPY, *h_overall_out);
    this->getPropOverall(COPropsOverall::ENTROPY, *s_overall_out);

    // Get the phase(s) present at equilibrium.
    size_t phaseIds[COPhases1Ph::Count];
    size_t nPhases;
    this->getPhases(phaseIds, nPhases, phaseFractions_out);
    for (size_t i = 0; i < nPhases; i++)
    {
        // +1 due to modelica vectors starting at 1.
        presentPhaseIndex_out[i] = (int) phaseIds[i] + 1;
    }
    *nbrOfPresentPhases_out = (int) nPhases;

    // Calculate remaining properties over the phases.
    this->doCalcPhases(phaseIds, nPhases);
    this->getPropPhases(COProps1Ph::DENSITY, phaseIds, nPhases, d_1ph_out);
    this->getPropPhases(COProps1Ph::ENTHALPY, phaseIds, nPhases, h_1ph_out);
    this->getPropPhases(COProps1Ph::ENTROPY, phaseIds, nPhases, s_1ph_out);
    this->getPropPhases(COProps1Ph::PRESSURE, phaseIds, nPhases, Pr_1ph_out);
    this->getPropPhases(COProps1Ph::SOUND_SPEED, phaseIds, nPhases, a_1ph_out);
    this->getPropPhases(COProps1Ph::THETA, phaseIds, nPhases, beta_1ph_out);
    this->getPropPhases(COProps1Ph::HEAT_CAPACITY, phaseIds, nPhases, cp_1ph_out);
    this->getPropPhases(COProps1Ph::HEAT_CAPACITY_CV, phaseIds, nPhases, cv_1ph_out);
    this->getPropPhases(COProps1Ph::COMPRESSIBILITY, phaseIds, nPhases, kappa_1ph_out);
    this->getPropPhases(COProps1Ph::LAMBDA, phaseIds, nPhases, lambda_1ph_out);
    this->getPropPhases(COProps1Ph::ETA, phaseIds, nPhases, eta_1ph_out);
    this->getPropPhasesPerComponent(COProps1Ph::FRACTION, phaseIds, nPhases, phaseCompositions_out);

    this->getPropPhases(COProps1Ph::PSI, phaseIds, nPhases, dpdd_TN_1ph_out);
    for (size_t i = 0; i < nPhases; i++)
    {
        dpdd_TN_1ph_out[phaseIds[i]] = 1.0 / dpdd_TN_1ph_out[phaseIds[i]];
        
        if(_basis == Units::MASS)
            dpdT_dN_1ph_out[phaseIds[i]] = beta_1ph_out[phaseIds[i]] * d_1ph_out[phaseIds[i]] * dpdd_TN_1ph_out[phaseIds[i]];
        else if(_basis == Units::MOLE)
            dpdT_dN_1ph_out[phaseIds[i]] = beta_1ph_out[phaseIds[i]] * d_1ph_out[phaseIds[i]] * dpdd_TN_1ph_out[phaseIds[i]] * averageMolarMass(X, size_X, X_unit);
    }
}

void CapeOpenCalculator::calcThermoProperties_psX(double p, double s, const double* X, size_t size_X, Units::Basis X_unit, int phase_id, BaseCalculatorCache *cache,
    double* p_overall_out, double* T_overall_out, double* d_overall_out, double* h_overall_out, double* s_overall_out,
    double* d_1ph_out, double* h_1ph_out, double* s_1ph_out, double* Pr_1ph_out, double* a_1ph_out, double* beta_1ph_out, double* cp_1ph_out, double* cv_1ph_out, double* kappa_1ph_out, double* lambda_1ph_out, double* eta_1ph_out,
    double* dpdT_dN_1ph_out, double* dpdd_TN_1ph_out,
    int* nbrOfPresentPhases_out, int* presentPhaseIndex_out, double* phaseCompositions_out, double* phaseFractions_out)
{
    // Set fraction properties
    setSubstanceProperties(X, size_X, X_unit);

    // Flash calculation.
    this->doFlash(p, s, COPropsOverall::PRESSURE, COPropsOverall::ENTROPY, COFlashTypes::PS_ID);

    // Calculate overall properties.
    this->doCalcOverall();
    this->getPropOverall(COPropsOverall::PRESSURE, *p_overall_out);
    this->getPropOverall(COPropsOverall::TEMPERATURE, *T_overall_out);
    this->getPropOverall(COPropsOverall::DENSITY, *d_overall_out);
    this->getPropOverall(COPropsOverall::ENTHALPY, *h_overall_out);
    this->getPropOverall(COPropsOverall::ENTROPY, *s_overall_out);

    // Get the phase(s) present at equilibrium.
    size_t phaseIds[COPhases1Ph::Count];
    size_t nPhases;
    this->getPhases(phaseIds, nPhases, phaseFractions_out);
    for (size_t i = 0; i < nPhases; i++)
    {
        // +1 due to modelica vectors starting at 1.
        presentPhaseIndex_out[i] = (int)(phaseIds[i] + 1);
    }
    *nbrOfPresentPhases_out = (int)nPhases;

    // Calculate remaining properties over the phases.
    this->doCalcPhases(phaseIds, nPhases);
    this->getPropPhases(COProps1Ph::DENSITY, phaseIds, nPhases, d_1ph_out);
    this->getPropPhases(COProps1Ph::ENTHALPY, phaseIds, nPhases, h_1ph_out);
    this->getPropPhases(COProps1Ph::ENTROPY, phaseIds, nPhases, s_1ph_out);
    this->getPropPhases(COProps1Ph::PRESSURE, phaseIds, nPhases, Pr_1ph_out);
    this->getPropPhases(COProps1Ph::SOUND_SPEED, phaseIds, nPhases, a_1ph_out);
    this->getPropPhases(COProps1Ph::THETA, phaseIds, nPhases, beta_1ph_out);
    this->getPropPhases(COProps1Ph::HEAT_CAPACITY, phaseIds, nPhases, cp_1ph_out);
    this->getPropPhases(COProps1Ph::HEAT_CAPACITY_CV, phaseIds, nPhases, cv_1ph_out);
    this->getPropPhases(COProps1Ph::COMPRESSIBILITY, phaseIds, nPhases, kappa_1ph_out);
    this->getPropPhases(COProps1Ph::LAMBDA, phaseIds, nPhases, lambda_1ph_out);
    this->getPropPhases(COProps1Ph::ETA, phaseIds, nPhases, eta_1ph_out);
    this->getPropPhasesPerComponent(COProps1Ph::FRACTION, phaseIds, nPhases, phaseCompositions_out);

    this->getPropPhases(COProps1Ph::PSI, phaseIds, nPhases, dpdd_TN_1ph_out);
    for (size_t i = 0; i < nPhases; i++)
    {
        dpdd_TN_1ph_out[phaseIds[i]] = 1.0 / dpdd_TN_1ph_out[phaseIds[i]];
        
        if(_basis == Units::MASS)
            dpdT_dN_1ph_out[phaseIds[i]] = beta_1ph_out[phaseIds[i]] * d_1ph_out[phaseIds[i]] * dpdd_TN_1ph_out[phaseIds[i]];
        else if(_basis == Units::MOLE)
            dpdT_dN_1ph_out[phaseIds[i]] = beta_1ph_out[phaseIds[i]] * d_1ph_out[phaseIds[i]] * dpdd_TN_1ph_out[phaseIds[i]] * averageMolarMass(X, size_X, X_unit);
    }
}

const BSTR CapeOpenCalculator::getBasisAsCOBasis(void)
{
    switch(_basis)
    {
    case Units::MOLE:
        return COBasis::CO_PERMOLE;
    case Units::MASS:
        return COBasis::CO_PERMASS;
    default:
        return COBasis::CO_UNDEFINED;
    }
}

void CapeOpenCalculator::doFlash(double prop1, double prop2,
                                 const BSTR prop1Name, const BSTR prop2Name,
                                 COFlashTypes::Enum flashType)
{
    // Set prop1 and prop2 on the material object
    _socket->SetProp(prop1Name, COPhasesOverall::OVERALL, getBasisAsCOBasis(), &prop1, 1);
    _socket->SetProp(prop2Name, COPhasesOverall::OVERALL, getBasisAsCOBasis(), &prop2, 1);

    // Let the property package calc the flash
    _socket->CalcEquilibrium(flashType);
}

void CapeOpenCalculator::doCalcOverall()
{
    // Collect all props to calc.

    CVariant propNames;
    propNames.MakeArray(COPropsOverall::Count, VT_BSTR);
    for (size_t i = 0; i < COPropsOverall::Count; i++)
    {
        propNames.SetStringAt(i, COPropsOverall::At[i]);
    }

    // Only overall phase.
    CVariant phaseNames;
    phaseNames.MakeArray(1, VT_BSTR);
    phaseNames.SetStringAt(0, COPhasesOverall::OVERALL);

    // The calculation.
    _socket->CalcProps(propNames, phaseNames);
}

void CapeOpenCalculator::doCalcPhases(const size_t* phaseIds, size_t nPhases)
{
    // Collect all props to calc.
    CVariant propNames;
    propNames.MakeArray(COProps1Ph::Count, VT_BSTR);
    for (size_t i = 0; i < COProps1Ph::Count; i++)
    {
        propNames.SetStringAt(i, COProps1Ph::At[i]);
    }

    // Collect all phases to calc.
    CVariant phaseNames;
    phaseNames.MakeArray(nPhases, VT_BSTR);
    for (size_t i = 0; i < nPhases; i++)
    {
        phaseNames.SetStringAt(i, COPhases1Ph::At[phaseIds[i]]);
    }

    // The calculation.
    _socket->CalcProps(propNames, phaseNames);
}

void CapeOpenCalculator::getPropOverall(const BSTR propName, double& prop)
{
    this->getProp(propName, COPhasesOverall::OVERALL, prop);
}

void CapeOpenCalculator::getPropPhases(const BSTR propName,
                                       const size_t* phaseIds, size_t nPhases,
                                       double* prop)
{
    // For all present phases.
    for (size_t i = 0; i < nPhases; i++)
    {
        this->getProp(propName, COPhases1Ph::At[phaseIds[i]], prop[phaseIds[i]]);
    }
}

void CapeOpenCalculator::getPropPhasesPerComponent(const BSTR propName,
                                       const size_t* phaseIds, size_t nPhases,
                                       double* prop)
{
    // For all present phases.
    for (size_t i = 0; i < nPhases; i++)
    {
        this->getPropPerComponent(propName, COPhases1Ph::At[phaseIds[i]], &prop[phaseIds[i] * _numCompounds]);
    }
}

void CapeOpenCalculator::getPropPerComponent(BSTR prop, BSTR phase, double *val)
{
    // Get the prop from the material object.
    _socket->GetProp(prop, phase, getBasisAsCOBasis(), val, _numCompounds);
}


void CapeOpenCalculator::getProp(BSTR prop, BSTR phase, double& val)
{
    // Get the prop from the material object.
    _socket->GetProp(prop, phase, getBasisAsCOBasis(), &val, 1);
}

double CapeOpenCalculator::averageMolarMass(const double X[], size_t size_X, Units::Basis X_unit) const
{
    double massTotal = totalMass(X, size_X, X_unit);
    double moleTotal = totalMole(X, size_X, X_unit);
    return massTotal / moleTotal;
}

double CapeOpenCalculator::averageMolarMass_X(const double X[], size_t size_X, Units::Basis X_unit, BaseCalculatorCache *cache) const
{
    return averageMolarMass(X, size_X, X_unit);
}

int CapeOpenCalculator::getNumberOfPhases() const
{
     return (int) COPhases1Ph::Count;
}

int CapeOpenCalculator::getNumberOfCompounds() const
{
     return _numCompounds;
}

void CapeOpenCalculator::getPhases(size_t* phaseIds, size_t& nPhases,
                                   double* phaseFractions)
{
    // For all phases.
    // TODO: Dew and bubble.
    size_t nPossiblePhases = 0;
    if(_socket->GetMaterialObject()->getVaporPhasePossible())
        nPossiblePhases++;
    if(_socket->GetMaterialObject()->getLiquidPhasePossible())
        nPossiblePhases++;
    if(_socket->GetMaterialObject()->getSolidPhasePossible())
        nPossiblePhases++;

    // initialize phaseFractions
    for (size_t i = 0; i < COPhases1Ph::Count; i++)
        phaseFractions[i] = 0.0;

    for (size_t i = 0; i < nPossiblePhases; i++)
    {
        this->getProp(COPropsFlash::PHASE_FRACTION, COPhases1Ph::At[i], phaseFractions[i]);
    }

    nPhases = 0;
    if (phaseFractions[COPhases1Ph::VAPOR_ID] > PHASE_FRACTION_ZERO)
    {
        phaseIds[nPhases] = COPhases1Ph::VAPOR_ID;
        nPhases++;
    }
    if (phaseFractions[COPhases1Ph::LIQUID_ID] > PHASE_FRACTION_ZERO)
    {
        phaseIds[nPhases] = COPhases1Ph::LIQUID_ID;
        nPhases++;
    }
    if (phaseFractions[COPhases1Ph::SOLID_ID] > PHASE_FRACTION_ZERO)
    {
        phaseIds[nPhases] = COPhases1Ph::SOLID_ID;
        nPhases++;
    }
}

void CapeOpenCalculator::getPhaseProperties(char** phaseLabel, char** stateOfAggregation, size_t numPossiblePhases) const
{
    // check number of phases
    if((size_t) getNumberOfPhases() > numPossiblePhases)
    {
        errorMessage("CapeOpenCalculator", "Actual number of phases is larger than expected number of phases");
        return;
    }
	//char* ModelicaAllocateString(size_t len);
    // get phase names
    for (size_t i = 0; i < COPhases1Ph::Count; i++)
    {
        const BSTR phaseName = COPhases1Ph::At[i];
        char buf[30];
        wcstombs_s(NULL, buf, phaseName, SysStringLen(phaseName));
        setModelicaString(&phaseLabel[i], buf);
        setModelicaString(&stateOfAggregation[i], buf);
    }
}

#endif // CAPEOPEN == 1

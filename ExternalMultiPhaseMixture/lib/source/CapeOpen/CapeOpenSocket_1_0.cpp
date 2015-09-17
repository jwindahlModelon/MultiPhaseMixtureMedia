/**
 * @file CapeOpenSocket_1_0.cpp
 * Source file for the implementation of the CapeOpenSocket_1_0 class.
 */

#include "CapeOpenSocket_1_0.h"

#include "config.h"

#if (CAPEOPEN == 1)

#include "MaterialObject_1_0.h"
#include "Variant.h"
#include "COUtilities.h"
#include "errorhandling.h"

using namespace ATL;

CapeOpenSocket_1_0::CapeOpenSocket_1_0(LPDISPATCH pack)
{
    HRESULT hr = pack->QueryInterface(IID_ICapeThermoPropertyPackage, (LPVOID*) &_pp);
    if (FAILED(hr))
    {
        errorMessage("CapeOpenCalculator", "Unable to access the specified "
                     "property package.\nCAPE-OPEN error:\n\t%s",
                     COUtilities::GetCOErrorAsString(_pp, hr).c_str());
        return;
    }

    // Initialize the property package
    CComPtr<IPersistStreamInit> iInit;
    iInit = _pp;
    if ((IPersistStreamInit*) iInit)
    {
        hr = iInit->InitNew();
        if (FAILED(hr) && hr != ECapeNoImplHR && hr != E_NOTIMPL)
        {
            // No implementation can be ignored
            errorMessage("CapeOpenCalculator", "Unable to initialize the "
                         "specified property package.\nCAPE-OPEN error:\n\t%s",
                         COUtilities::GetCOErrorAsString(_pp, hr).c_str());
            return;
        }
    }
    CComPtr<ICapeUtilities> utils;
    utils = _pp;
    if ((ICapeUtilities*) utils)
    {
        hr = utils->Initialize();
        if (FAILED(hr) && hr != ECapeNoImplHR && hr != E_NOTIMPL)
        {
            // No implementation can be ignored
            errorMessage("CapeOpenCalculator", "Unable to initialize the "
                         "specified property package.\nCAPE-OPEN error:\n\t%s",
                         COUtilities::GetCOErrorAsString(_pp, hr).c_str());
            return;
        }
    }

    // Create the material object
    hr = CComObject<CMaterialObject_1_0>::CreateInstance(&_mo);
    if (FAILED(hr))
    {
        errorMessage("CapeOpenCalculator", "CAPE-OPEN error:\n\t%s",
                     COUtilities::GetCOErrorAsString(_mo, hr).c_str());
        return;
    }
    _mo->AddRef();
}

CapeOpenSocket_1_0::~CapeOpenSocket_1_0()
{
    CComPtr<ICapeUtilities> utils;
    utils = _pp;
    if ((ICapeUtilities*) utils) utils->Terminate();
    _mo->Release();
}

AMaterialObject* CapeOpenSocket_1_0::GetMaterialObject() const
{
    return _mo;
}

void CapeOpenSocket_1_0::GetProp(BSTR prop, BSTR phase, BSTR basis, double *results, size_t nresults) const
{
    if (!prop || !phase)
    {
        errorMessage("CapeOpenSocket", "prop and phase must be defined");
        return;
    }

    // Check if the requested property is available
    std::vector<double> propVal;
    if (!_mo->_propLookup(prop, phase, basis, propVal))
    {   // Lookup failed, property for specified phase not present.
        warningMessage("CapeOpenCalculator", "CAPE-OPEN error:\n\t%s",
                       COUtilities::GetCOErrorAsString(_mo, ECapeInvalidArgumentHR).c_str());
        return;
    }

    // Return the result
    if (nresults < propVal.size())
    {
        warningMessage("CapeOpenSocket", "Not enough room in value array");
        return;
    }
    for (size_t i = 0; i < propVal.size(); ++i)
    {
        results[i] = propVal[i];
    }
}

void CapeOpenSocket_1_0::SetProp(BSTR prop, BSTR phase, BSTR basis, const double *val, size_t nval) const
{
    if (!prop || !phase)
    {
        errorMessage("CapeOpenSocket", "prop and phase must be defined");
        return;
    }

    std::vector<double> vValues(nval);
    for (size_t i = 0; i < nval; i++)
    {
        vValues[i] = val[i];
    }

    // Insert the property
    _mo->_propSet(prop, phase, basis, vValues);
}

void CapeOpenSocket_1_0::GetSupportedPhases(CVariant& phases) const
{
    HRESULT hr = _pp->GetPhaseList(phases.OutputArgument());
    if (FAILED(hr))
    {
        errorMessage("CapeOpenCalculator", "Getting the supported failed.\n"
                     "CAPE-OPEN error:\n\t%s",
                     COUtilities::GetCOErrorAsString(_pp, hr).c_str());
    }
}

void CapeOpenSocket_1_0::GetConstants(CVariant& props, CVariant& results) const
{
    HRESULT hr = _pp->GetComponentConstant(_mo, props.Value(), results.OutputArgument());
    if (FAILED(hr))
    {
        errorMessage("CapeOpenCalculator", "Getting the component constants "
                     " failed.\nCAPE-OPEN error:\n\t%s",
                     COUtilities::GetCOErrorAsString(_pp, hr).c_str());
    }
}

void CapeOpenSocket_1_0::CalcEquilibrium(COFlashTypes::Enum flashType) const
{
    VARIANT vProps;
    VariantInit(&vProps);

    HRESULT hr = _pp->CalcEquilibrium(_mo, COFlashTypes::At[flashType], vProps);
    if (FAILED(hr))
    {
        errorMessage("CapeOpenCalculator", "The property package failed to "
                     "calculate the equilibrium.\nCAPE-OPEN error:\n\t%s",
                     COUtilities::GetCOErrorAsString(_pp, hr).c_str());
    }
}

void CapeOpenSocket_1_0::CalcProps(CVariant& properties, CVariant& phases) const
{
    long numComps = 1;
    _mo->GetNumComponents(&numComps);

    const BSTR calcType = numComps > 1 ? COCalcTypes::CO_MIX : COCalcTypes::CO_PURE;

    HRESULT hr = _pp->CalcProp(_mo, properties.Value(), phases.Value(), calcType);
    if (FAILED(hr))
    {
        errorMessage("CapeOpenCalculator", "The property package failed to "
                     "calculate the properties.\nCAPE-OPEN error:\n\t%s",
                     COUtilities::GetCOErrorAsString(_pp, hr).c_str());
    }
}

#endif // CAPEOPEN == 1

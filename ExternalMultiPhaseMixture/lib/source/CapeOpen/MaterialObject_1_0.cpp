/**
 * @file MaterialObject_1_0.cpp
 * Source file for the implementation of the CapeOpen 1.0 MaterialObject class.
 */

#include "MaterialObject_1_0.h"

#include "config.h"

#if (CAPEOPEN == 1)
#include "Variant.h"
#include "COConsts.h"
#include <vector>

const CLSID CLSID_MaterialObject_1_0 =
{
    0x4fb88e35,0x9d98,0x47bc,0xb5,0x9d,0x09,0x0d,0x45,0x7e,0x79,0xe0
};

using namespace std;
using namespace ATL;

CMaterialObject_1_0::CMaterialObject_1_0() : AMaterialObject()
{
}

STDMETHODIMP CMaterialObject_1_0::get_ComponentIds(VARIANT* compIds)
{
    if (!compIds) return E_POINTER;

    VariantClear(compIds);
    if (this->_compIds.GetCount() > 0)
    {
        compIds->vt = VT_ARRAY | VT_BSTR;
        this->_compIds.CopyTo(&compIds->parray);
    }
    return NO_ERROR;
}

STDMETHODIMP CMaterialObject_1_0::get_PhaseIds(VARIANT* phaseIds)
{
    if (!phaseIds) return E_POINTER;

    VariantClear(phaseIds);
    if (this->_phaseIds.GetCount() > 0)
    {
        phaseIds->vt = VT_ARRAY | VT_BSTR;
        this->_phaseIds.CopyTo(&phaseIds->parray);
    }
    return NO_ERROR;
}

STDMETHODIMP CMaterialObject_1_0::GetUniversalConstant(VARIANT props,
                                                   VARIANT* propVals)
{
    // We do not use this function. GetUniversalConstant should instead be
    // called directly on the property package.
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_0::GetComponentConstant(VARIANT props,
                                                   VARIANT compIds,
                                                   VARIANT* propVals)
{
    // We do not use this function. GetComponentConstant should instead be
    // called directly on the property package.
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_0::CalcProp(VARIANT props, VARIANT phases,
                                       BSTR calcType)
{
    // We do not use this function. CalcProp should instead be called directly
    // on the property package.
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_0::GetProp(BSTR prop, BSTR phase,
                                      VARIANT compIds, BSTR calcType,
                                      BSTR basis, VARIANT* results)
{
    // TODO: Add calcType and basis implementation.
    if (!prop || !phase || !results) return E_POINTER;

    // Currently only support calculation of all components
    if (compIds.vt != VT_EMPTY) return ECapeUnknownHR;

    // Check if the requested property is available
    vector<double> propVal;
    if (!this->_propLookup(prop, phase, basis, propVal))
    {   // Lookup failed, property for specified phase not present.
        return ECapeInvalidArgumentHR;
    }

    // Return the result
    CComSafeArray<DOUBLE> csaResults(0L, 0L);
    for (int i = 0; i < (int) propVal.size(); i++)
    {
        csaResults.Add(propVal[i]);
    }

    VariantClear(results);
    if (csaResults.GetCount() > 0)
    {
        results->vt = VT_ARRAY | VT_R8;
        results->parray = csaResults.Detach();
    }

    return NO_ERROR;
}

STDMETHODIMP CMaterialObject_1_0::SetProp(BSTR prop, BSTR phase,
                                      VARIANT compIds, BSTR calcType,
                                      BSTR basis, VARIANT values)
{
    // TODO: Add calcType.
    if (!prop || !phase) return E_POINTER;

    vector<double> vValues(0);

    // Insert the property
    CComSafeArray<DOUBLE> csaValues(0L, 0L);
    if (values.vt == (VT_ARRAY | VT_R8))
    {
        csaValues.CopyFrom(values.parray);
        vValues.resize(csaValues.GetCount());

        for (int i = 0; i < (int) csaValues.GetCount(); i++)
        {
            vValues[i] = csaValues.GetAt(i);
        }
    }

    this->_propSet(prop, phase, basis, vValues);

    return NO_ERROR;
}

STDMETHODIMP CMaterialObject_1_0::CalcEquilibrium(BSTR flashType, VARIANT props)
{
    // We do not use this function. CalcEquilibrium should instead be called
    // directly on the property package.
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_0::SetIndependentVar(VARIANT indVars, VARIANT values)
{
    // This method is deprecated and should not be used.
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_0::GetIndependentVar(VARIANT indVars, VARIANT* values)
{
    // This method is deprecated and should not be used.
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_0::PropCheck(VARIANT props, VARIANT* valid)
{
    // We do not use this function. PropCheck should instead be called directly
    // on the property package.
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_0::AvailableProps(VARIANT* props)
{
    // Implementation not required. TODO: Should we implement?
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_0::RemoveResults(VARIANT props)
{
    // TODO: Add implementation.
    return NO_ERROR;
}

STDMETHODIMP CMaterialObject_1_0::CreateMaterialObject(LPDISPATCH* materialObject)
{
    // TODO: Add implementation.
    return NO_ERROR;
}

STDMETHODIMP CMaterialObject_1_0::Duplicate(LPDISPATCH* clone)
{
    //TODO: Add implementation.
    return NO_ERROR;
}

STDMETHODIMP CMaterialObject_1_0::ValidityCheck(VARIANT props, VARIANT* relList)
{
    // This method is deprecated and should not be used.
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_0::GetPropList(VARIANT* props)
{
    // We do not use this function. GetPropList should instead be called
    // directly on the property package.
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_0::GetNumComponents(long* numComp)
{
    if (!numComp) return E_POINTER;
    *numComp = this->_compIds.GetCount();
    return NO_ERROR;
}

#endif // CAPEOPEN == 1

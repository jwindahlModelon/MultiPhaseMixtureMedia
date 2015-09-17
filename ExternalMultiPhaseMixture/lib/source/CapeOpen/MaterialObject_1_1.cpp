/**
 * @file MaterialObject_1_1.cpp
 * Source file for the implementation of the CapeOpen 1.1 MaterialObject class.
 */

#include "MaterialObject_1_1.h"

#include "config.h"

#if (CAPEOPEN == 1)
#include "Variant.h"
#include "COConsts.h"
#include <vector>

const CLSID CLSID_MaterialObject_1_1 =
{
    0x4fb88e35,0x9d98,0x47bc,0xb5,0x9d,0x09,0x0d,0x45,0x7e,0x79,0xe0
};

using namespace std;
using namespace ATL;

CMaterialObject_1_1::CMaterialObject_1_1() : AMaterialObject()
{
}

STDMETHODIMP CMaterialObject_1_1::ClearAllProps()
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::CreateMaterial(LPDISPATCH* materialObject)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::CopyFromMaterial(LPDISPATCH* source)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetOverallProp(BSTR property, BSTR basis,
                                                 VARIANT* results)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetOverallTPFraction(double* temperature,
                                                       double* pressure,
                                                       VARIANT* composition)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetPresentPhases(VARIANT* phaseLabels,
                                                   VARIANT* phaseStatus)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetSinglePhaseProp(BSTR property,
                                                     BSTR phaseLabel,
                                                     BSTR basis,
                                                     VARIANT* results)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetTPFraction(BSTR phaseLabel,
                                                double* temperature,
                                                double* pressure,
                                                VARIANT* composition)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetTwoPhaseProp(BSTR property,
                                                  VARIANT phaseLabels, BSTR basis,
                                                  VARIANT* results)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::SetOverallProp(BSTR property, BSTR basis,
                                                 VARIANT values)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::SetPresentPhases(VARIANT phaseLabels,
                                                   VARIANT phaseStatus)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::SetSinglePhaseProp(BSTR property,
                                                     BSTR phaseLabel,
                                                     BSTR basis, VARIANT values)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::SetTwoPhaseProp(BSTR property,
                                                  VARIANT phaseLabels,
                                                  BSTR basis, VARIANT values)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetCompoundConstant(VARIANT props,
                                                      VARIANT compIds, 
                                                      VARIANT* propVals)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetCompoundList(VARIANT* compIds,
                                                  VARIANT* formulae,
                                                  VARIANT* names,
                                                  VARIANT* boilTemps,
                                                  VARIANT* molwts,
                                                  VARIANT* casnos)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetConstPropList(VARIANT* props)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetNumCompounds(long* num)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetPDependentProperty(VARIANT props,
                                                        double pressure,
                                                        VARIANT compIds,
                                                        VARIANT* propVals)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetPDependentPropList(VARIANT* props)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetTDependentProperty(VARIANT props,
                                                        double temperature,
                                                        VARIANT compIds,
                                                        VARIANT* propVals)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetTDependentPropList(VARIANT* props)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetNumPhases(long* num)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetPhaseInfo(BSTR phaseLabel,
                                               BSTR phaseAttribute,
                                               VARIANT* value)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetPhaseList(VARIANT* phaseLabels,
                                               VARIANT* stateOfAggregation,
                                               VARIANT* keyCompoundId)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetUniversalConstant(BSTR constantId,
                                                       VARIANT* constantValue)
{
    return ECapeNoImplHR;
}

STDMETHODIMP CMaterialObject_1_1::GetUniversalConstantList(VARIANT* constantId)
{
    return ECapeNoImplHR;
}

#endif // CAPEOPEN == 1

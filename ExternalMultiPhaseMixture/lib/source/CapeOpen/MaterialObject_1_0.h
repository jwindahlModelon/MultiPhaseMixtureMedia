/**
 * @file MaterialObject_1_0.h
 * Header file for the definition of the CapeOpen 1.0 MaterialObject class.
 */

#ifndef MATERIALOBJECT_1_0_H_
#define MATERIALOBJECT_1_0_H_

#include "config.h"

#if (CAPEOPEN == 1)
#include "AMaterialObject.h"

#import "CAPE-OPENv1-0-0.tlb" raw_interfaces_only, raw_native_types, no_namespace, named_guids

extern "C" const CLSID CLSID_MaterialObject_1_0;
class DECLSPEC_UUID("4fb88e35-9d98-47bc-b59d-090d457e79e0") MaterialObject_1_0;

/**
 * COM class with the implementation of the CapeOpen 1.0 MaterialObject interface.
 */
class ATL_NO_VTABLE CMaterialObject_1_0 :
    public AMaterialObject,
    public ATL::CComObjectRootEx<ATL::CComSingleThreadModel>,
    public ATL::CComCoClass<CMaterialObject_1_0, &CLSID_MaterialObject_1_0>,
    public ATL::IDispatchImpl<ICapeThermoMaterialObject,
                              &__uuidof(ICapeThermoMaterialObject),
                              &LIBID_CAPEOPEN100, 1, 0>
{
public:
    CMaterialObject_1_0();

    DECLARE_NO_REGISTRY()

    BEGIN_COM_MAP(CMaterialObject_1_0)
        COM_INTERFACE_ENTRY(ICapeThermoMaterialObject)
        COM_INTERFACE_ENTRY2(IDispatch, ICapeThermoMaterialObject)
    END_COM_MAP()

    DECLARE_PROTECT_FINAL_CONSTRUCT()

    // ICapeThermoMaterialObject Methods

    STDMETHOD(get_ComponentIds)(VARIANT* compIds);
    STDMETHOD(get_PhaseIds)(VARIANT* phaseIds);
    STDMETHOD(GetUniversalConstant)(VARIANT props, VARIANT* propVals);
    STDMETHOD(GetComponentConstant)(VARIANT props, VARIANT compIds,
                                    VARIANT* propVals);
    STDMETHOD(CalcProp)(VARIANT props, VARIANT phases, BSTR calcType);
    STDMETHOD(GetProp)(BSTR property, BSTR phase, VARIANT compIds,
                       BSTR calcType, BSTR basis, VARIANT* results);
    STDMETHOD(SetProp)(BSTR property, BSTR phase, VARIANT compIds,
                       BSTR calcType, BSTR basis, VARIANT values);
    STDMETHOD(CalcEquilibrium)(BSTR flashType, VARIANT props);
    STDMETHOD(SetIndependentVar)(VARIANT indVars, VARIANT values);
    STDMETHOD(GetIndependentVar)(VARIANT indVars, VARIANT* values);
    STDMETHOD(PropCheck)(VARIANT props, VARIANT* valid);
    STDMETHOD(AvailableProps)(VARIANT* props);
    STDMETHOD(RemoveResults)(VARIANT props);
    STDMETHOD(CreateMaterialObject)(LPDISPATCH* materialObject);
    STDMETHOD(Duplicate)(LPDISPATCH* clone);
    STDMETHOD(ValidityCheck)(VARIANT props, VARIANT* relList);
    STDMETHOD(GetPropList)(VARIANT* props);
    STDMETHOD(GetNumComponents)(long* numComp);
};

OBJECT_ENTRY_AUTO(__uuidof(MaterialObject_1_0), CMaterialObject_1_0)

#endif // CAPEOPEN == 1

#endif

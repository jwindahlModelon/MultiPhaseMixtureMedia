/**
 * @file MaterialObject_1_1.h
 * Header file for the definition of the CapeOpen 1.1 MaterialObject class.
 */

#ifndef MATERIALOBJECT_1_1_H_
#define MATERIALOBJECT_1_1_H_

#include "config.h"

#if (CAPEOPEN == 1)
#include "AMaterialObject.h"

#import "CAPE-OPENv1-1-0.tlb" raw_interfaces_only, raw_native_types, no_namespace, named_guids

extern "C" const CLSID CLSID_MaterialObject_1_1;
class DECLSPEC_UUID("4fb88e35-9d98-47bc-b59d-090d457e79e0") MaterialObject_1_1;

/**
 * COM class with the implementation of the CapeOpen 1.1 MaterialObject interface.
 */
class ATL_NO_VTABLE CMaterialObject_1_1 :
    public AMaterialObject,
    public ATL::CComObjectRootEx<ATL::CComSingleThreadModel>,
    public ATL::CComCoClass<CMaterialObject_1_1, &CLSID_MaterialObject_1_1>,
    public ATL::IDispatchImpl<ICapeThermoMaterial,
                              &__uuidof(ICapeThermoMaterial),
                              &LIBID_CAPEOPEN110, 1, 1>,
    public ATL::IDispatchImpl<ICapeThermoCompounds,
                              &__uuidof(ICapeThermoCompounds),
                              &LIBID_CAPEOPEN110, 1, 1>,
    public ATL::IDispatchImpl<ICapeThermoPhases, &__uuidof(ICapeThermoPhases),
                              &LIBID_CAPEOPEN110, 1, 1>,
    public ATL::IDispatchImpl<ICapeThermoUniversalConstant,
                              &__uuidof(ICapeThermoUniversalConstant),
                              &LIBID_CAPEOPEN110, 1, 1>
{
public:
    CMaterialObject_1_1();

    DECLARE_NO_REGISTRY()

    BEGIN_COM_MAP(CMaterialObject_1_1)
        COM_INTERFACE_ENTRY(ICapeThermoMaterial)
        COM_INTERFACE_ENTRY2(IDispatch, ICapeThermoMaterial)
    END_COM_MAP()

    DECLARE_PROTECT_FINAL_CONSTRUCT()

    // ICapeThermoMaterial Methods

    STDMETHOD(ClearAllProps)();
    STDMETHOD(CreateMaterial)(LPDISPATCH* materialObject);
    STDMETHOD(CopyFromMaterial)(LPDISPATCH* source);
    STDMETHOD(GetOverallProp)(BSTR property, BSTR basis, VARIANT* results);
    STDMETHOD(GetOverallTPFraction)(double* temperature, double* pressure,
                                    VARIANT* composition);
    STDMETHOD(GetPresentPhases)(VARIANT* phaseLabels, VARIANT* phaseStatus);
    STDMETHOD(GetSinglePhaseProp)(BSTR property, BSTR phaseLabel, BSTR basis,
                                  VARIANT* results);
    STDMETHOD(GetTPFraction)(BSTR phaseLabel, double* temperature,
                             double* pressure, VARIANT* composition);
    STDMETHOD(GetTwoPhaseProp)(BSTR property, VARIANT phaseLabels, BSTR basis,
                               VARIANT* results);
    STDMETHOD(SetOverallProp)(BSTR property, BSTR basis, VARIANT values);
    STDMETHOD(SetPresentPhases)(VARIANT phaseLabels, VARIANT phaseStatus);
    STDMETHOD(SetSinglePhaseProp)(BSTR property, BSTR phaseLabel, BSTR basis,
                                  VARIANT values);
    STDMETHOD(SetTwoPhaseProp)(BSTR property, VARIANT phaseLabels, BSTR basis,
                               VARIANT values);

    // ICapeThermoCompounds Methods

    STDMETHOD(GetCompoundConstant)(VARIANT props, VARIANT compIds, 
                                   VARIANT* propVals);
    STDMETHOD(GetCompoundList)(VARIANT* compIds, VARIANT* formulae,
                               VARIANT* names, VARIANT* boilTemps,
                               VARIANT* molwts, VARIANT* casnos);
    STDMETHOD(GetConstPropList)(VARIANT* props);
    STDMETHOD(GetNumCompounds)(long* num);
    STDMETHOD(GetPDependentProperty)(VARIANT props, double pressure, 
                                     VARIANT compIds, VARIANT* propVals);
    STDMETHOD(GetPDependentPropList)(VARIANT* props);
    STDMETHOD(GetTDependentProperty)(VARIANT props, double temperature, 
                                     VARIANT compIds, VARIANT* propVals);
    STDMETHOD(GetTDependentPropList)(VARIANT* props);

    // ICapeThermoPhases Methods

    STDMETHOD(GetNumPhases)(long* num);
    STDMETHOD(GetPhaseInfo)(BSTR phaseLabel, BSTR phaseAttribute,
                            VARIANT* value);
    STDMETHOD(GetPhaseList)(VARIANT* phaseLabels, VARIANT* stateOfAggregation,
                            VARIANT* keyCompoundId);

    // ICapeThermoUniversalConstant Methods

    STDMETHOD(GetUniversalConstant)(BSTR constantId, VARIANT* constantValue);
    STDMETHOD(GetUniversalConstantList)(VARIANT* constantId);
};

OBJECT_ENTRY_AUTO(__uuidof(MaterialObject_1_1), CMaterialObject_1_1)

#endif // CAPEOPEN == 1

#endif

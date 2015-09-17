/**
 * @file CapeOpenSocket_1_0.h
 * Header file for the definition of the CapeOpenSocket_1_0 class.
 */

#ifndef CAPEOPENSOCKET_1_0_H_
#define CAPEOPENSOCKET_1_0_H_

#include "config.h"

#if (CAPEOPEN == 1)
#include "ICapeOpenSocket.h"

// Forward declarations:
struct ICapeThermoPropertyPackage;
class CMaterialObject_1_0;

/**
 * Class for helper functions used by CapeOpenCalculator to communicate to
 * CapeOpen 1.0.
 */
class CapeOpenSocket_1_0 : public ICapeOpenSocket
{
private:
    ATL::CComPtr<ICapeThermoPropertyPackage> _pp;
    ATL::CComObject<CMaterialObject_1_0>* _mo;
public:
    CapeOpenSocket_1_0(LPDISPATCH pack);
    ~CapeOpenSocket_1_0();

    AMaterialObject* GetMaterialObject() const;
    void GetProp(BSTR prop, BSTR phase, BSTR basis, double *results, size_t nresults) const;
    void SetProp(BSTR prop, BSTR phase, BSTR basis, const double *val, size_t nval) const;

    void GetSupportedPhases(CVariant& phases) const;
    void GetConstants(CVariant& props, CVariant& results) const;
    void CalcEquilibrium(COFlashTypes::Enum flashType) const;
    void CalcProps(CVariant& properties, CVariant& phases) const;
};

#endif // CAPEOPEN == 1

#endif

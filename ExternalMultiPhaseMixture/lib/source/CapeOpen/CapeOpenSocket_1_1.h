/**
 * @file CapeOpenSocket_1_1.h
 * Header file for the definition of the CapeOpenSocket_1_1 class.
 */

#ifndef CAPEOPENSOCKET_1_1_H_
#define CAPEOPENSOCKET_1_1_H_

#include "config.h"

#if (CAPEOPEN == 1)
#include "ICapeOpenSocket.h"

// Forward declarations:
class CMaterialObject_1_1;

/**
 * Class for helper functions used by CapeOpenCalculator to communicate to
 * CapeOpen 1.1.
 */
class CapeOpenSocket_1_1 : public ICapeOpenSocket
{
private:
    ATL::CComObject<CMaterialObject_1_1>* _mo;
public:
    CapeOpenSocket_1_1(LPDISPATCH pack);
    ~CapeOpenSocket_1_1();

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

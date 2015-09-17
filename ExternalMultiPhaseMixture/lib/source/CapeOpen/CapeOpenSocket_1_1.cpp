/**
 * @file CapeOpenSocket_1_1.cpp
 * Source file for the implementation of the CapeOpenSocket_1_1 class.
 */

#include "CapeOpenSocket_1_1.h"

#include "config.h"

#if (CAPEOPEN == 1)

#include "MaterialObject_1_1.h"
#include "Variant.h"
#include "COUtilities.h"
#include "errorhandling.h"

using namespace ATL;

CapeOpenSocket_1_1::CapeOpenSocket_1_1(LPDISPATCH pack)
{
}

CapeOpenSocket_1_1::~CapeOpenSocket_1_1()
{
}

AMaterialObject* CapeOpenSocket_1_1::GetMaterialObject() const
{
    return _mo;
}

void CapeOpenSocket_1_1::GetProp(BSTR prop, BSTR phase, BSTR basis, double *results, size_t nresults) const
{
}

void CapeOpenSocket_1_1::SetProp(BSTR prop, BSTR phase, BSTR basis, const double *val, size_t nval) const
{
}

void CapeOpenSocket_1_1::GetSupportedPhases(CVariant& phases) const
{
}

void CapeOpenSocket_1_1::GetConstants(CVariant& props, CVariant& results) const
{
}

void CapeOpenSocket_1_1::CalcEquilibrium(COFlashTypes::Enum flashType) const
{
}

void CapeOpenSocket_1_1::CalcProps(CVariant& properties, CVariant& phases) const
{
}

#endif // CAPEOPEN == 1

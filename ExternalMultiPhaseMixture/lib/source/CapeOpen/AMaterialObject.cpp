/**
 * @file AMaterialObject.cpp
 * Source file for the implementation of the abstract MaterialObject class.
 */

#include "AMaterialObject.h"

#include "config.h"

#if (CAPEOPEN == 1)
#include "Variant.h"
#include "COConsts.h"
#include <vector>

using namespace std;
using namespace ATL;

AMaterialObject::AMaterialObject()
{
    this->_name = L"MaterialObject";
    this->_desc = L"ExternalMediaCO";

    this->_compIds = CComSafeArray<BSTR>(0L, 0L);
    this->_phaseIds = CComSafeArray<BSTR>(0L, 0L);
}

void AMaterialObject::setMM(const double mm)
{
    _MolarMass = mm;
}

double AMaterialObject::convertToMoleBasis(const wchar_t *propName, double propValue) const
{
    if(_wcsicmp(propName, COProps1Ph::DENSITY) == 0)
        return (propValue / _MolarMass);

    if(_wcsicmp(propName, COProps1Ph::ENTROPY) == 0)
        return (propValue * _MolarMass);

    if(_wcsicmp(propName, COProps1Ph::ENTHALPY) == 0)
        return (propValue * _MolarMass);

    if(_wcsicmp(propName, COProps1Ph::HEAT_CAPACITY) == 0)
        return (propValue * _MolarMass);

    if(_wcsicmp(propName, COProps1Ph::HEAT_CAPACITY_CV) == 0)
        return (propValue * _MolarMass);

    if(_wcsicmp(propName, COProps1Ph::KSI) == 0)
        return (propValue / (_MolarMass*_MolarMass));

    // return original value in all other cases
    return propValue;
}

double AMaterialObject::convertToMassBasis(const wchar_t *propName, double propValue) const
{
    if(_wcsicmp(propName, COProps1Ph::DENSITY) == 0)
        return (propValue * _MolarMass);

    if(_wcsicmp(propName, COProps1Ph::ENTROPY) == 0)
        return (propValue / _MolarMass);

    if(_wcsicmp(propName, COProps1Ph::ENTHALPY) == 0)
        return (propValue / _MolarMass);

    if(_wcsicmp(propName, COProps1Ph::HEAT_CAPACITY) == 0)
        return (propValue / _MolarMass);

    if(_wcsicmp(propName, COProps1Ph::HEAT_CAPACITY_CV) == 0)
        return (propValue / _MolarMass);

    if(_wcsicmp(propName, COProps1Ph::KSI) == 0)
        return (propValue * (_MolarMass*_MolarMass));

    // return original value in all other cases
    return propValue;
}

void AMaterialObject::setComponentIds(VARIANT comps)
{
    // Set the components
    if (comps.vt != VT_EMPTY)
        this->_compIds.CopyFrom(comps.parray);
}

#endif // CAPEOPEN == 1

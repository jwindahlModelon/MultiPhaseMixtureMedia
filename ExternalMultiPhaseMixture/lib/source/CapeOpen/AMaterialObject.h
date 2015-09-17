/**
 * @file AMaterialObject.h
 * Header file for the definition of the abstract MaterialObject class.
 */

#ifndef AMATERIALOBJECT_H_
#define AMATERIALOBJECT_H_

#include "config.h"

#if (CAPEOPEN == 1)
#include "COstdafx.h"
#include "COConsts.h"
#include <hash_map>
#include <string>
#include <algorithm>

/**
 * Abstract base class for material objects. Provides shared functionality for
 * material objects of different CapeOpen versions.
 */
class AMaterialObject
{
protected:
    std::wstring _name;
    std::wstring _desc;

    ATL::CComSafeArray<BSTR> _compIds;
    ATL::CComSafeArray<BSTR> _phaseIds;

    stdext::hash_map<std::wstring, std::vector<double>> _properties;
public:
    void _propSet(const BSTR prop, const BSTR phase, const BSTR basis, std::vector<double> &value)
    {
        // always save values on a per mole basis, so convert if the given basis is "mass"
        if (basis != NULL && _wcsicmp(basis, COBasis::CO_PERMASS) == 0)
        {
            for (size_t i = 0; i < value.size(); i++)
            {
                value[i] = convertToMoleBasis(prop, value[i]);
            }
        }
        std::wstring wsProperty(prop, SysStringLen(prop));
        std::wstring wsPhase(phase, SysStringLen(phase));
        std::wstring k = (wsProperty + L"_" + wsPhase).c_str();
        std::transform(k.begin(), k.end(), k.begin(), ::tolower);
        _properties[k] = value;
    }
    bool _propLookup(const BSTR prop, const BSTR phase, const BSTR basis, std::vector<double> &value) const
    {
        std::wstring wsProperty(prop, SysStringLen(prop));
        std::wstring wsPhase(phase, SysStringLen(phase));
        std::wstring k = (wsProperty + L"_" + wsPhase).c_str();
        std::transform(k.begin(), k.end(), k.begin(), ::tolower);
        stdext::hash_map<std::wstring, std::vector<double>>::const_iterator it;
        it = _properties.find(k);
        if (it == _properties.end()) return false;
        value = it->second;
        // values are saved on a per mole basis, so convert if the given basis is "mass"
        if (basis != NULL && _wcsicmp(basis, COBasis::CO_PERMASS) == 0)
        {
            for (size_t i = 0; i < value.size(); i++)
            {
                value[i] = convertToMassBasis(prop, value[i]);
            }
        }
        return true;
    }
protected:

    double _MolarMass; // molar mass

    bool _phaseVaporPossible;
    bool _phaseLiquidPossible;
    bool _phaseSolidPossible;

    AMaterialObject();

    /**
     * Converts the given property value to mole basis (if needed).
     *
     * @param propName  The name of the input property.
     * @param propValue The property value.
     */
    double convertToMoleBasis(const wchar_t *propName, double propValue) const;

    /**
     * Converts the given property value to mass basis (if needed).
     *
     * @param propName  The name of the input property.
     * @param propValue The property value.
     */
    double convertToMassBasis(const wchar_t *propName, double propValue) const;

public:
    void setComponentIds(VARIANT comps);

    void setMM(const double mm);

    void setVaporPhasePossible(bool value)
    {
        _phaseVaporPossible = value;
    }

    void setLiquidPhasePossible(bool value)
    {
        _phaseLiquidPossible = value;
    }

    void setSolidPhasePossible(bool value)
    {
        _phaseSolidPossible = value;
    }

    bool getVaporPhasePossible()
    {
        return _phaseVaporPossible;
    }

    bool getLiquidPhasePossible()
    {
        return _phaseLiquidPossible;
    }

    bool getSolidPhasePossible()
    {
        return _phaseSolidPossible;
    }
};

#endif // CAPEOPEN == 1

#endif

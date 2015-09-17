/**
 * @file ICapeOpenSocket.h
 * Header file for the definition of the CapeOpenSocket interface class.
 */

#ifndef ICAPEOPENSOCKET_H_
#define ICAPEOPENSOCKET_H_

#include "config.h"

#if (CAPEOPEN == 1)
#include "COstdafx.h"
#include "COConsts.h"

// Forward declarations
class AMaterialObject;
class CVariant;

/**
 * Interface class for helper functions used by CapeOpenCalculator to
 * communicate to CapeOpen.
 */
class ICapeOpenSocket
{
public:
    virtual ~ICapeOpenSocket() {};

    /**
     * Gets the material object managed by this socket.
     *
     * @return A pointer to the abstract material object.
     */
    virtual AMaterialObject* GetMaterialObject() const = 0;
    /**
     * Gets a property from the material object managed by this socket.
     */
    virtual void GetProp(BSTR prop, BSTR phase, BSTR basis, double *results, size_t nresults) const = 0;
    /**
     * Sets a property on the material object managed by this socket.
     */
    virtual void SetProp(BSTR prop, BSTR phase, BSTR basis, const double *val, size_t nval) const = 0;

    /**
     * Gets the possible phases supported by the propery package.
     */
    virtual void GetSupportedPhases(CVariant& phases) const = 0;
    /**
     * Gets the universal/component constants.
     */
    virtual void GetConstants(CVariant& props, CVariant& results) const = 0;
    /**
     * Calculates the equilibrium. Must be done before a property calculation.
     */
    virtual void CalcEquilibrium(COFlashTypes::Enum flashType) const = 0;
    /**
     * Calculates the properties. Must be done after an equilibrium calculation.
     * The properties are set on the material object.
     */
    virtual void CalcProps(CVariant& properties, CVariant& phases) const = 0;
};

#endif // CAPEOPEN == 1

#endif

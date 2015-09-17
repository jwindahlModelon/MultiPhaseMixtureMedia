/**
 * @file COConsts.h
 * Header file for the definition of namespaces containing CapeOpen constants.
 */

#ifndef COConst_H_
#define COConst_H_


#define PHASE_FRACTION_ZERO 1e-32

/**
 * Macro for generating an entry in a listing of constant string properties.
 */
#define GENERATE_CONST_ENTRY(key, value) const BSTR key = SysAllocString(L ## value)
/**
 * Macro for generating an entry in an enum.
 */
#define GENERATE_ENUM_ENTRY(key, value) key##_ID
/**
 * Macro for generating an entry in an array.
 */
#define GENERATE_ARRAY_ENTRY(key, value) key

#define SEMICOLON_SYMBOL ;
#define COMMA_SYMBOL ,

/**
 * Macro for generating a listing of constant string properties. Make sure a
 * "LISTING(m, s)" macro is defined before calling this macro.
 */
#define GENERATE_CONSTS()                           \
    LISTING(GENERATE_CONST_ENTRY, SEMICOLON_SYMBOL)

/**
 * Macro for generating an enum of property IDs. Make sure a "LISTING(m, s)"
 * macro is defined before calling this macro.
 */
#define GENERATE_ENUM()                            \
    enum Enum                                      \
    {                                              \
        LISTING(GENERATE_ENUM_ENTRY, COMMA_SYMBOL) \
    }

/**
 * Macro for generating an array of constant string properties. Make sure a
 * "LISTING(m, s)" macro is defined before calling this macro. Also, this macro
 * call must come after a "GENERATE_CONSTS()" call.
 */
#define GENERATE_ARRAY()                            \
    const BSTR At[] =                        \
    {                                               \
        LISTING(GENERATE_ARRAY_ENTRY, COMMA_SYMBOL) \
    };                                              \
    const size_t Count = sizeof(At) / sizeof(At[0])

/**
 * Namespace containing constants for Cape Open thermodynamic overall properties
 * and their names.
 */
namespace COPropsOverall
{
    #define LISTING(m, s)               \
        m(PRESSURE, "pressure")       s \
        m(TEMPERATURE, "temperature") s \
        m(DENSITY, "density")         s \
        m(ENTHALPY, "enthalpy")       s \
        m(ENTROPY, "entropy")

    GENERATE_CONSTS();
    GENERATE_ARRAY();

    #undef LISTING
}

/**
 * Namespace containing constants for Cape Open thermodynamic single phase
 * properties and their names.
 */
namespace COProps1Ph
{
    #define LISTING(m, s)                       \
        m(DENSITY, "density")                 s \
        m(ENTHALPY, "enthalpy")               s \
        m(ENTROPY, "entropy")                 s \
        m(PRESSURE, "pressure")               s \
        m(SOUND_SPEED, "soundSpeed")          s \
        m(THETA, "theta")                     s \
        m(HEAT_CAPACITY, "heatCapacity")      s \
        m(HEAT_CAPACITY_CV, "heatCapacityCv") s \
        m(COMPRESSIBILITY, "compressibility") s \
        m(KSI, "ksi")                         s \
        m(PSI, "psi")                         s \
        m(LAMBDA, "thermalConductivity")      s \
        m(ETA, "viscosity")                   s \
        m(FRACTION, "fraction")                 \

    GENERATE_CONSTS();
    GENERATE_ARRAY();

    #undef LISTING
}

/**
 * Namespace containing constants for Cape Open thermodynamic flash only
 * properties and their names.
 */
namespace COPropsFlash
{
    #define LISTING(m, s)                    \
        m(PHASE_FRACTION, "phaseFraction")  s \
        m(FRACTION, "fraction")               \

    GENERATE_CONSTS();

    #undef LISTING
}

/**
 * Namespace containing constants for Cape Open thermodynamic constant
 * properties and their names.
 */
namespace COPropsConst
{
    #define LISTING(m, s)                 \
        m(MMOL, "molecularWeight")      s \
        m(TCRIT, "criticalTemperature") s \
        m(PCRIT, "criticalPressure")      \

    GENERATE_CONSTS();
    GENERATE_ENUM();
    GENERATE_ARRAY();

    #undef LISTING
}

/**
 * Namespace containing constants for Cape Open flash types and their names.
 */
namespace COFlashTypes
{
    #define LISTING(m, s) \
        m(PH, "PH")     s \
        m(TP, "TP")     s \
        m(DT, "DT")     s \
        m(PS, "PS")     s \
        m(PVF, "PVF")   s \
        m(TVF, "TVF")     \

    GENERATE_CONSTS();
    GENERATE_ENUM();
    GENERATE_ARRAY();

    #undef LISTING
}

/**
 * Namespace containing constants for Cape Open overall phase types and their
 * names.
 */
namespace COPhasesOverall
{
    #define LISTING(m, s)     \
        m(OVERALL, "Overall") \

    GENERATE_CONSTS();

    #undef LISTING
}

/**
 * Namespace containing constants for Cape Open single phase, phase types and
 * their names.
 */
namespace COPhases1Ph
{
    #define LISTING(m, s)       \
        m(VAPOR, "Vapor")     s \
        m(LIQUID, "Liquid")   s \
        m(SOLID, "Solid")       \

    GENERATE_CONSTS();
    GENERATE_ENUM();
    GENERATE_ARRAY();

    #undef LISTING
}

/**
 * Namespace containing constants for Cape Open calculation types and their
 * names.
 */
namespace COCalcTypes
{
    #define LISTING(m, s)      \
        m(CO_PURE, "Pure")   s \
        m(CO_MIX, "Mixture")   \

    GENERATE_CONSTS();

    #undef LISTING
}

/**
 * Namespace containing constants for Cape Open Unit basis string.
 */
namespace COBasis
{
    #define LISTING(m, s)                 \
        m(CO_PERMOLE, "mole")           s \
        m(CO_PERMASS, "mass")           s \
        m(CO_UNDEFINED, "undefined")      \

    GENERATE_CONSTS();

    #undef LISTING
}

#endif // COConst_H_

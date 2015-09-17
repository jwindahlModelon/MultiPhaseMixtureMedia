#include "CalculatorMap.h"
#include "externalmixturemedialib.h"
#include "config.h"
#include "errorhandling.h"

#if (FLUIDPROP == 1)
#include "FluidProp/FluidPropCalculator.h"
#endif // FLUIDPROP == 1
#if (REFPROP == 1)
#include "RefProp/RefPropCalculator.h"
#endif // REFPROP == 1
#include "dummyCalculator.h"
#if (CAPEOPEN == 1)
#include "CapeOpen/CapeOpenCalculator.h"
#endif // CAPEOPEN == 1
//#if (COOLPROP == 1)
//#include "coolpropsolver.h"


// Create new calculator according to the given setupInfo
BaseCalculator *CalculatorMap::newCalculator(const MaterialCalculatorSetup *setupInfo)
{
    string libraryName = setupInfo->libraryName;
    // Dummy calculator for compiler setup debugging
    if (libraryName.compare("DummyCalculator") == 0) {
        return new DummyCalculator(setupInfo);
    }
#if REFPROP
    // RefProp calculator
    if (libraryName.compare("RefProp") == 0) {
        return new RefPropCalculator(setupInfo);
    }
#endif
    //#if COOLPROP
    // CoolProp calculator
    //if (libraryName.find("CoolProp") == 0)
    //_calculators[calculatorKeyString] = new CoolPropCalculator(compounds, libraryName, setupInfo);
    //#endif
#if CAPEOPEN
    if (libraryName.find("CapeOpen") == 0) {
        return new CapeOpenCalculator(setupInfo);
    }
#endif
#if FLUIDPROP
    // FluidProp calculator
    if (libraryName.find("FluidProp") == 0) {
        return new FluidPropCalculator(setupInfo);
    }
#endif

    // Calculator not found
    errorMessage("CalculatorMap", "libraryName = %s is not supported by any external calculator", setupInfo->libraryName);
}


string CalculatorMap::calculatorKey(const string &libraryName, const string &setupInfo, const string &compounds = "")
{
    // This function returns the calculator calculatorKeyString and may be changed by advanced users
    string key = libraryName + "." + setupInfo;
    if (!compounds.empty())
    {
        key += "." + compounds;
    }
    return key;
}

BaseCalculator *CalculatorMap::getCalculator(const MaterialCalculatorSetup *setupInfo)
{
    // Check for calculator in map, if there we don't need to create a new calculatorObject
    string calculatorKeyString = calculatorKey(setupInfo->libraryName, setupInfo->setupInfo, setupInfo->compounds);

    // Check whether calculator already exists
    if (_calculatorMap.find(calculatorKeyString) != _calculatorMap.end()) {
        _calculatorMapCounter[calculatorKeyString]++;
        return _calculatorMap[calculatorKeyString];
    } else {
        _calculatorMapCounter[calculatorKeyString] = 1;
        return _calculatorMap[calculatorKeyString] = newCalculator(setupInfo);
    }
};

void CalculatorMap::releaseCalculator(const string &calculatorKey)
{
    // Decrement reference count for Calculator
    _calculatorMapCounter[calculatorKey]--;

    if (_calculatorMapCounter[calculatorKey] == 0)
    {
        BaseCalculator *calculator = _calculatorMap[calculatorKey];
        // Last Material object that holds reference to Calculator object so delete and remove it from the map
        _calculatorMap.erase(calculatorKey);
        _calculatorMapCounter.erase(calculatorKey);
        delete calculator;
    }
}


// Need to be defined here -otherwize the compilation in Dymola will not work
map<string, BaseCalculator*>CalculatorMap::_calculatorMap;
map<string, int>CalculatorMap::_calculatorMapCounter;

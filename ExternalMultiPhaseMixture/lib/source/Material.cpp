#include "Material.h"
#include "CalculatorMap.h"

Material::Material(const MaterialCalculatorSetup *setupInfo)
{
    // Get a new or existing Calculator object
    calculator = CalculatorMap::getCalculator(setupInfo);

    // Create a new cache from calculator instance.
    cache = calculator->createCache();

    mCalculatorMapKey = CalculatorMap::calculatorKey(setupInfo->libraryName, setupInfo->setupInfo, setupInfo->compounds);
}

Material::~Material(void)
{
    delete cache;

    // if this was the last Material to hold a reference to the Calculator, delete calculator is called 
    CalculatorMap::releaseCalculator(mCalculatorMapKey);
}

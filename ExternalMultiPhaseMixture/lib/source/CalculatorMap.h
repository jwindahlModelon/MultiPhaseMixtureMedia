#ifndef CALCULATORMAP_H_
#define CALCULATORMAP_H_

#include "BaseCalculator.h"
#include "DummyCalculator.h"

#include <map>
using std::map;
#include <string>
using std::string;

class CalculatorMap {
public:
    //! Generate a unique calculator calculatorKeyString
    /*!
      This function generates a unique calculator calculatorKeyString based on the library name,
      substance name, and compound names
      @param libraryName Name of library to use
      @param setupInfo Library setup string
      @param compounds String holding compounds separated by '/' (optional)
    */
    static string calculatorKey(const string &libraryName, const string &setupInfo, const string &compounds);

    //! Get a specific calculator
    /*!
    This function returns the calculator for the specified library name, substance name
    and possibly medium name. It creates a new calculator if the calculator does not already
    exist. When implementing new calculators, one has to add the newly created calculators to
    this function. An error message is generated if the specific library is not supported
    by the interface library.
    @param setupInfo Library setup string
    */
    static BaseCalculator* getCalculator(const MaterialCalculatorSetup *setupInfo);

    //! Release a calculator
    /*!
    This function decrements the reference count of the specified calculator.
    If the reference count ends up being zero, the calculator is destroyed.
    @param calculatorKey the key of the calculator to release
    */
    static void CalculatorMap::releaseCalculator(const string &calculatorKey);

protected:
    static BaseCalculator* newCalculator(const MaterialCalculatorSetup *setupInfo);

    static map<string, BaseCalculator*> _calculatorMap;
    static map<string, int> _calculatorMapCounter;
};

#endif // CALCULATORMAP_H_
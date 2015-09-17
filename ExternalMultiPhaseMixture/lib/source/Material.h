#ifndef MATERIAL_H_
#define MATERIAL_H_

#include "BaseCalculator.h"
#include "BaseCalculatorCache.h"

using std::string;


class Material {
public:
    Material(const MaterialCalculatorSetup *setupInfo);
    ~Material(void);

    BaseCalculator* calculator;
    BaseCalculatorCache* cache;

    int _logId;

private:
    string mCalculatorMapKey;
};

#endif // MATERIAL_H_

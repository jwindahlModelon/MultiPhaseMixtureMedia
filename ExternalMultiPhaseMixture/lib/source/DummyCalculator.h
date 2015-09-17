#ifndef DUMMYCALCULATOR_H_
#define DUMMYCALCULATOR_H_

#include "basecalculator.h"

class DummyCalculator :
    public BaseCalculator
{
public:
    DummyCalculator(const MaterialCalculatorSetup *setupInfo);
    ~DummyCalculator(void);

private:
    class Cache : public BaseCalculatorCache {
    public:
        // Not used- only for testing
        void set_d(double d);
        double get_d();
        double d;
    };
public:
    virtual BaseCalculatorCache* createCache();
    virtual double density_pT(double p, double T, BaseCalculatorCache *cache);
    virtual double specificEnthalpy_pT(double p, double T, BaseCalculatorCache *cache);
    virtual double density_ph(double p, double h, BaseCalculatorCache *cache);
    double DummyCalculator::h_T(double T, bool  exclEnthForm, int refChoice, double h_off);



    //  String name "Name of ideal gas";
    double MM; // "Molar mass";
    double Hf; // "Enthalpy of formation at 298.15K";
    double H0; // "H0(298.15K) - H0(0K)";
    double Tlimit; // "Temperature limit between low and high data sets";
    double alow[7]; // "Low temperature coefficients a";
    double blow[2]; // "Low temperature constants b";
    double ahigh[7]; // "High temperature coefficients a";
    double bhigh[2]; // "High temperature constants b";
    double R; //"Gas constant";
    bool  exclEnthForm;
    int refChoice;
    double h_off;
};

#endif // DUMMYCALCULATOR_H_

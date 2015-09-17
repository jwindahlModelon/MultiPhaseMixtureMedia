#include "DummyCalculator.h"
#include "errorhandling.h"

#include <math.h>

DummyCalculator::DummyCalculator(const MaterialCalculatorSetup *setupInfo) : BaseCalculator(setupInfo) {
    // Test code - Assumes that medium is Ar
    static const double ahigh_[7] = {20.10538475,-0.05992661069999999,2.500069401,-3.99214116e-008,
        1.20527214e-011,-1.819015576e-015,1.078576636e-019};
    static const double alow_[7] = {0,0,2.5,0,0,0,0};
    static const double blow_[2] = {-745.375,4.37967491};
    static const double bhigh_[2] = {-744.993961,4.37918011};
    MM = 0.039948;
    Hf = 0;
    H0 = 155137.3785921698;
    Tlimit = 1000;
    memcpy(alow, alow_, sizeof(ahigh));
    memcpy(blow, blow_, sizeof(blow));
    memcpy(ahigh, ahigh_, sizeof(ahigh));
    memcpy(bhigh, bhigh_, sizeof(bhigh));
    R = 208.1323720837088;
    exclEnthForm = true;
    refChoice = 1;
    h_off = 0;
}

DummyCalculator::~DummyCalculator(void)
{
}

BaseCalculatorCache* DummyCalculator::createCache() {
    Cache *cache = new Cache();
    return cache;

}

double DummyCalculator::density_pT(double p, double T, BaseCalculatorCache *cache) {
    // cast to Cache
    warningMessage("DummyCalculator", "Inside density_pT");
    return p/(R*T);
}

double DummyCalculator::specificEnthalpy_pT(double p, double T, BaseCalculatorCache *cache) {
    // cast to Cache
    return h_T(T, exclEnthForm, refChoice, h_off);
}

double DummyCalculator::density_ph(double p, double h, BaseCalculatorCache *cache) {
    double d = p*h*30;
    ((Cache*) cache)->set_d(d);
    return d;
}



void DummyCalculator::Cache::set_d(double d) {
    this->d = d;
    warningMessage("DummyCalculator", "Inside Cache::set_d");
}

double DummyCalculator::h_T(double T, bool  exclEnthForm, int refChoice, double h_off) {
    // Compute specific enthalpy from temperature and gas data; reference is decided by the
    //    refChoice input, or by the referenceChoice package constant by default"

    if (T < Tlimit) {
        return R*((-alow[1] + T*(
            blow[1] + alow[2]*log(T) + T*(1.*alow[3] + T*(0.5*
            alow[4] + T*(1/3*alow[5] + T*(0.25*alow[6] + 0.2*alow[7]*T))))))
            /T);
    } else {
        return 0;
    }

}

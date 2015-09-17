// Source file for gtests that evaluate MultiPhaseMixtureMedium_calcThermoProperties_dTX_C_impl()

#include "ExternalMultiPhaseMixtureTester.h"

#if (REFPROP == 1)
static void do_RefProp_setup() {
    // Test to see if RefProp can handle the seupInformation- if not = crash
    const char *compounds = "";
    const char *libraryName = "RefProp";
    const char *setupInfo = "mixture=air.mix|path=C:/Program Files (x86)/REFPROP/";
    void *material = getMaterial(libraryName, compounds, setupInfo);
    closeMaterial(material);
}


TEST(test_RefPropSetup, RefPropSetup) {
    do_RefProp_setup();
}
#endif // REFPROP == 1

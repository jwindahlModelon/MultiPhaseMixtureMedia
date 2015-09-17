// ExternalMultiPhaseMixtureTester.cpp : Test client for testing ExternalMultiPhaseMixtureMedia
// through its C interface. GTest is used as a testing framework.

#include "ExternalMultiPhaseMixtureTester.h"
#include "Windows.h"

int main(int argc, char* argv[])
{
    testing::InitGoogleTest(&argc, argv);

    // init test code generation
    //InitTestCodeLogging();
    
    int exitCode = RUN_ALL_TESTS();

    //FinalizeTestCodeLogging();

    if (IsDebuggerPresent()) {
        system("PAUSE");
    }
    return exitCode;
}

/* *****************************************************************
 * Implementation of the error reporting functions
 *
 * The actual implementation depends on the selected preprocessor
 * variable defined in config.h
 *
 * Francesco Casella, Christoph Richter, Nov 2006
 ********************************************************************/

#include "errorhandling.h"
#include "config.h"

#include <iostream>
#include <stdlib.h>
#include <stdarg.h>

#if DYMOLA
#include "ModelicaUtilities.h"
#endif

#if DYMOLA
# define ERROR_MSG "Press the Stop button in Dymola to end the simulation!"
#elif OPENMODELICA
# define ERROR_MSG "Press the Stop button in OpenModelica to end the simulation!"
#else
# define ERROR_MSG "Press the ENTER key to abort"
#endif

#if (DYMOLA || OPENMODELICA) && !BUILD_DLL
// The Dymola specific implementation does currently not work for dynmic link libraries
# define USE_MODELICA_FUNCTIONS 1
#else
# define USE_MODELICA_FUNCTIONS 0
#endif

// Error and warnings are sent to either the standard error output or
// the native Modelica tool log and error window
static void errorMessage_internal(char *errorMessage) {
#if USE_MODELICA_FUNCTIONS
    ModelicaError(errorMessage);
#else
    std::cerr << "\a" << errorMessage << std::endl << ERROR_MSG << std::endl;
    getchar();
    exit(1);
#endif
}

static void warningMessage_internal(char *warningMessage) {
#if USE_MODELICA_FUNCTIONS
    ModelicaMessage(warningMessage);
#else
    std::cerr << warningMessage << std::endl;
#endif
}


void errorMessage(const char *subsystem, const char *errorFormat, ...) {
    va_list args;
    char buffer1[300], buffer2[300];

    va_start(args, errorFormat);
    vsprintf_s(buffer1, sizeof(buffer1), errorFormat, args);
    va_end(args);

    sprintf_s(buffer2, sizeof(buffer2), "Error in %s: %s", subsystem, buffer1);
    errorMessage_internal(buffer2);
}

void warningMessage(const char *subsystem, const char *warningFormat, ...) {
    va_list args;
    char buffer1[300], buffer2[300];

    va_start(args, warningFormat);
    vsprintf_s(buffer1, sizeof(buffer1), warningFormat, args);
    va_end(args);

    sprintf_s(buffer2, sizeof(buffer2), "%s: %s", subsystem, buffer1);
    warningMessage_internal(buffer2);
}

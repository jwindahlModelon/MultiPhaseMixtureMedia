/*!
  \file config.h
  \brief Configuration file

  This is a include file specifies which components of the
  ExternalMultiPhaseMixture package are enabled.

  Uncomment the define directives as appropriate
*/
#ifndef CONFIG_H_
#define CONFIG_H_


// Selection of build type for this project
//! Build project into a DLL
/*!
  Set this preprocessor variable to 1 if the project is built into a
  dynamic link library. This setting influences the error reporting
  mechanism as well as the export statement.
*/
#define BUILD_DLL 0


// Selection of used external fluid property computation packages.
/*! CAPE-OPEN calculator
  Set this preprocessor variable to 1 to include the interface to the
  Cape-Open calculator.
*/
#define CAPEOPEN 0

// Selection of used external fluid property computation packages.
//! CoolProp calculator
/*!
  Set this preprocessor variable to 1 to include the interface to the
  CoolProp calculator developed and maintained by Ian Bell et al.
*/
#define COOLPROP 1

// Selection of Modelica compiler
//! Modelica compiler is Dymola
/*!
  Set this preprocessor variable to 1 if Dymola is the Modelica
  compiler that is going to be used with the compiled library.
  \sa OPEN_MODELICA
*/
#define DYMOLA 1

// Selection of used external fluid property computation packages.
//! FluidProp calculator
/*!
  Set this preprocessor variable to 1 to include the interface to the
  FluidProp calculator developed and maintained by Francesco Casella.
*/
#define FLUIDPROP 0

//! Modelica compiler is OpenModelica
/*!
  Set this preprocessor variable to 1 if OpenModelica is the Modelica
  compiler that is going to be used with the compiled library.
  \sa DYMOLA
*/
#define OPEN_MODELICA 0

// Selection of used external fluid property computation packages.
//! RefProp calculator
/*!
  Set this preprocessor variable to 1 to include the interface to the
  RefProp calculator.
*/
#define REFPROP 1

//! Generate test code 
/*!
  Set this preprocessor variable to 1 to generate test code between getMaterial 
  and closeMaterial calls
*/
#define GENERATE_TEST_CODE 1

/********************************************************************
 *                 End of user option selection
 *            Do not change anything below this line
 ********************************************************************/

/*!
Overwrite FluidProp inclusion if not on Windows
 */
#if !defined(_WIN32) && !defined(__WIN32__) && !defined(_WIN64) && !defined(__WIN64__)
#  undef FLUIDPROP
#  define FLUIDPROP 0
#endif


#endif /* CONFIG_H_ */

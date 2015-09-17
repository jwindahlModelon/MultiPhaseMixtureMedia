/*!
  \file errorhandling.h
  \brief Error handling for external library

  Errors in the external fluid property library have to be reported
  to the Modelica layer. This class defines the required interface
  functions.

  Francesco Casella, Christoph Richter, Nov 2006
  Copyright Politecnico di Milano and TU Braunschweig
*/

#ifndef ERRORHANDLING_H_
#define ERRORHANDLING_H_

//! Function to display error message
/*!
  Calling this function will display the specified error message and will
  terminate the simulation.
  @param subsystem Subsystem name to use as a prefix
  @param errorMessage Error message to be displayed
*/
void errorMessage(const char *subsystem, const char *errorMessage, ...);

//! Function to display warning message
/*!
  Calling this function will display the specified warning message.
  @param subsystem Subsystem name to use as a prefix
  @param warningMessage Warning message to be displayed
*/
void warningMessage(const char *subsystem, const char *warningMessage, ...);

#endif // ERRORHANDLING_H_

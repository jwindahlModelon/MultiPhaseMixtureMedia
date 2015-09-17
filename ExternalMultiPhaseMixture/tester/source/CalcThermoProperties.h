// CalcThermoProperties.h : Include file for the CalcThermoProperties functions.

#ifndef CALCTHERMOPROPERTIES_H_
#define CALCTHERMOPROPERTIES_H_

#include "ExternalMultiPhaseMixtureTester.h"

extern void run_test_pure(const char *libraryName, const char *compounds, const char *inputSpec, const TestProperties props, int basis);
extern void run_test_mixture(const char *libraryName, const char *compounds, const char *inputSpec, const TestProperties props, int basis, const double *X, int X_unit, const size_t size_X);
extern void run_test_refprop_air_mixture1(const char *libraryName, const char *inputSpec, Units::Basis basis, Units::Basis x_unit);
extern void run_test_stanmix_pure(const char *libraryName, const char *inputSpec, Units::Basis basis);
extern void run_test_pcpsaft_pure(const char *libraryName, const char *inputSpec, Units::Basis basis);
extern void run_test_stanmix_mixture1(const char *libraryName, const char *inputSpec, Units::Basis basis, Units::Basis x_unit);
extern void run_test_stanmix_mixture2(const char *libraryName, const char *inputSpec, Units::Basis basis, Units::Basis x_unit);
extern void run_test_gasmix_mixture1(const char *libraryName, const char *inputSpec, Units::Basis basis, Units::Basis x_unit);
extern void run_test_gasmix_mixture2(const char *libraryName, const char *inputSpec, Units::Basis basis, Units::Basis x_unit);
extern void run_test_pcpsaft_air_mixture1(const char *libraryName, const char *inputSpec, Units::Basis basis, Units::Basis x_unit);

#endif /*CALCTHERMOPROPERTIES_H_*/
/**
 * @file COUtilities.h
 * Header file for the definition of namespaces containing CapeOpen Utilities.
 */

#ifndef COUtilities_H_
#define COUtilities_H_

#include "config.h"
#if (CAPEOPEN == 1)

#include <string>
#include "COstdafx.h"

/**
 * Namespace containing Cape Open utility functions
 */
namespace COUtilities
{
    // Error utilities
    std::string GetCOErrorAsString(IDispatch *capeObject, HRESULT hr);
    std::wstring CO_Error(IDispatch *capeObject, HRESULT hr);
    std::wstring HResError(HRESULT hr);

}

#endif // CAPEOPEN
#endif // COUtilities_H_

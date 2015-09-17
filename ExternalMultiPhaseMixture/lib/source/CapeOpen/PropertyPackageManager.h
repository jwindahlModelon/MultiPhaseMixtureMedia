/**
 * @file PropertyPackageManager.h
 * Header file for the definition of the PropertyPackageManager and Package
 * class.
 */

#ifndef PROPERTYPACKAGEMANAGER_H_
#define PROPERTYPACKAGEMANAGER_H_

#include "config.h"
#if (CAPEOPEN == 1)

#include "COstdafx.h"

#include <hash_map>
#include <string>

#define CATID_THERMOSYSTEM L"{678C09A3-7D66-11D2-A67D-00105A42887F}"
#define CATID_THERMOPROPERTYPACKAGE L"{678c09a4-7d66-11D2-a67d-00105a42887f}"
#define CATID_PROPERTYPACKAGE L"CF51E384-0110-4ed8-ACB7-B50CFDE6908E}"

/**
 * Manager for all available CAPE-OPEN property packages on the users system.
 */
class PropertyPackageManager
{
private:
    stdext::hash_map<std::wstring, CLSID> clsidMap;

    /**
     * Finds the value for the specified key in the CLSID map.
     *
     * @param key The key.
     * @param value A reference for the output value.
     * @return True if the value was found, false otherwise.
     */
    bool clsidMapLookup(const std::wstring& key, CLSID& value) const;
    /**
     * Initializes the package list by going through the Windows registry.
     */
    void initPackageList();

public:
    /**
     * Initializes COM and the package list.
     */
    PropertyPackageManager();
    /**
     * Uninitializes COM.
     */
    ~PropertyPackageManager();

    /**
     * Gets the property package with the specified name.
     *
     * @param packageName The name of the property package.
     * @param package A pointer for the output property package.
     * @return An HRESULT indicating if this function succeeded or not.
     */
    HRESULT getPropertyPackage(const std::string& packageName, LPDISPATCH* package) const;
};

/**
 * Wrapper for a property package's registry entries.
 */
class Package
{
public:
    std::wstring CLSID;
    std::wstring CATID;
    std::wstring name;
    std::wstring desc;
    std::wstring vendor;
};

#endif // CAPEOPEN == 1

#endif

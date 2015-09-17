/**
 * @file PropertyPackageManager.cpp
 * Source file for the implementation of the PropertyPackageManager class and
 * helper functions.
 */

#include "PropertyPackageManager.h"

#if (CAPEOPEN == 1)

#include "Variant.h"
#include "errorhandling.h"

#import "CAPE-OPENv1-0-0.tlb" raw_interfaces_only, raw_native_types, no_namespace, named_guids

using namespace ATL;

PropertyPackageManager::PropertyPackageManager()
{
    // Initialize COM.
    CoInitialize(NULL);

    this->initPackageList();
}

PropertyPackageManager::~PropertyPackageManager()
{
    CoUninitialize();
}

/**
 * Gets all CAPE-OPEN packages from the registry.
 */
static std::vector<Package> getRegisteredPackages()
{
    std::vector<Package> registered_packages;

    HKEY rootKey;
    HRESULT hr = RegOpenKeyEx(HKEY_CLASSES_ROOT, L"CLSID", 0,
                              KEY_ENUMERATE_SUB_KEYS, &rootKey);
    if (hr != ERROR_SUCCESS)
    {
        RegCloseKey(rootKey);
        return registered_packages;
    }

    wchar_t name[500];
    DWORD name_sz = 500;
    DWORD name_ix = 0;
    // Loop over the root keys.
    while (RegEnumKey(rootKey, name_ix++, name, name_sz) == ERROR_SUCCESS)
    {
        // Open the sub key.
        HKEY keyCLSID = NULL;
        hr = RegOpenKeyEx(rootKey, name, 0, KEY_READ, &keyCLSID);
        if (hr != ERROR_SUCCESS)
        {
            RegCloseKey(keyCLSID);
            continue;
        }

        // Open the implemented categories key.
        HKEY keyCAT = NULL;
        hr = RegOpenKeyEx(keyCLSID, L"Implemented Categories", 0, KEY_READ,
                          &keyCAT);
        if (hr != ERROR_SUCCESS)
        {
            RegCloseKey(keyCAT);
            continue;
        }

        wchar_t catid[100];
        DWORD catid_sz = 100;
        DWORD catid_ix = 0;
        // Loop over the CAT keys.
        while (RegEnumKey(keyCAT, catid_ix++, catid, catid_sz) == ERROR_SUCCESS)
        {
            if (lstrcmpi(catid, CATID_THERMOSYSTEM) != 0 &&
                lstrcmpi(catid, CATID_PROPERTYPACKAGE) != 0 &&
                lstrcmpi(catid, CATID_THERMOPROPERTYPACKAGE) != 0)
            {
                // Not a property package, so try next key.
                continue;
            }

            Package p;
            p.CLSID = name;
            p.CATID = catid;
            p.name = name;

            HKEY keyInfo = NULL;
            hr = RegOpenKeyEx(keyCLSID, L"CapeDescription", 0, KEY_READ,
                              &keyInfo);
            if (hr != ERROR_SUCCESS)
            {
                RegCloseKey(keyInfo);
                continue;
            }

            // Set the name, if available.
            wchar_t value[500];
            DWORD value_sz = sizeof(value); // in bytes, not chars.
            hr = RegQueryValueEx(keyInfo, L"Name", NULL, NULL, (LPBYTE) value,
                                 &value_sz);
            if (hr == ERROR_SUCCESS) p.name = value;

            // Get the properties.
            value_sz = sizeof(value);
            hr = RegQueryValueEx(keyInfo, L"Description", NULL, NULL,
                                 (LPBYTE) value, &value_sz);
            if (hr == ERROR_SUCCESS) p.desc = value;

            value_sz = sizeof(value);
            hr = RegQueryValueEx(keyInfo, L"VendorURL", NULL, NULL,
                                 (LPBYTE) value, &value_sz);
            if (hr == ERROR_SUCCESS) p.vendor = value;

            RegCloseKey(keyInfo);
            registered_packages.push_back(p);
        }

        RegCloseKey(keyCAT);
        RegCloseKey(keyCLSID);
    }

    RegCloseKey(rootKey);

    return registered_packages;
}

void PropertyPackageManager::initPackageList()
{
    std::vector<Package> registered_packages = getRegisteredPackages();

    std::vector<std::wstring> packages;
    // Loop through the found CAPE-OPEN objects.
    for (size_t ip = 0; ip < registered_packages.size(); ip++)
    {
        Package p = registered_packages[ip];

        GUID IID_ICapeThermo;
        if (lstrcmpi(p.CATID.c_str(), CATID_THERMOSYSTEM) == 0)
        {
            // We have found a thermo system.
            IID_ICapeThermo = IID_ICapeThermoSystem;
        }
        if (lstrcmpi(p.CATID.c_str(), CATID_PROPERTYPACKAGE) == 0 ||
            lstrcmpi(p.CATID.c_str(), CATID_THERMOPROPERTYPACKAGE) == 0)
        {
           // We have found a stand alone property package.
            IID_ICapeThermo = IID_ICapeThermoPropertyPackage;
        }

        CLSID clsID;
        HRESULT hr = CLSIDFromString(W2OLE((wchar_t*) p.CLSID.c_str()), &clsID);
        if (FAILED(hr))
        {
            ATLASSERT(FALSE);
            continue;
        }

        CComPtr<IUnknown> COobject;
        hr = CoCreateInstance(clsID, NULL, CLSCTX_ALL, IID_ICapeThermo,
                              (LPVOID*) &COobject.p);
        if (FAILED(hr))
        {
            _com_error err(hr);
            char name[255], message[255];
            const wchar_t* wname = p.name.c_str();
            const wchar_t* wmessage = err.ErrorMessage();
            wcstombs_s(NULL, name, wname, sizeof(name)-1);
            wcstombs_s(NULL, message, wmessage, sizeof(message)-1);
            warningMessage("CAPE-OPEN", "Creating [%s] failed: %s", name, message);
            continue;
        }

        CComPtr<IPersistStreamInit> init;
        if (init = COobject)
        {
            hr = init->InitNew();
            if (FAILED(hr) && hr != E_NOTIMPL && hr != ECapeNoImplHR) continue;
        }

        CComPtr<ICapeUtilities> utils;
        if (utils = COobject)
        {
            hr = utils->Initialize();
            if (FAILED(hr) && hr != E_NOTIMPL && hr != ECapeNoImplHR) continue;
        }

        // Handle property packages of thermo system.
        CComPtr<ICapeThermoSystem> system;
        if (system = COobject)
        {
            CVariant list;
            hr = system->GetPropertyPackages(list.OutputArgument());
            if (SUCCEEDED(hr))
            {
                std::wstring error;
                if (list.CheckArray(VT_BSTR, error))
                {
                    if (list.GetCount())
                    {
                        // Add the system to the map.
                        this->clsidMap[p.name] = clsID;
                        std::wstring prefix = p.name + L"//";
                        // Add the packages to the list.
                        for (int iPack = 0; iPack < list.GetCount(); iPack++)
                        {
                            CComBSTR name = list.GetStringAt(iPack);
                            packages.push_back(prefix + (BSTR) name);
                        }
                    }
                }
            }
        }

        // Handle stand-alone property package.
        CComPtr<ICapeThermoPropertyPackage> package;
        if (package = COobject)
        {
            // Add the package to the map and the list.
            this->clsidMap[p.name] = clsID;
            packages.push_back(p.name);
        }

        if (utils) utils->Terminate();
    }
}

bool PropertyPackageManager::clsidMapLookup(const std::wstring& key, CLSID &value) const
{
    stdext::hash_map<std::wstring,CLSID>::const_iterator it;
    it = clsidMap.find(key);
    if (it == clsidMap.end()) return false;
    value = it->second;
    return true;
}

HRESULT PropertyPackageManager::getPropertyPackage(const std::string& packageName, LPDISPATCH* package) const
{
    if (!package) return E_POINTER;

    // Check the name.
    std::wstring tsName = _bstr_t(packageName.c_str());
    std::wstring ppName;
    int i = tsName.find(L"//");
    if (i == std::wstring::npos) // Look for a Stand Alone Property Package.
    {
        ppName = tsName;
        CLSID clsid;
        if (!this->clsidMapLookup(ppName, clsid))
        {
            // We do not know how to create this.
            return ECapeUnknownHR;
        }

        // Create package.
        IClassFactory* ClassFactory;
        HRESULT hr = CoGetClassObject(clsid, CLSCTX_ALL, NULL,
                                      IID_IClassFactory,
                                      (void**) &ClassFactory);
        if (FAILED(hr)) return hr;

        hr = ClassFactory->CreateInstance(0, IID_IDispatch, (void**) package);
        if (FAILED(hr)) return hr;
        ClassFactory->Release();
    }
    else // Look for a Thermo System.
    {
        ppName = tsName.substr(i + 2);
        tsName = tsName.substr(0, i);
        // Look up the Thermo System.
        CLSID clsid;
        if (!this->clsidMapLookup(tsName, clsid))
        {
            // We do not know how to create this.
            return ECapeUnknownHR;
        }

        // Create the system.
        CComPtr<ICapeThermoSystem> system;
        HRESULT hr = system.CoCreateInstance(clsid, NULL, CLSCTX_ALL);
        if (FAILED(hr)) return ECapeUnknownHR;

        // Init
        CComPtr<IPersistStreamInit> init;
        if (init = system)
        {
            hr = init->InitNew();
            if (FAILED(hr) && hr != ECapeNoImplHR && hr != E_NOTIMPL)
            {
                return ECapeUnknownHR;
            }
        }

        CComPtr<ICapeUtilities> utils;
        if (utils = system)
        {
            hr = utils->Initialize();
            if (FAILED(hr) && hr != ECapeNoImplHR && hr != E_NOTIMPL)
            {
                return ECapeUnknownHR;
            }
        }

        // Create package.
        IDispatch *pack;
        hr = system->ResolvePropertyPackage(CComBSTR(ppName.c_str()),
                                            (IDispatch**) &pack);
        if (FAILED(hr)) return hr;

        *package = (ICapeIdentification*) pack;

        if (utils) hr = utils->Terminate();
    }

    return NO_ERROR;
}

#endif // CAPEOPEN == 1

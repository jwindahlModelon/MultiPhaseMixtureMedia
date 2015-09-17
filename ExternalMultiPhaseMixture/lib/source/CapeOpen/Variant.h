#ifndef VARIANT_H_
#define VARIANT_H_

//BSTR vs wide string comparison helper

__inline BOOL SameString(const wchar_t *str1, const wchar_t *str2)
{
    BOOL res = FALSE;
    if (str1) {
        if (str2) res = (lstrcmpiW(str1, str2) == 0);
        else if (*str1 == 0) res = TRUE;
    }
    else
        if (!str2) res = TRUE;
        else if (*str2 == 0) res = TRUE;
        return res;
}

__inline int StringLen(const wchar_t *str) {return (str)?lstrlenW(str):0;}


//CVariant class: wrapper class for VARIANT values

class CVariant
{
private:
    VARIANT value;
    BOOL mustDelete;
    //for array variables:
    LONG lBound, count;
    //keep track of element type during debugging
#ifdef _DEBUG
    VARTYPE elementType;
#endif

public:
    //default constructor (result will be destroyed)
    CVariant()
    {
        VariantInit(&value);
        mustDelete = TRUE;
        count = 0;
#ifdef _DEBUG
        elementType = VT_EMPTY;
#endif
    }

    //when an existing VARIANT needs to be analysed, use this constructor
    // you must indicate whether or not the result must be destroyed
    CVariant(VARIANT value, BOOL DestroyWhenDone)
    {
        mustDelete = DestroyWhenDone;
        this->value = value;
        count = 0;
#ifdef _DEBUG
        elementType = VT_EMPTY; //not checked
#endif
    }

    ~CVariant()
    {
        //destructor
        if (mustDelete) VariantClear(&value);
    }

    VARIANT *OutputArgument()
    {
        //used to pass variant to other routine as output argument
        if (mustDelete) VariantClear(&value); else value.vt = VT_EMPTY;
        mustDelete = true;
        return &value;
    }

    BOOL IsEmpty()
    {
        return (value.vt == VT_EMPTY);
    }

    //create a variant array; arrays that are created always index from 0
    void MakeArray(int count, VARTYPE vt)
    {
        SAFEARRAYBOUND ba;
        //clean up old content
        if (mustDelete)
            if (value.vt != VT_EMPTY)
                VariantClear(&value);
        //set new content
        mustDelete = TRUE;
        ba.cElements = count;
        ba.lLbound = 0;
        value.parray = SafeArrayCreate(vt, 1, &ba);
        value.vt = VT_ARRAY|vt;
        //keep track of content
        lBound = 0;
        this->count = count;
#ifdef _DEBUG
        elementType = vt;
#endif
    }

    //when a VARIANT return value is requested, use this function.
    // the result will then not be destroyed
    __inline VARIANT ReturnValue()
    {
        mustDelete = FALSE;
        return value;
    }

    //number of elements in an array:
    __inline int GetCount()
    {
        ATLASSERT(count >= 0);
        return count;
    }

    //functions to reset the content to something else (re-use a CVariant)

    void Set(VARIANT value, BOOL DestroyWhenDone)
    {
        //clean up old content
        if (mustDelete)
            if (this->value.vt != VT_EMPTY)
                VariantClear(&this->value);
        //set to existing VARIANT
        mustDelete = DestroyWhenDone;
        this->value = value;
        count = 0;
#ifdef _DEBUG
        elementType = VT_EMPTY; //not checked
#endif
    }

    void Clear(BOOL DestroyWhenDone=TRUE)
    {
        //clean up old content
        if (mustDelete)
            if (value.vt != VT_EMPTY)
                VariantClear(&value);
        value.vt = VT_EMPTY;
        count = 0;
        mustDelete = DestroyWhenDone;
    }

    //accessing and setting array elements

    __inline void SetDoubleAt(LONG index, double d)
    {
        //make sure to have called MakeArray before this
        ATLASSERT((count>0)&&(index<count));
        ATLASSERT(lBound == 0); //saves an operation; all MakeArray values have lBound=0
        ATLASSERT(elementType == VT_R8);
        SafeArrayPutElement(value.parray, &index, &d);
    }

    __inline double GetDoubleAt(LONG index)
    {
        //make sure CheckArray was called before this
        double d;
        ATLASSERT((count>0)&&(index<count));
        ATLASSERT(elementType == VT_R8);
        index += lBound;
        SafeArrayGetElement(value.parray, &index, &d);
        return d;
    }

    __inline void SetStringAt(LONG index, BSTR b)
    {
        //make sure to have called MakeArray before this
        ATLASSERT((count>0)&&(index<count));
        ATLASSERT(lBound == 0); //saves an operation; all MakeArray values have lBound=0
        ATLASSERT(elementType == VT_BSTR);
        SafeArrayPutElement(value.parray, &index, b);
    }

    __inline BSTR GetStringAt(LONG index)
    {
        //make sure CheckArray was called before this
        // MAKE SURE TO SysFreeString THE RESULTING STRING
        BSTR b;
        ATLASSERT((count>0)&&(index<count));
        ATLASSERT(elementType == VT_BSTR);
        index += lBound;
        SafeArrayGetElement(value.parray, &index, &b);
        return b;
    }

    __inline void SetVariantAt(LONG index, VARIANT v)
    {
        //make sure to have called MakeArray before this
        ATLASSERT((count>0)&&(index<count));
        ATLASSERT(lBound == 0); //saves an operation; all MakeArray values have lBound=0
        ATLASSERT(elementType == VT_VARIANT);
        SafeArrayPutElement(value.parray, &index, &v);
    }

    __inline VARIANT GetVariantAt(LONG index)
    {
        //make sure CheckArray was called before this
        // MAKE SURE TO VariantClear THE RESULTING VARIANT
        // (the call to VariantInit causes some overhead over directly
        //  re-using a VARIANT in order to keep the application
        //  clear and maintainable. VARIANT arrays are assumed not the
        //  most time consuming part of the application; most VARIANT
        //  arrays are outgoing; the incoming ones are only for logging)
        VARIANT v;
        VariantInit(&v);
        ATLASSERT((count>0)&&(index<count));
        ATLASSERT(elementType == VT_VARIANT);
        index += lBound;
        SafeArrayGetElement(value.parray, &index, &v);
        return v;
    }

    __inline void SetLongAt(LONG index, LONG i)
    {
        //make sure to have called MakeArray before this
        ATLASSERT((count>0)&&(index<count));
        ATLASSERT(lBound == 0); //saves an operation; all MakeArray values have lBound=0
        ATLASSERT(elementType == VT_I4);
        SafeArrayPutElement(value.parray, &index, &i);
    }

    __inline LONG GetLongAt(LONG index)
    {
        //make sure CheckArray was called before this
        LONG i;
        ATLASSERT((count>0)&&(index<count));
        index += lBound;
        ATLASSERT(elementType == VT_I4);
        SafeArrayGetElement(value.parray, &index, &i);
        return i;
    }

    __inline VARIANT Copy()
    {
        //return a copy of the current value
        // (destorying is responsibility of caller)
        VARIANT v;
        v.vt = VT_EMPTY;
        VariantCopy(&v, &value);
        return v;
    }

    __inline VARIANT Value()
    {
        //this will not destroy the value, use only for values we
        // own, such as setting values with SetSinglePhaseProp
        return value;
    }

    //utility functions

    BOOL CheckArray(VARTYPE vt, std::wstring &error)
    {
        //sets the low bound and count if check is
#ifdef _DEBUG
        elementType = vt;
#endif
        // performed ok
        BOOL res = FALSE;
        //check type
        if (value.vt == VT_EMPTY) {
            //this is ok for an empty array
            res = TRUE;
            lBound = count = 0;
        } else if (value.vt != (vt|VT_ARRAY)) {
            //not the type we expected
            error = L"Expected an array of type ";
            switch (vt) {
            case VT_EMPTY: error += L"EMPTY"; ATLASSERT(0); break;
            case VT_R8: error += L"double precision";break;
            case VT_VARIANT: error += L"VARIANT";break;
            case VT_BSTR: error += L"string";break;
            case VT_I4: error += L"long";break;
            case VT_I2: error += L"short";break;
            default: error += L"<unknown>";ATLASSERT(0);break;
            }
        }
        else {
            // type is ok, check dimension
            if (SafeArrayGetDim(value.parray) != 1) error = L"unexpected dimension; 1-dimensional array expected";
            else {
                // get lower and upper bound:
                if (FAILED(SafeArrayGetLBound(value.parray, 1, &lBound))) error = L"failed to get lower bound";
                else if (FAILED(SafeArrayGetUBound(value.parray, 1, &count))) error = L"failed to get upper bound";
                else {
                    //all ok
                    count -= lBound-1;
                    res = TRUE;
                }
            }
        }
        return res;
    }

};

#endif

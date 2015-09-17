
#ifndef COSTDAFX_H_
#define COSTDAFX_H_

#ifndef STRICT
#define STRICT
#endif

#define _ATL_APARTMENT_THREADED
#define _ATL_NO_AUTOMATIC_NAMESPACE
#define _ATL_CSTRING_EXPLICIT_CONSTRUCTORS
#define ATL_NO_ASSERT_ON_DESTROY_NONEXISTENT_WINDOW

#include <atlbase.h>
#include <atlcom.h>
#include <atlctl.h>
#include <atlsafe.h>

#undef GetProp
#undef SetProp

#endif

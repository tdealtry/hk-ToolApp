#include "Factory.h"

Tool* Factory(std::string tool) {
Tool* ret=0;

// if (tool=="Type") tool=new Type;
if (tool=="WCSim_exe") ret=new HK::GHOST::WCSim_exe;
return ret;
}

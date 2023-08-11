#include "Factory.h"

Tool* Factory(std::string tool) {
Tool* ret=0;

// if (tool=="Type") tool=new Type;
 if (tool=="HKG4TrackingAction") ret=new HK::GHOST::G4::HKG4TrackingAction;
 if (tool=="WCSim_exe") ret=new HK::GHOST::G4::WCSim_exe;
 if (tool=="HKG4DetectorConstruction") ret=new HK::GHOST::G4::HKG4DetectorConstruction;
return ret;
}

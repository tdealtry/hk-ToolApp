#include "Factory.h"

Tool* Factory(std::string tool) {
Tool* ret=0;

// if (tool=="Type") tool=new Type;
if (tool=="HKG4DetectorConstruction") ret=new HK::GHOST::G4::HKG4DetectorConstruction;
if (tool=="HKG4TrackingAction") ret=new HK::GHOST::G4::HKG4TrackingAction;
if (tool=="WCSim_exe") ret=new HK::GHOST::G4::WCSim_exe;
if (tool=="HKG4DetectorConstruction") ret=new HK::GHOST::G4::HKG4DetectorConstruction;
if (tool=="HKG4EventAction") ret=new HK::GHOST::G4::HKG4EventAction;
if (tool=="HKG4PhysicsListFactory") ret=new HK::GHOST::G4::HKG4PhysicsListFactory;
if (tool=="HKG4PrimaryGeneratorAction") ret=new HK::GHOST::G4::HKG4PrimaryGeneratorAction;
if (tool=="HKG4RunAction") ret=new HK::GHOST::G4::HKG4RunAction;
if (tool=="HKG4StackingAction") ret=new HK::GHOST::G4::HKG4StackingAction;
if (tool=="HKG4SteppingAction") ret=new HK::GHOST::G4::HKG4SteppingAction;
if (tool=="HKG4TrackingAction") ret=new HK::GHOST::G4::HKG4TrackingAction;
if (tool=="WCSim_exe") ret=new HK::GHOST::G4::WCSim_exe;
return ret;
}

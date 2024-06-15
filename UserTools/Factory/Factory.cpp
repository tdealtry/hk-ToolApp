// Factory.cpp file created via hk-pilot
#include "Factory.h"
#include "Unity.h"

Tool* Factory(std::string tool) {
	Tool* ret = 0;

	if (tool=="DummyTool") ret=new DummyTool;
	if (tool=="TestTool") ret=new TestTool;
	if (tool=="WCSim_exe") ret=new Ghost::G4::WCSim_exe;
	if (tool=="HKG4TrackingAction") ret=new HK::Ghost::G4::HKG4TrackingAction;
	if (tool=="HKG4StackingAction") ret=new HK::Ghost::G4::HKG4StackingAction;
	if (tool=="HKG4PhysicsList") ret=new Ghost::G4::HKG4PhysicsList;
	if (tool=="HKG4SteppingAction") ret = new HK::Ghost::G4::HKG4SteppingAction;
	if (tool=="GhostG4PrimaryGeneratorAction") ret = new Ghost::G4::GhostG4PrimaryGeneratorAction;
	if (tool=="GhostG4EventAction") ret = new Ghost::G4::GhostG4EventAction;
	if (tool=="HKG4RunAction") ret = new HK::Ghost::G4::HKG4RunAction;
	if (tool=="HKGFileWriterRootWCSim") ret = new HK::Ghost::IO::HKGFileWriterRootWCSim;
	return ret;
}

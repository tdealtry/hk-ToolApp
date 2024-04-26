// Factory.cpp file created via hk-pilot
#include "Factory.h"
#include "Unity.h"

Tool* Factory(std::string tool) {
	Tool* ret = 0;

	if (tool=="DummyTool") ret=new DummyTool;
	if (tool=="TestTool") ret=new TestTool;
	if (tool=="WCSim_exe") ret=new HK::Ghost::G4::WCSim_exe;
	if (tool=="HKG4TrackingAction") ret=new HK::Ghost::G4::HKG4TrackingAction;
	if (tool=="HKG4StackingAction") ret=new HK::Ghost::G4::HKG4StackingAction;
	if (tool=="HKG4PhysicsList") ret=new HK::Ghost::G4::HKG4PhysicsList;
	if (tool=="HKG4SteppingAction") ret = new HK::Ghost::G4::HKG4SteppingAction;
	if (tool=="HKG4PrimaryGeneratorAction") ret = new HK::Ghost::G4::HKG4PrimaryGeneratorAction;
	if (tool=="HKG4EventAction") ret = new HK::Ghost::G4::HKG4EventAction;
	//if (tool=="X") ret = new HK::Ghost::G4::X;
	return ret;
}

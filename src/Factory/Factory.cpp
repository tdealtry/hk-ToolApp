#include "Factory.h"

Tool* Factory(std::string tool) {
	Tool* ret = 0;

	if(tool == "DummyTool")
		ret = new DummyTool;

	// if(tool == "WCSimTool")
	//     ret = new WCSimTool;

	return ret;
}

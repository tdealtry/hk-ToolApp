ToolFrameworkPath=/usr/local/hk/ToolFrameworkCore/src

Geant4Path = /usr/local/hk/Geant4/install-Linux_x86_64-gcc_8-python_3.8.13/
WCSimPath = /usr/local/hk/hk-ToolApp/UserTools/ImportedTools/GHOST-WCSim/OriginalWCSim_build/

ROOT_INCLUDES  = -I$(shell root-config --incdir)
ROOT_LIBS  = $(shell root-config --libs)
GEANT4_INCLUDES = -I$(Geant4Path)/include/Geant4/
GEANT4_LIBS = $(shell geant4-config --libs)
WCSIM_INCLUDES = -I$(WCSimPath)/include/WCSim/ -DWCSIM_CHECK_GEOMETRY_OVERLAPS=0
WCSIM_LIBS = -L$(WCSimPath)/lib/ -lWCSimCore -lWCSimRoot
EXTERNALS := $(ROOT_INCLUDES) \
	$(ROOT_LIBS) \
	$(GEANT4_INCLUDES) \
	$(GEANT4_LIBS) \
	$(WCSIM_LIBS) \
	$(WCSIM_INCLUDES)

CXXFLAGS=  -fPIC -O3 -Wpedantic -Wall

ifeq ($(MAKECMDGOALS),debug)
CXXFLAGS+= -O0 -g -lSegFault -rdynamic -DDEBUG
endif

ToolLibs = $(patsubst %.so, %, $(patsubst lib%, -l%,$(filter lib%, $(subst /, , $(wildcard UserTools/*/*.so)))))
ToolPaths =  $(filter-out %.md ,$(filter-out %.sh , $(filter-out %.h , $(wildcard UserTools/*/))))
ToolObjects = $(patsubst %.cpp, %.o, $(filter-out $(patsubst %.so, %.cpp, $(ToolLibs)), $(wildcard UserTools/*/*.cpp)))
ToolIncludes =  $(patsubst %, -I %, $(ToolPaths))
ToolLibPaths = $(patsubst %, -L %, $(ToolPaths))


debug: all

all: lib/libMyTools.so main

main: src/main.cpp lib/libMyTools.so  
	@echo -e "\e[38;5;214m\n*************** Making " $@ "****************\e[0m"
	g++ $(CXXFLAGS) src/main.cpp -o main -I include -L lib -lMyTools -lToolChain -lpthread -I hk-DataModel/ -L hk-DataModel/ -lDataModel $(ToolIncludes) $(ToolLibPaths) $(ToolLibs) -L $(ToolFrameworkPath)/lib -lStore -lLogging -I $(ToolFrameworkPath)/include


#lib/libToolChain.so: lib/libMyTools.so 
#	@echo -e "\e[38;5;226m\n*************** Making " $@ "****************\e[0m"
#	g++ $(CXXFLAGS) -shared $(ToolFrameworkPath)/src/ToolChain/ToolChain.cpp -o lib/libToolChain.so -I include -L lib -lMyTools -lpthread $(ToolIncludes) $(ToolLibPaths) $(ToolLibs) -I hk-DataModel/ -L hk-DataModel/ -lDataModel -L $(ToolFrameworkPath)/lib -lStore -lLogging -I $(ToolFrameworkPath)/include


clean: 

	@echo -e "\e[38;5;201m\n*************** Cleaning up ****************\e[0m"
	rm -f $(ToolObjects)
	rm -f lib/*.so
	rm -f main

lib/libMyTools.so: $(ToolObjects) 

	@echo -e "\e[38;5;214m\n*************** Making " $@ "****************\e[0m"
	g++ $(CXXFLAGS) -shared -o lib/libMyTools.so $^  $(ToolIncludes) $(ToolLibPaths) $(ToolLibs)  -I hk-DataModel/ -L hk-DataModel/ -lDataModel -L $(ToolFrameworkPath)/lib -lStore -lLogging -I $(ToolFrameworkPath)/include -lpthread

#UserTools/Factory/Factory.o: UserTools/Factory/Factory.cpp | $(ToolObjects)
#	@echo -e "\e[38;5;214m\n*************** Making " $@ "****************\e[0m"
#	-g++ $(CXXFLAGS) -c -o $@ $< -I UserTools $(ToolIncludes) $(ToolLibPaths) $(ToolLibs) -I hk-DataModel/ -L hk-DataModel/ -lDataModel -L $(ToolFrameworkPath)/lib -lStore -lLogging -I $(ToolFrameworkPath)/include -pthread

UserTools/%.o: UserTools/%.cpp 
	@echo -e "\e[38;5;214m\n*************** Making " $@ "****************\e[0m"
	-g++ $(CXXFLAGS) -c -o $@ $< -I UserTools $(ToolIncludes) $(ToolLibPaths) $(ToolLibs) -I hk-DataModel/ -L hk-DataModel/ -lDataModel -L $(ToolFrameworkPath)/lib -lStore -lLogging -I $(ToolFrameworkPath)/include -pthread $(EXTERNALS)


target: remove $(patsubst %.cpp, %.o, $(wildcard UserTools/$(TOOL)/*.cpp))

remove:
	echo "removing"
	-rm UserTools/$(TOOL)/*.o


ToolFrameworkPath=/usr/local/hk/ToolFrameworkCore/src

CXXFLAGS=  -fPIC -O3 -Wpedantic -Wall

ifeq ($(MAKECMDGOALS),debug)
CXXFLAGS+= -O0 -g -lSegFault -rdynamic -DDEBUG
endif

ToolLibs = $(patsubst lib%, -l%, $(wildcard UserTools/*/*.so))
ToolPaths =  $(filter-out %.md ,$(filter-out %.sh , $(filter-out %.h , $(wildcard UserTools/*/))))
ToolObjects = $(patsubst %.cpp, %.o, $(filter-out $(patsubst %.so, %.cpp, $(ToolLibs)), $(wildcard UserTools/*/*.cpp)))
ToolInlcudes =  $(patsubst %, -I %, $(ToolPaths))
ToolLibPaths = $(patsubst %, -L %, $(ToolPaths))

#test:
#	echo $(ToolInlcudes)


debug: all

all: lib/libMyTools.so main

main: src/main.cpp lib/libMyTools.so  
	@echo -e "\e[38;5;214m\n*************** Making " $@ "****************\e[0m"
	g++ $(CXXFLAGS) src/main.cpp -o main -I include -L lib -lMyTools -lpthread  $(ToolIncludes) -L $(ToolFrameworkPath)/lib -lStore -lLogging -lToolChain -I hk-DataModel/ -L hk-DataModel/ -lDataModel -I $(ToolFrameworkPath)/include


#lib/libToolChain.so: $(Dependencies)/ToolFrameworkCore/src/ToolChain/*  lib/libLogging.so lib/libStore.so | lib/libMyTools.so lib/libDataModel.so
#	@echo -e "\e[38;5;226m\n*************** Making " $@ "****************\e[0m"
#	cp $(Dependencies)/ToolFrameworkCore/src/ToolChain/*.h include/
#	g++ $(CXXFLAGS) -shared $(Dependencies)/ToolFrameworkCore/src/ToolChain/ToolChain.cpp -I include -lpthread -L lib -lStore -lDataModel -lLogging -lMyTools -o lib/libToolChain.so $(DataModelInclude) $(DataModelib) $(MyToolsInclude) $(MyToolsLib)


clean: 

	@echo -e "\e[38;5;201m\n*************** Cleaning up ****************\e[0m"
	rm -f $(ToolObjects)
	rm -f lib/*.so
	rm -f main

lib/libMyTools.so: $(ToolObjects) 

	@echo -e "\e[38;5;214m\n*************** Making " $@ "****************\e[0m"
	g++ $(CXXFLAGS) -shared -o lib/libMyTools.so $^  $(ToolIncludes) $(ToolLibPaths) $(ToolLibs) -L $(ToolFrameworkPath)/lib -lStore -lLogging -I hk-DataModel/ -L hk-DataModel/ -lDataModel  -I $(ToolFrameworkPath)/include -lpthread

UserTools/%.o: UserTools/%.cpp
	@echo -e "\e[38;5;214m\n*************** Making " $@ "****************\e[0m"
	-g++ $(CXXFLAGS) -c -o $@ $< $(ToolIncludes) -L $(ToolFrameworkPath)/lib -lStore -lLogging -I hk-DataModel/ -L hk-DataModel/ -lDataModel -I $(ToolFrameworkPath)/include -pthread


target: remove $(patsubst %.cpp, %.o, $(wildcard UserTools/$(TOOL)/*.cpp))

remove:
	echo "removing"
	-rm UserTools/$(TOOL)/*.o


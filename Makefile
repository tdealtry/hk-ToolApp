ToolFrameworkPath=

CXXFLAGS=  -fPIC -O3 -Wpedantic -Wall

ifeq ($(MAKECMDGOALS),debug)
CXXFLAGS+= -O0 -g -lSegFault -rdynamic -DDEBUG
endif

ToolLibs = $(wildcard UserTools/*/*.so)
Toolsinlude =  $(filter-out %.md ,$(filter-out %.sh , $(filter-out %.h , $(wildcard UserTools/*/))))
ToolObjects = $(patsubst %.o, %.cpp, $(filter-out $(patsubst %.cpp, %.so, $(ToolLibs)), $(wildcard UserTools/*/*.cpp)))

test:
	echo $(ToolLibs)
	echo $(Toolsinlude)
	echo $(ToolObjects)

debug: all

all: lib/libMyTools.so main

main: src/main.cpp lib/libStore.so lib/libLogging.so lib/libToolChain.so | lib/libMyTools.so  lib/libDataModel.so 
	@echo -e "\e[38;5;214m\n*************** Making " $@ "****************\e[0m"
	g++ $(CXXFLAGS) src/main.cpp -o main -I include -L lib -lStore -lMyTools -lToolChain -lDataModel -lLogging  -lpthread $(DataModelInclude) $(MyToolsInclude) $(MyToolsLib) $(DataModelLib) 


lib/libStore.so: $(Dependencies)/ToolFrameworkCore/src/Store/*
	cd $(Dependencies)/ToolFrameworkCore && $(MAKE) lib/libStore.so
	@echo -e "\e[38;5;118m\n*************** Copying " $@ "****************\e[0m"
	cp $(Dependencies)/ToolFrameworkCore/src/Store/*.h include/
	cp $(Dependencies)/ToolFrameworkCore/lib/libStore.so lib/



#lib/libToolChain.so: $(Dependencies)/ToolFrameworkCore/src/ToolChain/*  lib/libLogging.so lib/libStore.so | lib/libMyTools.so lib/libDataModel.so
#	@echo -e "\e[38;5;226m\n*************** Making " $@ "****************\e[0m"
#	cp $(Dependencies)/ToolFrameworkCore/src/ToolChain/*.h include/
#	g++ $(CXXFLAGS) -shared $(Dependencies)/ToolFrameworkCore/src/ToolChain/ToolChain.cpp -I include -lpthread -L lib -lStore -lDataModel -lLogging -lMyTools -o lib/libToolChain.so $(DataModelInclude) $(DataModelib) $(MyToolsInclude) $(MyToolsLib)


clean: 

	@echo -e "\e[38;5;201m\n*************** Cleaning up ****************\e[0m"
	rm -f include/*.h
	rm -f lib/*.so
	rm -f main
	rm -f UserTools/*/*.o
	rm -f DataModel/*.o


lib/libMyTools.so: $(ToolObjects) 

	@echo -e "\e[38;5;214m\n*************** Making " $@ "****************\e[0m"
	g++ $(CXXFLAGS) -shared -o lib/libMyTools.so $^ -I  $(Toolinclude) -L $(ToolFrameworkPath)/lib -lStore -lLogging -I hk-DataModel/ -L hk-DataModel/ -lDataModel

UserTools/%.o: UserTools/%.cpp
	@echo -e "\e[38;5;214m\n*************** Making " $@ "****************\e[0m"
	-g++ $(CXXFLAGS) -c -o $@ $< -I  $(Toolinclude) -L $(ToolFrameworkPath)/lib -lStore -lLogging -I hk-DataModel/ -L hk-DataModel/ -lDataModel


target: remove $(patsubst %.cpp, %.o, $(wildcard UserTools/$(TOOL)/*.cpp))

remove:
	echo "removing"
	-rm UserTools/$(TOOL)/*.o


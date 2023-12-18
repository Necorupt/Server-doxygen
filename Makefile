.PHONY: all
.PHONY: build
.PHONY: debug
.PHONY: run
.PHONY: run-dbg
.PHONY: clean

override CPPFILES := $(shell find -L * -type f -name '*.cpp')
override OBJ := $(addprefix obj/,$(CPPFILES:.cpp=.cpp.o))

TARGET =  server
CC = g++
LIBS = -lcrypto++ 
CXXINCLUDE = include/
CXXFLAGS = 

all:build

run: build
	./$(TARGET)

run-dbg: debug
	./$(TARGET)_dbg

build: CXXFLAGS+=-O3
build: $(OBJ) 
	$(CC) -I $(CXXINCLUDE) $(OBJ) $(LDFLAGS) -o $(TARGET) $(LIBS)

debug: CXXFLAGS+=-g -O0
debug: $(OBJ) 
	$(CC) -I $(CXXINCLUDE)  $(OBJ) -g  -o $(TARGET)_dbg $(LIBS)

obj/%.cpp.o: %.cpp
	mkdir -p "$$(dirname $@)"
	$(CC) $(CXXFLAGS) -I  $(CXXINCLUDE) $(CPPFLAGS) -c $< -o $@

clean:
	rm -rf obj
	rm -f $(TARGET)
	rm -f $(TARGET)_dbg
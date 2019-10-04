#
# Compiler Flags
#
CC 		 := gcc
CC_FLAGS := -std=c99 -Wall -Werror -Wextra

#
# Project Folders
#
BIN 	:= bin
SRC 	:= src
INCLUDE := src
LIB 	:= lib

#
# Project Files
#
LIBRARIES :=
EXECUTABLE := c_template

#
# Debug build settings
#
DEBUG_DIR := $(BIN)\debug
DEBUG_EXE := $(DEBUG_DIR)\$(addsuffix _d,$(EXECUTABLE))
DEBUG_FLAGS := -g -O0 -DDEBUG

#
# Release build settings
#
RELEASE_DIR := $(BIN)\release
RELEASE_EXE := $(RELEASE_DIR)\$(EXECUTABLE)
RELEASE_FLAGS := -O3

.PHONY: all clean debug release prep

# Default rule
all: prep debug

#
# Debug rules
#
debug: prep $(DEBUG_EXE)
	$(DEBUG_EXE)

$(DEBUG_EXE): $(SRC)/*.c
	$(CC) $(CC_FLAGS) $(DEBUG_FLAGS) -I$(INCLUDE) -L$(LIB) $^ -o $@ $(LIBRARIES)

#
# Release rules
#
release: prep $(RELEASE_EXE)
	$(RELEASE_EXE)

$(RELEASE_EXE): $(SRC)/*.c
	$(CC) $(CC_FLAGS) $(RELEASE_FLAGS) -I$(INCLUDE) -L$(LIB) $^ -o $@ $(LIBRARIES)

#
# Misc rules
#
clean:
ifeq ($(OS),Windows_NT)
	if exist $(DEBUG_DIR) rmdir /S /Q $(DEBUG_DIR)
	if exist $(RELEASE_DIR) rmdir /S /Q $(RELEASE_DIR)
endif

# Create bin folders with configurations
prep:
ifeq ($(OS),Windows_NT)
	if not exist $(DEBUG_DIR) mkdir $(DEBUG_DIR)
	if not exist $(RELEASE_DIR) mkdir $(RELEASE_DIR)
endif

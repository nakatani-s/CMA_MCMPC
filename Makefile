###########################################################

## USER SPECIFIC DIRECTORIES ##

# CUDA directory:
CUDA_ROOT_DIR=/usr/local/cuda-10.2

##########################################################

## CC COMPILER OPTIONS ##

# CC compiler options:
CC=g++
CC_FLAGS=
CC_LIBS=

##########################################################

## NVCC COMPILER OPTIONS ##

# NVCC compiler options:
NVCC=nvcc
NVCC_FLAGS=
NVCC_LIBS=

# CUDA library directory:
CUDA_LIB_DIR= -L$(CUDA_ROOT_DIR)/lib64
# CUDA include directory:
CUDA_INC_DIR= -I$(CUDA_ROOT_DIR)/include
# CUDA linking libraries:
CUDA_LINK_LIBS= -lcudart -lcusolver

##########################################################

## Project file structure ##

# Source file directory:
SRC_DIR = src

# Object file directory:
OBJ_DIR = bin

# Include header file diretory:
INC_DIR = include

##########################################################

## Make variables ##

# Target executable name:
EXE = run_test

# Object files:
OBJS = \
$(OBJ_DIR)/main.o $(OBJ_DIR)/MCMPC.o \
$(OBJ_DIR)/cuSolverForMCMPC.o $(OBJ_DIR)/dynamics.o \
$(OBJ_DIR)/init.o $(OBJ_DIR)/CMAFunctionsForMCMPC.o
##########################################################

## Compile ##

# Link c++ and CUDA compiled object files to target executable:
#$(EXE) : $(OBJS)
#	$(CC) $(CC_FLAGS) $(OBJS) -o $@ $(CUDA_INC_DIR) $(CUDA_LIB_DIR) $(CUDA_LINK_LIBS)
$(EXE) : $(OBJS)
	$(NVCC) $(NVCC_FLAGS) $(OBJS) -o $@ $(CUDA_LIB_DIR) $(CUDA_LINK_LIBS)

# Compile main .cpp file to object files:
# $(OBJ_DIR)/%.o : %.cpp
	# $(CC) $(CC_FLAGS) -c $< -o $@
$(OBJ_DIR)/%.o : %.cu
	$(NVCC) $(NVCC_FLAGS) -c $< -o $@ $(CUDA_INC_DIR) $(NVCC_LIBS)

# Compile C++ source files to object files:
# $(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp include/%.h
	# $(CC) $(CC_FLAGS) -c $< -o $@

# Compile CUDA source files to object files:
$(OBJ_DIR)/%.o : $(SRC_DIR)/%.cu $(INC_DIR)/%.cuh
	# $(NVCC) $(NVCC_FLAGS) -dc $< -o $@ $(CUDA_INC_DIR)
	$(NVCC) $(NVCC_FLAGS) -dc $< -o $@ $(CUDA_INC_DIR) $(NVCC_LIBS)

# Clean objects in object directory.
clean:
	$(RM) bin/* *.o $(EXE)

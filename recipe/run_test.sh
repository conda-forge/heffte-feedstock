#!/usr/bin/env bash

set -eu -x -o pipefail

# OpenMP
export OMP_NUM_THREADS=2

# OpenMPI
export OMPI_MCA_plm=^rsh

# Configure
cmake    \
    -S ${PREFIX}/share/heffte/testing  \
    -B build_test                      \
    -DBUILD_SHARED_LIBS=ON             \
    -DCMAKE_VERBOSE_MAKEFILE=ON

# Build
cmake --build build_test

# Run tests
#   note: example_r2r uses 4 MPI ranks, CI has 2 cores
ctest --test-dir build_test --output-on-failure -E example_r2r

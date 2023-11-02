#!/bin/bash

# 'Autobrew' is being used by more and more packages these days
# to grab static libraries from Homebrew bottles. These bottles
# are fetched via Homebrew's --force-bottle option which grabs
# a bottle for the build machine which may not be macOS 10.9.
# Also, we want to use conda packages (and shared libraries) for
# these 'system' dependencies. See:
# https://github.com/jeroen/autobrew/issues/3
export DISABLE_AUTOBREW=1

# Following changes from conda-forge/r-openmx-feedstock
# BSD-3-Clause license
# Copyright (c) 2015-2022, conda-forge contributors
#
# The OpenMx uses this var to toggle debug behavior within
# its own build system. Conda sets this var also, causing
# the OpenMx build to crash. Better unset it here so
# OpenMx can use its own DEBUG_CXXFLAGS
unset DEBUG_CXXFLAGS
#
# OpenMx should not build fortran code with -fopenmp because
# of this issue: https://github.com/OpenMx/OpenMx/issues/284
# So take ALL_FFLAGS and ALL_CFFLAGS from Makeconf, remove
# -fopenmp and append them to the pkg Makevars as overrides
cat $PREFIX/lib/R/etc/Makeconf | awk '/^ALL_FFLAGS/ || /^ALL_FCFLAGS/ {m=$1;$1=$2=""; printf "override %s = $(filter-out -fopenmp, %s)\n",m,$0}' >> src/Makevars.in

# R refuses to build packages that mark themselves as Priority: Recommended
mv DESCRIPTION DESCRIPTION.old
grep -va '^Priority: ' DESCRIPTION.old > DESCRIPTION
# shellcheck disable=SC2086
${R} CMD INSTALL --build . ${R_ARGS}

# Add more build steps here, if they are necessary.

# See
# https://docs.conda.io/projects/conda-build
# for a list of environment variables that are set during the build process.

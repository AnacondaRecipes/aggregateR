# Building R

## Overview

This document should help the reader to build the R packages.


## Getting set up

### Where to Build

At the time this document was written, manual builds were
necessary. This means a local build on a developer machine or shelling
into a builder box. Since developer machines are not normally
certified for build, a builder box is required.


### A Note on Using tmux

Though we automate most of it, building the full set of R packages is
time consuming. In order to ensure processes aren't halted by
network/vpn disconnects a tool like `tmux` should be used.


### Environment

After logging into the build machine, create an appropriate
directory. For example, if the goal is to build R v4.2.0, create a
driectory entitled `r-4.2.0` or similar.


Inside the directory, you will want to install your own miniconda3
environment and create an environment for building with the various
tools needed.

  conda create r-4.2.0
  conda install conda-build


Once you have, you can modify the `conda_init.sh` file found in the
bin folder, specifically ensure the `__minconda_loc` variable points
to the miniconda location and update other instances of the
version. Then you can simply source the build environment:
`source conda_init.sh`


### aggregateR

#### Clone

You'll need to clone `aggregateR`:

```
git clone https://github.com/AnacondaRecipes/aggregateR.git
cd aggregateR
```

#### Branch

Branch the repository from the latest version, assuming R-4.1.3 was the latest...

```
git checkout R-4.1.3
git pull
git branch R-4.2.0
git checkout R-4.2.0
git submodule update --init
```

### Apply patches

Make sure the patch (`patch/mcg1969-fetch-all.patch`) is applied in
`lib/python3.*/site-packages/conda_build` of your miniconda
environment.


### Skeleton

Check `aggregateR/bin/prepare_skeleton*` and
`aggregateR/bin/conda_skeleton*` to see how the skeleton script is
created and run.  Log files are dumped to `aggreagate/logs`.



NOTE: "archived" packages aren't going to be automatically built.


### Update some metapackage versions

```
CONDA_R=4.2.0
sed -i.bak "s|version = \".*\"|version = \"${CONDA_R}\"|" r-recommended-feedstock/recipe/meta.yaml
rm r-recommended-feedstock/recipe/meta.yaml.bak
sed -i.bak "s|version = \".*\"|version = \"${CONDA_R}\"|" r-feedstock/recipe/meta.yaml
rm r-recommended-feedstock/recipe/meta.yaml.bak
# This sed of `r-essentials` may not work but you need to examine it carefully by hand anyway.
sed -i.bak "s|version = \".*\"|version = \"${CONDA_R}\"|" r-essentials-feedstock/recipe/meta.yaml
rm r-essentials-feedstock/recipe/meta.yaml.bak
# Now go through r-essentials-feedstock and update all of the versions *very* carefully, using _'s not -'s
```


#### Make the build_order executable

Inside bin, make the build order executable. Either by: `make bld_order` or `gcc bld_order.c -o bld_order`.


#### Build

See `aggregateR/bin/prepare_build_*` and `aggregateR/bin/build_*` to
see an example of how to create the build scripts and then run them.

Please use `tmux` to ensure your build isn't interrupted by a network fail!

Log files are dumped to `aggreagateR/logs`.

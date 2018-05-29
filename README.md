# Instructions for updating and building the Anaconda R package ecosystem (non-MRO)

## 1. Figure out or decide upon the latest R version and the appropriate MRAN snapshot date to use
```
# For example:
export CRAN_URL=https://mran.microsoft.com/snapshot/2018-04-23
export CONDA_R=3.5.0
# Edit ~/conda/aggregateR/conda_build_config.yaml and change:
    cran_mirror:
      - <CRAN_URL>
```

## 2. Clean everything up (please exercise caution and judgement here)
```
git reset --hard
git submodule foreach git reset --hard
git submodule foreach git clean -dxf .
git clean -dxf .
```

## 3. Update all of the recipes that are sourced from MRAN
```
conda skeleton cran \
  --cran-url ${CRAN_URL} \
  --output-suffix=-feedstock/recipe --recursive \
  --add-maintainer=mingwandroid \
  --update-policy=merge-keep-build-num \
  --r-interp=r-base \
  $(find . -name "*feedstock" | \
    sed -e 's|^./rstudio-feedstock$||' \
        -e 's|^./rstudio-1.1.442-feedstock$||' \
        -e 's|^./r-essentials-feedstock$||' \
        -e 's|^./r-recommended-feedstock$||' \
        -e 's|^./r-shinysky-feedstock$||' \
        -e 's|^./r-rmr2-feedstock$||' \
        -e 's|^./rpy2-feedstock$||' \
        -e 's|^./rpy2-2.8-feedstock$||' \
        -e 's|^./r-base-feedstock$||' \
        -e 's|^./r-irkernel-feedstock$||' \
        -e 's|^./r-rhive-feedstock$||' \
        -e 's|^./r-feedstock$||' \
        -e 's|^./r-weatherdata-feedstock$||' \
        -e 's|^./_r-mutex-feedstock$||' \
        -e 's|^./$||' \
        -e 's|^./\.git.*$||')
```

Here, the exclusion of `r-rmr2` and `r-shinysky` are because they are from `GitHub` but not from git repos which breaks some assumptions made by `conda skeleton cran`, namely:
1. Any URL with `github` in it is a git repository (it could be an archive).
2. Any git repository will have tags and the right default is the 'latest' one.

`r-shinysky` seems pretty dead these days. It was done as a fork of a fork of the real upstream and archived due to a lack of git tags.
`r-rmr2` is also probably using archives due to a lack of git tags.
`r-weatherdata` has been removed from CRAN around R 3.5.0 time.
The other excluded packages are not R packages at all (`rpy2`, `rstudio` and metapackages).

## 4. Update all of the recipes that are sourced from `GitHub`
```
conda skeleton cran --output-suffix=-feedstock/recipe \
    --add-maintainer=mingwandroid \
    --update-policy=merge-keep-build-num \
    https://github.com/bokeh/rbokeh \
    https://github.com/IRkernel/IRkernel \
    https://github.com/rstats-db/odbc \
    https://github.com/nexr/RHive
# there many be some more of these, TODO :: Check this.
```
### .. take care that `RHive`'s git tag gets reset back to `nexr-rhive-2.0.10` (released Dec 2014, it has not changed much since though .. the issue here is that their newest tag refers to a WIP branch):
```
sed -i.bak 's|nexr-rhive-2\.0\.10-ranger.*$|nexr-rhive-2\.0\.10|' r-rhive-feedstock/recipe/meta.yaml
rm r-rhive-feedstock/recipe/meta.yaml.bak
```

At this point prune [this list](#list-of-packages-with-build-number-problems) (i.e. edit this very file to remove) packages that have had a new version released
which allows us to reset the build number back to 0. The ultimate goal is for this list to disappear completely.

## 5. Update some metapackage versions
```
sed -i.bak "s|version = \".*\"|version = \"${CONDA_R}\"|" r-recommended-feedstock/recipe/meta.yaml
rm r-recommended-feedstock/recipe/meta.yaml.bak
sed -i.bak "s|version = \".*\"|version = \"${CONDA_R}\"|" r-feedstock/recipe/meta.yaml
rm r-recommended-feedstock/recipe/meta.yaml.bak
# This sed of `r-essentials` may not work but you need to examine it carefully by hand anyway.
sed -i.bak "s|version = \".*\"|version = \"${CONDA_R}\"|" r-essentials-feedstock/recipe/meta.yaml
rm r-essentials-feedstock/recipe/meta.yaml.bak
# Now go through r-essentials-feedstock and update all of the versions *very* carefully, using _'s not -'s
```

## 6. Add new dependencies, either as forks of `conda-forge` recipes when available or directly
```
# If conda-forge has r-foo-feedstock then move our new one out of the way:
mv r-foo-feedstock r-foo-feedstock.mran.latest
# .. fork theirs then:
git submodule add -b ../r-foo-feedstock r-foo-feedstock
# .. and compare and merge across the differences and delete r-foo-feedstock.mran.latest
# Git add the remaining ones (the cleanup in 1. is important for this to work right):
git add -N .
git commit -m "Added new dependencies as of R ${CONDA_R}"
```

## 7. For the super-module (due to the inline recipes) and every submodule carefully undo damage done by the update procedure

The damage most often seen is that CDT and/or 'system' packages get dropped since `conda skeleton cran` does not parse `SystemRequirements:`
TODO :: Consider adding this feature to `conda skeleton cran`?
```
git checkout -p .
# This is boring and it is easy to lose concentration and make a costly mistake so pay close attention:
git submodule foreach "git checkout -p ."
```

## 8. For the super-module (due to the inline recipes) and every submodule add the new changes
```
git add -p .
git commit -m "Updates as of R ${CONDA_R}"
# TODO :: This needs work, I could not find the appropriate invocation in my bash history :-(
git submodule foreach "git add -p . && git commit -m 'Updates as of R ${CONDA_R}' || true"
```

## 9. Regenerate the build order
For linux-64 (edit ~/conda/pcr/rays-scratch-scripts/c3i-build-orderer-config/build_platforms.d/example.yml)
```
c3i examine --matrix-base-dir ~/conda/pcr/rays-scratch-scripts/c3i-build-orderer-config \
    ~/conda/aggregateR \
    --output /tmp/build-order \
    --folders $(find . -maxdepth 1 -type d | grep -v -e '\.git' -e '\.$')
# TODO :: The source filename is not correct here, find the correct file and update this document.
cp /tmp/build-order-recipes ~/conda/pcr/rays-scratch-scripts/build-order/r/all
# Now use git to put back some of the useful comments in this file iff you are using `build-in-order` to do the build-out.
```

## 10. If updating RStudio then check if the R package dependencies need to be updated

Look for these dependencies [here](https://github.com/rstudio/rstudio/blob/master/src/gwt/src/org/rstudio/studio/client/common/dependencies/DependencyManager.java)
TODO :: I seem to remember some dependencies were located in some other files too. Check into this and update this document.

## 11. Run the build using either my `build-in-order` or plain old `conda-build`:

You can use either now because, for the parts that we need from `build-in-order` we are close to
`conda` and `conda-build` and the `Anaconda Distribution` being fully capable of doing the right
thing. In particular, the first part (compiling the toolchain) and the final parts (dealing with
`constructor` and creating baked metapackages) are not used.
```
# `build-in-order` method
# Advantages: You can add `--start-at=r-foo-feedstock` to err, start at `r-foo-feedstock`
#             You can add `--packages=r-foo-feedstock,r-bar-feedstock` to build only some.
~/conda/pcr/rays-scratch-scripts/build-in-order --product=r \
  --upload-channel=none --pkg-build-channel-priority=M \
  --installer-build-channel-priority=D --skip-existing=yes \
  --build-toolchain=no 2>&1 | tee -a ~/conda/R-${CONDA_R}-$(uname)-$(uname -m).log

# `conda-build` (doing all packages):
CONDA_ADD_PIP_AS_PYTHON_DEPENDENCY=0 \
  conda-build $(cat ~/conda/pcr/rays-scratch-scripts/build-order/r/all | tr '\n' ' ') \
  -c https://repo.continuum.io/pkgs/main \
  --skip-existing --error-overlinking 2>&1 | tee -a ~/conda/R-${CONDA_R}-$(uname)-$(uname -m).log

# `conda-build` (starting at `r-foo-feedstock`):
CONDA_ADD_PIP_AS_PYTHON_DEPENDENCY=0 \
  conda-build $(cat ~/conda/pcr/rays-scratch-scripts/build-order/r/all | sed '/r-foo-feedstock/,$d' | tr '\n' ' ') \
  -c https://repo.continuum.io/pkgs/main \
  --skip-existing --error-overlinking 2>&1 | tee -a ~/conda/R-${CONDA_R}-$(uname)-$(uname -m).log
```

# Addendum and miscellaneous notes:

## list of packages with build number problems

The 33 (mostly legacy or perhaps 'finished'?) packages that must maintain their build number at `4` at R 3.5.0 buildout time (Mon 30 Apr 2018). It may be the case that we do not need to do this any more; it could've been down to their lack of exact pinning on the `r` or `r-base` version that has since been fixed, however I'm playing it safe here.
```
r-base64enc
r-bitops
r-brew
r-catools
r-class
r-dichromat
r-fracdiff
r-functional
r-gridbase
r-gtools
r-kernsmooth
r-labeling
r-magrittr
r-manipulate
r-matrixmodels
r-minqa
r-mlmrev
r-modeltools
r-nloptr
r-pkgmaker
r-praise
r-profilemodel
r-quadprog
r-rjson
r-rjsonio
r-rngtools
r-rocr
r-rserve
r-spatial
r-uuid
r-whisker
r-xlsx
r-xlsxjars
```

### Very rough popularity figures for these taken from: https://dgrtwo.shinyapps.io/cranview/
```
r-base64enc      6000
r-bitops         6000
r-brew           1000
r-catools        6000
r-class          400
r-dichromat      7000
r-fracdiff       900
r-functional     200
r-gridbase       200
r-gtools         2000
r-hexbin         2000
r-kernsmooth     8000
r-labeling       7000
r-magrittr       12000
r-manipulate     1000
r-matrixmodels   4000
r-minqa          4000
r-mlmrev         10
r-modeltools     1900
r-nloptr         3000
r-nmf            200
r-pkgmaker       1000
r-praise         1500
r-profilemodel   100
r-quadprog       1800
r-randomforest   1800
r-rjson          1500
r-rjsonio        1500
r-rngtools       500
r-rocr           600
r-rserve         600
r-spatial        150
r-uuid           250
r-whisker        2500
r-xlsx           2000
r-xlsxjars       1500
```

## Possible additions?:

We probably want to get biocLite added as per https://github.com/ContinuumIO/anaconda-issues/issues/7068
```
source("https://bioconductor.org/biocLite.R")
biocLite()
```

Seems we miss, or have too old versions of:

```
BiocInstaller
blob
memoise
BiocGenerics
bit
S4Vectors
Biobase
bit64
IRanges
RSQLite
AnnotationDbi
```

## To check that `anaconda upload` did not drop some packages (it often does):
```
python ~/conda/pcr/rays-scratch-scripts/binstar_copy.py \
  --owner rdonnellyr --platform "osx-64" \
  --operation list > /tmp/uploaded.txt
# .. then compare against e.g:
pushd /opt/conda/conda-bld/osx-64
ls -1 | LC_ALL=C sort > /tmp/build.txt
diff -urN /tmp/build.txt /tmp/uploaded.txt
```

## To get a very poor list (contains lots of things other than packages) of the non-R packages that R packages depend upon:
```
grep -R '\- ' */recipe/*.yaml | awk '{print $3}' | grep -v '{{posix}}' | grep -v 'r-' | sed 's|{{native}}||' | sort | uniq > Rdeps
```

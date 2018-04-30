# aggregateR

# 1. .. to clean everything up:
git reset --hard
git submodule foreach git reset --hard
git submodule foreach git clean -dxf .
git clean -dxf .

# 2. .. to update the recipes:
export CONDA_R=3.5.0
conda skeleton cran --cran-url https://mran.microsoft.com/snapshot/2018-04-23 --output-suffix=-feedstock/recipe --recursive --add-maintainer=mingwandroid \
                    --update-policy=merge-keep-build-num $(find . -name "*feedstock" | sed -e 's|^./rstudio-feedstock$||' -e 's|^./rstudio-1.1.442-feedstock$||' -e 's|^./r-essentials-feedstock$||' \
                    -e 's|^./r-recommended-feedstock$||' -e 's|^./r-shinysky-feedstock$||' -e 's|^./r-rmr2-feedstock$||' -e 's|^./rpy2-feedstock$||' \
                    -e 's|^./rpy2-2.8-feedstock$||' -e 's|^./r-base-feedstock$||' -e 's|^./r-irkernel-feedstock$||' -e 's|^./r-rhive-feedstock$||' \
                    -e 's|^./r-feedstock$||' -e 's|^./r-weatherdata-feedstock$||' -e 's|^./_r-mutex-feedstock$||' -e 's|^./$||' -e 's|^./\.git.*$||')
conda skeleton cran --output-suffix=-feedstock/recipe --add-maintainer=mingwandroid --update-policy=merge-keep-build-num \
    https://github.com/bokeh/rbokeh \
    https://github.com/IRkernel/IRkernel \
    https://github.com/rstats-db/odbc \
    https://github.com/nexr/RHive
# .. take care that RHive's git tag gets reset back to nexr-rhive-2.0.10 (which was released in Dec 2014, not that there has been any real work since then):
sed -i.bak 's|nexr-rhive-2\.0\.10-ranger.*$|nexr-rhive-2\.0\.10|' r-rhive-feedstock/recipe/meta.yaml
rm r-rhive-feedstock/recipe/meta.yaml.bak
sed -i.bak "s|version = \".*\"|version = \"${CONDA_R}\"|" r-recommended-feedstock/recipe/meta.yaml
# .. now update all of the versions in r-essentials and bump the version of that too (now unified with r-base version)
# If you need to regenerate the build order:
for linux-64 (edit ~/conda/private_conda_recipes/rays-scratch-scripts/c3i-build-orderer-config/build_platforms.d/example.yml)
c3i examine --matrix-base-dir ~/conda/private_conda_recipes/rays-scratch-scripts/c3i-build-orderer-config ~/conda/aggregateR --output /tmp/build-order --folders $(find . -maxdepth 1 -type d | grep -v -e '\.git' -e '\.$')

# Here, the exclusion of r-rmr2 and r-shinysky are because they are from GitHub but not from git repos which breaks conda skeleton cran's assumptions, namely:
#   1. Any URL with 'github' in it is a git repository (it could be an archive)
#   2. Any git repository will have tags and the right default is the 'latest' one
# r-shinysky seems pretty dead these days. It was done as a fork of a fork of the real upstream and archived due to a lack of git tags.
# r-rmr2 is also probably using archives due to a lack of git tags.
# The other excluded packages are not R packages (rpy2, rstudio and metapackages).

# 3 .. to generate a (non-git) patch including new files and changes to submodules after updating the recipes but before having the guts to commit everything:
# Signal 'intent to add' for all untracked files
git add -N .
git submodule foreach git add -N .
git submodule foreach git add .
/usr/local/bin/git diff -a --submodule=diff --ignore-submodules=none > updates.patch
git reset HEAD .
git submodule foreach git reset HEAD .

# 4 .. if updating RStudio then check if the R package dependencies need to be updated

The complete list of the 33 legacy packages that must maintain their build number at 4 at R 3.5.0 buildout time (Mon 30 Apr 2018) is:

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

Very rough popularity figures taken from: https://dgrtwo.shinyapps.io/cranview/
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

Additions:

We probably want to get biocLite added as per https://github.com/ContinuumIO/anaconda-issues/issues/7068
source("https://bioconductor.org/biocLite.R")
biocLite()

Seems we miss, or have too old versions of:

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

Dependencies that get dropped when doing a mass update:

Some compiler('c') vanished despite compiler('cxx') <= fix this just-in-case in skeleton RPM.
Hack any that require Rcpp or Rcpparmadillo to need a compiler('cxx') too.

r-data.table
build:
-    - llvm-openmp >=4.0.1        # [osx]
host:
-    - llvm-openmp >=4.0.1        # [osx]
run:
-    - llvm-openmp >=4.0.1        # [osx]

r-gmp
host:
-    - {{native}}gmp
run:
-    - {{native}}gmp

r-igraph:
host:
-    - {{native}}gmp
-    - {{native}}libxml2
run:
-    - {{native}}gmp
-    - {{native}}libxml2

r-mongolite
host:
-    - {{native}}openssl
-    - {{native}}cyrus-sasl       # [not win]
run:
-    - {{native}}openssl
-    - {{native}}cyrus-sasl       # [not win]

r-nloptr
host:
-    - {{native}}nlopt            # [win]
run:
-    - {{native}}nlopt            # [win]

r-odbc
host:
-    - {{native}}unixodbc         # [not win]
run:
-    - {{native}}unixodbc         # [not win]

r-rcurl
host:
-    - {{native}}curl
run:
-    - {{native}}curl

r-rgl:
build:
-    - {{ cdt('xorg-x11-proto-devel') }}  # [linux]
-    - {{ cdt('mesa-libgl-devel') }}      # [linux]
-    - {{ cdt('libx11-devel') }}          # [linux]
-    - {{ cdt('libxext-devel') }}         # [linux]
-    - {{ cdt('libxrender-devel') }}      # [linux]
-    - {{ cdt('mesa-libgl-devel') }}      # [linux]
-    - {{ cdt('mesa-libegl-devel') }}     # [linux]
-    - {{ cdt('mesa-dri-drivers') }}      # [linux]
-    - {{ cdt('libxau-devel') }}          # [linux]
-    - {{ cdt('libdrm-devel') }}          # [linux]
-    - {{ cdt('libxcomposite-devel') }}   # [linux]
-    - {{ cdt('libxcursor-devel') }}      # [linux]
-    - {{ cdt('libxi-devel') }}           # [linux]
-    - {{ cdt('libxrandr-devel') }}       # [linux]
-    - {{ cdt('libxscrnsaver-devel') }}   # [linux]
-    - {{ cdt('libxtst-devel') }}         # [linux]
-    - {{ cdt('libselinux-devel') }}      # [linux]
-    - {{ cdt('libxdamage') }}            # [linux]
-    - {{ cdt('libxfixes') }}             # [linux]
-    - {{ cdt('libxxf86vm') }}            # [linux]
host:
-    - expat                              # [linux]
-    - libglu                             # [linux]
run:
-    - expat                              # [linux]
-    - libglu                             # [linux]

r-rjava
build:
-    - {{posix}}curl                      # [win]
-    - {{ cdt('java-1.7.0-openjdk') }}        # [linux]
-    - {{ cdt('java-1.7.0-openjdk-devel') }}  # [linux]

r-rmariadb
host:
-    - {{native}}mysql
run:
-    - {{native}}mysql

r-rmysql
host:
-    - {{native}}mysql
run:
-    - {{native}}mysql  (why is this not a run dep for r-rmariadb?)

r-rodbc
host:
-    - {{native}}unixodbc         # [not win]
run:
-    - {{native}}unixodbc         # [not win]

r-rzmq
host:
-    - {{native}}zeromq >=3.0.0
run:
-    - {{native}}zeromq >=3.0.0

r-sf
host:
-    - {{native}}libgdal
run
-    - {{native}}libgdal

r-udunits2
host:
-    - {{native}}udunits2
run:
-    - {{native}}udunits2

r-xml
host:
-    - {{native}}libxml2 >=2.6.3
run:
-    - {{native}}libxml2 >=2.6.3

# Build ..
# linux-64 (does not look for existing packages on rdonnellyr (or to be exact, on the --upload-channel))
~/conda/private_conda_recipes/rays-scratch-scripts/build-in-order --product=r --upload-channel=rdonnellyr --pkg-build-channel-priority=M --installer-build-channel-priority=D --skip-existing=yes --build-toolchain=no 2>&1 | tee ~/conda/R-3.4.3.log
# the rest (does look on rdonnellyr) - ACTUALLY WE CANNOT USE NOARCH YET UNFORTUNATELY, SO USE THE ABOVE FOR ALL PLATFORMS.
~/conda/private_conda_recipes/rays-scratch-scripts/build-in-order --product=r --upload-channel=rdonnellyr --pkg-build-channel-priority=M,U --installer-build-channel-priority=D --skip-existing=yes --build-toolchain=no 2>&1 | tee ~/conda/R-3.4.3.log

# To check that anaconda upload didn't drop some packages:
python ~/conda/private_conda_recipes/rays-scratch-scripts/binstar_copy.py --owner rdonnellyr --platform "osx-64" --operation list > /tmp/uploaded.txt
.. then compare against e.g:
pushd /opt/conda/conda-bld/osx-64
ls -1 | LC_ALL=C sort > /tmp/build.txt
diff -urN /tmp/build.txt /tmp/uploaded.txt

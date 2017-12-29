# aggregateR

# 1. .. to clean everything up:
git reset --hard
git submodule foreach git reset --hard
git submodule foreach git clean -dxf .
git clean -dxf .

# 2. .. to update the recipes:
conda skeleton cran --output-suffix=-feedstock/recipe --recursive --add-maintainer=mingwandroid --update-policy=merge-keep-build-num $(echo *feedstock | sed 's/\brstudio-feedstock\b//' | sed 's/\br-essentials-feedstock\b//' | sed 's/\br-recommended-feedstock\b//' | sed 's/\br-shinysky-feedstock\b//' | sed 's/\br-rmr2-feedstock\b//' | sed 's/\brpy2-feedstock\b//' | sed 's/\brpy2-2.8-feedstock\b//' | sed 's/\br-base-feedstock\b//' | sed 's/\br-feedstock\b//')

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

The complete list of the 36 legacy packages that must maintain their build number at 4 at R 3.4.3 buildout time (29th Dec 2017) is:

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
r-hexbin
r-kernsmooth
r-labeling
r-magrittr
r-manipulate
r-matrixmodels
r-minqa
r-mlmrev
r-modeltools
r-nloptr
r-nmf
r-pkgmaker
r-praise
r-profilemodel
r-quadprog
r-randomforest
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
run:
-    - llvm-openmp >=4.0.1        # [osx]

r-gmp
build:
-    - {{native}}gmp
run:
-    - {{native}}gmp

r-hunspell
build:
-    - {{ compiler('c') }}        # [not win]

r-igraph:
build:
-    - {{native}}gmp
-    - {{native}}libxml2
run:
-    - {{native}}gmp
-    - {{native}}libxml2

r-mongolite
build:
-    - {{native}}openssl
-    - {{native}}cyrus-sasl       # [not win]
run:
-    - {{native}}openssl
-    - {{native}}cyrus-sasl       # [not win]

r-nloptr
build:
-    - {{native}}nlopt            # [win]
run:
-    - {{native}}nlopt            # [win]

r-odbc
build:
-    - {{ compiler('cxx') }}      # [not win]
-    - {{native}}toolchain        # [win]
-    - {{posix}}filesystem        # [win]
-    - {{posix}}autoconf
-    - {{posix}}automake-wrapper  # [win]
-    - {{posix}}automake          # [not win]
-    - {{posix}}pkg-config
-    - {{posix}}make
-    - {{native}}unixodbc         # [not win]
run:
-    - {{native}}unixodbc         # [not win]

r-rcurl
build:
-    - {{native}}curl
run:
-    - {{native}}curl

r-rjava
build:
-    - {{posix}}curl                      # [win]
-    - {{ cdt('java-1.7.0-openjdk') }}        # [linux]
-    - {{ cdt('java-1.7.0-openjdk-devel') }}  # [linux]

r-rmariadb
build:
-    - {{native}}mysql

r-rmysql
build:
-    - {{native}}mysql
run:
-    - {{native}}mysql  (why is this not a run dep for r-rmariadb?)

r-rodbc
build:
-    - {{native}}unixodbc         # [not win]
run:
-    - {{native}}unixodbc         # [not win]

r-rzmq
build:
-    - {{native}}zeromq >=3.0.0
run:
-    - {{native}}zeromq >=3.0.0

r-sf
build:
-    - {{native}}libgdal
run
-    - {{native}}libgdal

r-udunits2
build:
-    - {{native}}udunits2
run:
-    - {{native}}udunits2

r-xml
build:
-    - {{native}}libxml2 >=2.6.3
run:
-    - {{native}}libxml2 >=2.6.3

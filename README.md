# aggregateR

# 1. .. to clean everything up:
git reset --hard
git submodule foreach git reset --hard
git submodule foreach git clean -dxf .
git clean -dxf .

# 2. .. to update the recipes:
conda skeleton cran --output-suffix=-feedstock/recipe --recursive --add-maintainer=mingwandroid --update-policy=merge-keep-build-num $(echo * | sed 's/rstudio-feedstock//' | sed 's/r-essentials-feedstock//' | sed 's/r-recommended-feedstock//' | sed 's/r-shinysky-feedstock//' | sed 's/r-rmr2-feedstock//' | sed 's/rpy2-feedstock//' | sed 's/rpy2-2.8-feedstock//' | sed 's/r-base-feedstock//')

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

Already fixed:
r-bitops
r-brew
r-catools
r-dichromat
r-fracdiff
r-labeling
r-magrittr
r-minqa
r-mlmrev
r-nloptr
r-profilemodel
r-quadprog
r-rjsonio
r-timedate
r-whisker
r-xts

Still broken:
r-base64enc
r-class
r-domc
r-foreach
r-functional
r-gridbase
r-gtools
r-hexbin
r-iterators
r-kernsmooth
r-manipulate
r-matrixmodels
r-modeltools
r-nmf
r-pkgmaker
r-praise
r-randomforest
r-registry
r-rjson
r-rngtools
r-rocr
r-rserve
r-spatial
r-uuid
r-xlsx
r-xlsxjars

The complete list of the 42 legacy packages that must maintain their build number at between 1 and 4 (bump all to 4?) is:
r-base64enc     2
r-bitops        3
r-brew          3
r-catools       3
r-class         3
r-dichromat     4
r-domc          1
r-foreach       3
r-fracdiff      2
r-functional    1
r-gridbase      1
r-gtools        1
r-hexbin        3
r-iterators     3
r-kernsmooth    3
r-labeling      3
r-magrittr      3
r-manipulate    1
r-matrixmodels  1
r-minqa         2
r-mlmrev        3
r-modeltools    3
r-nloptr        3
r-nmf           1
r-pkgmaker      1
r-praise        1
r-profilemodel  3
r-quadprog      2
r-randomforest  2
r-registry      1
r-rjson         1
r-rjsonio       2
r-rngtools      1
r-rocr          1
r-rserve        1
r-spatial       3
r-timedate      3
r-uuid          2
r-whisker       3
r-xlsx          1
r-xlsxjars      1
r-xts           2

Very rough popularity figures taken from: https://dgrtwo.shinyapps.io/cranview/
r-base64enc      6000
r-bitops         6000
r-brew           1000
r-catools        6000
r-class          400
r-dichromat      7000
r-domc           10
r-foreach        2000
r-fracdiff       900
r-functional     200
r-gridbase       200
r-gtools         2000
r-hexbin         2000
r-iterators      2000
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
r-registry       800
r-rjson          1500
r-rjsonio        1500
r-rngtools       500
r-rocr           600
r-rserve         600
r-spatial        150
r-timedate       1500
r-uuid           250
r-whisker        2500
r-xlsx           2000
r-xlsxjars       1500
r-xts            3000

r-base64enc-feedstock-feedstock,r-bitops-feedstock-feedstock,r-brew-feedstock-feedstock,r-catools-feedstock-feedstock,r-class-feedstock-feedstock,r-dichromat-feedstock-feedstock,r-domc-feedstock-feedstock,r-foreach-feedstock-feedstock,r-fracdiff-feedstock-feedstock,r-functional-feedstock-feedstock,r-gridbase-feedstock-feedstock,r-gtools-feedstock-feedstock,r-hexbin-feedstock-feedstock,r-iterators-feedstock-feedstock,r-kernsmooth-feedstock-feedstock,r-labeling-feedstock-feedstock,r-magrittr-feedstock-feedstock,r-manipulate-feedstock-feedstock,r-matrixmodels-feedstock-feedstock,r-minqa-feedstock-feedstock,r-mlmrev-feedstock-feedstock,r-modeltools-feedstock-feedstock,r-nloptr-feedstock-feedstock,r-nmf-feedstock-feedstock,r-pkgmaker-feedstock-feedstock,r-praise-feedstock-feedstock,r-profilemodel-feedstock-feedstock,r-quadprog-feedstock-feedstock,r-randomforest-feedstock-feedstock,r-registry-feedstock-feedstock,r-rjson-feedstock-feedstock,r-rjsonio-feedstock-feedstock,r-rngtools-feedstock-feedstock,r-rocr-feedstock-feedstock,r-rserve-feedstock-feedstock,r-spatial-feedstock-feedstock,r-timedate-feedstock-feedstock,r-uuid-feedstock-feedstock,r-whisker-feedstock-feedstock,r-xlsx-feedstock-feedstock,r-xlsxjars-feedstock,r-xts-feedstock

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

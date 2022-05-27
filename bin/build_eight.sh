#!/bin/bash

export EXTRA_BUILD_ARGS=
#export EXTRA_BUILD_ARGS=' --skip-existing'

DATE=`date -Iseconds`
BUILD_LIST="build_list.log"
BUILD_GOOD="build_good.log"
BUILD_FAIL="build_fail.log"
BUILD_FULL="build_full.log"

echo $DATE > $BUILD_LIST
echo $DATE > $BUILD_GOOD
echo $DATE > $BUILD_FAIL
echo $DATE > $BUILD_FULL

build_one () {
    echo "================================================================================" >> $BUILD_FULL
    echo "Building ${@}" >> $BUILD_FULL
    echo "================================================================================" >> $BUILD_FULL
    conda-build --R 4.2.0 ${EXTRA_BUILD_ARGS} ${@} >> $BUILD_FULL 2>> $BUILD_FULL || return 1
    return 0
}

build_all () {
    for JUST_THE_ONE in ${@}; do
        DATE=`date`
        echo -n "Building ${JUST_THE_ONE}..."
        if build_one $JUST_THE_ONE ; then
            echo  "good: $JUST_THE_ONE" >> $BUILD_LIST
            echo  "$DATE $JUST_THE_ONE" >> $BUILD_GOOD
            echo  " good!"
        else
            echo  "fail: $JUST_THE_ONE" >> $BUILD_LIST
            echo  "$DATE $JUST_THE_ONE" >> $BUILD_FAIL
            echo  " FAIL!"
        fi
    done
}


build_all \
    _r-mutex-feedstock \
    r-base-feedstock \
    r-sys-feedstock \
    r-assertthat-feedstock \
    r-backports-feedstock \
    r-base64enc-feedstock \
    r-bit-feedstock \
    r-rlang-feedstock \
    r-brio-feedstock \
    r-generics-feedstock \
    r-glue-feedstock \
    r-jsonlite-feedstock \
    r-r6-feedstock \
    r-rematch-feedstock \
    r-clipr-feedstock \
    r-colorspace-feedstock \
    r-cpp11-feedstock \
    r-crayon-feedstock


build_all \
    r-curl-feedstock \
    r-data.table-feedstock \
    r-dbi-feedstock \
    r-magrittr-feedstock \
    r-withr-feedstock \
    r-rprojroot-feedstock \
    r-digest-feedstock \
    r-essentials-feedstock \
    r-evaluate-feedstock \
    r-fansi-feedstock \
    r-farver-feedstock \
    r-fastmap-feedstock \
    r-fs-feedstock \
    r-rappdirs-feedstock \
    r-rstudioapi-feedstock \
    r-mass-feedstock

build_all \
    r-gtable-feedstock \
    r-isoband-feedstock \
    r-uuid-feedstock \
    r-xfun-feedstock \
    r-pkgconfig-feedstock \
    r-mime-feedstock \
    r-pbdzmq-feedstock \
    r-yaml-feedstock \
    r-labeling-feedstock \
    r-lattice-feedstock \
    r-utf8-feedstock \
    r-png-feedstock \
    r-praise-feedstock \
    r-prettyunits-feedstock \
    r-ps-feedstock \
    r-rcolorbrewer-feedstock

build_all \
    r-rcpp-feedstock \
    r-rjava-feedstock \
    r-rodbc-feedstock \
    r-xml2-feedstock \
    r-viridislite-feedstock \
    r-stringi-feedstock \
    r-xml-feedstock

build_all \
    r-askpass-feedstock \
    r-bit64-feedstock \
    r-ellipsis-feedstock \
    r-purrr-feedstock \
    r-stringr-feedstock \
    r-htmltools-feedstock \
    r-processx-feedstock \
    r-cli-feedstock \
    r-lifecycle-feedstock \
    r-diffobj-feedstock \
    r-here-feedstock \
    r-highr-feedstock \
    r-lubridate-feedstock \
    r-matrix-feedstock \
    r-nlme-feedstock \
    r-munsell-feedstock

build_all \
    r-rcpptoml-feedstock \
    r-tzdb-feedstock \
    r-tinytex-feedstock

build_all \
    r-vctrs-feedstock \
    r-jquerylib-feedstock \
    r-sass-feedstock \
    r-callr-feedstock \
    r-desc-feedstock \
    r-mgcv-feedstock \
    r-scales-feedstock \
    r-openssl-feedstock \
    r-knitr-feedstock \
    r-reticulate-feedstock \
    r-selectr-feedstock

build_all \
    r-blob-feedstock \
    r-bslib-feedstock \
    r-tidyselect-feedstock \
    r-pillar-feedstock \
    r-httr-feedstock \
    r-ids-feedstock \
    r-hms-feedstock \
    r-pkgload-feedstock

build_all \
    r-tibble-feedstock \
    r-gargle-feedstock \
    r-repr-feedstock \
    r-progress-feedstock \
    r-rmarkdown-feedstock

build_all \
    r-dplyr-feedstock \
    r-ggplot2-feedstock \
    r-cellranger-feedstock \
    r-forcats-feedstock \
    r-googledrive-feedstock \
    r-rematch2-feedstock \
    r-irdisplay-feedstock \
    r-vroom-feedstock \
    r-reprex-feedstock \
    r-rvest-feedstock

build_all \
    r-tidyr-feedstock \
    r-dbplyr-feedstock \
    r-dtplyr-feedstock \
    r-googlesheets4-feedstock \
    r-readr-feedstock \
    r-irkernel-feedstock \
    r-readxl-feedstock \
    r-waldo-feedstock

build_all \
    r-broom-feedstock \
    r-haven-feedstock \
    r-testthat-feedstock

build_all \
    r-modelr-feedstock

build_all \
    r-tidyverse-feedstock

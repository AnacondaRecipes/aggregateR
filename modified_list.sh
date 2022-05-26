
fix_one_a() {
    cd ${1}
    git fetch
    git pull
    git branch update-R4.2
    git checkout update-R4.2
    git commit -a -m"Updating for R 4.2.0."
    git checkout master || git checkout main
    git merge update-R4.2
    cd ..
}

fix_one_b() {
    git add ${1}
}

fix_one() {
    cd ${1}
    git push
    cd ..
}


fix_all() {
    for JUST_ONE in ${@}; do
        fix_one $JUST_ONE
    done
}


fix_all \
        \
    r-assertthat-feedstock \
    r-backports-feedstock \
    r-base64enc-feedstock \
    r-bit-feedstock \
    r-bit64-feedstock \
    r-broom-feedstock \
    r-cellranger-feedstock \
    r-colorspace-feedstock \
    r-crayon-feedstock \
    r-curl-feedstock \
    r-data.table-feedstock \
    r-dbi-feedstock \
    r-dbplyr-feedstock \
    r-desc-feedstock \
    r-digest-feedstock \
    r-dplyr-feedstock \
    r-essentials-feedstock \
    r-evaluate-feedstock \
    r-forcats-feedstock \
    r-ggplot2-feedstock \
    r-glue-feedstock \
    r-gtable-feedstock \
    r-haven-feedstock \
    r-highr-feedstock \
    r-hms-feedstock \
    r-htmltools-feedstock \
    r-httr-feedstock \
    r-irdisplay-feedstock \
    r-irkernel-feedstock \
    r-jsonlite-feedstock \
    r-knitr-feedstock \
    r-labeling-feedstock \
    r-lattice-feedstock \
    r-lubridate-feedstock \
    r-magrittr-feedstock \
    r-mass-feedstock \
    r-matrix-feedstock \
    r-mgcv-feedstock \
    r-mime-feedstock \
    r-modelr-feedstock \
    r-munsell-feedstock \
    r-nlme-feedstock \
    r-openssl-feedstock \
    r-pbdzmq-feedstock \
    r-pkgconfig-feedstock \
    r-png-feedstock \
    r-praise-feedstock \
    r-purrr-feedstock \
    r-r6-feedstock \
    r-rappdirs-feedstock \
    r-rcolorbrewer-feedstock \
    r-rcpp-feedstock \
    r-readr-feedstock \
    r-readxl-feedstock \
    r-rematch-feedstock \
    r-repr-feedstock \
    r-reticulate-feedstock \
    r-rjava-feedstock \
    r-rlang-feedstock \
    r-rmarkdown-feedstock \
    r-rodbc-feedstock \
    r-rprojroot-feedstock \
    r-rvest-feedstock \
    r-scales-feedstock \
    r-selectr-feedstock \
    r-stringi-feedstock \
    r-stringr-feedstock \
    r-testthat-feedstock \
    r-tibble-feedstock \
    r-tidyr-feedstock \
    r-tidyverse-feedstock \
    r-tinytex-feedstock \
    r-uuid-feedstock \
    r-viridislite-feedstock \
    r-withr-feedstock \
    r-xfun-feedstock \
    r-xml-feedstock \
    r-xml2-feedstock \
    r-yaml-feedstock \

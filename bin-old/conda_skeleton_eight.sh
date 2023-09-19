#!/bin/sh

export CRAN_URL=https://cran.r-project.org
export CONDA_R=4.2.0

skelly () {

    echo "================================================================================"
    echo ${@}
    echo "================================================================================"
    conda skeleton cran \
          --cran-url ${CRAN_URL} \
          --output-suffix=-feedstock/recipe \
          --recursive \
          --update-policy=merge-keep-build-num \
          --r-interp=r-base \
          --use-noarch-generic \
          ${@}


    # was: --allow-archived \

}


# notebook-feedstock \

# r-base

skelly \
    r-essentials-feedstock \
    r-tidyverse \
    r-xml \
    r-rodbc \
    r-irkernel \
    r-reticulate \
    r-testthat \
    r-rjava \



exit

#skelly \
    r-recommended-feedstock \


#skelly r-base

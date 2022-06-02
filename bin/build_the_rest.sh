#!/bin/bash


echo "Please run this from inside a tmux session in case your network connection becomes disconnected!"


#export EXTRA_BUILD_ARGS=
export EXTRA_BUILD_ARGS=' --skip-existing'

mkdir -p logs

DATE=`date -Iseconds`
BUILD_LIST="logs/build_the_rest_list.log"
BUILD_GOOD="logs/build_the_rest_good.log"
BUILD_FAIL="logs/build_the_rest_fail.log"
BUILD_FULL="logs/build_the_rest_full.log"

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
    _r-mutex-feedstock

build_all \
    r-base-feedstock


build_all \
    r-abc.data-feedstock \
    r-abc.rap-feedstock \
    r-rcpp-feedstock \
    r-mass-feedstock \
    r-abe-feedstock \
    r-abf2-feedstock \
    r-abind-feedstock \
    r-cluster-feedstock \
    r-kernlab-feedstock \
    r-data.table-feedstock \
    r-aca-feedstock \
    r-acceptancesampling-feedstock \
    r-acd-feedstock \
    r-acepack-feedstock \
    r-bh-feedstock \
    r-acnr-feedstock

build_all \
    r-acopula-feedstock \
    r-xml-feedstock \
    r-acss.data-feedstock \
    r-matrixstats-feedstock \
    r-expint-feedstock \
    r-rpart-feedstock \
    r-lpsolve-feedstock \
    r-adaptivetau-feedstock \
    r-adaptmt-feedstock \
    r-lattice-feedstock \
    r-mvtnorm-feedstock \
    r-boot-feedstock \
    r-additivitytests-feedstock \
    r-pixmap-feedstock \
    r-kernsmooth-feedstock \
    r-rcolorbrewer-feedstock

build_all \
    r-adeptdata-feedstock \
    r-adequacymodel-feedstock \
    r-adfexplorer-feedstock \
    r-adgoftest-feedstock \
    r-awsmethods-feedstock \
    r-rappdirs-feedstock \
    r-admisc-feedstock \
    r-glue-feedstock \
    r-adpf-feedstock \
    r-advdif4-feedstock \
    r-rjson-feedstock \
    r-formula-feedstock \
    r-afc-feedstock \
    r-afpt-feedstock \
    r-aggregation-feedstock \
    r-agop-feedstock

build_all \
    r-agridat-feedstock \
    r-agrmt-feedstock \
    r-airgr-feedstock \
    r-airports-feedstock \
    r-airthermo-feedstock \
    r-ake-feedstock \
    r-numderiv-feedstock \
    r-albopictus-feedstock \
    r-ald-feedstock \
    r-jsonlite-feedstock \
    r-magrittr-feedstock \
    r-algdesign-feedstock \
    r-algebraichaplopackage-feedstock \
    r-base64enc-feedstock \
    r-dynamictreecut-feedstock \
    r-alleleretain-feedstock

build_all \
    r-alluvial-feedstock \
    r-r6-feedstock \
    r-alscpc-feedstock \
    r-amap-feedstock \
    r-rlang-feedstock \
    r-amcp-feedstock \
    r-amctestmaker-feedstock \
    r-foreign-feedstock \
    r-amelie-feedstock \
    r-amen-feedstock \
    r-americancallopt-feedstock \
    r-amerika-feedstock \
    r-amget-feedstock \
    r-lars-feedstock \
    r-ammoniaconcentration-feedstock \
    r-ampd-feedstock

build_all \
    r-vgam-feedstock \
    r-yaml-feedstock \
    r-analyz-feedstock \
    r-anapuce-feedstock \
    r-andrews-feedstock \
    r-quadprog-feedstock \
    r-assertthat-feedstock \
    r-pbapply-feedstock \
    r-whisker-feedstock \
    r-sys-feedstock \
    r-biocmanager-feedstock \
    r-curl-feedstock \
    r-withr-feedstock \
    r-aod-feedstock \
    r-islr-feedstock \
    r-apcanalysis-feedstock

build_all \
    r-wk-feedstock \
    r-pls-feedstock \
    r-apfr-feedstock \
    r-aplore3-feedstock \
    r-aplpack-feedstock \
    r-bitops-feedstock \
    r-densratio-feedstock \
    r-ellipse-feedstock \
    r-appnn-feedstock \
    r-approxmatch-feedstock \
    r-aprean3-feedstock \
    r-apsimbatch-feedstock \
    r-distrib-feedstock \
    r-arabicstemr-feedstock \
    r-ararredux-feedstock \
    r-discretization-feedstock

build_all \
    r-archdata-feedstock \
    r-ardec-feedstock \
    r-areaplot-feedstock \
    r-xtable-feedstock \
    r-argon2-feedstock \
    r-rstudioapi-feedstock \
    r-findpython-feedstock \
    r-argparser-feedstock \
    r-arht-feedstock \
    r-arnie-feedstock \
    r-arpobservation-feedstock \
    r-arpsdca-feedstock \
    r-gmp-feedstock \
    r-cpp11-feedstock \
    r-ars-feedstock \
    r-generics-feedstock

build_all \
    r-rjava-feedstock \
    r-asaur-feedstock \
    r-asdreader-feedstock \
    r-ash-feedstock \
    r-asioheaders-feedstock \
    r-aspect-feedstock \
    r-aspi-feedstock \
    r-assa-feedstock \
    r-assertive.base-feedstock \
    r-stringi-feedstock \
    r-codetools-feedstock \
    r-compquadform-feedstock \
    r-assocind-feedstock \
    r-assortnet-feedstock \
    r-ast-feedstock \
    r-astrodatr-feedstock

build_all \
    r-astrofns-feedstock \
    r-astrolibr-feedstock \
    r-astsa-feedstock \
    r-deltd-feedstock \
    r-asymld-feedstock \
    r-asymptest-feedstock \
    r-asynchlong-feedstock \
    r-asypow-feedstock \
    r-ate-feedstock \
    r-atmcmc-feedstock \
    r-zip-feedstock \
    r-atsa-feedstock \
    r-auc-feedstock \
    r-audio-feedstock \
    r-audit-feedstock \
    r-autoencoder-feedstock

build_all \
    r-automl-feedstock \
    r-autoregressionmde-feedstock \
    r-av-feedstock \
    r-aweek-feedstock \
    r-gsl-feedstock \
    r-xml2-feedstock \
    r-digest-feedstock \
    r-b6e6rl-feedstock \
    r-babar-feedstock \
    r-backpipe-feedstock \
    r-leaps-feedstock \
    r-bannercommenter-feedstock \
    r-baprestopro-feedstock \
    r-barborgradient-feedstock \
    r-nnet-feedstock \
    r-barnard-feedstock

build_all \
    r-bas-feedstock \
    r-backports-feedstock \
    r-sparsem-feedstock \
    r-basetheme-feedstock \
    r-basicmcmcplots-feedstock \
    r-basicspace-feedstock \
    r-basix-feedstock \
    r-batch-feedstock \
    r-batchmeans-feedstock \
    r-batchscr-feedstock \
    r-bayesbio-feedstock \
    r-bayescombo-feedstock \
    r-bayesda-feedstock \
    r-bayesianetas-feedstock \
    r-bayesianpower-feedstock \
    r-bayesni-feedstock

build_all \
    r-bayesqr-feedstock \
    r-combinat-feedstock \
    r-bayestreeprior-feedstock \
    r-bayesxsrc-feedstock \
    r-bayfoxr-feedstock \
    r-bdsmatrix-feedstock \
    r-bcaboot-feedstock \
    r-bcc1997-feedstock \
    r-bcdating-feedstock \
    r-bcgee-feedstock \
    r-bcra-feedstock \
    r-bdpv-feedstock \
    r-beanplot-feedstock \
    r-crochet-feedstock \
    r-beeswarm-feedstock \
    r-rcppprogress-feedstock

build_all \
    r-benfordtests-feedstock \
    r-bentcablear-feedstock \
    r-betacal-feedstock \
    r-modeltools-feedstock \
    r-bethel-feedstock \
    r-bezier-feedstock \
    r-bgge-feedstock \
    r-bgmfiles-feedstock \
    r-bgsimd-feedstock \
    r-bhh2-feedstock \
    r-biasedurn-feedstock \
    r-bibplots-feedstock \
    r-biclique-feedstock \
    r-bicorn-feedstock \
    r-bigassertr-feedstock \
    r-dbi-feedstock

build_all \
    r-colorspace-feedstock \
    r-bigmemory.sri-feedstock \
    r-uuid-feedstock \
    r-parallelly-feedstock \
    r-bigtcr-feedstock \
    r-corrplot-feedstock \
    r-bikeshare14-feedstock \
    r-bild-feedstock \
    r-mclust-feedstock \
    r-diptest-feedstock \
    r-binaryemvs-feedstock \
    r-entropy-feedstock \
    r-bindr-feedstock \
    r-plogr-feedstock \
    r-binford-feedstock \
    r-corpcor-feedstock

build_all \
    r-binom-feedstock \
    r-binomialcftp-feedstock \
    r-binomlogit-feedstock \
    r-binr-feedstock \
    r-bio.infer-feedstock \
    r-biodem-feedstock \
    r-ecodist-feedstock \
    r-bioftf-feedstock \
    r-biogas-feedstock \
    r-biom.utils-feedstock \
    r-biopn-feedstock \
    r-biotic-feedstock \
    r-birk-feedstock \
    r-birtr-feedstock \
    r-bitsqueezr-feedstock \
    r-dfoptim-feedstock

build_all \
    r-bivgeo-feedstock \
    r-blakerci-feedstock \
    r-blandaltmanleh-feedstock \
    r-blatr-feedstock \
    r-blendedlink-feedstock \
    r-blm-feedstock \
    r-blmodel-feedstock \
    r-blockmatrix-feedstock \
    r-blockmessage-feedstock \
    r-blockrand-feedstock \
    r-blr-feedstock \
    r-bmass-feedstock \
    r-functional-feedstock \
    r-bmp-feedstock \
    r-bndatagenerator-feedstock \
    r-bnlearn-feedstock

build_all \
    r-nnls-feedstock \
    r-boa-feedstock \
    r-boardgames-feedstock \
    r-bodenmiller-feedstock \
    r-bolstad2-feedstock \
    r-timedate-feedstock \
    r-xfun-feedstock \
    r-bootmrmr-feedstock \
    r-bootpr-feedstock \
    r-bootruin-feedstock \
    r-bootstrap-feedstock \
    r-bor-feedstock \
    r-boxplotdbl-feedstock \
    r-bpbounds-feedstock \
    r-bqtl-feedstock \
    r-gtools-feedstock

build_all \
    r-qvcalc-feedstock \
    r-braidrm-feedstock \
    r-branching-feedstock \
    r-brea-feedstock \
    r-bretigea-feedstock \
    r-brew-feedstock \
    r-profilemodel-feedstock \
    r-bridgedist-feedstock \
    r-brm-feedstock \
    r-truncnorm-feedstock \
    r-brobdingnag-feedstock \
    r-brotli-feedstock \
    r-brq-feedstock \
    r-bsmd-feedstock \
    r-bspec-feedstock \
    r-bspmma-feedstock

build_all \
    r-bucss-feedstock \
    r-bundesbank-feedstock \
    r-bundesligr-feedstock \
    r-burstfin-feedstock \
    r-burstmisc-feedstock \
    r-bursts-feedstock \
    r-chron-feedstock \
    r-bvls-feedstock \
    r-bwd-feedstock \
    r-jpeg-feedstock \
    r-png-feedstock \
    r-bytescircle-feedstock \
    r-c2c-feedstock \
    r-ca-feedstock \
    r-fastmap-feedstock \
    r-cacirt-feedstock

build_all \
    r-cairo-feedstock \
    r-calacs-feedstock \
    r-calculator.lr.fns-feedstock \
    r-chnosz-feedstock \
    r-capitalr-feedstock \
    r-capn-feedstock \
    r-captioner-feedstock \
    r-capwire-feedstock \
    r-cardata-feedstock \
    r-care1-feedstock \
    r-caribou-feedstock \
    r-carletonstats-feedstock \
    r-carlit-feedstock \
    r-caroline-feedstock \
    r-cascadedata-feedstock \
    r-casematch-feedstock

build_all \
    r-cat-feedstock \
    r-catdap-feedstock \
    r-cateselection-feedstock \
    r-catnet-feedstock \
    r-catr-feedstock \
    r-catseyes-feedstock \
    r-catt-feedstock \
    r-cattexact-feedstock \
    r-causalsens-feedstock \
    r-cbanalysis-feedstock \
    r-cbt-feedstock \
    r-cc-feedstock \
    r-deriv-feedstock \
    r-cclust-feedstock \
    r-ccm-feedstock \
    r-ccp-feedstock

build_all \
    r-ccremover-feedstock \
    r-cdft-feedstock \
    r-cdlasso-feedstock \
    r-cdnmoney-feedstock \
    r-cdrom-feedstock \
    r-cec2013-feedstock \
    r-censnid-feedstock \
    r-censregmod-feedstock \
    r-cernn-feedstock \
    r-cetcolor-feedstock \
    r-cfa-feedstock \
    r-cfestimatequantiles-feedstock \
    r-cfma-feedstock \
    r-cge-feedstock \
    r-cgp-feedstock \
    r-cgraph-feedstock

build_all \
    r-statmod-feedstock \
    r-tweedie-feedstock \
    r-changepointtesting-feedstock \
    r-chaos01-feedstock \
    r-chargetransport-feedstock \
    r-checkarg-feedstock \
    r-checkdigit-feedstock \
    r-cheddar-feedstock \
    r-chemcal-feedstock \
    r-cherryblossom-feedstock \
    r-chff-feedstock \
    r-chi-feedstock \
    r-chillmodels-feedstock \
    r-chiptest-feedstock \
    r-choicemodelr-feedstock \
    r-cholwishart-feedstock

build_all \
    r-choplump-feedstock \
    r-commonsmath-feedstock \
    r-choroplethrmaps-feedstock \
    r-cifsmry-feedstock \
    r-cim-feedstock \
    r-cinid-feedstock \
    r-cinterpolate-feedstock \
    r-cir-feedstock \
    r-globaloptions-feedstock \
    r-shape-feedstock \
    r-circnntsr-feedstock \
    r-cit-feedstock \
    r-cla-feedstock \
    r-intcal-feedstock \
    r-clamr-feedstock \
    r-cleancall-feedstock

build_all \
    r-cleandata-feedstock \
    r-fritools-feedstock \
    r-rprojroot-feedstock \
    r-clickclust-feedstock \
    r-clinpk-feedstock \
    r-clinsig-feedstock \
    r-clinutidna-feedstock \
    r-clisymbols-feedstock \
    r-packrat-feedstock \
    r-cloudutil-feedstock \
    r-clttools-feedstock \
    r-clust.bin.pair-feedstock \
    r-cluster.datasets-feedstock \
    r-clustercrit-feedstock \
    r-clusterhap-feedstock \
    r-clustering.sc.dp-feedstock

build_all \
    r-mathjaxr-feedstock \
    r-clusterranktest-feedstock \
    r-clusterrepro-feedstock \
    r-clustertend-feedstock \
    r-clustsig-feedstock \
    r-iterators-feedstock \
    r-cmaes-feedstock \
    r-cmc-feedstock \
    r-cmce-feedstock \
    r-cmm-feedstock \
    r-cmna-feedstock \
    r-cmocean-feedstock \
    r-cmplot-feedstock \
    r-coconut-feedstock \
    r-cocor-feedstock \
    r-cocron-feedstock

build_all \
    r-code-feedstock \
    r-codep-feedstock \
    r-coenocliner-feedstock \
    r-cofad-feedstock \
    r-collections-feedstock \
    r-colmozzie-feedstock \
    r-colorfulvennplot-feedstock \
    r-colorhcplot-feedstock \
    r-colorr-feedstock \
    r-colorramps-feedstock \
    r-colortools-feedstock \
    r-crayon-feedstock \
    r-combineportfolio-feedstock \
    r-combins-feedstock \
    r-comclim-feedstock \
    r-commonjavajars-feedstock

build_all \
    r-commonmark-feedstock \
    r-compactr-feedstock \
    r-compare-feedstock \
    r-comparec-feedstock \
    r-comparetests-feedstock \
    r-comphclust-feedstock \
    r-comprehenr-feedstock \
    r-compute.es-feedstock \
    r-con2aqi-feedstock \
    r-conake-feedstock \
    r-concatenate-feedstock \
    r-conclust-feedstock \
    r-condreg-feedstock \
    r-conf.design-feedstock \
    r-ini-feedstock \
    r-confinterpret-feedstock

build_all \
    r-confintvariance-feedstock \
    r-confsam-feedstock \
    r-conics-feedstock \
    r-conjointchecks-feedstock \
    r-connmattools-feedstock \
    r-conover.test-feedstock \
    r-constants-feedstock \
    r-contfrac-feedstock \
    r-contourfunctions-feedstock \
    r-tkrplot-feedstock \
    r-convertgraph-feedstock \
    r-coop-feedstock \
    r-coppecosenzar-feedstock \
    r-pspline-feedstock \
    r-stabledist-feedstock \
    r-copula.markov-feedstock

build_all \
    r-copula.surv-feedstock \
    r-copuladata-feedstock \
    r-coranking-feedstock \
    r-corbin-feedstock \
    r-core-feedstock \
    r-plotrix-feedstock \
    r-corlink-feedstock \
    r-corpora-feedstock \
    r-utf8-feedstock \
    r-correctedfdr-feedstock \
    r-corrsieve-feedstock \
    r-corset-feedstock \
    r-cortools-feedstock \
    r-cosmofns-feedstock \
    r-costsensitive-feedstock \
    r-counthmm-feedstock

build_all \
    r-countrycode-feedstock \
    r-covreg-feedstock \
    r-covrobust-feedstock \
    r-gtable-feedstock \
    r-coxsei-feedstock \
    r-cpa-feedstock \
    r-cpca-feedstock \
    r-cpk-feedstock \
    r-cpm-feedstock \
    r-rcppparallel-feedstock \
    r-cprr-feedstock \
    r-randomforest-feedstock \
    r-cptcity-feedstock \
    r-crank-feedstock \
    r-cream-feedstock \
    r-credsubs-feedstock

build_all \
    r-credule-feedstock \
    r-crimcv-feedstock \
    r-crm-feedstock \
    r-crone-feedstock \
    r-crop-feedstock \
    r-cropdatape-feedstock \
    r-crossreg-feedstock \
    r-lazyeval-feedstock \
    r-crossval-feedstock \
    r-crsmeta-feedstock \
    r-crsnls-feedstock \
    r-crtsize-feedstock \
    r-httpcode-feedstock \
    r-mime-feedstock \
    r-crwrm-feedstock \
    r-nlp-feedstock

build_all \
    r-cstar-feedstock \
    r-csvread-feedstock \
    r-clipr-feedstock \
    r-ctt-feedstock \
    r-ctv-feedstock \
    r-viridislite-feedstock \
    r-cump-feedstock \
    r-cumstats-feedstock \
    r-curry-feedstock \
    r-customerscoringmetrics-feedstock \
    r-cusumdesign-feedstock \
    r-cuttlefish.model-feedstock \
    r-cvcalibration-feedstock \
    r-cvd-feedstock \
    r-cvequality-feedstock \
    r-cvgee-feedstock

build_all \
    r-cvq2-feedstock \
    r-inline-feedstock \
    r-remotes-feedstock \
    r-cycloids-feedstock \
    r-daarem-feedstock \
    r-dacf-feedstock \
    r-dagr-feedstock \
    r-daime-feedstock \
    r-daly-feedstock \
    r-dam-feedstock \
    r-tidycpp-feedstock \
    r-dapr-feedstock \
    r-dark-feedstock \
    r-dasst-feedstock \
    r-dataframes2xls-feedstock \
    r-datarium-feedstock

build_all \
    r-datasaurus-feedstock \
    r-dataseries-feedstock \
    r-date-feedstock \
    r-datetime-feedstock \
    r-datetimeutils-feedstock \
    r-dblcens-feedstock \
    r-dcg-feedstock \
    r-dchipio-feedstock \
    r-sfsmisc-feedstock \
    r-ddm-feedstock \
    r-deal-feedstock \
    r-deamer-feedstock \
    r-decide-feedstock \
    r-decision-feedstock \
    r-decode-feedstock \
    r-decoder-feedstock

build_all \
    r-decon-feedstock \
    r-deconvolver-feedstock \
    r-deepnet-feedstock \
    r-default-feedstock \
    r-delaporte-feedstock \
    r-deldir-feedstock \
    r-delta-feedstock \
    r-demogr-feedstock \
    r-demokde-feedstock \
    r-dendroextras-feedstock \
    r-dendsort-feedstock \
    r-denoiseq-feedstock \
    r-denvax-feedstock \
    r-deoptim-feedstock \
    r-deoptimr-feedstock \
    r-deplogo-feedstock

build_all \
    r-depthtools-feedstock \
    r-dequer-feedstock \
    r-des-feedstock \
    r-descomponer-feedstock \
    r-describer-feedstock \
    r-designgg-feedstock \
    r-desir-feedstock \
    r-desirability-feedstock \
    r-desolve-feedstock \
    r-detpack-feedstock \
    r-devemf-feedstock \
    r-devoid-feedstock \
    r-devrate-feedstock \
    r-fs-feedstock \
    r-dfadjust-feedstock \
    r-dfcompare-feedstock

build_all \
    r-dfcrm-feedstock \
    r-dgof-feedstock \
    r-dhh-feedstock \
    r-diagonals-feedstock \
    r-diaplt-feedstock \
    r-dicedesign-feedstock \
    r-dicekriging-feedstock \
    r-dichromat-feedstock \
    r-dicionariosibge-feedstock \
    r-diffmeshgp-feedstock \
    r-digitalpcr-feedstock \
    r-dime-feedstock \
    r-dinamic-feedstock \
    r-dint-feedstock \
    r-diphiseq-feedstock \
    r-direct-feedstock

build_all \
    r-directstandardisation-feedstock \
    r-dirmult-feedstock \
    r-disclap-feedstock \
    r-discretelaplace-feedstock \
    r-discretemtp-feedstock \
    r-discriminer-feedstock \
    r-dispmod-feedstock \
    r-disposables-feedstock \
    r-dissutils-feedstock \
    r-distances-feedstock \
    r-distcrete-feedstock \
    r-distfree.cr-feedstock \
    r-distillery-feedstock \
    r-farver-feedstock \
    r-distributionutils-feedstock \
    r-disttools-feedstock

build_all \
    r-dixontest-feedstock \
    r-dkdna-feedstock \
    r-dlm-feedstock \
    r-dnaseqtest-feedstock \
    r-dne-feedstock \
    r-tmcn-feedstock \
    r-dobson-feedstock \
    r-microbenchmark-feedstock \
    r-docopt-feedstock \
    r-docopulae-feedstock \
    r-dodge-feedstock \
    r-doestrare-feedstock \
    r-doex-feedstock \
    r-domino-feedstock \
    r-snow-feedstock \
    r-dostats-feedstock

build_all \
    r-dotcall64-feedstock \
    r-dotenv-feedstock \
    r-doubcens-feedstock \
    r-double.truncation-feedstock \
    r-dovalidation-feedstock \
    r-brio-feedstock \
    r-evaluate-feedstock \
    r-fansi-feedstock \
    r-dplrcon-feedstock \
    r-dprint-feedstock \
    r-dragonking-feedstock \
    r-drat-feedstock \
    r-draw-feedstock \
    r-drmdel-feedstock \
    r-ds-feedstock \
    r-dsl-feedstock

build_all \
    r-dst-feedstock \
    r-dstat-feedstock \
    r-dtaxg-feedstock \
    r-dtda.ni-feedstock \
    r-dtk-feedstock \
    r-dtmcpack-feedstock \
    r-dtt-feedstock \
    r-proxy-feedstock \
    r-dub-feedstock \
    r-dummy-feedstock \
    r-dunn.test-feedstock \
    r-dwlm-feedstock \
    r-dykstra-feedstock \
    r-dym-feedstock \
    r-dynatree-feedstock \
    r-dynclust-feedstock

build_all \
    r-dynia-feedstock \
    r-easyahp-feedstock \
    r-easynls-feedstock \
    r-easypubmed-feedstock \
    r-easysvg-feedstock \
    r-ebal-feedstock \
    r-ebgenotyping-feedstock \
    r-ebrank-feedstock \
    r-ebsnp-feedstock \
    r-ecohydmod-feedstock \
    r-econdemand-feedstock \
    r-ecoreg-feedstock \
    r-ecosolver-feedstock \
    r-ecotoxicology-feedstock \
    r-ecovirtual-feedstock \
    r-edf-feedstock

build_all \
    r-edfreader-feedstock \
    r-edfun-feedstock \
    r-edgecorr-feedstock \
    r-eegkitdata-feedstock \
    r-effectsrelbaseline-feedstock \
    r-effecttreat-feedstock \
    r-efficientmaxeigenpair-feedstock \
    r-efflog-feedstock \
    r-effsize-feedstock \
    r-eigeninv-feedstock \
    r-eigenmodel-feedstock \
    r-eigenprcomp-feedstock \
    r-el-feedstock \
    r-elec-feedstock \
    r-elections-feedstock \
    r-electivity-feedstock

build_all \
    r-elexr-feedstock \
    r-elliplot-feedstock \
    r-elmr-feedstock \
    r-elmso-feedstock \
    r-fnn-feedstock \
    r-emdist-feedstock \
    r-moments-feedstock \
    r-estimability-feedstock \
    r-emmixmfa-feedstock \
    r-emmli-feedstock \
    r-emoa-feedstock \
    r-emov-feedstock \
    r-emplik2-feedstock \
    r-emsnm-feedstock \
    r-emt-feedstock \
    r-enc-feedstock

build_all \
    r-encode-feedstock \
    r-english-feedstock \
    r-enrichwith-feedstock \
    r-ensemblepp-feedstock \
    r-ensurer-feedstock \
    r-entropyestimation-feedstock \
    r-envdocument-feedstock \
    r-envipat-feedstock \
    r-envnames-feedstock \
    r-epandist-feedstock \
    r-epanet2toolkit-feedstock \
    r-epanetreader-feedstock \
    r-epibasix-feedstock \
    r-epicontacttrace-feedstock \
    r-laplacesdemon-feedstock \
    r-polspline-feedstock

build_all \
    r-episcan-feedstock \
    r-epitools-feedstock \
    r-eplot-feedstock \
    r-epsiwal-feedstock \
    r-eq5d-feedstock \
    r-ttutils-feedstock \
    r-equalcovs-feedstock \
    r-equalden.hd-feedstock \
    r-equate-feedstock \
    r-equivump-feedstock \
    r-ercv-feedstock \
    r-ergmharris-feedstock \
    r-rpanel-feedstock \
    r-err-feedstock \
    r-errors-feedstock \
    r-es.dif-feedstock

build_all \
    r-esc-feedstock \
    r-esdesign-feedstock \
    r-esg-feedstock \
    r-estout-feedstock \
    r-estsimpdmp-feedstock \
    r-etma-feedstock \
    r-etrunct-feedstock \
    r-europop-feedstock \
    r-evaluationmeasures-feedstock \
    r-evcombr-feedstock \
    r-evd-feedstock \
    r-eventdatar-feedstock \
    r-evir-feedstock \
    r-evorag-feedstock \
    r-ew-feedstock \
    r-rootsolve-feedstock

build_all \
    r-exactloglintest-feedstock \
    r-exactmeta-feedstock \
    r-exactranktests-feedstock \
    r-exams-feedstock \
    r-excel.link-feedstock \
    r-excessmass-feedstock \
    r-exprep-feedstock \
    r-exptest-feedstock \
    r-exteriormatch-feedstock \
    r-extlasso-feedstock \
    r-extmallows-feedstock \
    r-extrafontdb-feedstock \
    r-extremefit-feedstock \
    r-extweibquant-feedstock \
    r-ezglm-feedstock \
    r-factorsr-feedstock

build_all \
    r-fadist-feedstock \
    r-fahrmeir-feedstock \
    r-faisalconjoint-feedstock \
    r-falcon-feedstock \
    r-falconx-feedstock \
    r-fam.recrisk-feedstock \
    r-fancova-feedstock \
    r-fancycut-feedstock \
    r-fanplot-feedstock \
    r-faseg-feedstock \
    r-fasta-feedstock \
    r-fastcluster-feedstock \
    r-fastdigest-feedstock \
    r-fastgraph-feedstock \
    r-fastica-feedstock \
    r-fastmatch-feedstock

build_all \
    r-fastmatrix-feedstock \
    r-fastpseudo-feedstock \
    r-fastsom-feedstock \
    r-slam-feedstock \
    r-fasttime-feedstock \
    r-favnums-feedstock \
    r-gss-feedstock \
    r-spatial-feedstock \
    r-fcros-feedstock \
    r-fdakma-feedstock \
    r-fdrsampsize-feedstock \
    r-fdrtool-feedstock \
    r-featurizer-feedstock \
    r-fechner-feedstock \
    r-fermicatsr-feedstock \
    r-bit-feedstock

build_all \
    r-ffield-feedstock \
    r-ffmanova-feedstock \
    r-fftw-feedstock \
    r-fftwtools-feedstock \
    r-fgac-feedstock \
    r-fgalgorithm-feedstock \
    r-fgsg-feedstock \
    r-fgui-feedstock \
    r-fhdi-feedstock \
    r-fi-feedstock \
    r-maps-feedstock \
    r-filehash-feedstock \
    r-filelock-feedstock \
    r-filematrix-feedstock \
    r-filenamer-feedstock \
    r-files-feedstock

build_all \
    r-fillr-feedstock \
    r-finana-feedstock \
    r-financialmath-feedstock \
    r-finasym-feedstock \
    r-findallroots-feedstock \
    r-finepop-feedstock \
    r-fingerprint-feedstock \
    r-fishdata-feedstock \
    r-fishkirkko2015-feedstock \
    r-fishmod-feedstock \
    r-fitsio-feedstock \
    r-fittetra-feedstock \
    r-fivethirtyeight-feedstock \
    r-fixedtimeevents-feedstock \
    r-fixseqmtp-feedstock \
    r-fizzbuzzr-feedstock

build_all \
    r-flagr-feedstock \
    r-flashclust-feedstock \
    r-flexdir-feedstock \
    r-flexmet-feedstock \
    r-somemtp-feedstock \
    r-float-feedstock \
    r-flower-feedstock \
    r-flowfield-feedstock \
    r-flsa-feedstock \
    r-fluosurv-feedstock \
    r-fluxweb-feedstock \
    r-fmp-feedstock \
    r-fmsb-feedstock \
    r-fmstable-feedstock \
    r-folderfun-feedstock \
    r-fontbitstreamvera-feedstock

build_all \
    r-fontcm-feedstock \
    r-fontliberation-feedstock \
    r-fracdiff-feedstock \
    r-pracma-feedstock \
    r-foresthes-feedstock \
    r-forit-feedstock \
    r-formatr-feedstock \
    r-operator.tools-feedstock \
    r-fortunes-feedstock \
    r-forwards-feedstock \
    r-fourgametep-feedstock \
    r-fourscores-feedstock \
    r-fpca3d-feedstock \
    r-fpcompare-feedstock \
    r-fpest-feedstock \
    r-fpop-feedstock

build_all \
    r-fpow-feedstock \
    r-fptdapprox-feedstock \
    r-fractalparameterestimation-feedstock \
    r-fraction-feedstock \
    r-fragman-feedstock \
    r-frapplot-feedstock \
    r-frbs-feedstock \
    r-freq-feedstock \
    r-freqdist-feedstock \
    r-frm-feedstock \
    r-frmhet-feedstock \
    r-frmpd-feedstock \
    r-fsadata-feedstock \
    r-fsia-feedstock \
    r-fstability-feedstock \
    r-fsthet-feedstock

build_all \
    r-fueleconomy-feedstock \
    r-fugue-feedstock \
    r-fun-feedstock \
    r-funique-feedstock \
    r-funr-feedstock \
    r-funta-feedstock \
    r-fusionlearn-feedstock \
    r-futile.options-feedstock \
    r-futility-feedstock \
    r-listenv-feedstock \
    r-fuzzynumbers-feedstock \
    r-fuzzyranktests-feedstock \
    r-modeva-feedstock \
    r-fuzzystattra-feedstock \
    r-fwi.fbp-feedstock \
    r-g.data-feedstock

build_all \
    r-r.methodss3-feedstock \
    r-gadifpt-feedstock \
    r-gafit-feedstock \
    r-gains-feedstock \
    r-gaipe-feedstock \
    r-gamair-feedstock \
    r-gamlss.data-feedstock \
    r-ganpadata-feedstock \
    r-gap.datasets-feedstock \
    r-garray-feedstock \
    r-gatepoints-feedstock \
    r-gausscov-feedstock \
    r-gaussdiff-feedstock \
    r-gaussfacts-feedstock \
    r-gbrd-feedstock \
    r-gcai.bias-feedstock

build_all \
    r-gcat-feedstock \
    r-gcookbook-feedstock \
    r-gdadata-feedstock \
    r-gds-feedstock \
    r-gee-feedstock \
    r-geigen-feedstock \
    r-gelnet-feedstock \
    r-genalg-feedstock \
    r-genbinomapps-feedstock \
    r-gendata-feedstock \
    r-gendist-feedstock \
    r-genef-feedstock \
    r-genepi-feedstock \
    r-generator-feedstock \
    r-geneticsubsetter-feedstock \
    r-gensa-feedstock

build_all \
    r-gensurv-feedstock \
    r-gensvm-feedstock \
    r-gentag-feedstock \
    r-geoboxplot-feedstock \
    r-geodist-feedstock \
    r-geohashtools-feedstock \
    r-rapidjsonr-feedstock \
    r-geomapdata-feedstock \
    r-geoscale-feedstock \
    r-geosed-feedstock \
    r-geotools-feedstock \
    r-gesca-feedstock \
    r-getopt-feedstock \
    r-gettz-feedstock \
    r-gevcdn-feedstock \
    r-gfa-feedstock

build_all \
    r-gglasso-feedstock \
    r-ggplot2movies-feedstock \
    r-polynom-feedstock \
    r-ggroups-feedstock \
    r-ggversa-feedstock \
    r-gitcreds-feedstock \
    r-gibbs.met-feedstock \
    r-gifski-feedstock \
    r-gigrvg-feedstock \
    r-gillespiessa-feedstock \
    r-giniwegneg-feedstock \
    r-gipfrm-feedstock \
    r-git2r-feedstock \
    r-gk2011-feedstock \
    r-glasso-feedstock \
    r-glassofast-feedstock

build_all \
    r-glba-feedstock \
    r-gldrm-feedstock \
    r-glinternet-feedstock \
    r-gllm-feedstock \
    r-glm2-feedstock \
    r-glmlep-feedstock \
    r-glmmml-feedstock \
    r-glmsdata-feedstock \
    r-globalopttests-feedstock \
    r-globe-feedstock \
    r-glpkapi-feedstock \
    r-glrth-feedstock \
    r-gmac-feedstock \
    r-gmdhreg-feedstock \
    r-gmfd-feedstock \
    r-gmt-feedstock

build_all \
    r-gnorm-feedstock \
    r-goftest-feedstock \
    r-gomms-feedstock \
    r-govstatjpn-feedstock \
    r-gower-feedstock \
    r-gparotation-feedstock \
    r-gpclib-feedstock \
    r-gpdtest-feedstock \
    r-gpk-feedstock \
    r-grade-feedstock \
    r-gramevol-feedstock \
    r-grape-feedstock \
    r-grapher-feedstock \
    r-greenclust-feedstock \
    r-pbmcapply-feedstock \
    r-grex-feedstock

build_all \
    r-gridbase-feedstock \
    r-gridbezier-feedstock \
    r-gridgraphics-feedstock \
    r-grnn-feedstock \
    r-groupremmap-feedstock \
    r-tcltk2-feedstock \
    r-groupsubsetselection-feedstock \
    r-grouptest-feedstock \
    r-growthmodels-feedstock \
    r-grplasso-feedstock \
    r-grr-feedstock \
    r-grs.test-feedstock \
    r-gsa-feedstock \
    r-gsafishercombined-feedstock \
    r-gsalib-feedstock \
    r-gsaq-feedstock

build_all \
    r-gseg-feedstock \
    r-gsloid-feedstock \
    r-gsmoothr-feedstock \
    r-gstream-feedstock \
    r-proto-feedstock \
    r-gsw-feedstock \
    r-gt4ireval-feedstock \
    r-gtwas-feedstock \
    r-gumbel-feedstock \
    r-gvlma-feedstock \
    r-gwasexacthw-feedstock \
    r-gwrpvr-feedstock \
    r-gwsignif-feedstock \
    r-hamlet-feedstock \
    r-handtill2001-feedstock \
    r-handyplots-feedstock

build_all \
    r-hapassoc-feedstock \
    r-haplosim-feedstock \
    r-haplotyper-feedstock \
    r-happytime-feedstock \
    r-hash-feedstock \
    r-hashids-feedstock \
    r-hashr-feedstock \
    r-hazer-feedstock \
    r-hbmem-feedstock \
    r-hcandersenr-feedstock \
    r-hcc-feedstock \
    r-hcci-feedstock \
    r-hcp-feedstock \
    r-hdcpdetect-feedstock \
    r-hddesign-feedstock \
    r-hdfqlr-feedstock

build_all \
    r-hdglm-feedstock \
    r-hdinterval-feedstock \
    r-hdtweedie-feedstock \
    r-heatex-feedstock \
    r-heatmapfit-feedstock \
    r-hellno-feedstock \
    r-hexview-feedstock \
    r-hflights-feedstock \
    r-hgnchelper-feedstock \
    r-hgsl-feedstock \
    r-hi-feedstock \
    r-hicseg-feedstock \
    r-hiddenf-feedstock \
    r-hiddenmarkov-feedstock \
    r-hidimda-feedstock \
    r-hiernet-feedstock

build_all \
    r-highlight-feedstock \
    r-highlighthtml-feedstock \
    r-highttest-feedstock \
    r-hindexcalculator-feedstock \
    r-hint-feedstock \
    r-histdata-feedstock \
    r-histmdl-feedstock \
    r-histogram-feedstock \
    r-historydata-feedstock \
    r-hiv.lifetables-feedstock \
    r-hk80-feedstock \
    r-hmeasure-feedstock \
    r-hmm-feedstock \
    r-hmmcont-feedstock \
    r-hmmpa-feedstock \
    r-hmr-feedstock

build_all \
    r-holdem-feedstock \
    r-homer-feedstock \
    r-homeric-feedstock \
    r-sodium-feedstock \
    r-hornpa-feedstock \
    r-horseshoe-feedstock \
    r-hotspot-feedstock \
    r-housingdata-feedstock \
    r-howmany-feedstock \
    r-hqmisc-feedstock \
    r-hqreg-feedstock \
    r-hsaur-feedstock \
    r-hsaur2-feedstock \
    r-hsaur3-feedstock \
    r-htm2txt-feedstock \
    r-htree-feedstock

build_all \
    r-httprequest-feedstock \
    r-humidity-feedstock \
    r-hurdlr-feedstock \
    r-hw.pval-feedstock \
    r-hwde-feedstock \
    r-hweintrinsic-feedstock \
    r-hwriter-feedstock \
    r-hydra-feedstock \
    r-hydrogeo-feedstock \
    r-hydrostats-feedstock \
    r-hyperbolicdist-feedstock \
    r-hypergate-feedstock \
    r-hypersampleplan-feedstock \
    r-iasd-feedstock \
    r-iatanalytics-feedstock \
    r-iatscore-feedstock

build_all \
    r-ibdlabels-feedstock \
    r-ibdreg-feedstock \
    r-ibelief-feedstock \
    r-ic10trainingdata-feedstock \
    r-ica-feedstock \
    r-icaff-feedstock \
    r-icapca-feedstock \
    r-icarus-feedstock \
    r-icc-feedstock \
    r-icc.sample.size-feedstock \
    r-iccbin-feedstock \
    r-icd.data-feedstock \
    r-mlecens-feedstock \
    r-icesadvice-feedstock \
    r-icesdatras-feedstock \
    r-icsw-feedstock

build_all \
    r-icv-feedstock \
    r-idbg-feedstock \
    r-idetect-feedstock \
    r-idr-feedstock \
    r-idx2r-feedstock \
    r-ieeeround-feedstock \
    r-iemiscdata-feedstock \
    r-iemisctext-feedstock \
    r-ifctools-feedstock \
    r-ifs-feedstock \
    r-ig.vancouver.2014.topcolour-feedstock \
    r-pkgconfig-feedstock \
    r-igraphdata-feedstock \
    r-igsea-feedstock \
    r-impact-feedstock \
    r-impimp-feedstock

build_all \
    r-import-feedstock \
    r-importar-feedstock \
    r-stinepack-feedstock \
    r-imrmc-feedstock \
    r-indexnumr-feedstock \
    r-indiantaxcalc-feedstock \
    r-indtestpp-feedstock \
    r-ineq-feedstock \
    r-inflection-feedstock \
    r-infotheo-feedstock \
    r-injector-feedstock \
    r-insight-feedstock \
    r-insurancedata-feedstock \
    r-integratebs-feedstock \
    r-interact-feedstock \
    r-interactiontest-feedstock

build_all \
    r-interim-feedstock \
    r-interva4-feedstock \
    r-intervals-feedstock \
    r-intervcomp-feedstock \
    r-interventionaldbn-feedstock \
    r-intreggof-feedstock \
    r-intrval-feedstock \
    r-invgamma-feedstock \
    r-invlt-feedstock \
    r-iosmooth-feedstock \
    r-iotools-feedstock \
    r-ipfp-feedstock \
    r-ippp-feedstock \
    r-iqlearn-feedstock \
    r-ircor-feedstock \
    r-irepro-feedstock

build_all \
    r-isco08conversions-feedstock \
    r-isdals-feedstock \
    r-isinglenzmc-feedstock \
    r-isnullptr-feedstock \
    r-iso-feedstock \
    r-isocodes-feedstock \
    r-isopat-feedstock \
    r-iswr-feedstock \
    r-italy-feedstock \
    r-itsmr-feedstock \
    r-jacpop-feedstock \
    r-janeaustenr-feedstock \
    r-jcp-feedstock \
    r-renv-feedstock \
    r-jiebard-feedstock \
    r-jjb-feedstock

build_all \
    r-jmdesign-feedstock \
    r-jmetrik-feedstock \
    r-jmisc-feedstock \
    r-jmuoutlier-feedstock \
    r-johnson-feedstock \
    r-jointdiag-feedstock \
    r-jointnmix-feedstock \
    r-jrf-feedstock \
    r-jrvfinance-feedstock \
    r-jtrans-feedstock \
    r-julia-feedstock \
    r-jvcoords-feedstock \
    r-jvnvar-feedstock \
    r-kader-feedstock \
    r-kaphom-feedstock \
    r-kappasize-feedstock

build_all \
    r-kdist-feedstock \
    r-keep-feedstock \
    r-kendl-feedstock \
    r-zeallot-feedstock \
    r-kere-feedstock \
    r-kerndwd-feedstock \
    r-keypress-feedstock \
    r-kfas-feedstock \
    r-kfksds-feedstock \
    r-kidney.epi-feedstock \
    r-kmda-feedstock \
    r-kmodr-feedstock \
    r-kmsurv-feedstock \
    r-knotr-feedstock \
    r-kpeaks-feedstock \
    r-kpodclustr-feedstock

build_all \
    r-kriens-feedstock \
    r-kriging-feedstock \
    r-krls-feedstock \
    r-suppdists-feedstock \
    r-kselection-feedstock \
    r-kstatistics-feedstock \
    r-kuiper.2samp-feedstock \
    r-kyotil-feedstock \
    r-kza-feedstock \
    r-labelvector-feedstock \
    r-labstatr-feedstock \
    r-labstats-feedstock \
    r-lagged-feedstock \
    r-lagsequential-feedstock \
    r-lamme-feedstock \
    r-languager-feedstock

build_all \
    r-largelist-feedstock \
    r-lasso2-feedstock \
    r-lassoshooting-feedstock \
    r-latexpdf-feedstock \
    r-latticedesign-feedstock \
    r-squarem-feedstock \
    r-pbivnorm-feedstock \
    r-lazy-feedstock \
    r-lazydata-feedstock \
    r-lca-feedstock \
    r-lcfdata-feedstock \
    r-lcmcr-feedstock \
    r-lda-feedstock \
    r-ldbounds-feedstock \
    r-ldcorsv-feedstock \
    r-ldrtools-feedstock

build_all \
    r-leadercluster-feedstock \
    r-leafarea-feedstock \
    r-leaflet.providers-feedstock \
    r-leafstar-feedstock \
    r-leap-feedstock \
    r-learnbayes-feedstock \
    r-learngeom-feedstock \
    r-learnn-feedstock \
    r-learnrbook-feedstock \
    r-legocolors-feedstock \
    r-leiv-feedstock \
    r-lero.lero-feedstock \
    r-lest-feedstock \
    r-lexiconpt-feedstock \
    r-snowballc-feedstock \
    r-lfactors-feedstock

build_all \
    r-lfdr.mle-feedstock \
    r-lgrdata-feedstock \
    r-lgtdl-feedstock \
    r-lhmixr-feedstock \
    r-liblinear-feedstock \
    r-liblinear.acf-feedstock \
    r-librarysnapshot-feedstock \
    r-libsoc-feedstock \
    r-lift-feedstock \
    r-rjsonio-feedstock \
    r-linbin-feedstock \
    r-lincal-feedstock \
    r-linearregressionmde-feedstock \
    r-linkim-feedstock \
    r-lintools-feedstock \
    r-xmlparsedata-feedstock

build_all \
    r-lisreltor-feedstock \
    r-listarrays-feedstock \
    r-listest-feedstock \
    r-littler-feedstock \
    r-liureg-feedstock \
    r-ljr-feedstock \
    r-llogistic-feedstock \
    r-lm.beta-feedstock \
    r-lmenbbayes-feedstock \
    r-lmf-feedstock \
    r-lmm-feedstock \
    r-lmodel2-feedstock \
    r-lmom-feedstock \
    r-lmperm-feedstock \
    r-lmridge-feedstock \
    r-lmsubsets-feedstock

build_all \
    r-scatterplot3d-feedstock \
    r-loadr-feedstock \
    r-localsolver-feedstock \
    r-locfdr-feedstock \
    r-lock5data-feedstock \
    r-lock5withr-feedstock \
    r-locpol-feedstock \
    r-loder-feedstock \
    r-log4r-feedstock \
    r-logconcens-feedstock \
    r-logger-feedstock \
    r-logging-feedstock \
    r-logitnorm-feedstock \
    r-loglognorm-feedstock \
    r-lognormreg-feedstock \
    r-logofgamma-feedstock

build_all \
    r-logranka-feedstock \
    r-logspline-feedstock \
    r-longcateda-feedstock \
    r-misc3d-feedstock \
    r-longmemo-feedstock \
    r-loon.data-feedstock \
    r-lorec-feedstock \
    r-lotkaslaw-feedstock \
    r-lowrankqp-feedstock \
    r-lpc-feedstock \
    r-lpcm-feedstock \
    r-lpint-feedstock \
    r-lpridge-feedstock \
    r-lps-feedstock \
    r-lpsolveapi-feedstock \
    r-nleqslv-feedstock

build_all \
    r-lrequire-feedstock \
    r-lrth-feedstock \
    r-lsd-feedstock \
    r-lsdv-feedstock \
    r-lsei-feedstock \
    r-lshorth-feedstock \
    r-lspline-feedstock \
    r-lsplsglm-feedstock \
    r-lsr-feedstock \
    r-lsrs-feedstock \
    r-ltpdvar-feedstock \
    r-ltsa-feedstock \
    r-ltxsparklines-feedstock \
    r-lunar-feedstock \
    r-lxb-feedstock \
    r-lzerospikeinference-feedstock

build_all \
    r-mad-feedstock \
    r-maddison-feedstock \
    r-madr-feedstock \
    r-madsim-feedstock \
    r-magicfor-feedstock \
    r-magree-feedstock \
    r-mail-feedstock \
    r-makeproject-feedstock \
    r-maldiquant-feedstock \
    r-mancie-feedstock \
    r-mangrove-feedstock \
    r-manipulate-feedstock \
    r-manlymix-feedstock \
    r-manytests-feedstock \
    r-mapplots-feedstock \
    r-march-feedstock

build_all \
    r-mareymap-feedstock \
    r-marima-feedstock \
    r-masae-feedstock \
    r-massign-feedstock \
    r-masstimate-feedstock \
    r-mata-feedstock \
    r-matchbook-feedstock \
    r-matconv-feedstock \
    r-matmanlymix-feedstock \
    r-matpow-feedstock \
    r-matrixcalc-feedstock \
    r-matrixeqtl-feedstock \
    r-matrixstructest-feedstock \
    r-matskew-feedstock \
    r-maxskew-feedstock \
    r-mbcluster.seq-feedstock

build_all \
    r-mbi-feedstock \
    r-mblm-feedstock \
    r-mbvs-feedstock \
    r-mcbiopi-feedstock \
    r-mcc-feedstock \
    r-mccr-feedstock \
    r-mchtest-feedstock \
    r-mci-feedstock \
    r-mcmc-feedstock \
    r-mco-feedstock \
    r-mcr-feedstock \
    r-mcs-feedstock \
    r-mctest-feedstock \
    r-mctm-feedstock \
    r-md-feedstock \
    r-mded-feedstock

build_all \
    r-mdfs-feedstock \
    r-mdimnormn-feedstock \
    r-meanr-feedstock \
    r-meanshiftr-feedstock \
    r-measurements-feedstock \
    r-measures-feedstock \
    r-med-feedstock \
    r-meddietcalc-feedstock \
    r-medicare-feedstock \
    r-meditations-feedstock \
    r-mefa-feedstock \
    r-memuse-feedstock \
    r-merror-feedstock \
    r-metabel-feedstock \
    r-metaheuristicopt-feedstock \
    r-metalik-feedstock

build_all \
    r-metansue-feedstock \
    r-metarnaseq-feedstock \
    r-metasubtract-feedstock \
    r-metatest-feedstock \
    r-metnorm-feedstock \
    r-metrics-feedstock \
    r-metricsweighted-feedstock \
    r-mewavg-feedstock \
    r-mfag-feedstock \
    r-mfilter-feedstock \
    r-mft-feedstock \
    r-mgl-feedstock \
    r-mglm-feedstock \
    r-mgsub-feedstock \
    r-mhg-feedstock \
    r-mhtdiscrete-feedstock

build_all \
    r-mhtmult-feedstock \
    r-micompr-feedstock \
    r-microbats-feedstock \
    r-micromacromultilevel-feedstock \
    r-labeling-feedstock \
    r-midastouch-feedstock \
    r-milc-feedstock \
    r-mindonstats-feedstock \
    r-miney-feedstock \
    r-minigui-feedstock \
    r-minimalrsd-feedstock \
    r-minimap-feedstock \
    r-minimax-feedstock \
    r-minirand-feedstock \
    r-minpack.lm-feedstock \
    r-minval-feedstock

build_all \
    r-mirsea-feedstock \
    r-norm-feedstock \
    r-miscor-feedstock \
    r-mise-feedstock \
    r-mistat-feedstock \
    r-mix-feedstock \
    r-mixdist-feedstock \
    r-mixemm-feedstock \
    r-mixmeta-feedstock \
    r-mixrasch-feedstock \
    r-mixraschtools-feedstock \
    r-mixreg-feedstock \
    r-mixtnb-feedstock \
    r-mixtureregltic-feedstock \
    r-mize-feedstock \
    r-mkle-feedstock

build_all \
    r-mkssd-feedstock \
    r-mlbench-feedstock \
    r-mlbstats-feedstock \
    r-mlcm-feedstock \
    r-mldr.datasets-feedstock \
    r-mle.tools-feedstock \
    r-mlegp-feedstock \
    r-mlf-feedstock \
    r-mlml2r-feedstock \
    r-mlmmm-feedstock \
    r-mlpugs-feedstock \
    r-mlsjunkgen-feedstock \
    r-mltest-feedstock \
    r-mmac-feedstock \
    r-mmap-feedstock \
    r-mmeln-feedstock

build_all \
    r-mmpa-feedstock \
    r-mmpp-feedstock \
    r-mmtsne-feedstock \
    r-mmwrweek-feedstock \
    r-tmvnsim-feedstock \
    r-moc-feedstock \
    r-mod-feedstock \
    r-mod09nrt-feedstock \
    r-modehunt-feedstock \
    r-modelobj-feedstock \
    r-modelwordcloud-feedstock \
    r-modmarg-feedstock \
    r-modturpoint-feedstock \
    r-modules-feedstock \
    r-modygliani-feedstock \
    r-mole-feedstock

build_all \
    r-momentchi2-feedstock \
    r-mondate-feedstock \
    r-monoreg-feedstock \
    r-monreg-feedstock \
    r-monte.carlo.se-feedstock \
    r-mopsocd-feedstock \
    r-morder-feedstock \
    r-morgenstemning-feedstock \
    r-mosaicdata-feedstock \
    r-most-feedstock \
    r-mpci-feedstock \
    r-mpdir-feedstock \
    r-mpkn-feedstock \
    r-mpn-feedstock \
    r-mppa-feedstock \
    r-mps-feedstock

build_all \
    r-mpsychor-feedstock \
    r-mpt-feedstock \
    r-mra-feedstock \
    r-survpresmooth-feedstock \
    r-mreg-feedstock \
    r-mrfse-feedstock \
    r-mri-feedstock \
    r-mrqol-feedstock \
    r-mrtsamplesize-feedstock \
    r-ms.sev-feedstock \
    r-msaface-feedstock \
    r-msbp-feedstock \
    r-msglasso-feedstock \
    r-msgpackr-feedstock \
    r-msgps-feedstock \
    r-msma-feedstock

build_all \
    r-msmwra-feedstock \
    r-mstr-feedstock \
    r-mtdrh-feedstock \
    r-mthapower-feedstock \
    r-mtsys-feedstock \
    r-muckrock-feedstock \
    r-muerelativerisk-feedstock \
    r-multcompview-feedstock \
    r-multeq-feedstock \
    r-multfisher-feedstock \
    r-multiband-feedstock \
    r-multicnvdetect-feedstock \
    r-multicoll-feedstock \
    r-multifwf-feedstock \
    r-multijoin-feedstock \
    r-multinomialci-feedstock

build_all \
    r-multiplex-feedstock \
    r-multirdpg-feedstock \
    r-multirich-feedstock \
    r-multirng-feedstock \
    r-multirobust-feedstock \
    r-multispatialccm-feedstock \
    r-multitaper-feedstock \
    r-multiwave-feedstock \
    r-murphydiagram-feedstock \
    r-mus-feedstock \
    r-mustat-feedstock \
    r-mvbutils-feedstock \
    r-mvisage-feedstock \
    r-mvnggrad-feedstock \
    r-mvnormtest-feedstock \
    r-mvnpermute-feedstock

build_all \
    r-mvrtn-feedstock \
    r-mvshapirotest-feedstock \
    r-mwlasso-feedstock \
    r-mxkssd-feedstock \
    r-mycobacrvr-feedstock \
    r-na.tools-feedstock \
    r-naepprimer-feedstock \
    r-naivebayes-feedstock \
    r-namedcapture-feedstock \
    r-nameneedle-feedstock \
    r-namespace-feedstock \
    r-nasaweather-feedstock \
    r-nat.utils-feedstock \
    r-naturalsort-feedstock \
    r-nb-feedstock \
    r-nbclust-feedstock

build_all \
    r-nbconvertr-feedstock \
    r-nbddirichlet-feedstock \
    r-ncbit-feedstock \
    r-ncdf4-feedstock \
    r-ncdunnett-feedstock \
    r-ncf-feedstock \
    r-proftools-feedstock \
    r-ncvreg-feedstock \
    r-neariso-feedstock \
    r-needs-feedstock \
    r-needy-feedstock \
    r-negenes-feedstock \
    r-neighbr-feedstock \
    r-nephro-feedstock \
    r-netsimr-feedstock \
    r-netweaver-feedstock

build_all \
    r-neuroblastoma-feedstock \
    r-newtestsurvrec-feedstock \
    r-nfca-feedstock \
    r-nfwdist-feedstock \
    r-ngram-feedstock \
    r-nhanes-feedstock \
    r-nhldata-feedstock \
    r-nice-feedstock \
    r-nicherover-feedstock \
    r-nilde-feedstock \
    r-nipals-feedstock \
    r-nistnls-feedstock \
    r-nistunits-feedstock \
    r-nlmrt-feedstock \
    r-nlroot-feedstock \
    r-nlsmsn-feedstock

build_all \
    r-nlstools-feedstock \
    r-testit-feedstock \
    r-nlwaldtest-feedstock \
    r-nmainla-feedstock \
    r-nmfn-feedstock \
    r-nmi-feedstock \
    r-nmof-feedstock \
    r-nna-feedstock \
    r-nnlasso-feedstock \
    r-noia-feedstock \
    r-noncompart-feedstock \
    r-nonpar-feedstock \
    r-nonpareil-feedstock \
    r-nor1mix-feedstock \
    r-nordklimdata1-feedstock \
    r-norm2-feedstock

build_all \
    r-normalp-feedstock \
    r-normexpression-feedstock \
    r-normtest-feedstock \
    r-nortest-feedstock \
    r-nose-feedstock \
    r-not-feedstock \
    r-noweb-feedstock \
    r-nozzle.r1-feedstock \
    r-npcoptest-feedstock \
    r-npcp-feedstock \
    r-npexact-feedstock \
    r-nplplot-feedstock \
    r-nplr-feedstock \
    r-npmlda-feedstock \
    r-npmlecmprsk-feedstock \
    r-npmr-feedstock

build_all \
    r-npordtests-feedstock \
    r-npp-feedstock \
    r-nppbib-feedstock \
    r-npreg-feedstock \
    r-nps-feedstock \
    r-npst-feedstock \
    r-nptest-feedstock \
    r-nscancor-feedstock \
    r-nscluster-feedstock \
    r-nseval-feedstock \
    r-nsprcomp-feedstock \
    r-nsrfa-feedstock \
    r-numbers-feedstock \
    r-numgen-feedstock \
    r-numosl-feedstock \
    r-nzelect-feedstock

build_all \
    r-nzpullover-feedstock \
    r-oaqc-feedstock \
    r-oarray-feedstock \
    r-objectsignals-feedstock \
    r-obmbpkg-feedstock \
    r-obs.agree-feedstock \
    r-obsmd-feedstock \
    r-obssens-feedstock \
    r-oca-feedstock \
    r-occ-feedstock \
    r-ocedata-feedstock \
    r-ocp-feedstock \
    r-odds.converter-feedstock \
    r-odr-feedstock \
    r-ohit-feedstock \
    r-omd-feedstock

build_all \
    r-onage-feedstock \
    r-onehot-feedstock \
    r-oner-feedstock \
    r-onetwosamples-feedstock \
    r-ontologyindex-feedstock \
    r-oompadata-feedstock \
    r-oor-feedstock \
    r-opencl-feedstock \
    r-piper-feedstock \
    r-operators-feedstock \
    r-opi-feedstock \
    r-opportunistic-feedstock \
    r-optgs-feedstock \
    r-opthedging-feedstock \
    r-optifunset-feedstock \
    r-optimalcutpoints-feedstock

build_all \
    r-optimparallel-feedstock \
    r-optionpricing-feedstock \
    r-optionstrat-feedstock \
    r-optr-feedstock \
    r-orca-feedstock \
    r-orclus-feedstock \
    r-ordering-feedstock \
    r-orderstats-feedstock \
    r-ordinalnet-feedstock \
    r-ordmonreg-feedstock \
    r-ore-feedstock \
    r-orgmassspecr-feedstock \
    r-oriclust-feedstock \
    r-orientlib-feedstock \
    r-ormdr-feedstock \
    r-orthogonalsplinebasis-feedstock

build_all \
    r-oscillatorgenerator-feedstock \
    r-osdesign-feedstock \
    r-osdr-feedstock \
    r-oshka-feedstock \
    r-otutable-feedstock \
    r-outbreaks-feedstock \
    r-outliers-feedstock \
    r-overlap-feedstock \
    r-oxybs-feedstock \
    r-oz-feedstock \
    r-pabonlasso-feedstock \
    r-pack-feedstock \
    r-pade-feedstock \
    r-pagenum-feedstock \
    r-painter-feedstock \
    r-paintmap-feedstock

build_all \
    r-pairwise-feedstock \
    r-paleomorph-feedstock \
    r-palettesforr-feedstock \
    r-palettetown-feedstock \
    r-palr-feedstock \
    r-pan-feedstock \
    r-paneldata-feedstock \
    r-paperplanes-feedstock \
    r-parade-feedstock \
    r-parallelpc-feedstock \
    r-parmigene-feedstock \
    r-partiallyoverlapping-feedstock \
    r-partitionbefsp-feedstock \
    r-partitionmetric-feedstock \
    r-partsm-feedstock \
    r-pass.lme-feedstock

build_all \
    r-passport-feedstock \
    r-password-feedstock \
    r-patchdvi-feedstock \
    r-pathmapping-feedstock \
    r-pbibd-feedstock \
    r-pbm-feedstock \
    r-pbrackets-feedstock \
    r-pbrf-feedstock \
    r-pbs-feedstock \
    r-pbsddesolve-feedstock \
    r-pbsmapping-feedstock \
    r-pcal1-feedstock \
    r-pcamixdata-feedstock \
    r-pcensmix-feedstock \
    r-pcfam-feedstock \
    r-pcg-feedstock

build_all \
    r-pcict-feedstock \
    r-pco-feedstock \
    r-pcse-feedstock \
    r-pcsinr-feedstock \
    r-pdc-feedstock \
    r-pdfestimator-feedstock \
    r-pdist-feedstock \
    r-pdsce-feedstock \
    r-peacock.test-feedstock \
    r-peacots-feedstock \
    r-peakerror-feedstock \
    r-peakram-feedstock \
    r-peaksegdp-feedstock \
    r-pearson7-feedstock \
    r-pearsonds-feedstock \
    r-pearsonica-feedstock

build_all \
    r-pegrouptesting-feedstock \
    r-pemm-feedstock \
    r-perc-feedstock \
    r-periodictable-feedstock \
    r-perm-feedstock \
    r-permalgo-feedstock \
    r-permute-feedstock \
    r-persiandictionary-feedstock \
    r-persianstemmer-feedstock \
    r-pesel-feedstock \
    r-petitr-feedstock \
    r-pgam-feedstock \
    r-pgm2-feedstock \
    r-pgmm-feedstock \
    r-pgnorm-feedstock \
    r-phidelta-feedstock

build_all \
    r-phonenumber-feedstock \
    r-phontools-feedstock \
    r-phreeqc-feedstock \
    r-phuassess-feedstock \
    r-phylin-feedstock \
    r-phylogr-feedstock \
    r-phylotate-feedstock \
    r-phyreg-feedstock \
    r-physicalactivity-feedstock \
    r-pinfsc50-feedstock \
    r-pinochet-feedstock \
    r-pipegs-feedstock \
    r-pipeliner-feedstock \
    r-pips-feedstock \
    r-pk-feedstock \
    r-prettyunits-feedstock

build_all \
    r-ps-feedstock \
    r-pkgkitten-feedstock \
    r-registry-feedstock \
    r-pkmon-feedstock \
    r-pkpdmodels-feedstock \
    r-pksea-feedstock \
    r-plan-feedstock \
    r-planesmuestra-feedstock \
    r-planets-feedstock \
    r-plantecophys-feedstock \
    r-playerratings-feedstock \
    r-plde-feedstock \
    r-pln-feedstock \
    r-plot.matrix-feedstock \
    r-plotfunctions-feedstock \
    r-plotlygeoassets-feedstock

build_all \
    r-plotpc-feedstock \
    r-plotscale-feedstock \
    r-plotwidgets-feedstock \
    r-plrmodels-feedstock \
    r-plsdepot-feedstock \
    r-plugdensity-feedstock \
    r-swagger-feedstock \
    r-pmcmr-feedstock \
    r-pmmltransformations-feedstock \
    r-pmr-feedstock \
    r-pmsampsize-feedstock \
    r-pod-feedstock \
    r-poet-feedstock \
    r-poibin-feedstock \
    r-poiclaclu-feedstock \
    r-poilog-feedstock

build_all \
    r-poisson-feedstock \
    r-poisson.glm.mix-feedstock \
    r-poissonpca-feedstock \
    r-poistweedie-feedstock \
    r-poker-feedstock \
    r-polyaaeppli-feedstock \
    r-polyclip-feedstock \
    r-polytrend-feedstock \
    r-pomdpsolve-feedstock \
    r-pomic-feedstock \
    r-pooh-feedstock \
    r-pooledmeangroup-feedstock \
    r-popbio-feedstock \
    r-posi-feedstock \
    r-tensora-feedstock \
    r-postinfectious-feedstock

build_all \
    r-postlogic-feedstock \
    r-pot-feedstock \
    r-potts-feedstock \
    r-rmutil-feedstock \
    r-powermediation-feedstock \
    r-powernormal-feedstock \
    r-powerpkg-feedstock \
    r-powerupr-feedstock \
    r-pp3-feedstock \
    r-ppcc-feedstock \
    r-pps-feedstock \
    r-practools-feedstock \
    r-praznik-feedstock \
    r-precisesums-feedstock \
    r-predictiveregression-feedstock \
    r-presenceabsence-feedstock

build_all \
    r-prettyb-feedstock \
    r-prettygraphs-feedstock \
    r-prettyr-feedstock \
    r-primefactr-feedstock \
    r-prinsimp-feedstock \
    r-prithulib-feedstock \
    r-privatelr-feedstock \
    r-prnsamplr-feedstock \
    r-pro-feedstock \
    r-proccalibrad-feedstock \
    r-profmem-feedstock \
    r-proj-feedstock \
    r-proj4-feedstock \
    r-proliferativeindex-feedstock \
    r-propcis-feedstock \
    r-properties-feedstock

build_all \
    r-propscrrand-feedstock \
    r-proscorertools-feedstock \
    r-protoclust-feedstock \
    r-protr-feedstock \
    r-provviz-feedstock \
    r-prroc-feedstock \
    r-prsr-feedstock \
    r-pso-feedstock \
    r-psoptim-feedstock \
    r-pspearman-feedstock \
    r-pstat-feedstock \
    r-psy-feedstock \
    r-psychotools-feedstock \
    r-psyphy-feedstock \
    r-ptprocess-feedstock \
    r-ptwikiwords-feedstock

build_all \
    r-purge-feedstock \
    r-pvclust-feedstock \
    r-pwr-feedstock \
    r-pwr2-feedstock \
    r-pwrab-feedstock \
    r-pwrfdr-feedstock \
    r-pwrrasch-feedstock \
    r-pwt-feedstock \
    r-pwt8-feedstock \
    r-pwt9-feedstock \
    r-pyramid-feedstock \
    r-qap-feedstock \
    r-qboxplot-feedstock \
    r-qcafalsepositive-feedstock \
    r-qcewas-feedstock \
    r-qcgwas-feedstock

build_all \
    r-qcsis-feedstock \
    r-qcv-feedstock \
    r-qdapdictionaries-feedstock \
    r-qdcomparison-feedstock \
    r-qdm-feedstock \
    r-qfrm-feedstock \
    r-qgtools-feedstock \
    r-qhot-feedstock \
    r-qlearning-feedstock \
    r-qmrparser-feedstock \
    r-qqperm-feedstock \
    r-qrnn-feedstock \
    r-qsardata-feedstock \
    r-qtl-feedstock \
    r-qtlbook-feedstock \
    r-qtldesign-feedstock

build_all \
    r-qtlmt-feedstock \
    r-qualvar-feedstock \
    r-quantileda-feedstock \
    r-quantilegrader-feedstock \
    r-quantilenpci-feedstock \
    r-quantnorm-feedstock \
    r-quantumops-feedstock \
    r-quclu-feedstock \
    r-queryparser-feedstock \
    r-queueing-feedstock \
    r-quietr-feedstock \
    r-quotedargs-feedstock \
    r-quran-feedstock \
    r-r1magic-feedstock \
    r-r2html-feedstock \
    r-r2pmml-feedstock

build_all \
    r-r2ppt-feedstock \
    r-r2wd-feedstock \
    r-radar-feedstock \
    r-radarboxplot-feedstock \
    r-raddata-feedstock \
    r-rainfallerosivityfactor-feedstock \
    r-rainfarmr-feedstock \
    r-ramble-feedstock \
    r-ramify-feedstock \
    r-ramp-feedstock \
    r-randcorr-feedstock \
    r-randgeo-feedstock \
    r-randmeta-feedstock \
    r-randomfieldsutils-feedstock \
    r-randomizebe-feedstock \
    r-randomizr-feedstock

build_all \
    r-randtests-feedstock \
    r-rngwell-feedstock \
    r-rankingproject-feedstock \
    r-rankresponse-feedstock \
    r-rann-feedstock \
    r-rap-feedstock \
    r-rapidatetime-feedstock \
    r-rapidxmlr-feedstock \
    r-rapiserialize-feedstock \
    r-rapror-feedstock \
    r-rarity-feedstock \
    r-raschsampler-feedstock \
    r-rateratio.test-feedstock \
    r-raters-feedstock \
    r-ratesci-feedstock \
    r-raverage-feedstock

build_all \
    r-raw-feedstock \
    r-rbeast-feedstock \
    r-rbenchmark-feedstock \
    r-rbeta2009-feedstock \
    r-rbf-feedstock \
    r-rbibutils-feedstock \
    r-rcapture-feedstock \
    r-rcassandra-feedstock \
    r-rcc-feedstock \
    r-rcdd-feedstock \
    r-rceim-feedstock \
    r-rcelldata-feedstock \
    r-rcereal-feedstock \
    r-rcheology-feedstock \
    r-rcircos-feedstock \
    r-rcma-feedstock

build_all \
    r-rconics-feedstock \
    r-rcpp11-feedstock \
    r-rcppthread-feedstock \
    r-rcriticor-feedstock \
    r-rcrypt-feedstock \
    r-rcsdp-feedstock \
    r-rcssplot-feedstock \
    r-rdidq-feedstock \
    r-rdieharder-feedstock \
    r-rdistance-feedstock \
    r-rdnase-feedstock \
    r-rdsdp-feedstock \
    r-rdstreeboot-feedstock \
    r-readabf-feedstock \
    r-readbrukerflexdata-feedstock \
    r-readhac-feedstock

build_all \
    r-readmnist-feedstock \
    r-reat-feedstock \
    r-rebmix-feedstock \
    r-rebus.base-feedstock \
    r-reca-feedstock \
    r-records-feedstock \
    r-redmonder-feedstock \
    r-stringdist-feedstock \
    r-refnr-feedstock \
    r-refset-feedstock \
    r-regent-feedstock \
    r-regexpipes-feedstock \
    r-regress-feedstock \
    r-regressionfactory-feedstock \
    r-regspec-feedstock \
    r-regsubseq-feedstock

build_all \
    r-rehh.data-feedstock \
    r-reinstallr-feedstock \
    r-relatedness-feedstock \
    r-relen-feedstock \
    r-relimp-feedstock \
    r-renpow-feedstock \
    r-requirer-feedstock \
    r-resample-feedstock \
    r-resampledata-feedstock \
    r-resistorarray-feedstock \
    r-ress-feedstock \
    r-restorepoint-feedstock \
    r-retrodesign-feedstock \
    r-rferns-feedstock \
    r-rfit-feedstock \
    r-rfolding-feedstock

build_all \
    r-rfordummies-feedstock \
    r-rgabriel-feedstock \
    r-rgb-feedstock \
    r-rgen-feedstock \
    r-rgendata-feedstock \
    r-rgenetics-feedstock \
    r-rgenoud-feedstock \
    r-rgift-feedstock \
    r-rgw-feedstock \
    r-rhli-feedstock \
    r-rhmc-feedstock \
    r-rhnerm-feedstock \
    r-rhosp-feedstock \
    r-rhpcblasctl-feedstock \
    r-rht-feedstock \
    r-ridge-feedstock

build_all \
    r-ridittools-feedstock \
    r-rifs-feedstock \
    r-rimpact-feedstock \
    r-rinsp-feedstock \
    r-rintervaltree-feedstock \
    r-risk-feedstock \
    r-riskr-feedstock \
    r-riskyr-feedstock \
    r-riverbuilder-feedstock \
    r-rivernet-feedstock \
    r-rivervis-feedstock \
    r-rjsplot-feedstock \
    r-rkeeldata-feedstock \
    r-rkelly-feedstock \
    r-rkmetrics-feedstock \
    r-rkt-feedstock

build_all \
    r-rkum-feedstock \
    r-rlab-feedstock \
    r-rleafangle-feedstock \
    r-rlecuyer-feedstock \
    r-rlt-feedstock \
    r-rm2006-feedstock \
    r-rmargint-feedstock \
    r-rmea-feedstock \
    r-rmeta-feedstock \
    r-rmkdiscrete-feedstock \
    r-rmosek-feedstock \
    r-rmpi-feedstock \
    r-rms.gof-feedstock \
    r-rmsfact-feedstock \
    r-rmtstat-feedstock \
    r-rnavgraphimagedata-feedstock

build_all \
    r-rnd-feedstock \
    r-rnentropy-feedstock \
    r-rnetcarto-feedstock \
    r-rnetcdf-feedstock \
    r-rngsetseed-feedstock \
    r-robastrda-feedstock \
    r-robcor-feedstock \
    r-robeth-feedstock \
    r-robrsvd-feedstock \
    r-robumeta-feedstock \
    r-robustetm-feedstock \
    r-robustrankaggreg-feedstock \
    r-rocit-feedstock \
    r-rocnit-feedstock \
    r-rodbc-feedstock \
    r-rope-feedstock

build_all \
    r-roperators-feedstock \
    r-rose-feedstock \
    r-roughsetknowledgereduction-feedstock \
    r-roundhouse-feedstock \
    r-rpca-feedstock \
    r-rpexe.rpext-feedstock \
    r-rpicosat-feedstock \
    r-rpmg-feedstock \
    r-rpnf-feedstock \
    r-rpoet-feedstock \
    r-rpoppler-feedstock \
    r-rppairwisedesign-feedstock \
    r-rprobsup-feedstock \
    r-rqcc-feedstock \
    r-rrate-feedstock \
    r-rrblup-feedstock

build_all \
    r-rrdrand-feedstock \
    r-rrf-feedstock \
    r-rrna-feedstock \
    r-rroad-feedstock \
    r-rsadbe-feedstock \
    r-rsae-feedstock \
    r-rsampling-feedstock \
    r-rsca-feedstock \
    r-rscala-feedstock \
    r-rsclient-feedstock \
    r-rsdepth-feedstock \
    r-rse-feedstock \
    r-rseedcalc-feedstock \
    r-rserve-feedstock \
    r-rspc-feedstock \
    r-rspincalc-feedstock

build_all \
    r-rssop-feedstock \
    r-rstackdeque-feedstock \
    r-rstiefel-feedstock \
    r-rstream-feedstock \
    r-rsvg-feedstock \
    r-rsymphony-feedstock \
    r-rsyslog-feedstock \
    r-rt.test-feedstock \
    r-rt3-feedstock \
    r-rtape-feedstock \
    r-rtauchen-feedstock \
    r-rtaxometrics-feedstock \
    r-rtconnect-feedstock \
    r-rtde-feedstock \
    r-rtensor-feedstock \
    r-rtephra-feedstock

build_all \
    r-rtexturemetrics-feedstock \
    r-rtnmin-feedstock \
    r-rtriangle-feedstock \
    r-rtrim-feedstock \
    r-rttf2pt1-feedstock \
    r-rtwalk-feedstock \
    r-rtype-feedstock \
    r-runit-feedstock \
    r-runuran-feedstock \
    r-rv-feedstock \
    r-yulab.utils-feedstock \
    r-rviennacl-feedstock \
    r-rzmq-feedstock \
    r-s20x-feedstock \
    r-sabarsi-feedstock \
    r-sac-feedstock

build_all \
    r-sadeg-feedstock \
    r-saery-feedstock \
    r-safd-feedstock \
    r-saic-feedstock \
    r-sample.size-feedstock \
    r-samplesize-feedstock \
    r-samplesize4clinicaltrials-feedstock \
    r-samplesizecmh-feedstock \
    r-samplingbigdata-feedstock \
    r-samplingvarest-feedstock \
    r-sanitizers-feedstock \
    r-sanon-feedstock \
    r-sapp-feedstock \
    r-sas7bdat-feedstock \
    r-sascii-feedstock \
    r-sasmixed-feedstock

build_all \
    r-sautomata-feedstock \
    r-saves-feedstock \
    r-sbgcop-feedstock \
    r-sbiopn-feedstock \
    r-sbl-feedstock \
    r-sbsdiff-feedstock \
    r-scar-feedstock \
    r-scat-feedstock \
    r-schoolmath-feedstock \
    r-schorsch-feedstock \
    r-schumaker-feedstock \
    r-scifigure-feedstock \
    r-sciplot-feedstock \
    r-scma-feedstock \
    r-scorer2-feedstock \
    r-scoring-feedstock

build_all \
    r-scperf-feedstock \
    r-scrime-feedstock \
    r-scriptexec-feedstock \
    r-scripturs-feedstock \
    r-scrt-feedstock \
    r-scs-feedstock \
    r-scuba-feedstock \
    r-sdaa-feedstock \
    r-sdef-feedstock \
    r-solvesaphe-feedstock \
    r-searcher-feedstock \
    r-searchtrees-feedstock \
    r-seasic-feedstock \
    r-x13binary-feedstock \
    r-seedcalc-feedstock \
    r-seismic-feedstock

build_all \
    r-sejong-feedstock \
    r-selectapref-feedstock \
    r-webp-feedstock \
    r-sempower-feedstock \
    r-sensemakr-feedstock \
    r-sensitivitycasecontrol-feedstock \
    r-sensitivityfull-feedstock \
    r-sensitivitymult-feedstock \
    r-sensitivitymv-feedstock \
    r-sensitivitymw-feedstock \
    r-sensrivastava-feedstock \
    r-separate-feedstock \
    r-seqalloc-feedstock \
    r-seqminer-feedstock \
    r-seqmon-feedstock \
    r-seqtest-feedstock

build_all \
    r-serial-feedstock \
    r-session-feedstock \
    r-setrng-feedstock \
    r-sets-feedstock \
    r-settest-feedstock \
    r-settings-feedstock \
    r-severity-feedstock \
    r-sfa-feedstock \
    r-sfinx-feedstock \
    r-sgeostat-feedstock \
    r-sgl-feedstock \
    r-shades-feedstock \
    r-shiftr-feedstock \
    r-sourcetools-feedstock \
    r-shinyshortcut-feedstock \
    r-ship-feedstock

build_all \
    r-shuffle-feedstock \
    r-si-feedstock \
    r-sier-feedstock \
    r-sievetest-feedstock \
    r-sig-feedstock \
    r-sigclust-feedstock \
    r-sigmoid-feedstock \
    r-signmedian.test-feedstock \
    r-simctest-feedstock \
    r-simdistr-feedstock \
    r-simex-feedstock \
    r-similaritymeasures-feedstock \
    r-simile-feedstock \
    r-simphe-feedstock \
    r-simplecache-feedstock \
    r-simplegraph-feedstock

build_all \
    r-simpleneural-feedstock \
    r-simplesetup-feedstock \
    r-simplicialcubature-feedstock \
    r-simscrpiecewise-feedstock \
    r-simsurv-feedstock \
    r-simtimer-feedstock \
    r-sin-feedstock \
    r-sinib-feedstock \
    r-sitools-feedstock \
    r-spatest-feedstock \
    r-skeletor-feedstock \
    r-skellam-feedstock \
    r-skewt-feedstock \
    r-slc-feedstock \
    r-sldassay-feedstock \
    r-sleekts-feedstock

build_all \
    r-sleuth2-feedstock \
    r-sleuth3-feedstock \
    r-slhd-feedstock \
    r-slide-feedstock \
    r-sm-feedstock \
    r-smaa-feedstock \
    r-smatr-feedstock \
    r-smco-feedstock \
    r-smcrm-feedstock \
    r-smdata-feedstock \
    r-smfilter-feedstock \
    r-smirnov-feedstock \
    r-smloutliers-feedstock \
    r-smoothie-feedstock \
    r-smr-feedstock \
    r-smss-feedstock

build_all \
    r-smvar-feedstock \
    r-snakesandladdersanalysis-feedstock \
    r-snappier-feedstock \
    r-snapshot-feedstock \
    r-snn-feedstock \
    r-snowflakes-feedstock \
    r-soar-feedstock \
    r-socialposition-feedstock \
    r-soda-feedstock \
    r-softclustering-feedstock \
    r-soilwater-feedstock \
    r-sokoban-feedstock \
    r-solarpos-feedstock \
    r-solrad-feedstock \
    r-som-feedstock \
    r-somebm-feedstock

build_all \
    r-sonar-feedstock \
    r-soniclength-feedstock \
    r-soobench-feedstock \
    r-soql-feedstock \
    r-sorptionanalysis-feedstock \
    r-sotu-feedstock \
    r-sound-feedstock \
    r-soundexbr-feedstock \
    r-spaa-feedstock \
    r-spacesrgb-feedstock \
    r-spacesxyz-feedstock \
    r-spader-feedstock \
    r-spaero-feedstock \
    r-spam64-feedstock \
    r-spanel-feedstock \
    r-spar-feedstock

build_all \
    r-sparcl-feedstock \
    r-sparktex-feedstock \
    r-sparsedc-feedstock \
    r-sparseeigen-feedstock \
    r-sparsegrid-feedstock \
    r-sparseindextracking-feedstock \
    r-sparsepp-feedstock \
    r-sparsesvm-feedstock \
    r-spatialcovariance-feedstock \
    r-spatialnp-feedstock \
    r-spatstat.utils-feedstock \
    r-tensor-feedstock \
    r-spc-feedstock \
    r-spcadjust-feedstock \
    r-spdownscale-feedstock \
    r-speccalt-feedstock

build_all \
    r-species-feedstock \
    r-spectralgp-feedstock \
    r-spedinstabr-feedstock \
    r-spgs-feedstock \
    r-sphericalk-feedstock \
    r-spiassay-feedstock \
    r-spina-feedstock \
    r-spinyreg-feedstock \
    r-splitsoftening-feedstock \
    r-splot-feedstock \
    r-splus2r-feedstock \
    r-splustimedate-feedstock \
    r-spmc-feedstock \
    r-spongebob-feedstock \
    r-sprt-feedstock \
    r-spsl-feedstock

build_all \
    r-spt-feedstock \
    r-spyvsspy-feedstock \
    r-squash-feedstock \
    r-sra-feedstock \
    r-srcs-feedstock \
    r-ssanv-feedstock \
    r-ssd-feedstock \
    r-ssize.fdr-feedstock \
    r-sslasso-feedstock \
    r-ssm-feedstock \
    r-sspline-feedstock \
    r-stabs-feedstock \
    r-stackoverflow-feedstock \
    r-stakeholderanalysis-feedstock \
    r-stargazer-feedstock \
    r-startup-feedstock

build_all \
    r-startupmsg-feedstock \
    r-stat2data-feedstock \
    r-statpermeco-feedstock \
    r-statprograms-feedstock \
    r-stcov-feedstock \
    r-stddiff-feedstock \
    r-steepness-feedstock \
    r-steiniv-feedstock \
    r-stellar-feedstock \
    r-stepplr-feedstock \
    r-sticky-feedstock \
    r-stochqn-feedstock \
    r-stoichcalc-feedstock \
    r-strainranking-feedstock \
    r-stratification-feedstock \
    r-stressstrength-feedstock

build_all \
    r-stuart-feedstock \
    r-stv-feedstock \
    r-subcopem2d-feedstock \
    r-subcultcon-feedstock \
    r-subdetect-feedstock \
    r-subgroup-feedstock \
    r-subgxe-feedstock \
    r-subplex-feedstock \
    r-subrank-feedstock \
    r-subsamp-feedstock \
    r-sudoku-feedstock \
    r-suntersampling-feedstock \
    r-superexacttest-feedstock \
    r-support.bws-feedstock \
    r-support.bws2-feedstock \
    r-surtex-feedstock

build_all \
    r-writexls-feedstock \
    r-surveyeditor-feedstock \
    r-surveyoutliers-feedstock \
    r-survivalroc-feedstock \
    r-survjamda.data-feedstock \
    r-survlong-feedstock \
    r-svd-feedstock \
    r-svenssonm-feedstock \
    r-svgui-feedstock \
    r-svmisc-feedstock \
    r-svunit-feedstock \
    r-swcrtdesign-feedstock \
    r-swdft-feedstock \
    r-swissair-feedstock \
    r-sylcount-feedstock \
    r-sylly-feedstock

build_all \
    r-sym.arma-feedstock \
    r-symts-feedstock \
    r-synchrony-feedstock \
    r-syncmove-feedstock \
    r-syncrng-feedstock \
    r-sysfonts-feedstock \
    r-t2eq-feedstock \
    r-tabletolongform-feedstock \
    r-tabusearch-feedstock \
    r-tapkee-feedstock \
    r-tariff-feedstock \
    r-tatest-feedstock \
    r-tau-feedstock \
    r-taxicabca-feedstock \
    r-tclust-feedstock \
    r-tdamapper-feedstock

build_all \
    r-tdthap-feedstock \
    r-teachingdemos-feedstock \
    r-teachnet-feedstock \
    r-teda-feedstock \
    r-teigen-feedstock \
    r-tempdisagg-feedstock \
    r-tempr-feedstock \
    r-teqr-feedstock \
    r-testassay-feedstock \
    r-testdriver-feedstock \
    r-testequavar-feedstock \
    r-tester-feedstock \
    r-testfunctions-feedstock \
    r-testscorer-feedstock \
    r-textgrid-feedstock \
    r-textile-feedstock

build_all \
    r-textometry-feedstock \
    r-textutils-feedstock \
    r-tfer-feedstock \
    r-tframe-feedstock \
    r-tgcd-feedstock \
    r-thankr-feedstock \
    r-thermindex-feedstock \
    r-thermocouple-feedstock \
    r-thgenetics-feedstock \
    r-threegroups-feedstock \
    r-threeway-feedstock \
    r-tickexec-feedstock \
    r-tictoc-feedstock \
    r-tideharmonics-feedstock \
    r-tides-feedstock \
    r-tiff-feedstock

build_all \
    r-tightclust-feedstock \
    r-timetools-feedstock \
    r-timsac-feedstock \
    r-tinflex-feedstock \
    r-tinsel-feedstock \
    r-tinytest-feedstock \
    r-tis-feedstock \
    r-titanic-feedstock \
    r-titrationcurves-feedstock \
    r-tkrplotr-feedstock \
    r-tlemix-feedstock \
    r-tls-feedstock \
    r-tmcalculator-feedstock \
    r-tnc-feedstock \
    r-topmodel-feedstock \
    r-topsis-feedstock

build_all \
    r-toxtestd-feedstock \
    r-tp.idm-feedstock \
    r-tpes-feedstock \
    r-trampr-feedstock \
    r-translation.ko-feedstock \
    r-transp-feedstock \
    r-trapezoid-feedstock \
    r-tree-feedstock \
    r-treelet-feedstock \
    r-trekfont-feedstock \
    r-trendchange-feedstock \
    r-trendsegmentr-feedstock \
    r-trialsize-feedstock \
    r-triangle-feedstock \
    r-triangulation-feedstock \
    r-trimcluster-feedstock

build_all \
    r-triosgl-feedstock \
    r-tripack-feedstock \
    r-tripsanddipr-feedstock \
    r-tropalgebra-feedstock \
    r-trotter-feedstock \
    r-trueskill-feedstock \
    r-trust-feedstock \
    r-trycatchlog-feedstock \
    r-tsallisqexp-feedstock \
    r-tsc-feedstock \
    r-tsdata-feedstock \
    r-tsdecomp-feedstock \
    r-tsdf-feedstock \
    r-tsdisagg2-feedstock \
    r-tse-feedstock \
    r-tseind-feedstock

build_all \
    r-tsentropies-feedstock \
    r-tseriesmma-feedstock \
    r-tsewgt-feedstock \
    r-tshrc-feedstock \
    r-tsmn-feedstock \
    r-tsmodel-feedstock \
    r-tsne-feedstock \
    r-tsss-feedstock \
    r-tsvr-feedstock \
    r-ttbbeer-feedstock \
    r-tth-feedstock \
    r-tttplot-feedstock \
    r-tuckerr.mmgg-feedstock \
    r-tunepareto-feedstock \
    r-tuple-feedstock \
    r-turtlegraphics-feedstock

build_all \
    r-tuwmodel-feedstock \
    r-twocop-feedstock \
    r-twosampletest.hd-feedstock \
    r-twoway-feedstock \
    r-txtplot-feedstock \
    r-types-feedstock \
    r-ubcrm-feedstock \
    r-ucminf-feedstock \
    r-ucr.columnnames-feedstock \
    r-udderquarterinfectiondata-feedstock \
    r-udunits2-feedstock \
    r-ukbabynames-feedstock \
    r-umoments-feedstock \
    r-ump-feedstock \
    r-unbalhaar-feedstock \
    r-unicode-feedstock

build_all \
    r-unifed-feedstock \
    r-uniqtag-feedstock \
    r-unitcircle-feedstock \
    r-unittest-feedstock \
    r-univrng-feedstock \
    r-unix-feedstock \
    r-unrepx-feedstock \
    r-unvotes-feedstock \
    r-upsvarapprox-feedstock \
    r-urbin-feedstock \
    r-uroot-feedstock \
    r-usaboundaries-feedstock \
    r-usedist-feedstock \
    r-usmapdata-feedstock \
    r-ustatbookabsc-feedstock \
    r-utc-feedstock

build_all \
    r-utility-feedstock \
    r-vaersndvax-feedstock \
    r-vaersvax-feedstock \
    r-valottery-feedstock \
    r-var.etp-feedstock \
    r-vardiag-feedstock \
    r-vared-feedstock \
    r-vares-feedstock \
    r-varhandle-feedstock \
    r-variables-feedstock \
    r-varsel-feedstock \
    r-vbdm-feedstock \
    r-vcov-feedstock \
    r-vcvcomp-feedstock \
    r-vdgraph-feedstock \
    r-vdspcalibration-feedstock

build_all \
    r-vegperiod-feedstock \
    r-versions-feedstock \
    r-vetr-feedstock \
    r-vfprogression-feedstock \
    r-vhica-feedstock \
    r-vietnamcode-feedstock \
    r-vifcp-feedstock \
    r-vigor-feedstock \
    r-vipor-feedstock \
    r-visualize-feedstock \
    r-vitality-feedstock \
    r-vlf-feedstock \
    r-vocaldia-feedstock \
    r-volleystat-feedstock \
    r-vortexrdata-feedstock \
    r-vowels-feedstock

build_all \
    r-vrtest-feedstock \
    r-vudc-feedstock \
    r-wahc-feedstock \
    r-walkscoreapi-feedstock \
    r-wand-feedstock \
    r-washdata-feedstock \
    r-wateryeartype-feedstock \
    r-waved-feedstock \
    r-wavefunction-feedstock \
    r-waveletcomp-feedstock \
    r-wavelets-feedstock \
    r-waveslim-feedstock \
    r-wbs-feedstock \
    r-wcq-feedstock \
    r-weathermetrics-feedstock \
    r-websearchr-feedstock

build_all \
    r-weibullness-feedstock \
    r-weighted.desc.stat-feedstock \
    r-weightedroc-feedstock \
    r-weirs-feedstock \
    r-wesanderson-feedstock \
    r-wgteff-feedstock \
    r-wikibooks-feedstock \
    r-wilcoxcv-feedstock \
    r-wildpoker-feedstock \
    r-wktmo-feedstock \
    r-wmdb-feedstock \
    r-wmwssp-feedstock \
    r-wnnsel-feedstock \
    r-woe-feedstock \
    r-woebinning-feedstock \
    r-wooldridge-feedstock

build_all \
    r-wordpools-feedstock \
    r-wperm-feedstock \
    r-wpkde-feedstock \
    r-wpp2008-feedstock \
    r-wpp2010-feedstock \
    r-wpp2012-feedstock \
    r-wrapr-feedstock \
    r-wrightmap-feedstock \
    r-write.snns-feedstock \
    r-writexl-feedstock \
    r-wtest-feedstock \
    r-wwgbook-feedstock \
    r-xhwe-feedstock \
    r-ximple-feedstock \
    r-xmisc-feedstock \
    r-xnomial-feedstock

build_all \
    r-xptr-feedstock \
    r-xrscc-feedstock \
    r-xtal-feedstock \
    r-xtermstyle-feedstock \
    r-yacca-feedstock \
    r-yaimpute-feedstock \
    r-yarr-feedstock \
    r-yasp-feedstock \
    r-yesno-feedstock \
    r-yll-feedstock \
    r-ypmodel-feedstock \
    r-zipfr-feedstock \
    r-zipr-feedstock \
    r-zoeppritz-feedstock \
    r-zoom-feedstock \
    r-isoband-feedstock

build_all \
    r-praise-feedstock \
    r-rematch-feedstock


build_all \
    r-abcoptim-feedstock \
    r-abcp2-feedstock \
    r-matrix-feedstock \
    r-abodoutlier-feedstock \
    r-abps-feedstock \
    r-ac3net-feedstock \
    r-stringr-feedstock \
    r-rcpparmadillo-feedstock \
    r-acfmperiod-feedstock \
    r-plyr-feedstock \
    r-zoo-feedstock \
    r-acswr-feedstock \
    r-activedriver-feedstock \
    r-actuar-feedstock \
    r-ada-feedstock \
    r-adagio-feedstock

build_all \
    r-coda-feedstock \
    r-adapttest-feedstock \
    r-adct-feedstock \
    r-nlme-feedstock \
    r-sp-feedstock \
    r-latticeextra-feedstock \
    r-adimpro-feedstock \
    r-admit-feedstock \
    r-adpss-feedstock \
    r-rcurl-feedstock \
    r-ncmisc-feedstock \
    r-agsemisc-feedstock \
    r-ahocorasicktrie-feedstock \
    r-aidar-feedstock \
    r-alabama-feedstock \
    r-lubridate-feedstock

build_all \
    r-allehap-feedstock \
    r-allelematch-feedstock \
    r-cubature-feedstock \
    r-ambient-feedstock \
    r-aml-feedstock \
    r-anacoda-feedstock \
    r-anocva-feedstock \
    r-bit64-feedstock \
    r-antiword-feedstock \
    r-anytime-feedstock \
    r-aoptbdtvc-feedstock \
    r-foreach-feedstock \
    r-apcf-feedstock \
    r-apercu-feedstock \
    r-apng-feedstock \
    r-appestimation-feedstock

build_all \
    r-emulator-feedstock \
    r-ar-feedstock \
    r-htmltools-feedstock \
    r-argparse-feedstock \
    r-armspp-feedstock \
    r-arpr-feedstock \
    r-arrangements-feedstock \
    r-purrr-feedstock \
    r-artp2-feedstock \
    r-asd-feedstock \
    r-askpass-feedstock \
    r-energy-feedstock \
    r-assertable-feedstock \
    r-assertive.matrices-feedstock \
    r-assertive.models-feedstock \
    r-assertive.numbers-feedstock

build_all \
    r-assertive.properties-feedstock \
    r-assertive.reflection-feedstock \
    r-assertive.sets-feedstock \
    r-assocafc-feedstock \
    r-assotester-feedstock \
    r-asyk-feedstock \
    r-cli-feedstock \
    r-attempt-feedstock \
    r-averisk-feedstock \
    r-awr-feedstock \
    r-rjdbc-feedstock \
    r-aws-feedstock \
    r-aws.signature-feedstock \
    r-aws.ec2metadata-feedstock \
    r-backtest-feedstock \
    r-bacprior-feedstock

build_all \
    r-rvcheck-feedstock \
    r-barcode-feedstock \
    r-class-feedstock \
    r-bartmachinejars-feedstock \
    r-base64url-feedstock \
    r-limsolve-feedstock \
    r-truncdist-feedstock \
    r-batman-feedstock \
    r-bayespiecehazselect-feedstock \
    r-bayespiecewiseicar-feedstock \
    r-mnormt-feedstock \
    r-bayestree-feedstock \
    r-bayesvarsel-feedstock \
    r-bb-feedstock \
    r-checkmate-feedstock \
    r-bcbcsf-feedstock

build_all \
    r-bcpmeta-feedstock \
    r-bda-feedstock \
    r-beast-feedstock \
    r-bedmatrix-feedstock \
    r-behavr-feedstock \
    r-belex-feedstock \
    r-benchr-feedstock \
    r-benford.analysis-feedstock \
    r-berryfunctions-feedstock \
    r-betabit-feedstock \
    r-flexmix-feedstock \
    r-bfp-feedstock \
    r-bfsl-feedstock \
    r-bhat-feedstock \
    r-bidimregression-feedstock \
    r-bigmemory-feedstock

build_all \
    r-biglm-feedstock \
    r-biglmm-feedstock \
    r-bigreadr-feedstock \
    r-bigsplines-feedstock \
    r-oompabase-feedstock \
    r-binarize-feedstock \
    r-binda-feedstock \
    r-bindrcpp-feedstock \
    r-binmto-feedstock \
    r-binomsamsize-feedstock \
    r-clinfun-feedstock \
    r-binst-feedstock \
    r-bio3d-feedstock \
    r-circular-feedstock \
    r-bisrna-feedstock \
    r-bitrina-feedstock

build_all \
    r-bizdays-feedstock \
    r-blendstat-feedstock \
    r-blockfest-feedstock \
    r-polynomf-feedstock \
    r-blrpm-feedstock \
    r-bmix-feedstock \
    r-bmrv-feedstock \
    r-bnclassify-feedstock \
    r-bnormnlr-feedstock \
    r-bnptsclust-feedstock \
    r-boilerpiper-feedstock \
    r-bolstad-feedstock \
    r-bondvaluation-feedstock \
    r-tinytex-feedstock \
    r-boom-feedstock \
    r-bootes-feedstock

build_all \
    r-bootlr-feedstock \
    r-bootstepaic-feedstock \
    r-bpp-feedstock \
    r-brglm-feedstock \
    r-brnn-feedstock \
    r-lifecycle-feedstock \
    r-bsearchtools-feedstock \
    r-bsplinepsd-feedstock \
    r-btm-feedstock \
    r-businessduration-feedstock \
    r-bvar-feedstock \
    r-bwimage-feedstock \
    r-bzinb-feedstock \
    r-cabootcrs-feedstock \
    r-cachem-feedstock \
    r-calibrate-feedstock

build_all \
    r-captr-feedstock \
    r-capushe-feedstock \
    r-care-feedstock \
    r-modelmetrics-feedstock \
    r-casmap-feedstock \
    r-catdata-feedstock \
    r-catirt-feedstock \
    r-catools-feedstock \
    r-cbinom-feedstock \
    r-cbsodatar-feedstock \
    r-pcapp-feedstock \
    r-robustbase-feedstock \
    r-ccda-feedstock \
    r-ccmm-feedstock \
    r-cdb-feedstock \
    r-census2016-feedstock

build_all \
    r-cgauc-feedstock \
    r-cgwtools-feedstock \
    r-chandwich-feedstock \
    r-changepointsvar-feedstock \
    r-hommel-feedstock \
    r-choicedes-feedstock \
    r-chopthin-feedstock \
    r-chor-feedstock \
    r-chunkr-feedstock \
    r-circlize-feedstock \
    r-circstats-feedstock \
    r-rdpack-feedstock \
    r-clam-feedstock \
    r-clarifai-feedstock \
    r-cld2-feedstock \
    r-cld3-feedstock

build_all \
    r-clickclustcont-feedstock \
    r-clikcorr-feedstock \
    r-clime-feedstock \
    r-clinicaltrialsummary-feedstock \
    r-clogitboost-feedstock \
    r-clogitl1-feedstock \
    r-config-feedstock \
    r-processx-feedstock \
    r-clue-feedstock \
    r-clusrank-feedstock \
    r-clustergeneration-feedstock \
    r-clustmmdd-feedstock \
    r-cmf-feedstock \
    r-cmls-feedstock \
    r-cmrutils-feedstock \
    r-elliptic-feedstock

build_all \
    r-cobiclust-feedstock \
    r-libcoin-feedstock \
    r-collapse-feedstock \
    r-collutils-feedstock \
    r-coloredica-feedstock \
    r-colourvalues-feedstock \
    r-colt-feedstock \
    r-combat-feedstock \
    r-comparer-feedstock \
    r-complognormal-feedstock \
    r-compoissonreg-feedstock \
    r-compr-feedstock \
    r-conconpiwifun-feedstock \
    r-conditionz-feedstock \
    r-condmvnorm-feedstock \
    r-condvis-feedstock

build_all \
    r-configparser-feedstock \
    r-constellation-feedstock \
    r-container-feedstock \
    r-convergenceconcepts-feedstock \
    r-rpart.plot-feedstock \
    r-corenlp-feedstock \
    r-coroica-feedstock \
    r-corpus-feedstock \
    r-corrdna-feedstock \
    r-correctoverloadedpeaks-feedstock \
    r-countgmifs-feedstock \
    r-tokenizers-feedstock \
    r-rex-feedstock \
    r-covsep-feedstock \
    r-cpgfilter-feedstock \
    r-minqa-feedstock

build_all \
    r-cpprouting-feedstock \
    r-cramer-feedstock \
    r-crfsuite-feedstock \
    r-cronr-feedstock \
    r-crossdes-feedstock \
    r-crossva-feedstock \
    r-crov-feedstock \
    r-tm-feedstock \
    r-csn-feedstock \
    r-csv-feedstock \
    r-csvy-feedstock \
    r-cub-feedstock \
    r-cumseg-feedstock \
    r-curstatci-feedstock \
    r-cvmgof-feedstock \
    r-cxxfunplus-feedstock

build_all \
    r-cyclertools-feedstock \
    r-fauxpas-feedstock \
    r-dang-feedstock \
    r-dap-feedstock \
    r-rook-feedstock \
    r-data.tree-feedstock \
    r-databaseconnectorjars-feedstock \
    r-datagraph-feedstock \
    r-davies-feedstock \
    r-dbscan-feedstock \
    r-dbx-feedstock \
    r-debugme-feedstock \
    r-debugr-feedstock \
    r-decido-feedstock \
    r-decompr-feedstock \
    r-deepboost-feedstock

build_all \
    r-deepgmm-feedstock \
    r-deformula-feedstock \
    r-deltaplotr-feedstock \
    r-deming-feedstock \
    r-demova-feedstock \
    r-denstrip-feedstock \
    r-depend.truncation-feedstock \
    r-depmix-feedstock \
    r-depth.plot-feedstock \
    r-descr-feedstock \
    r-detestset-feedstock \
    r-detsel-feedstock \
    r-devore7-feedstock \
    r-ellipsis-feedstock \
    r-rversions-feedstock \
    r-dfcomb-feedstock

build_all \
    r-dhsic-feedstock \
    r-downloader-feedstock \
    r-v8-feedstock \
    r-dialrjars-feedstock \
    r-dice-feedstock \
    r-diceeval-feedstock \
    r-didacticboost-feedstock \
    r-diffpriv-feedstock \
    r-directlabels-feedstock \
    r-disclapmix-feedstock \
    r-discretefdr-feedstock \
    r-treeclust-feedstock \
    r-dishet-feedstock \
    r-terra-feedstock \
    r-distance.sample.size-feedstock \
    r-homomorpher-feedstock

build_all \
    r-distributiontest-feedstock \
    r-divdyn-feedstock \
    r-divo-feedstock \
    r-dlasso-feedstock \
    r-dlib-feedstock \
    r-dma-feedstock \
    r-dng-feedstock \
    r-openxlsx-feedstock \
    r-rngtools-feedstock \
    r-dos-feedstock \
    r-dosearch-feedstock \
    r-dosefinding-feedstock \
    r-doubleexpseq-feedstock \
    r-dparser-feedstock \
    r-sitmo-feedstock \
    r-dr-feedstock

build_all \
    r-dreamerr-feedstock \
    r-droptest-feedstock \
    r-dsample-feedstock \
    r-dtangle-feedstock \
    r-dtw-feedstock \
    r-dydea-feedstock \
    r-dynpanel-feedstock \
    r-dynprog-feedstock \
    r-easycsv-feedstock \
    r-ecipex-feedstock \
    r-ecotroph-feedstock \
    r-ecp-feedstock \
    r-ed50-feedstock \
    r-edison-feedstock \
    r-effectstars-feedstock \
    r-misctools-feedstock

build_all \
    r-eive-feedstock \
    r-ekmcmc-feedstock \
    r-elasticnet-feedstock \
    r-elec.strat-feedstock \
    r-elitism-feedstock \
    r-rtsne-feedstock \
    r-emg-feedstock \
    r-emmeans-feedstock \
    r-endogenous-feedstock \
    r-engrexpt-feedstock \
    r-ensemblebma-feedstock \
    r-envirostat-feedstock \
    r-officer-feedstock \
    r-pander-feedstock \
    r-epistemicgametheory-feedstock \
    r-eply-feedstock

build_all \
    r-eql-feedstock \
    r-equivnoninf-feedstock \
    r-erboost-feedstock \
    r-erpr-feedstock \
    r-esshist-feedstock \
    r-etc-feedstock \
    r-eventinterval-feedstock \
    r-evmix-feedstock \
    r-ewgof-feedstock \
    r-exact-feedstock \
    r-exceedprob-feedstock \
    r-excon-feedstock \
    r-rcpproll-feedstock \
    r-exif-feedstock \
    r-exiftoolr-feedstock \
    r-expde-feedstock

build_all \
    r-experiment-feedstock \
    r-expperm-feedstock \
    r-maditr-feedstock \
    r-extradistr-feedstock \
    r-extratrees-feedstock \
    r-extremebounds-feedstock \
    r-extremogram-feedstock \
    r-markdown-feedstock \
    r-fabci-feedstock \
    r-fabricatr-feedstock \
    r-famle-feedstock \
    r-fastadaboost-feedstock \
    r-fastghquad-feedstock \
    r-fastjt-feedstock \
    r-fastrweb-feedstock \
    r-fasttextr-feedstock

build_all \
    r-timeseries-feedstock \
    r-fc-feedstock \
    r-fdth-feedstock \
    r-fenmlm-feedstock \
    r-ff-feedstock \
    r-ffstream-feedstock \
    r-spam-feedstock \
    r-fincovregularization-feedstock \
    r-fire-feedstock \
    r-fit.models-feedstock \
    r-fixedpoint-feedstock \
    r-flam-feedstock \
    r-flock-feedstock \
    r-flr-feedstock \
    r-fmsmsnreg-feedstock \
    r-foolbox-feedstock

build_all \
    r-forecastsnsts-feedstock \
    r-forestfit-feedstock \
    r-forge-feedstock \
    r-formula.tools-feedstock \
    r-forward-feedstock \
    r-prabclus-feedstock \
    r-fpca2d-feedstock \
    r-fpeek-feedstock \
    r-fractaldim-feedstock \
    r-fractional-feedstock \
    r-franc-feedstock \
    r-magic-feedstock \
    r-frlr-feedstock \
    r-fromo-feedstock \
    r-fstcore-feedstock \
    r-funchir-feedstock

build_all \
    r-globals-feedstock \
    r-fuzzyahp-feedstock \
    r-fuzzysim-feedstock \
    r-fwsim-feedstock \
    r-gad-feedstock \
    r-gamlss.dist-feedstock \
    r-gb-feedstock \
    r-gclus-feedstock \
    r-gcpm-feedstock \
    r-gdata-feedstock \
    r-systemfonts-feedstock \
    r-generalizedhyperbolic-feedstock \
    r-generaloaxaca-feedstock \
    r-genieclust-feedstock \
    r-genodds-feedstock \
    r-genwin-feedstock

build_all \
    r-jqr-feedstock \
    r-protolite-feedstock \
    r-geometries-feedstock \
    r-jsonify-feedstock \
    r-linprog-feedstock \
    r-geonames-feedstock \
    r-geozoo-feedstock \
    r-gepaf-feedstock \
    r-gestalt-feedstock \
    r-getpass-feedstock \
    r-gexp-feedstock \
    r-gridextra-feedstock \
    r-ggmridge-feedstock \
    r-ggmselect-feedstock \
    r-prismatic-feedstock \
    r-ghs-feedstock

build_all \
    r-ghyp-feedstock \
    r-gibbsacov-feedstock \
    r-gifi-feedstock \
    r-gim-feedstock \
    r-git2rdata-feedstock \
    r-glarma-feedstock \
    r-spacefillr-feedstock \
    r-glm.deploy-feedstock \
    r-glmbb-feedstock \
    r-glmulti-feedstock \
    r-glsme-feedstock \
    r-rmysql-feedstock \
    r-gmdh-feedstock \
    r-gmeta-feedstock \
    r-gnumeric-feedstock \
    r-gofkernel-feedstock

build_all \
    r-googleknowledgegraphr-feedstock \
    r-googlepolylines-feedstock \
    r-googlevis-feedstock \
    r-gpltr-feedstock \
    r-grapes-feedstock \
    r-graphql-feedstock \
    r-greedyexperimentaldesignjars-feedstock \
    r-gridsvg-feedstock \
    r-grimport-feedstock \
    r-grimport2-feedstock \
    r-groupica-feedstock \
    r-grt-feedstock \
    r-grto-feedstock \
    r-gsarima-feedstock \
    r-gscounts-feedstock \
    r-gsm-feedstock

build_all \
    r-gsmx-feedstock \
    r-gsubfn-feedstock \
    r-guide-feedstock \
    r-guts-feedstock \
    r-gwidgets2-feedstock \
    r-hapsim-feedstock \
    r-harvest.tree-feedstock \
    r-hbim-feedstock \
    r-hbv.ianigla-feedstock \
    r-hcr-feedstock \
    r-hdpca-feedstock \
    r-locfit-feedstock \
    r-orthopolynom-feedstock \
    r-hellojavaworld-feedstock \
    r-heritability-feedstock \
    r-optimx-feedstock

build_all \
    r-hetgp-feedstock \
    r-hett-feedstock \
    r-hexbin-feedstock \
    r-hgm-feedstock \
    r-rlist-feedstock \
    r-hive-feedstock \
    r-hkclustering-feedstock \
    r-hmm.discnp-feedstock \
    r-hmmextra0s-feedstock \
    r-hmvd-feedstock \
    r-hnp-feedstock \
    r-hoardr-feedstock \
    r-hotelling-feedstock \
    r-hpbayes-feedstock \
    r-hrw-feedstock \
    r-htdp-feedstock

build_all \
    r-later-feedstock \
    r-hues-feedstock \
    r-humaniformat-feedstock \
    r-humanleague-feedstock \
    r-hunspell-feedstock \
    r-ibm-feedstock \
    r-ibmcraftr-feedstock \
    r-ibs-feedstock \
    r-icebox-feedstock \
    r-iceinfer-feedstock \
    r-icensmis-feedstock \
    r-icesvocab-feedstock \
    r-icge-feedstock \
    r-icods-feedstock \
    r-icr-feedstock \
    r-idendr0-feedstock

build_all \
    r-idpmisc-feedstock \
    r-ifa-feedstock \
    r-igasso-feedstock \
    r-imagine-feedstock \
    r-imak-feedstock \
    r-imptree-feedstock \
    r-imputemissings-feedstock \
    r-inbreedr-feedstock \
    r-infiniumpurify-feedstock \
    r-infix-feedstock \
    r-infodecompute-feedstock \
    r-inplace-feedstock \
    r-inspectchangepoint-feedstock \
    r-interatrix-feedstock \
    r-interpretr-feedstock \
    r-intervalsurgeon-feedstock

build_all \
    r-invasioncorrection-feedstock \
    r-ipec-feedstock \
    r-iplots-feedstock \
    r-irace-feedstock \
    r-irr-feedstock \
    r-isa2-feedstock \
    r-xlsxjars-feedstock \
    r-isoplotr-feedstock \
    r-isospecr-feedstock \
    r-istacr-feedstock \
    r-itertools-feedstock \
    r-itertools2-feedstock \
    r-itrlearn-feedstock \
    r-ivfixed-feedstock \
    r-ivpanel-feedstock \
    r-ivprobit-feedstock

build_all \
    r-jaatha-feedstock \
    r-jacobieigen-feedstock \
    r-jaggr-feedstock \
    r-javagd-feedstock \
    r-jmvcore-feedstock \
    r-josaplay-feedstock \
    r-jpen-feedstock \
    r-json64-feedstock \
    r-kappalab-feedstock \
    r-kendall-feedstock \
    r-kernscr-feedstock \
    r-keyboardsimulator-feedstock \
    r-kfda-feedstock \
    r-kirby21.base-feedstock \
    r-knapsacksampling-feedstock \
    r-r.oo-feedstock

build_all \
    r-kohonen-feedstock \
    r-kpart-feedstock \
    r-kpmt-feedstock \
    r-multicool-feedstock \
    r-plot3d-feedstock \
    r-ksamples-feedstock \
    r-ksgeneral-feedstock \
    r-ksnn-feedstock \
    r-kvh-feedstock \
    r-kzs-feedstock \
    r-l1pack-feedstock \
    r-l2boost-feedstock \
    r-label.switching-feedstock \
    r-laeken-feedstock \
    r-laf-feedstock \
    r-lambda.r-feedstock

build_all \
    r-larf-feedstock \
    r-lassopv-feedstock \
    r-progressr-feedstock \
    r-lbfgs-feedstock \
    r-lbreg-feedstock \
    r-lcf-feedstock \
    r-lclgwas-feedstock \
    r-randtoolbox-feedstock \
    r-lestat-feedstock \
    r-lfdrempiricalbayes-feedstock \
    r-lgr-feedstock \
    r-lhs-feedstock \
    r-librarian-feedstock \
    r-linkedmatrix-feedstock \
    r-linpk-feedstock \
    r-linreginteractive-feedstock

build_all \
    r-listwithdefaults-feedstock \
    r-lm.br-feedstock \
    r-lmfilter-feedstock \
    r-lmreg-feedstock \
    r-lnirt-feedstock \
    r-lobstr-feedstock \
    r-localcontrol-feedstock \
    r-localcontrolstrategy-feedstock \
    r-lodi-feedstock \
    r-loe-feedstock \
    r-logicoil-feedstock \
    r-logistic4p-feedstock \
    r-logisticrr-feedstock \
    r-lokern-feedstock \
    r-longitudinal-feedstock \
    r-lotri-feedstock

build_all \
    r-lpmodeler-feedstock \
    r-lpstimeseries-feedstock \
    r-lpwc-feedstock \
    r-lrgs-feedstock \
    r-lsa-feedstock \
    r-lspls-feedstock \
    r-rcppgsl-feedstock \
    r-lumberjack-feedstock \
    r-luzlogr-feedstock \
    r-lvec-feedstock \
    r-units-feedstock \
    r-magick-feedstock \
    r-makefiler-feedstock \
    r-mallet-feedstock \
    r-mapdata-feedstock \
    r-mapproj-feedstock

build_all \
    r-maptpx-feedstock \
    r-maptree-feedstock \
    r-mar-feedstock \
    r-matching-feedstock \
    r-matrixnormal-feedstock \
    r-matrixtests-feedstock \
    r-mba-feedstock \
    r-mc2d-feedstock \
    r-mcbftest-feedstock \
    r-mcclust-feedstock \
    r-mcheatmaps-feedstock \
    r-mcpmod-feedstock \
    r-mdendro-feedstock \
    r-mdir.logrank-feedstock \
    r-mdscore-feedstock \
    r-memo-feedstock

build_all \
    r-mergetrees-feedstock \
    r-metadat-feedstock \
    r-metadynminer-feedstock \
    r-meteor-feedstock \
    r-mgsda-feedstock \
    r-mhsmm-feedstock \
    r-michelrodange-feedstock \
    r-midn-feedstock \
    r-misaem-feedstock \
    r-misreport-feedstock \
    r-mitools-feedstock \
    r-mittagleffler-feedstock \
    r-mixedts-feedstock \
    r-mixsal-feedstock \
    r-mixsim-feedstock \
    r-mixsmsn-feedstock

build_all \
    r-mixspe-feedstock \
    r-mixtureinf-feedstock \
    r-mknapsack-feedstock \
    r-mlds-feedstock \
    r-mmand-feedstock \
    r-mmeta-feedstock \
    r-mnp-feedstock \
    r-mockr-feedstock \
    r-modifiedmk-feedstock \
    r-mondrian-feedstock \
    r-monomvn-feedstock \
    r-monopoly-feedstock \
    r-mountainplot-feedstock \
    r-mpcv-feedstock \
    r-mpe-feedstock \
    r-mpm-feedstock

build_all \
    r-mpmi-feedstock \
    r-mpv-feedstock \
    r-msde-feedstock \
    r-msg-feedstock \
    r-msme-feedstock \
    r-msu-feedstock \
    r-mullerplot-feedstock \
    r-mulset-feedstock \
    r-multicmp-feedstock \
    r-multigroup-feedstock \
    r-multipol-feedstock \
    r-multivariaterandomforest-feedstock \
    r-multiwayregression-feedstock \
    r-multxpert-feedstock \
    r-music-feedstock \
    r-mvar-feedstock

build_all \
    r-mvar.pt-feedstock \
    r-mvlm-feedstock \
    r-mvmeta-feedstock \
    r-mvna-feedstock \
    r-mvntest-feedstock \
    r-mvtmeta-feedstock \
    r-mvtsplot-feedstock \
    r-mycor-feedstock \
    r-nakagami-feedstock \
    r-nam-feedstock \
    r-nb.mclust-feedstock \
    r-neatranges-feedstock \
    r-netindices-feedstock \
    r-neuralnet-feedstock \
    r-neurosim-feedstock \
    r-newdistns-feedstock

build_all \
    r-nightday-feedstock \
    r-nlar-feedstock \
    r-nlcoptim-feedstock \
    r-nls2-feedstock \
    r-nlsr-feedstock \
    r-nmw-feedstock \
    r-nodeharvest-feedstock \
    r-nofrills-feedstock \
    r-noisyce2-feedstock \
    r-nomclust-feedstock \
    r-noncompliance-feedstock \
    r-nonneg.cg-feedstock \
    r-nortestarma-feedstock \
    r-nparld-feedstock \
    r-npmv-feedstock \
    r-nprocregression-feedstock

build_all \
    r-nsgp-feedstock \
    r-numero-feedstock \
    r-numform-feedstock \
    r-nvennr-feedstock \
    r-oacolors-feedstock \
    r-oaiharvester-feedstock \
    r-oce-feedstock \
    r-odds.n.ends-feedstock \
    r-odeintr-feedstock \
    r-offlinechange-feedstock \
    r-ogi-feedstock \
    r-ohtadstats-feedstock \
    r-olctools-feedstock \
    r-olscurve-feedstock \
    r-oncotree-feedstock \
    r-opencv-feedstock

build_all \
    r-opennlpdata-feedstock \
    r-optextras-feedstock \
    r-optigrab-feedstock \
    r-optimization-feedstock \
    r-optional-feedstock \
    r-optiscale-feedstock \
    r-optparse-feedstock \
    r-orddisp-feedstock \
    r-ordinalcont-feedstock \
    r-orthopanels-feedstock \
    r-ote-feedstock \
    r-packcircles-feedstock \
    r-pacman-feedstock \
    r-pakpmics2014ch-feedstock \
    r-pakpmics2014hh-feedstock \
    r-pakpmics2014hl-feedstock

build_all \
    r-pakpmics2014wm-feedstock \
    r-palinsol-feedstock \
    r-pampe-feedstock \
    r-pandocfilters-feedstock \
    r-panelaggregation-feedstock \
    r-parallelmcmccombine-feedstock \
    r-rcpptoml-feedstock \
    r-paramtest-feedstock \
    r-paran-feedstock \
    r-partialor-feedstock \
    r-partitionmap-feedstock \
    r-pastecs-feedstock \
    r-patternator-feedstock \
    r-pawacc-feedstock \
    r-pbsmodelling-feedstock \
    r-pcirt-feedstock

build_all \
    r-pdm-feedstock \
    r-peaksegdisk-feedstock \
    r-penmsm-feedstock \
    r-peptides-feedstock \
    r-permallows-feedstock \
    r-petfinder-feedstock \
    r-pgdraw-feedstock \
    r-pgee-feedstock \
    r-ph2bayes-feedstock \
    r-phonics-feedstock \
    r-phylometrics-feedstock \
    r-physiology-feedstock \
    r-pijavski-feedstock \
    r-piton-feedstock \
    r-pkgcond-feedstock \
    r-pki-feedstock

build_all \
    r-plfm-feedstock \
    r-plotcontour-feedstock \
    r-plsdof-feedstock \
    r-webutils-feedstock \
    r-pmultinom-feedstock \
    r-pocrm-feedstock \
    r-pointdensityp-feedstock \
    r-poisbinom-feedstock \
    r-poisdoublesamp-feedstock \
    r-polyfreqs-feedstock \
    r-polylabelr-feedstock \
    r-polypatex-feedstock \
    r-polysat-feedstock \
    r-ryacas-feedstock \
    r-pop.wolf-feedstock \
    r-population-feedstock

build_all \
    r-powercomprisk-feedstock \
    r-powerlaw-feedstock \
    r-pp-feedstock \
    r-ppcor-feedstock \
    r-prclust-feedstock \
    r-prediction-feedstock \
    r-preputils-feedstock \
    r-prettycode-feedstock \
    r-primes-feedstock \
    r-princurve-feedstock \
    r-promethee-feedstock \
    r-prosper-feedstock \
    r-proton-feedstock \
    r-protviz-feedstock \
    r-provparser-feedstock \
    r-psagraphics-feedstock

build_all \
    r-pscl-feedstock \
    r-psumtsim-feedstock \
    r-pts2polys-feedstock \
    r-ptsuite-feedstock \
    r-purging-feedstock \
    r-pvar-feedstock \
    r-pzfx-feedstock \
    r-qcapro-feedstock \
    r-qcc-feedstock \
    r-qdapregex-feedstock \
    r-qif-feedstock \
    r-reproj-feedstock \
    r-quadprogxt-feedstock \
    r-qualci-feedstock \
    r-qualv-feedstock \
    r-quantregforest-feedstock

build_all \
    r-r.blip-feedstock \
    r-r0-feedstock \
    r-sampling-feedstock \
    r-r62s3-feedstock \
    r-r6ds-feedstock \
    r-rafalib-feedstock \
    r-ramchoice-feedstock \
    r-random-feedstock \
    r-rankaggreg-feedstock \
    r-highr-feedstock \
    r-rasterize-feedstock \
    r-ratelimitr-feedstock \
    r-rbart-feedstock \
    r-rbit-feedstock \
    r-rblpapi-feedstock \
    r-rbmn-feedstock

build_all \
    r-rborist-feedstock \
    r-rbtt-feedstock \
    r-rlemon-feedstock \
    r-rcdklibs-feedstock \
    r-rchoicedialogs-feedstock \
    r-rcorpora-feedstock \
    r-rcplex-feedstock \
    r-rcppannoy-feedstock \
    r-rcppapt-feedstock \
    r-rcppbdt-feedstock \
    r-rcppcctz-feedstock \
    r-rcppclassic-feedstock \
    r-rcppcnpy-feedstock \
    r-rcppcwb-feedstock \
    r-rcppdl-feedstock \
    r-rcppexamples-feedstock

build_all \
    r-rcppfaddeeva-feedstock \
    r-rcppgetconf-feedstock \
    r-rcppgreedysetcover-feedstock \
    r-rcpphnsw-feedstock \
    r-rcpphungarian-feedstock \
    r-rcppmsgpack-feedstock \
    r-rcppquantuccia-feedstock \
    r-rcppstreams-feedstock \
    r-rcpptn-feedstock \
    r-rcppxptrutils-feedstock \
    r-rcppxsimd-feedstock \
    r-rcsf-feedstock \
    r-rcube-feedstock \
    r-rdatacanvas-feedstock \
    r-semver-feedstock \
    r-rdbnomics-feedstock

build_all \
    r-rde-feedstock \
    r-rdice-feedstock \
    r-rdroolsjars-feedstock \
    r-reactlog-feedstock \
    r-read.dbc-feedstock \
    r-readmldata-feedstock \
    r-readmzxmldata-feedstock \
    r-readobj-feedstock \
    r-readsdmx-feedstock \
    r-readstata13-feedstock \
    r-recombinator-feedstock \
    r-recorder-feedstock \
    r-recosystem-feedstock \
    r-recurse-feedstock \
    r-redm-feedstock \
    r-refinr-feedstock

build_all \
    r-relatable-feedstock \
    r-remindr-feedstock \
    r-repec-feedstock \
    r-repfdr-feedstock \
    r-repo-feedstock \
    r-reporttools-feedstock \
    r-represtools-feedstock \
    r-reservoir-feedstock \
    r-restrictedmvn-feedstock \
    r-rethinker-feedstock \
    r-rexpokit-feedstock \
    r-rflptools-feedstock \
    r-rforensicbatwing-feedstock \
    r-rformatter-feedstock \
    r-rfreak-feedstock \
    r-rfutilities-feedstock

build_all \
    r-rgammagamma-feedstock \
    r-rgcca-feedstock \
    r-rgeode-feedstock \
    r-rglpk-feedstock \
    r-rgr-feedstock \
    r-rgrass7-feedstock \
    r-rgroovy-feedstock \
    r-ri2by2-feedstock \
    r-rifle-feedstock \
    r-ring-feedstock \
    r-rinside-feedstock \
    r-rip46-feedstock \
    r-riverplot-feedstock \
    r-rivr-feedstock \
    r-rjdemetra-feedstock \
    r-rjwsacruncher-feedstock

build_all \
    r-rkeajars-feedstock \
    r-rkvo-feedstock \
    r-rlas-feedstock \
    r-rldcp-feedstock \
    r-rlibeemd-feedstock \
    r-rmallow-feedstock \
    r-rmalschains-feedstock \
    r-rmoajars-feedstock \
    r-rmpfr-feedstock \
    r-rmpw-feedstock \
    r-rmumps-feedstock \
    r-rncbieutilslibs-feedstock \
    r-rnifti-feedstock \
    r-robcp-feedstock \
    r-robfitcongraph-feedstock \
    r-rococo-feedstock

build_all \
    r-rodbcdbi-feedstock \
    r-rode-feedstock \
    r-rodeo-feedstock \
    r-roi-feedstock \
    r-roloc-feedstock \
    r-ropj-feedstock \
    r-roracle-feedstock \
    r-rotationforest-feedstock \
    r-rotor-feedstock \
    r-roughsets-feedstock \
    r-rpact-feedstock \
    r-rpart.utils-feedstock \
    r-rpartscore-feedstock \
    r-rplotengine-feedstock \
    r-rpmm-feedstock \
    r-rpostgresql-feedstock

build_all \
    r-rprintf-feedstock \
    r-rprotobuf-feedstock \
    r-rpushbullet-feedstock \
    r-rres-feedstock \
    r-rsatscan-feedstock \
    r-rsfa-feedstock \
    r-rslurm-feedstock \
    r-rsm-feedstock \
    r-rsnns-feedstock \
    r-rstack-feedstock \
    r-rstata-feedstock \
    r-rsubgroup-feedstock \
    r-rtk-feedstock \
    r-rtkore-feedstock \
    r-rtson-feedstock \
    r-rucrdtw-feedstock

build_all \
    r-ruimtehol-feedstock \
    r-runner-feedstock \
    r-runstats-feedstock \
    r-rvhpdt-feedstock \
    r-rviewgraph-feedstock \
    r-rwekajars-feedstock \
    r-rxseq-feedstock \
    r-rxshrink-feedstock \
    r-s2-feedstock \
    r-saltsampler-feedstock \
    r-samplesizelogisticcasecontrol-feedstock \
    r-samplingdatacrt-feedstock \
    r-sarp.moodle-feedstock \
    r-sbrect-feedstock \
    r-scagnostics-feedstock \
    r-scalreg-feedstock

build_all \
    r-scbmeanfd-feedstock \
    r-scci-feedstock \
    r-scclust-feedstock \
    r-scdensity-feedstock \
    r-scepter-feedstock \
    r-schoenberg-feedstock \
    r-sciviews-feedstock \
    r-scrm-feedstock \
    r-scrselect-feedstock \
    r-scrypt-feedstock \
    r-sdt-feedstock \
    r-sealasso-feedstock \
    r-seas-feedstock \
    r-seasonal-feedstock \
    r-segmentier-feedstock \
    r-segregation-feedstock

build_all \
    r-seismicroll-feedstock \
    r-sel-feedstock \
    r-selectiongain-feedstock \
    r-selectmeta-feedstock \
    r-selemix-feedstock \
    r-sendmailr-feedstock \
    r-sensitivity2x2xk-feedstock \
    r-senstrat-feedstock \
    r-seqmade-feedstock \
    r-sequences-feedstock \
    r-sequential-feedstock \
    r-setter-feedstock \
    r-sgpdata-feedstock \
    r-sgr-feedstock \
    r-shapefiles-feedstock \
    r-sharpdata-feedstock

build_all \
    r-shiftsharese-feedstock \
    r-shipunov-feedstock \
    r-shopifyr-feedstock \
    r-showimage-feedstock \
    r-signal-feedstock \
    r-sigora-feedstock \
    r-sim.diffproc-feedstock \
    r-simboot-feedstock \
    r-simcop-feedstock \
    r-simframe-feedstock \
    r-similar-feedstock \
    r-simmer-feedstock \
    r-simpleboot-feedstock \
    r-simplercache-feedstock \
    r-simputation-feedstock \
    r-simsalapar-feedstock

build_all \
    r-sisvive-feedstock \
    r-sizer-feedstock \
    r-sjdbc-feedstock \
    r-slim-feedstock \
    r-smallarea-feedstock \
    r-smartsizer-feedstock \
    r-smfsb-feedstock \
    r-smoothmest-feedstock \
    r-snem-feedstock \
    r-sobolsequence-feedstock \
    r-soccer-feedstock \
    r-social-feedstock \
    r-sodavis-feedstock \
    r-sofia-feedstock \
    r-sos-feedstock \
    r-spanish-feedstock

build_all \
    r-sparsemse-feedstock \
    r-spatialml-feedstock \
    r-spatialpack-feedstock \
    r-spcalda-feedstock \
    r-spcavrp-feedstock \
    r-spd-feedstock \
    r-specdetec-feedstock \
    r-specklestar-feedstock \
    r-spiderbar-feedstock \
    r-spikeslab-feedstock \
    r-spin-feedstock \
    r-splitfeas-feedstock \
    r-splitstackshape-feedstock \
    r-spls-feedstock \
    r-spurs-feedstock \
    r-sqlrender-feedstock

build_all \
    r-sqrl-feedstock \
    r-srttools-feedstock \
    r-sse-feedstock \
    r-sss-feedstock \
    r-sssimple-feedstock \
    r-stabreg-feedstock \
    r-startdesign-feedstock \
    r-statdataml-feedstock \
    r-statmeasures-feedstock \
    r-stdvectors-feedstock \
    r-stem-feedstock \
    r-stepsignalmargilike-feedstock \
    r-stevedore-feedstock \
    r-stima-feedstock \
    r-stmgp-feedstock \
    r-stochprofml-feedstock

build_all \
    r-stockr-feedstock \
    r-stopwords-feedstock \
    r-storr-feedstock \
    r-stosim-feedstock \
    r-streambugs-feedstock \
    r-strider-feedstock \
    r-stringb-feedstock \
    r-stripless-feedstock \
    r-sudokualt-feedstock \
    r-supc-feedstock \
    r-supcluster-feedstock \
    r-svdvisual-feedstock \
    r-svmpath-feedstock \
    r-swephr-feedstock \
    r-synchronicity-feedstock \
    r-syntaxr-feedstock

build_all \
    r-systemicrisk-feedstock \
    r-table1heatmap-feedstock \
    r-tablematrix-feedstock \
    r-tablemonster-feedstock \
    r-tabulog-feedstock \
    r-tagcloud-feedstock \
    r-tailloss-feedstock \
    r-taqmngr-feedstock \
    r-tar-feedstock \
    r-taskscheduler-feedstock \
    r-tbd-feedstock \
    r-tdboost-feedstock \
    r-tdcor-feedstock \
    r-tdigest-feedstock \
    r-tdsc-feedstock \
    r-tensr-feedstock

build_all \
    r-ternvis-feedstock \
    r-textshape-feedstock \
    r-tfmpvalue-feedstock \
    r-tfse-feedstock \
    r-tfx-feedstock \
    r-tggd-feedstock \
    r-threearmedtrials-feedstock \
    r-thsls-feedstock \
    r-tidetables-feedstock \
    r-tilting-feedstock \
    r-timechange-feedstock \
    r-timedelay-feedstock \
    r-timesboot-feedstock \
    r-tlm-feedstock \
    r-tmvmixnorm-feedstock \
    r-tokenbrowser-feedstock

build_all \
    r-tokenizers.bpe-feedstock \
    r-tosls-feedstock \
    r-touch-feedstock \
    r-tpmsm-feedstock \
    r-tracerer-feedstock \
    r-triebeard-feedstock \
    r-tserieschaos-feedstock \
    r-tstutorial-feedstock \
    r-ttmoment-feedstock \
    r-ttwa-feedstock \
    r-twosamples-feedstock \
    r-ulid-feedstock \
    r-unf-feedstock \
    r-uniisoregression-feedstock \
    r-unine-feedstock \
    r-diffobj-feedstock

build_all \
    r-unrtf-feedstock \
    r-usmap-feedstock \
    r-valaddin-feedstock \
    r-vapour-feedstock \
    r-varbin-feedstock \
    r-varselrf-feedstock \
    r-vecsets-feedstock \
    r-vecstatgraphs2d-feedstock \
    r-venn-feedstock \
    r-venneuler-feedstock \
    r-verylargeintegers-feedstock \
    r-vgamdata-feedstock \
    r-vgamextra-feedstock \
    r-visreg-feedstock \
    r-vita-feedstock \
    r-vlmc-feedstock

build_all \
    r-vottrans-feedstock \
    r-w3cmarkupvalidator-feedstock \
    r-wamasim-feedstock \
    r-warn-feedstock \
    r-waterfall-feedstock \
    r-wavethresh-feedstock \
    r-wdi-feedstock \
    r-wdm-feedstock \
    r-wheatmap-feedstock \
    r-whitening-feedstock \
    r-wildcard-feedstock \
    r-wingui-feedstock \
    r-wisam-feedstock \
    r-wnl-feedstock \
    r-wordcloud-feedstock \
    r-wordnet-feedstock

build_all \
    r-wpp2017-feedstock \
    r-wpp2019-feedstock \
    r-wrswor-feedstock \
    r-wsrf-feedstock \
    r-wwr-feedstock \
    r-xbrl-feedstock \
    r-xmlrpc2-feedstock \
    r-xr-feedstock \
    r-xslt-feedstock \
    r-xtensor-feedstock \
    r-ypinterimtesting-feedstock \
    r-yum-feedstock \
    r-zim-feedstock \
    r-zseq-feedstock \
    r-munsell-feedstock \
    r-tzdb-feedstock

build_all \
    r-here-feedstock


build_all \
    r-abnormality-feedstock \
    r-ace2fastq-feedstock \
    r-acet-feedstock \
    r-rcppeigen-feedstock \
    r-sandwich-feedstock \
    r-acss-feedstock \
    r-r.utils-feedstock \
    r-adaptivesparsity-feedstock \
    r-ramcmc-feedstock \
    r-addhaz-feedstock \
    r-coneproj-feedstock \
    r-ade4-feedstock \
    r-adwordsr-feedstock \
    r-lmtest-feedstock \
    r-survival-feedstock \
    r-reshape2-feedstock

build_all \
    r-aghmatrix-feedstock \
    r-psych-feedstock \
    r-akima-feedstock \
    r-algaeclassify-feedstock \
    r-alpaca-feedstock \
    r-alphasimr-feedstock \
    r-metafor-feedstock \
    r-rjags-feedstock \
    r-altopt-feedstock \
    r-amelia-feedstock \
    r-anmc-feedstock \
    r-doparallel-feedstock \
    r-reshape-feedstock \
    r-apcluster-feedstock \
    r-apdesign-feedstock \
    r-ape-feedstock

build_all \
    r-corelearn-feedstock \
    r-approximator-feedstock \
    r-arules-feedstock \
    r-xts-feedstock \
    r-argonr-feedstock \
    r-aricode-feedstock \
    r-arrapply-feedstock \
    r-vctrs-feedstock \
    r-knitr-feedstock \
    r-asciiruler-feedstock \
    r-asgs.foyer-feedstock \
    r-asnipe-feedstock \
    r-aspc-feedstock \
    r-assertive.files-feedstock \
    r-assertive.types-feedstock \
    r-aster2-feedstock

build_all \
    r-desc-feedstock \
    r-awr.athena-feedstock \
    r-awr.kms-feedstock \
    r-openssl-feedstock \
    r-lavaan-feedstock \
    r-gplots-feedstock \
    r-bamp-feedstock \
    r-barycenter-feedstock \
    r-baseline-feedstock \
    r-hypergeo-feedstock \
    r-bayescomm-feedstock \
    r-bayesdccgarch-feedstock \
    r-bayesgarch-feedstock \
    r-bayesimages-feedstock \
    r-igraph-feedstock \
    r-bayesm-feedstock

build_all \
    r-bayessae-feedstock \
    r-baystar-feedstock \
    r-proc-feedstock \
    r-bbmisc-feedstock \
    r-bbmle-feedstock \
    r-bcf-feedstock \
    r-bcp-feedstock \
    r-bcpa-feedstock \
    r-bdots-feedstock \
    r-beepr-feedstock \
    r-belg-feedstock \
    r-grpreg-feedstock \
    r-bestree-feedstock \
    r-betategarch-feedstock \
    r-bevimed-feedstock \
    r-bhsbvar-feedstock

build_all \
    r-bibtex-feedstock \
    r-bife-feedstock \
    r-bigalgebra-feedstock \
    r-biganalytics-feedstock \
    r-bigmap-feedstock \
    r-bigreg-feedstock \
    r-bimodalindex-feedstock \
    r-e1071-feedstock \
    r-binnonnor-feedstock \
    r-binseqtest-feedstock \
    r-htmlwidgets-feedstock \
    r-biodry-feedstock \
    r-copula-feedstock \
    r-blockmodeling-feedstock \
    r-blockmodels-feedstock \
    r-blocksdesign-feedstock

build_all \
    r-bmamevt-feedstock \
    r-bmk-feedstock \
    r-boltzmm-feedstock \
    r-jquerylib-feedstock \
    r-boomspikeslab-feedstock \
    r-boottol-feedstock \
    r-bosonsampling-feedstock \
    r-bpa-feedstock \
    r-bracer-feedstock \
    r-brant-feedstock \
    r-breeze-feedstock \
    r-brlrmr-feedstock \
    r-brugs-feedstock \
    r-buddle-feedstock \
    r-mgcv-feedstock \
    r-busdater-feedstock

build_all \
    r-bvarsv-feedstock \
    r-bvartools-feedstock \
    r-memoise-feedstock \
    r-c212-feedstock \
    r-calibrator-feedstock \
    r-caman-feedstock \
    r-maptools-feedstock \
    r-pryr-feedstock \
    r-catencoders-feedstock \
    r-ccapp-feedstock \
    r-cccp-feedstock \
    r-raster-feedstock \
    r-cepreader-feedstock \
    r-ceriolioutlierdetection-feedstock \
    r-cggp-feedstock \
    r-changepoint-feedstock

build_all \
    r-changepointshd-feedstock \
    r-channelattribution-feedstock \
    r-chcn-feedstock \
    r-readjdx-feedstock \
    r-cherry-feedstock \
    r-chk-feedstock \
    r-chords-feedstock \
    r-ciaawconsensus-feedstock \
    r-circmle-feedstock \
    r-circoutlier-feedstock \
    r-circularddm-feedstock \
    r-cirt-feedstock \
    r-ckmeans.1d.dp-feedstock \
    r-cladorcpp-feedstock \
    r-classifly-feedstock \
    r-clusternomics-feedstock

build_all \
    r-clv-feedstock \
    r-clvalid-feedstock \
    r-cmvnorm-feedstock \
    r-cnorm-feedstock \
    r-coda.base-feedstock \
    r-codadiags-feedstock \
    r-codatags-feedstock \
    r-cointreg-feedstock \
    r-cold-feedstock \
    r-comat-feedstock \
    r-commentr-feedstock \
    r-comorbidity-feedstock \
    r-cord-feedstock \
    r-corrcoverage-feedstock \
    r-covbm-feedstock \
    r-covfefe-feedstock

build_all \
    r-covtestr-feedstock \
    r-scales-feedstock \
    r-coxplus-feedstock \
    r-cpcg-feedstock \
    r-cpgassoc-feedstock \
    r-cplots-feedstock \
    r-cpmcglm-feedstock \
    r-crf-feedstock \
    r-crisp-feedstock \
    r-crosstalk-feedstock \
    r-crso-feedstock \
    r-urltools-feedstock \
    r-cseqpat-feedstock \
    r-csrplus-feedstock \
    r-cthresher-feedstock \
    r-cubfits-feedstock

build_all \
    r-cusum-feedstock \
    r-cvst-feedstock \
    r-cvtools-feedstock \
    r-callr-feedstock \
    r-d3network-feedstock \
    r-daag-feedstock \
    r-dashboard-feedstock \
    r-xlsx-feedstock \
    r-datassim-feedstock \
    r-datastructures-feedstock \
    r-dbest-feedstock \
    r-dcl-feedstock \
    r-dcov-feedstock \
    r-dcurver-feedstock \
    r-geometry-feedstock \
    r-irlba-feedstock

build_all \
    r-deepnn-feedstock \
    r-derivmkts-feedstock \
    r-desnowball-feedstock \
    r-detector-feedstock \
    r-devfunc-feedstock \
    r-sessioninfo-feedstock \
    r-dfmta-feedstock \
    r-dfphase1-feedstock \
    r-dga-feedstock \
    r-dglars-feedstock \
    r-diagrammersvg-feedstock \
    r-dialr-feedstock \
    r-discreterv-feedstock \
    r-mvnfast-feedstock \
    r-dmt-feedstock \
    r-dobad-feedstock

build_all \
    r-domc-feedstock \
    r-dorng-feedstock \
    r-dosnow-feedstock \
    r-dpp-feedstock \
    r-dqrng-feedstock \
    r-drimpute-feedstock \
    r-dsbayes-feedstock \
    r-promises-feedstock \
    r-dtd-feedstock \
    r-dtp-feedstock \
    r-dtsg-feedstock \
    r-dwdlarger-feedstock \
    r-rcppziggurat-feedstock \
    r-dyn-feedstock \
    r-dyncomp-feedstock \
    r-eaf-feedstock

build_all \
    r-easyanova-feedstock \
    r-easyreg-feedstock \
    r-ecctmc-feedstock \
    r-effectstars2-feedstock \
    r-egst-feedstock \
    r-eikosograms-feedstock \
    r-elrm-feedstock \
    r-emcluster-feedstock \
    r-emmreml-feedstock \
    r-empichar-feedstock \
    r-emvs-feedstock \
    r-endorse-feedstock \
    r-energyonlinecpm-feedstock \
    r-esmprep-feedstock \
    r-evapotranspiration-feedstock \
    r-reticulate-feedstock

build_all \
    r-excursions-feedstock \
    r-exdex-feedstock \
    r-expm-feedstock \
    r-factory-feedstock \
    r-fanc-feedstock \
    r-far-feedstock \
    r-farmtest-feedstock \
    r-fastbandchol-feedstock \
    r-fastcox-feedstock \
    r-fasterelasticnet-feedstock \
    r-fasthica-feedstock \
    r-fastimputation-feedstock \
    r-fastm-feedstock \
    r-fastnaivebayes-feedstock \
    r-fbasics-feedstock \
    r-fbfsearch-feedstock

build_all \
    r-fclust-feedstock \
    r-fdamixed-feedstock \
    r-featurehashing-feedstock \
    r-fimport-feedstock \
    r-fints-feedstock \
    r-fitpoly-feedstock \
    r-flamingos-feedstock \
    r-flexclust-feedstock \
    r-flexparamcurve-feedstock \
    r-gdtools-feedstock \
    r-flowregenvcost-feedstock \
    r-flux-feedstock \
    r-fmcmc-feedstock \
    r-fmdates-feedstock \
    r-fontawesome-feedstock \
    r-urca-feedstock

build_all \
    r-forestplot-feedstock \
    r-forwardsearch-feedstock \
    r-fourierin-feedstock \
    r-fourpno-feedstock \
    r-fpc-feedstock \
    r-fracprolif-feedstock \
    r-frcc-feedstock \
    r-freegroup-feedstock \
    r-pkgfilecache-feedstock \
    r-sass-feedstock \
    r-fsinteract-feedstock \
    r-fst-feedstock \
    r-future-feedstock \
    r-ga-feedstock \
    r-gam-feedstock \
    r-gamlr-feedstock

build_all \
    r-gaparsimony-feedstock \
    r-gaselect-feedstock \
    r-gcdnet-feedstock \
    r-gckrig-feedstock \
    r-geem-feedstock \
    r-gen2stage-feedstock \
    r-genemodel-feedstock \
    r-genepop-feedstock \
    r-genetics-feedstock \
    r-genie-feedstock \
    r-genmeta-feedstock \
    r-genord-feedstock \
    r-geojson-feedstock \
    r-rgeos-feedstock \
    r-jsonvalidate-feedstock \
    r-geojsonr-feedstock

build_all \
    r-sfheaders-feedstock \
    r-geosphere-feedstock \
    r-gets-feedstock \
    r-gridtext-feedstock \
    r-ghibli-feedstock \
    r-giraf-feedstock \
    r-gitlink-feedstock \
    r-glamlasso-feedstock \
    r-gldex-feedstock \
    r-glmaspu-feedstock \
    r-glmmadaptive-feedstock \
    r-gmmboost-feedstock \
    r-gmapsdistance-feedstock \
    r-gmcm-feedstock \
    r-gmodels-feedstock \
    r-gmwt-feedstock

build_all \
    r-goric-feedstock \
    r-gpg-feedstock \
    r-gprofiler-feedstock \
    r-gpvam-feedstock \
    r-grassmannoptim-feedstock \
    r-greedyepl-feedstock \
    r-gremlin-feedstock \
    r-groupseq-feedstock \
    r-growthrate-feedstock \
    r-grpstring-feedstock \
    r-gtfsrouter-feedstock \
    r-guerry-feedstock \
    r-gustave-feedstock \
    r-gvc-feedstock \
    r-gwfa-feedstock \
    r-h2o-feedstock

build_all \
    r-hawkes-feedstock \
    r-hbsae-feedstock \
    r-hdbm-feedstock \
    r-hdf5r-feedstock \
    r-hellcor-feedstock \
    r-hglm.data-feedstock \
    r-highmean-feedstock \
    r-higrad-feedstock \
    r-hkevp-feedstock \
    r-hmb-feedstock \
    r-hpa-feedstock \
    r-hsdm-feedstock \
    r-humanize-feedstock \
    r-icdglm-feedstock \
    r-idcard-feedstock \
    r-iilasso-feedstock

build_all \
    r-inca-feedstock \
    r-install.load-feedstock \
    r-installr-feedstock \
    r-splines2-feedstock \
    r-interep-feedstock \
    r-intsurv-feedstock \
    r-inum-feedstock \
    r-invctr-feedstock \
    r-investr-feedstock \
    r-irishdirectorates-feedstock \
    r-isat-feedstock \
    r-isoweek-feedstock \
    r-isqg-feedstock \
    r-iterpc-feedstock \
    r-itop-feedstock \
    r-jade-feedstock

build_all \
    r-snakecase-feedstock \
    r-jmi-feedstock \
    r-jmotif-feedstock \
    r-josae-feedstock \
    r-jsonld-feedstock \
    r-svglite-feedstock \
    r-kamila-feedstock \
    r-kernelknn-feedstock \
    r-keyringr-feedstock \
    r-kinship2-feedstock \
    r-knitrprogressbar-feedstock \
    r-minerva-feedstock \
    r-kofnga-feedstock \
    r-krige-feedstock \
    r-l0ara-feedstock \
    r-langevin-feedstock

build_all \
    r-lassobacktracking-feedstock \
    r-latdiag-feedstock \
    r-latex2exp-feedstock \
    r-lazysql-feedstock \
    r-lbfgsb3c-feedstock \
    r-lcpm-feedstock \
    r-leabra-feedstock \
    r-learningr-feedstock \
    r-leersiecyl-feedstock \
    r-lemarns-feedstock \
    r-lgarch-feedstock \
    r-liger-feedstock \
    r-likelihood-feedstock \
    r-likelihoodexplore-feedstock \
    r-lindenmayer-feedstock \
    r-linselect-feedstock

build_all \
    r-lllcrc-feedstock \
    r-lmeinfo-feedstock \
    r-lmesplines-feedstock \
    r-lmoments-feedstock \
    r-lognorm-feedstock \
    r-loo-feedstock \
    r-loon-feedstock \
    r-loopanalyst-feedstock \
    r-lowmemtkmeans-feedstock \
    r-lpbrim-feedstock \
    r-powdist-feedstock \
    r-lpower-feedstock \
    r-lrcontrast-feedstock \
    r-polycor-feedstock \
    r-lsmeans-feedstock \
    r-ltable-feedstock

build_all \
    r-ltsbase-feedstock \
    r-lucid-feedstock \
    r-lutz-feedstock \
    r-lvmcomp-feedstock \
    r-managelocalrepo-feedstock \
    r-manifoldoptim-feedstock \
    r-mapfit-feedstock \
    r-mat-feedstock \
    r-matchingr-feedstock \
    r-matlabr-feedstock \
    r-matrixmodels-feedstock \
    r-maxact-feedstock \
    r-mazeinda-feedstock \
    r-mbc-feedstock \
    r-mcgibbsit-feedstock \
    r-mcglm-feedstock

build_all \
    r-mcmcplots-feedstock \
    r-mcpmodgeneral-feedstock \
    r-mcsim-feedstock \
    r-mda-feedstock \
    r-mdatools-feedstock \
    r-mdhglm-feedstock \
    r-mdw-feedstock \
    r-mederrrank-feedstock \
    r-medextractr-feedstock \
    r-mefa4-feedstock \
    r-meifly-feedstock \
    r-metablue-feedstock \
    r-metaboqc-feedstock \
    r-metafolio-feedstock \
    r-metaheuristicfpa-feedstock \
    r-methodcompare-feedstock

build_all \
    r-meto-feedstock \
    r-metrology-feedstock \
    r-miceconindex-feedstock \
    r-micefast-feedstock \
    r-micromapst-feedstock \
    r-migration.indices-feedstock \
    r-mixedmem-feedstock \
    r-mixmatrix-feedstock \
    r-mixture-feedstock \
    r-mlapi-feedstock \
    r-mlr3misc-feedstock \
    r-mltools-feedstock \
    r-mme-feedstock \
    r-mmmgee-feedstock \
    r-mmpf-feedstock \
    r-mmsample-feedstock

build_all \
    r-mocca-feedstock \
    r-modalclust-feedstock \
    r-moult-feedstock \
    r-mp-feedstock \
    r-mscombine-feedstock \
    r-mswm-feedstock \
    r-multiassetoptions-feedstock \
    r-multifit-feedstock \
    r-multilevel-feedstock \
    r-multiplebubbles-feedstock \
    r-multiroc-feedstock \
    r-multisom-feedstock \
    r-multivator-feedstock \
    r-multiway-feedstock \
    r-mumin-feedstock \
    r-murl-feedstock

build_all \
    r-murty-feedstock \
    r-mvglmmrank-feedstock \
    r-mvnbayesian-feedstock \
    r-mwright-feedstock \
    r-n1qn1-feedstock \
    r-nadiv-feedstock \
    r-naptime-feedstock \
    r-tuner-feedstock \
    r-ncpen-feedstock \
    r-negbinbetabinreg-feedstock \
    r-netregr-feedstock \
    r-ngspatial-feedstock \
    r-nlmeu-feedstock \
    r-nlms-feedstock \
    r-nonnormvtdist-feedstock \
    r-nopaco-feedstock

build_all \
    r-npcd-feedstock \
    r-numbersbr-feedstock \
    r-odb-feedstock \
    r-odenetwork-feedstock \
    r-okmesonet-feedstock \
    r-onetr-feedstock \
    r-onion-feedstock \
    r-optimbase-feedstock \
    r-order2parent-feedstock \
    r-ordinalclust-feedstock \
    r-orsifronts-feedstock \
    r-orsk-feedstock \
    r-osqp-feedstock \
    r-overture-feedstock \
    r-oxcaar-feedstock \
    r-pagwas-feedstock

build_all \
    r-parglm-feedstock \
    r-patchsynctex-feedstock \
    r-pbo-feedstock \
    r-pbv-feedstock \
    r-qpdf-feedstock \
    r-pedigreetools-feedstock \
    r-pedometrics-feedstock \
    r-pense-feedstock \
    r-pepsavims-feedstock \
    r-ph2mult-feedstock \
    r-phenex-feedstock \
    r-physactbedrest-feedstock \
    r-picasso-feedstock \
    r-pieceexpintensity-feedstock \
    r-pingr-feedstock \
    r-pkgmaker-feedstock

build_all \
    r-plordprob-feedstock \
    r-plusser-feedstock \
    r-pmml-feedstock \
    r-poisbinnonnor-feedstock \
    r-poisnonnor-feedstock \
    r-poisnor-feedstock \
    r-polycub-feedstock \
    r-polysegratio-feedstock \
    r-pomaspu-feedstock \
    r-pool-feedstock \
    r-popreconstruct-feedstock \
    r-portfolio-feedstock \
    r-ppmr-feedstock \
    r-profilelikelihood-feedstock \
    r-profr-feedstock \
    r-prospectr-feedstock

build_all \
    r-rcppde-feedstock \
    r-pullword-feedstock \
    r-pulsar-feedstock \
    r-pumilior-feedstock \
    r-pvclass-feedstock \
    r-pwd-feedstock \
    r-pyinit-feedstock \
    r-qaig-feedstock \
    r-qdaptools-feedstock \
    r-qgglmm-feedstock \
    r-qkerntool-feedstock \
    r-qqman-feedstock \
    r-qtlrel-feedstock \
    r-qz-feedstock \
    r-r2admb-feedstock \
    r-r2d2-feedstock

build_all \
    r-r2openbugs-feedstock \
    r-r2winbugs-feedstock \
    r-r4couchdb-feedstock \
    r-radwords-feedstock \
    r-textshaping-feedstock \
    r-ratios-feedstock \
    r-rbacon-feedstock \
    r-rbiouml-feedstock \
    r-rbitcoinchartsapi-feedstock \
    r-rcbalance-feedstock \
    r-rcgmin-feedstock \
    r-rclinicalcodes-feedstock \
    r-xopen-feedstock \
    r-rcppdist-feedstock \
    r-rcppensmallen-feedstock \
    r-rcpphmm-feedstock

build_all \
    r-rcppsmc-feedstock \
    r-rdist-feedstock \
    r-rdsm-feedstock \
    r-rdstk-feedstock \
    r-rdtq-feedstock \
    r-reactr-feedstock \
    r-readbulk-feedstock \
    r-realvams-feedstock \
    r-recoder-feedstock \
    r-reemtree-feedstock \
    r-reglogit-feedstock \
    r-repolr-feedstock \
    r-reportreg-feedstock \
    r-resemble-feedstock \
    r-restimizeapi-feedstock \
    r-revgeo-feedstock

build_all \
    r-rexperigen-feedstock \
    r-rfgls-feedstock \
    r-rgdal-feedstock \
    r-rgooglemaps-feedstock \
    r-rh2-feedstock \
    r-rhor-feedstock \
    r-rhpcbenchmark-feedstock \
    r-rhpcc-feedstock \
    r-rjazz-feedstock \
    r-rjsdmx-feedstock \
    r-rjstat-feedstock \
    r-rkeeljars-feedstock \
    r-rlakeanalyzer-feedstock \
    r-rltp-feedstock \
    r-rmatio-feedstock \
    r-rmecabko-feedstock

build_all \
    r-rmi-feedstock \
    r-rmio-feedstock \
    r-rmisc-feedstock \
    r-rmixpanel-feedstock \
    r-rmr-feedstock \
    r-rmthreshold-feedstock \
    r-rnaturalearthdata-feedstock \
    r-rnavicell-feedstock \
    r-rneos-feedstock \
    r-rngforgpd-feedstock \
    r-rnomni-feedstock \
    r-rnr-feedstock \
    r-roauth-feedstock \
    r-robfilter-feedstock \
    r-robustreg-feedstock \
    r-robustx-feedstock

build_all \
    r-rollregres-feedstock \
    r-ropendota-feedstock \
    r-ropensecretsapi-feedstock \
    r-roptim-feedstock \
    r-rotasym-feedstock \
    r-rpensemble-feedstock \
    r-rpms-feedstock \
    r-rprime-feedstock \
    r-rquantlib-feedstock \
    r-rrcov-feedstock \
    r-rri-feedstock \
    r-rscimark-feedstock \
    r-rsiena-feedstock \
    r-rskey-feedstock \
    r-rslp-feedstock \
    r-rsmartlyio-feedstock

build_all \
    r-rspde-feedstock \
    r-rstorm-feedstock \
    r-rsvd-feedstock \
    r-rtematres-feedstock \
    r-rtf-feedstock \
    r-runjags-feedstock \
    r-rwhois-feedstock \
    r-rwishart-feedstock \
    r-rworldxtra-feedstock \
    r-rxkcd-feedstock \
    r-ryoudaotranslate-feedstock \
    r-salty-feedstock \
    r-samurais-feedstock \
    r-sbmsdp-feedstock \
    r-sbsa-feedstock \
    r-scientotext-feedstock

build_all \
    r-scmodels-feedstock \
    r-scorepeak-feedstock \
    r-screenclean-feedstock \
    r-scriptname-feedstock \
    r-sdpt3r-feedstock \
    r-sdwd-feedstock \
    r-seacarb-feedstock \
    r-secure-feedstock \
    r-seeclickfixr-feedstock \
    r-seermapper2010east-feedstock \
    r-seermapper2010regs-feedstock \
    r-seermapper2010west-feedstock \
    r-seermappereast-feedstock \
    r-seermapperregs-feedstock \
    r-seermapperwest-feedstock \
    r-segmag-feedstock

build_all \
    r-segmented-feedstock \
    r-segmentr-feedstock \
    r-selfingtree-feedstock \
    r-semipar-feedstock \
    r-sensory-feedstock \
    r-seqcbs-feedstock \
    r-sfs-feedstock \
    r-sgb-feedstock \
    r-sharpr2-feedstock \
    r-shrinkcovmat-feedstock \
    r-simcdm-feedstock \
    r-simecol-feedstock \
    r-siminf-feedstock \
    r-sinaplot-feedstock \
    r-skmeans-feedstock \
    r-sleepr-feedstock

build_all \
    r-slfm-feedstock \
    r-slope-feedstock \
    r-smma-feedstock \
    r-sns-feedstock \
    r-softimpute-feedstock \
    r-soilhyp-feedstock \
    r-soiltexture-feedstock \
    r-solar-feedstock \
    r-solartime-feedstock \
    r-sommer-feedstock \
    r-somplot-feedstock \
    r-sopie-feedstock \
    r-sor-feedstock \
    r-spaddins-feedstock \
    r-sparsebnutils-feedstock \
    r-sparsemvn-feedstock

build_all \
    r-sparsestep-feedstock \
    r-sparsesvd-feedstock \
    r-sparsio-feedstock \
    r-spatgraphs-feedstock \
    r-spatialacc-feedstock \
    r-spatstat.data-feedstock \
    r-spatstat.sparse-feedstock \
    r-spbayes-feedstock \
    r-spbsampling-feedstock \
    r-spec-feedstock \
    r-specsverification-feedstock \
    r-speedglm-feedstock \
    r-splancs-feedstock \
    r-splitreg-feedstock \
    r-spnn-feedstock \
    r-srm-feedstock

build_all \
    r-ssbtools-feedstock \
    r-sscor-feedstock \
    r-ssdr-feedstock \
    r-ssosvm-feedstock \
    r-stabm-feedstock \
    r-staplr-feedstock \
    r-statnet.common-feedstock \
    r-steadyica-feedstock \
    r-stepwisetest-feedstock \
    r-stochvol-feedstock \
    r-stratest-feedstock \
    r-stratifiedbalancing-feedstock \
    r-string2adjmatrix-feedstock \
    r-stringformattr-feedstock \
    r-strip-feedstock \
    r-striprtf-feedstock

build_all \
    r-stylest-feedstock \
    r-subtite-feedstock \
    r-suncalc-feedstock \
    r-sunder-feedstock \
    r-sundialr-feedstock \
    r-supclust-feedstock \
    r-superdiag-feedstock \
    r-svgviewr-feedstock \
    r-svmmatch-feedstock \
    r-svmplus-feedstock \
    r-svs-feedstock \
    r-sweidnumbr-feedstock \
    r-switchr-feedstock \
    r-sybil-feedstock \
    r-synlik-feedstock \
    r-tablaxlsx-feedstock

build_all \
    r-tactile-feedstock \
    r-tatoo-feedstock \
    r-taustar-feedstock \
    r-tbart-feedstock \
    r-tdpanalysis-feedstock \
    r-tempcont-feedstock \
    r-tenispolar-feedstock \
    r-testcor-feedstock \
    r-testingsimilarity-feedstock \
    r-texexamrandomizer-feedstock \
    r-textreg-feedstock \
    r-texttinyr-feedstock \
    r-tgram-feedstock \
    r-thinknum-feedstock \
    r-threeboost-feedstock \
    r-timeprojection-feedstock

build_all \
    r-timer-feedstock \
    r-tm.plugin.alceste-feedstock \
    r-tm.plugin.dc-feedstock \
    r-tm.plugin.europresse-feedstock \
    r-tm.plugin.lexisnexis-feedstock \
    r-tm.plugin.mail-feedstock \
    r-tm.plugin.webmining-feedstock \
    r-topicmodels-feedstock \
    r-totalcensus-feedstock \
    r-treecm-feedstock \
    r-tsbox-feedstock \
    r-tsp-feedstock \
    r-tsqn-feedstock \
    r-udpipe-feedstock \
    r-ultimixt-feedstock \
    r-unitedr-feedstock

build_all \
    r-unitizer-feedstock \
    r-uptimerobot-feedstock \
    r-ustyc-feedstock \
    r-varband-feedstock \
    r-vec2dtransf-feedstock \
    r-votesys-feedstock \
    r-wcorr-feedstock \
    r-websocket-feedstock \
    r-weibullr-feedstock \
    r-whereami-feedstock \
    r-wkb-feedstock \
    r-word.alignment-feedstock \
    r-wpp2015-feedstock \
    r-x12-feedstock \
    r-xgboost-feedstock \
    r-xml2r-feedstock

build_all \
    r-yaletoolkit-feedstock \
    r-ykmeans-feedstock \
    r-zendeskr-feedstock \
    r-zic-feedstock \
    r-zillowr-feedstock \
    r-ztree-feedstock \
    r-selectr-feedstock


build_all \
    r-acrt-feedstock \
    r-httr-feedstock \
    r-activityindex-feedstock \
    r-adaptmcmc-feedstock \
    r-addt-feedstock \
    r-adegraphics-feedstock \
    r-admmnet-feedstock \
    r-spatstat.geom-feedstock \
    r-agreementinterval-feedstock \
    r-ahaz-feedstock \
    r-apachelogprocessor-feedstock \
    r-survey-feedstock \
    r-apml0-feedstock \
    r-appliedpredictivemodeling-feedstock \
    r-cmprsk-feedstock \
    r-arc-feedstock

build_all \
    r-glmnet-feedstock \
    r-tidyselect-feedstock \
    r-arsenal-feedstock \
    r-arulesnbminer-feedstock \
    r-arulessequences-feedstock \
    r-assertive.code-feedstock \
    r-assertive.datetimes-feedstock \
    r-assertive.strings-feedstock \
    r-keyring-feedstock \
    r-auto.pca-feedstock \
    r-bain-feedstock \
    r-balancecheck-feedstock \
    r-bammtools-feedstock \
    r-barcodingr-feedstock \
    r-bart-feedstock \
    r-base64-feedstock

build_all \
    r-bass-feedstock \
    r-bayesdistreg-feedstock \
    r-bayesloglin-feedstock \
    r-bayesmix-feedstock \
    r-bayesmixsurv-feedstock \
    r-bayess-feedstock \
    r-bbl-feedstock \
    r-bcrypt-feedstock \
    r-bdgraph-feedstock \
    r-betalink-feedstock \
    r-betareg-feedstock \
    r-bigtabulate-feedstock \
    r-bigvar-feedstock \
    r-bimets-feedstock \
    r-bindata-feedstock \
    r-binnor-feedstock

build_all \
    r-biocircos-feedstock \
    r-bios2cor-feedstock \
    r-compound.cox-feedstock \
    r-bivarp-feedstock \
    r-bivgeom-feedstock \
    r-blockforest-feedstock \
    r-blsm-feedstock \
    r-bnpsd-feedstock \
    r-bnsl-feedstock \
    r-bnstruct-feedstock \
    r-visnetwork-feedstock \
    r-crul-feedstock \
    r-boolnet-feedstock \
    r-ranger-feedstock \
    r-httpuv-feedstock \
    r-bslib-feedstock

build_all \
    r-bsda-feedstock \
    r-bsts-feedstock \
    r-bucky-feedstock \
    r-bwgr-feedstock \
    r-bwstest-feedstock \
    r-c3net-feedstock \
    r-caper-feedstock \
    r-quantreg-feedstock \
    r-careless-feedstock \
    r-carrier-feedstock \
    r-cchs-feedstock \
    r-cengam-feedstock \
    r-censcov-feedstock \
    r-censorcopula-feedstock \
    r-centiserve-feedstock \
    r-cernaseek-feedstock

build_all \
    r-cfc-feedstock \
    r-cglasso-feedstock \
    r-chromomap-feedstock \
    r-ciee-feedstock \
    r-cklrt-feedstock \
    r-classint-feedstock \
    r-pkgload-feedstock \
    r-climatestability-feedstock \
    r-clubsandwich-feedstock \
    r-cluer-feedstock \
    r-clustvarlv-feedstock \
    r-coclust-feedstock \
    r-coenoflex-feedstock \
    r-cofra-feedstock \
    r-cointmonitor-feedstock \
    r-comf-feedstock

build_all \
    r-rocr-feedstock \
    r-compas-feedstock \
    r-concreg-feedstock \
    r-conflicted-feedstock \
    r-vcd-feedstock \
    r-conspline-feedstock \
    r-controltest-feedstock \
    r-convergenceclubs-feedstock \
    r-corclass-feedstock \
    r-corrmixed-feedstock \
    r-cost-feedstock \
    r-cotrend-feedstock \
    r-covafillr-feedstock \
    r-coxme-feedstock \
    r-coxphf-feedstock \
    r-coxphlb-feedstock

build_all \
    r-coxphmic-feedstock \
    r-coxphsgd-feedstock \
    r-coxphw-feedstock \
    r-coxrobust-feedstock \
    r-cp-feedstock \
    r-credentials-feedstock \
    r-crrsc-feedstock \
    r-crseeventstudy-feedstock \
    r-ctrlgene-feedstock \
    r-cubist-feedstock \
    r-cutpointsoehr-feedstock \
    r-rvcg-feedstock \
    r-rgl-feedstock \
    r-cyclocomp-feedstock \
    r-jose-feedstock \
    r-d3plus-feedstock

build_all \
    r-dataclean-feedstock \
    r-rfast-feedstock \
    r-ddalpha-feedstock \
    r-ddrtree-feedstock \
    r-ttr-feedstock \
    r-denseflmm-feedstock \
    r-densparcorr-feedstock \
    r-derezende.ferreira-feedstock \
    r-detmcd-feedstock \
    r-detr-feedstock \
    r-pkgbuild-feedstock \
    r-di-feedstock \
    r-influencer-feedstock \
    r-difconet-feedstock \
    r-diffee-feedstock \
    r-diffr-feedstock

build_all \
    r-diffusr-feedstock \
    r-dils-feedstock \
    r-drr-feedstock \
    r-directedclustering-feedstock \
    r-directeffects-feedstock \
    r-discfrail-feedstock \
    r-dismo-feedstock \
    r-disparityfilter-feedstock \
    r-distory-feedstock \
    r-dnmf-feedstock \
    r-doublecone-feedstock \
    r-downlit-feedstock \
    r-downsize-feedstock \
    r-driftbursthypothesis-feedstock \
    r-dt-feedstock \
    r-dtda-feedstock

build_all \
    r-dtda.cif-feedstock \
    r-dygraphs-feedstock \
    r-dynamac-feedstock \
    r-dynamichazard-feedstock \
    r-dynetnlaresistance-feedstock \
    r-dynpred-feedstock \
    r-ebdbnet-feedstock \
    r-edma-feedstock \
    r-eha-feedstock \
    r-ehof-feedstock \
    r-el2surv-feedstock \
    r-elo-feedstock \
    r-elyp-feedstock \
    r-embc-feedstock \
    r-emdbook-feedstock \
    r-maxlik-feedstock

build_all \
    r-emistatr-feedstock \
    r-emon-feedstock \
    r-envcpt-feedstock \
    r-epidisplay-feedstock \
    r-epiilmct-feedstock \
    r-eqs2lavaan-feedstock \
    r-equaltestmi-feedstock \
    r-erm-feedstock \
    r-estimatr-feedstock \
    r-etm-feedstock \
    r-excelr-feedstock \
    r-excerptr-feedstock \
    r-htmltable-feedstock \
    r-ezknitr-feedstock \
    r-factorial2x2-feedstock \
    r-fail-feedstock

build_all \
    r-fasjem-feedstock \
    r-fastclime-feedstock \
    r-fasterize-feedstock \
    r-fastglm-feedstock \
    r-fasthcs-feedstock \
    r-fastpcs-feedstock \
    r-fastrcs-feedstock \
    r-fbonds-feedstock \
    r-fbranks-feedstock \
    r-fcmapper-feedstock \
    r-hms-feedstock \
    r-fgarch-feedstock \
    r-fgeo.x-feedstock \
    r-fiberld-feedstock \
    r-pdftools-feedstock \
    r-fishical-feedstock

build_all \
    r-fishtree-feedstock \
    r-fixest-feedstock \
    r-flare-feedstock \
    r-flip-feedstock \
    r-fllat-feedstock \
    r-fnonlinear-feedstock \
    r-focusedmds-feedstock \
    r-foto-feedstock \
    r-fregression-feedstock \
    r-ftrading-feedstock \
    r-funchisq-feedstock \
    r-funitroots-feedstock \
    r-funreg-feedstock \
    r-furrr-feedstock \
    r-fusionclust-feedstock \
    r-future.apply-feedstock

build_all \
    r-fuzzywuzzyr-feedstock \
    r-fwdselect-feedstock \
    r-gadag-feedstock \
    r-gambin-feedstock \
    r-gammslice-feedstock \
    r-gamrr-feedstock \
    r-gaussianhmm1d-feedstock \
    r-gbm-feedstock \
    r-gcd-feedstock \
    r-gdistance-feedstock \
    r-gdpc-feedstock \
    r-generalhoslem-feedstock \
    r-genesignaturefinder-feedstock \
    r-genlasso-feedstock \
    r-genomic.autocorr-feedstock \
    r-genoplotr-feedstock

build_all \
    r-geojsonsf-feedstock \
    r-gifti-feedstock \
    r-glcm-feedstock \
    r-glide-feedstock \
    r-glmmlasso-feedstock \
    r-glmpath-feedstock \
    r-glmx-feedstock \
    r-glogis-feedstock \
    r-gmm-feedstock \
    r-graphkernels-feedstock \
    r-graphlayouts-feedstock \
    r-gremlins-feedstock \
    r-grf-feedstock \
    r-gte-feedstock \
    r-gtests-feedstock \
    r-strucchange-feedstock

build_all \
    r-gvcm.cat-feedstock \
    r-gwrm-feedstock \
    r-h2o4gpu-feedstock \
    r-hac-feedstock \
    r-halfcircle-feedstock \
    r-harmodel-feedstock \
    r-hazus-feedstock \
    r-hbstm-feedstock \
    r-hchinamap-feedstock \
    r-hda-feedstock \
    r-hdbinseg-feedstock \
    r-ks-feedstock \
    r-highscreen-feedstock \
    r-hlsm-feedstock \
    r-hpackedbubble-feedstock \
    r-htmltidy-feedstock

build_all \
    r-huge-feedstock \
    r-ibr-feedstock \
    r-ibrokers-feedstock \
    r-ibst-feedstock \
    r-icenreg-feedstock \
    r-icluster-feedstock \
    r-idmining-feedstock \
    r-idmtpreg-feedstock \
    r-igraphtosonia-feedstock \
    r-imageviewer-feedstock \
    r-immigrate-feedstock \
    r-imputer-feedstock \
    r-indirect-feedstock \
    r-inferencesmr-feedstock \
    r-influence.sem-feedstock \
    r-intccr-feedstock

build_all \
    r-interfaceqpcr-feedstock \
    r-interlinear-feedstock \
    r-interp-feedstock \
    r-ionr-feedstock \
    r-ipcwswitch-feedstock \
    r-iregression-feedstock \
    r-irg-feedstock \
    r-ism-feedstock \
    r-ismev-feedstock \
    r-isotonic.pen-feedstock \
    r-jeek-feedstock \
    r-jetpack-feedstock \
    r-jgl-feedstock \
    r-jm-feedstock \
    r-joint.cox-feedstock \
    r-jousboost-feedstock

build_all \
    r-jrich-feedstock \
    r-jstree-feedstock \
    r-juliacall-feedstock \
    r-webshot-feedstock \
    r-kerasr-feedstock \
    r-kfigr-feedstock \
    r-kimisc-feedstock \
    r-kin.cohort-feedstock \
    r-kissmig-feedstock \
    r-kknn-feedstock \
    r-klustr-feedstock \
    r-km.ci-feedstock \
    r-knitlatex-feedstock \
    r-kodama-feedstock \
    r-konpsurv-feedstock \
    r-krmm-feedstock

build_all \
    r-ksd-feedstock \
    r-kseaapp-feedstock \
    r-kstmatrix-feedstock \
    r-labrs-feedstock \
    r-landest-feedstock \
    r-landpred-feedstock \
    r-landscaper-feedstock \
    r-laterality-feedstock \
    r-lcmm-feedstock \
    r-lcopula-feedstock \
    r-leaflet.opacity-feedstock \
    r-leanr-feedstock \
    r-leiden-feedstock \
    r-lexrankr-feedstock \
    r-lfe-feedstock \
    r-linerr-feedstock

build_all \
    r-linkcomm-feedstock \
    r-lncpath-feedstock \
    r-logicreg-feedstock \
    r-longroc-feedstock \
    r-lpm-feedstock \
    r-lrmest-feedstock \
    r-lsasim-feedstock \
    r-lsmontecarlo-feedstock \
    r-mailr-feedstock \
    r-malani-feedstock \
    r-mandelbrot-feedstock \
    r-mapmisc-feedstock \
    r-marqlevalg-feedstock \
    r-maxlike-feedstock \
    r-maxmatching-feedstock \
    r-mazegen-feedstock

build_all \
    r-mbir-feedstock \
    r-mccmeiv-feedstock \
    r-mcmcprecision-feedstock \
    r-mcparalleldo-feedstock \
    r-mdplot-feedstock \
    r-mediak-feedstock \
    r-mediana-feedstock \
    r-metricsgraphics-feedstock \
    r-mfp-feedstock \
    r-mhctools-feedstock \
    r-mhtrajectoryr-feedstock \
    r-rspectra-feedstock \
    r-mistr-feedstock \
    r-mixphm-feedstock \
    r-mixsqp-feedstock \
    r-ml.msbd-feedstock

build_all \
    r-mm4lmm-feedstock \
    r-mmc-feedstock \
    r-modmax-feedstock \
    r-mogavs-feedstock \
    r-mongolite-feedstock \
    r-monotonicity-feedstock \
    r-mpinet-feedstock \
    r-mplikelihoodwb-feedstock \
    r-mpr-feedstock \
    r-mpsem-feedstock \
    r-mptinr-feedstock \
    r-stanheaders-feedstock \
    r-rstantools-feedstock \
    r-mrmre-feedstock \
    r-mrs-feedstock \
    r-msap-feedstock

build_all \
    r-msar-feedstock \
    r-msimcc-feedstock \
    r-msm-feedstock \
    r-mstate-feedstock \
    r-mstknnclust-feedstock \
    r-mtlr-feedstock \
    r-mudens-feedstock \
    r-muhaz-feedstock \
    r-th.data-feedstock \
    r-multiapply-feedstock \
    r-multilaterals-feedstock \
    r-multinet-feedstock \
    r-multiord-feedstock \
    r-multiplencc-feedstock \
    r-multisv-feedstock \
    r-multivariance-feedstock

build_all \
    r-multiwayvcov-feedstock \
    r-mvbinary-feedstock \
    r-nabor-feedstock \
    r-nada-feedstock \
    r-naturesounds-feedstock \
    r-ncopula-feedstock \
    r-neat-feedstock \
    r-nestfs-feedstock \
    r-netchain-feedstock \
    r-netrankr-feedstock \
    r-nets-feedstock \
    r-netswan-feedstock \
    r-networkd3-feedstock \
    r-networkgen-feedstock \
    r-neverhpfilter-feedstock \
    r-nfactors-feedstock

build_all \
    r-nimble-feedstock \
    r-nltm-feedstock \
    r-nltt-feedstock \
    r-nnmis-feedstock \
    r-nonnest2-feedstock \
    r-nphazardrate-feedstock \
    r-nricens-feedstock \
    r-numkm-feedstock \
    r-ocomposition-feedstock \
    r-blob-feedstock \
    r-ods-feedstock \
    r-oem-feedstock \
    r-onnx-feedstock \
    r-ramcharts-feedstock \
    r-optbdmaeat-feedstock \
    r-optrcdmaeat-feedstock

build_all \
    r-optrees-feedstock \
    r-opusminer-feedstock \
    r-orcutt-feedstock \
    r-ordinalgmifs-feedstock \
    r-ordinallbm-feedstock \
    r-osc-feedstock \
    r-osrmr-feedstock \
    r-otrselect-feedstock \
    r-outrankingtools-feedstock \
    r-paf-feedstock \
    r-paleobiodb-feedstock \
    r-paleots-feedstock \
    r-pameasures-feedstock \
    r-pamr-feedstock \
    r-panjen-feedstock \
    r-parallelmap-feedstock

build_all \
    r-parallelml-feedstock \
    r-partdsa-feedstock \
    r-paswr-feedstock \
    r-peerperformance-feedstock \
    r-penalized-feedstock \
    r-pencoxfrail-feedstock \
    r-perccal-feedstock \
    r-performanceanalytics-feedstock \
    r-pgee.mixed-feedstock \
    r-phangorn-feedstock \
    r-phase123-feedstock \
    r-pheatmap-feedstock \
    r-pheval-feedstock \
    r-phyclust-feedstock \
    r-phyloclim-feedstock \
    r-phylogram-feedstock

build_all \
    r-phylomeasures-feedstock \
    r-phylotools-feedstock \
    r-pigshift-feedstock \
    r-pkgcache-feedstock \
    r-ragg-feedstock \
    r-plac-feedstock \
    r-plotmcmc-feedstock \
    r-plrasch-feedstock \
    r-pomdp-feedstock \
    r-pomp-feedstock \
    r-pop-feedstock \
    r-popkin-feedstock \
    r-poptrend-feedstock \
    r-portsort-feedstock \
    r-pillar-feedstock \
    r-powersurvepi-feedstock

build_all \
    r-pqlseq-feedstock \
    r-prais-feedstock \
    r-printr-feedstock \
    r-prioritizrdata-feedstock \
    r-profvis-feedstock \
    r-pseval-feedstock \
    r-psychtools-feedstock \
    r-psymonitor-feedstock \
    r-pte-feedstock \
    r-ptw-feedstock \
    r-ptycho-feedstock \
    r-pweall-feedstock \
    r-pwrgsd-feedstock \
    r-pxr-feedstock \
    r-pymturkr-feedstock \
    r-qrage-feedstock

build_all \
    r-qrcode-feedstock \
    r-qrencoder-feedstock \
    r-qrm-feedstock \
    r-qrmdata-feedstock \
    r-quiddich-feedstock \
    r-r.cache-feedstock \
    r-r.devices-feedstock \
    r-r.huge-feedstock \
    r-r.matlab-feedstock \
    r-r2bayesx-feedstock \
    r-r2d3-feedstock \
    r-r2dt-feedstock \
    r-r3port-feedstock \
    r-radanalysis-feedstock \
    r-radarchart-feedstock \
    r-rampath-feedstock

build_all \
    r-ramsvm-feedstock \
    r-rankcluster-feedstock \
    r-rankhazard-feedstock \
    r-raptor-feedstock \
    r-rasterkernelestimates-feedstock \
    r-rasterlist-feedstock \
    r-rastervis-feedstock \
    r-rbldatalicense-feedstock \
    r-rca-feedstock \
    r-rcbsubset-feedstock \
    r-rcppnumerical-feedstock \
    r-rcppxts-feedstock \
    r-rcrm-feedstock \
    r-rd2md-feedstock \
    r-rdataretriever-feedstock \
    r-reconstructr-feedstock

build_all \
    r-reins-feedstock \
    r-rem-feedstock \
    r-reordercluster-feedstock \
    r-reportroc-feedstock \
    r-rerefact-feedstock \
    r-revecor-feedstock \
    r-rgf-feedstock \
    r-rhandsontable-feedstock \
    r-rising-feedstock \
    r-risksetroc-feedstock \
    r-rje-feedstock \
    r-rlda-feedstock \
    r-rleafmap-feedstock \
    r-rlof-feedstock \
    r-rmcorr-feedstock \
    r-rmediation-feedstock

build_all \
    r-rmixmod-feedstock \
    r-rmixtcompio-feedstock \
    r-rmonad-feedstock \
    r-rmtl-feedstock \
    r-rmvp-feedstock \
    r-rnetlogo-feedstock \
    r-robustaft-feedstock \
    r-robustgam-feedstock \
    r-rolr-feedstock \
    r-rootwishart-feedstock \
    r-rpf-feedstock \
    r-rphylip-feedstock \
    r-rpivottable-feedstock \
    r-rsarules-feedstock \
    r-rsconnect-feedstock \
    r-rsem-feedstock

build_all \
    r-rsoi-feedstock \
    r-rsurrogate-feedstock \
    r-rtorch-feedstock \
    r-rts-feedstock \
    r-rwc-feedstock \
    r-ryoutheria-feedstock \
    r-sacobra-feedstock \
    r-sasmarkdown-feedstock \
    r-satellite-feedstock \
    r-saturnin-feedstock \
    r-scam-feedstock \
    r-scatterd3-feedstock \
    r-scico-feedstock \
    r-scina-feedstock \
    r-scoringrules-feedstock \
    r-sdcspatial-feedstock

build_all \
    r-sdm-feedstock \
    r-sdmvspecies-feedstock \
    r-secret-feedstock \
    r-semicomprisks-feedstock \
    r-semid-feedstock \
    r-semnetdictionaries-feedstock \
    r-semtools-feedstock \
    r-seqdesign-feedstock \
    r-seqicp-feedstock \
    r-sesem-feedstock \
    r-setrank-feedstock \
    r-sgee-feedstock \
    r-sglasso-feedstock \
    r-sgloptim-feedstock \
    r-shapechange-feedstock \
    r-shp2graph-feedstock

build_all \
    r-sieveph-feedstock \
    r-simexaft-feedstock \
    r-simhaz-feedstock \
    r-simml-feedstock \
    r-simsem-feedstock \
    r-simule-feedstock \
    r-sirad-feedstock \
    r-slickr-feedstock \
    r-slideview-feedstock \
    r-slippymath-feedstock \
    r-slouch-feedstock \
    r-slp-feedstock \
    r-smcfcs-feedstock \
    r-smcure-feedstock \
    r-smitidvisu-feedstock \
    r-smoothhr-feedstock

build_all \
    r-smoothsurv-feedstock \
    r-smpracticals-feedstock \
    r-sms-feedstock \
    r-soptdmaea-feedstock \
    r-sp23design-feedstock \
    r-spacyr-feedstock \
    r-sparkline-feedstock \
    r-sparsehessianfd-feedstock \
    r-sparsemdc-feedstock \
    r-spdata-feedstock \
    r-speff2trial-feedstock \
    r-spelling-feedstock \
    r-spreda-feedstock \
    r-srda-feedstock \
    r-stand-feedstock \
    r-steinernet-feedstock

build_all \
    r-stemmatology-feedstock \
    r-stepreg-feedstock \
    r-strategy-feedstock \
    r-streammetabolism-feedstock \
    r-stressr-feedstock \
    r-structfdr-feedstock \
    r-subpathwaygmir-feedstock \
    r-sunclarco-feedstock \
    r-supergauss-feedstock \
    r-superpc-feedstock \
    r-surrogateoutcome-feedstock \
    r-surrogatetest-feedstock \
    r-surrosurvroc-feedstock \
    r-survawkmt2-feedstock \
    r-survbootoutliers-feedstock \
    r-survc1-feedstock

build_all \
    r-survexp.fr-feedstock \
    r-survivalmpl-feedstock \
    r-survregcenscov-feedstock \
    r-survrm2-feedstock \
    r-survrm2adapt-feedstock \
    r-survsnp-feedstock \
    r-survtrunc-feedstock \
    r-svgpanzoom-feedstock \
    r-svn-feedstock \
    r-table1-feedstock \
    r-tangram-feedstock \
    r-tdroc-feedstock \
    r-tempor-feedstock \
    r-tfautograph-feedstock \
    r-tensorr-feedstock \
    r-tess-feedstock

build_all \
    r-textrank-feedstock \
    r-tfcox-feedstock \
    r-threejs-feedstock \
    r-threg-feedstock \
    r-thregi-feedstock \
    r-timeordered-feedstock \
    r-timevtree-feedstock \
    r-tinyproject-feedstock \
    r-tmb-feedstock \
    r-tmpm-feedstock \
    r-tnet-feedstock \
    r-todor-feedstock \
    r-tpauc-feedstock \
    r-transmodel-feedstock \
    r-transport-feedstock \
    r-treeman-feedstock

build_all \
    r-trustoptim-feedstock \
    r-tsdfgs-feedstock \
    r-tstools-feedstock \
    r-tts-feedstock \
    r-tutorial-feedstock \
    r-twitterwidget-feedstock \
    r-twophaseind-feedstock \
    r-twostepclogit-feedstock \
    r-umpire-feedstock \
    r-unsystation-feedstock \
    r-uscensus2010-feedstock \
    r-usdm-feedstock \
    r-valorate-feedstock \
    r-vdjgermlines-feedstock \
    r-vegawidget-feedstock \
    r-vertexsimilarity-feedstock

build_all \
    r-vhdclassification-feedstock \
    r-volesti-feedstock \
    r-washer-feedstock \
    r-wce-feedstock \
    r-wfg-feedstock \
    r-whitechapelr-feedstock \
    r-widgetframe-feedstock \
    r-wlreg-feedstock \
    r-wordcloud2-feedstock \
    r-wordmatch-feedstock \
    r-wskm-feedstock \
    r-xlink-feedstock \
    r-xwf-feedstock \
    r-yakmor-feedstock \
    r-yatah-feedstock


build_all \
    r-quantmod-feedstock \
    r-acs-feedstock \
    r-ade4tkgui-feedstock \
    r-adklakedata-feedstock \
    r-tibble-feedstock \
    r-alfr-feedstock \
    r-algorithmia-feedstock \
    r-analogsea-feedstock \
    r-shiny-feedstock \
    r-roxygen2-feedstock \
    r-plm-feedstock \
    r-aptools-feedstock \
    r-arco-feedstock \
    r-argo-feedstock \
    r-arrow-feedstock \
    r-arulescba-feedstock

build_all \
    r-arxiv-feedstock \
    r-assertive.data-feedstock \
    r-assertive.data.uk-feedstock \
    r-assertive.data.us-feedstock \
    r-atsd-feedstock \
    r-rmarkdown-feedstock \
    r-aws.comprehend-feedstock \
    r-aws.iam-feedstock \
    r-aws.kms-feedstock \
    r-aws.lambda-feedstock \
    r-aws.s3-feedstock \
    r-aws.transcribe-feedstock \
    r-aws.translate-feedstock \
    r-azurevmmetadata-feedstock \
    r-mcmcpack-feedstock \
    r-cranlogs-feedstock

build_all \
    r-bender-feedstock \
    r-bess-feedstock \
    r-bestglm-feedstock \
    r-bivariate.pareto-feedstock \
    r-bmixture-feedstock \
    r-borrowr-feedstock \
    r-boruta-feedstock \
    r-brandwatchr-feedstock \
    r-browndog-feedstock \
    r-lava-feedstock \
    r-camsrad-feedstock \
    r-canvasxpress-feedstock \
    r-cdltools-feedstock \
    r-censusapi-feedstock \
    r-censys-feedstock \
    r-pkgdepends-feedstock

build_all \
    r-multcomp-feedstock \
    r-cleanr-feedstock \
    r-tfruns-feedstock \
    r-cluscov-feedstock \
    r-progress-feedstock \
    r-cmprskqr-feedstock \
    r-cobs-feedstock \
    r-codina-feedstock \
    r-colourlovers-feedstock \
    r-comics-feedstock \
    r-comp2roc-feedstock \
    r-comtradr-feedstock \
    r-confreq-feedstock \
    r-couchdb-feedstock \
    r-covr-feedstock \
    r-cpt-feedstock

build_all \
    r-cqrreg-feedstock \
    r-crrstep-feedstock \
    r-sf-feedstock \
    r-currentsurvival-feedstock \
    r-cvauc-feedstock \
    r-morpho-feedstock \
    r-datarobot-feedstock \
    r-dbhydror-feedstock \
    r-rfast2-feedstock \
    r-deadband-feedstock \
    r-rcmdcheck-feedstock \
    r-diezeit-feedstock \
    r-dimred-feedstock \
    r-dmrnet-feedstock \
    r-docusignr-feedstock \
    r-drawr-feedstock

build_all \
    r-drillr-feedstock \
    r-dtrlearn2-feedstock \
    r-dyads-feedstock \
    r-ebprs-feedstock \
    r-edgarwebr-feedstock \
    r-eiadata-feedstock \
    r-eila-feedstock \
    r-elastic-feedstock \
    r-emplik-feedstock \
    r-umap-feedstock \
    r-uwot-feedstock \
    r-emhawkes-feedstock \
    r-emp-feedstock \
    r-epiilm-feedstock \
    r-epxtor-feedstock \
    r-eshrink-feedstock

build_all \
    r-esreg-feedstock \
    r-esther-feedstock \
    r-expss-feedstock \
    r-exrq-feedstock \
    r-fastcmh-feedstock \
    r-fastcmprsk-feedstock \
    r-federalregister-feedstock \
    r-fextremes-feedstock \
    r-ffmetadata-feedstock \
    r-findr-feedstock \
    r-fitbitscraper-feedstock \
    r-flatxml-feedstock \
    r-forecastcombinations-feedstock \
    r-frailtyhl-feedstock \
    r-games-feedstock \
    r-geojsonlint-feedstock

build_all \
    r-geomedb-feedstock \
    r-geometa-feedstock \
    r-gert-feedstock \
    r-gethr-feedstock \
    r-gh-feedstock \
    r-glassdoor-feedstock \
    r-glmnetcr-feedstock \
    r-glmnetutils-feedstock \
    r-gogarch-feedstock \
    r-goodmankruskal-feedstock \
    r-vars-feedstock \
    r-gsheet-feedstock \
    r-gym-feedstock \
    r-hdci-feedstock \
    r-hdlm-feedstock \
    r-httpcache-feedstock

build_all \
    r-hermite-feedstock \
    r-hier.part-feedstock \
    r-hkex.api-feedstock \
    r-hmdhfdplus-feedstock \
    r-hmstimer-feedstock \
    r-htmltab-feedstock \
    r-iciter-feedstock \
    r-ics-feedstock \
    r-imgur-feedstock \
    r-immailgun-feedstock \
    r-instar-feedstock \
    r-intlik-feedstock \
    r-ipflasso-feedstock \
    r-irafnet-feedstock \
    r-islasso-feedstock \
    r-jrc-feedstock

build_all \
    r-kofdata-feedstock \
    r-languagelayer-feedstock \
    r-lassosir-feedstock \
    r-ldlinkr-feedstock \
    r-leanpubr-feedstock \
    r-lenses-feedstock \
    r-lightningr-feedstock \
    r-lmmot-feedstock \
    r-longitudinaldata-feedstock \
    r-mable-feedstock \
    r-mams-feedstock \
    r-maxnet-feedstock \
    r-mfgarch-feedstock \
    r-micar-feedstock \
    r-minicran-feedstock \
    r-mleur-feedstock

build_all \
    r-mlmetrics-feedstock \
    r-mns-feedstock \
    r-modelltest-feedstock \
    r-mts-feedstock \
    r-multivarsel-feedstock \
    r-mvprobit-feedstock \
    r-mwridge-feedstock \
    r-natural-feedstock \
    r-rpostgres-feedstock \
    r-rsqlite-feedstock \
    r-sofa-feedstock \
    r-nomnoml-feedstock \
    r-np-feedstock \
    r-nparsurv-feedstock \
    r-nso1212-feedstock \
    r-nsrr-feedstock

build_all \
    r-nzilbb.labbcat-feedstock \
    r-odbc-feedstock \
    r-oglmx-feedstock \
    r-ohpl-feedstock \
    r-omickriging-feedstock \
    r-openblender-feedstock \
    r-opera-feedstock \
    r-optimaldesign-feedstock \
    r-ordfacreg-feedstock \
    r-ores-feedstock \
    r-pageviews-feedstock \
    r-palasso-feedstock \
    r-pas-feedstock \
    r-pastis-feedstock \
    r-patentsview-feedstock \
    r-paws.common-feedstock

build_all \
    r-pdftables-feedstock \
    r-phd-feedstock \
    r-pheno-feedstock \
    r-pinnacle.api-feedstock \
    r-pivotaltrackr-feedstock \
    r-plaqr-feedstock \
    r-plumber-feedstock \
    r-pluscode-feedstock \
    r-postcodesior-feedstock \
    r-predkmeans-feedstock \
    r-prettymapr-feedstock \
    r-prevederer-feedstock \
    r-prioritylasso-feedstock \
    r-prism.forecast-feedstock \
    r-promote-feedstock \
    r-ptest-feedstock

build_all \
    r-pushoverr-feedstock \
    r-pxweb-feedstock \
    r-qcba-feedstock \
    r-qiitr-feedstock \
    r-qrank-feedstock \
    r-qrjoint-feedstock \
    r-qrmix-feedstock \
    r-quandl-feedstock \
    r-quantreggrowth-feedstock \
    r-quantregranger-feedstock \
    r-raltmetric-feedstock \
    r-rapiclient-feedstock \
    r-rare-feedstock \
    r-rarpack-feedstock \
    r-rbtc-feedstock \
    r-rcites-feedstock

build_all \
    r-rcolombos-feedstock \
    r-rcriteo-feedstock \
    r-rdian-feedstock \
    r-rdnb-feedstock \
    r-rdocumentation-feedstock \
    r-rdota2-feedstock \
    r-rentrez-feedstock \
    r-rearrangement-feedstock \
    r-rechonest-feedstock \
    r-refmanager-feedstock \
    r-regnet-feedstock \
    r-request-feedstock \
    r-rfacebook-feedstock \
    r-rfinterval-feedstock \
    r-rfoaas-feedstock \
    r-rga4gh-feedstock

build_all \
    r-rgdax-feedstock \
    r-rgeckoboard-feedstock \
    r-rgeolocate-feedstock \
    r-servr-feedstock \
    r-rglwidget-feedstock \
    r-rgoogleanalytics-feedstock \
    r-rgoogleanalyticspremium-feedstock \
    r-rgooglefit-feedstock \
    r-rgoogleslides-feedstock \
    r-rhealthdatagov-feedstock \
    r-rhymer-feedstock \
    r-ridigbio-feedstock \
    r-rismed-feedstock \
    r-rlabkey-feedstock \
    r-rlinkedin-feedstock \
    r-rlme-feedstock

build_all \
    r-rmariadb-feedstock \
    r-rnassqs-feedstock \
    r-rnbp-feedstock \
    r-rocc-feedstock \
    r-roccv-feedstock \
    r-rodam-feedstock \
    r-rollbar-feedstock \
    r-ronfhir-feedstock \
    r-ropendata-feedstock \
    r-ropenfigi-feedstock \
    r-ropenweathermap-feedstock \
    r-rosetteapi-feedstock \
    r-rpinterest-feedstock \
    r-rpresto-feedstock \
    r-rptests-feedstock \
    r-rpublica-feedstock

build_all \
    r-rredlist-feedstock \
    r-rromeo-feedstock \
    r-rsaucelabs-feedstock \
    r-rsdmx-feedstock \
    r-rsitecatalyst-feedstock \
    r-rsocrata-feedstock \
    r-rstatscn-feedstock \
    r-rstripe-feedstock \
    r-ryandextranslate-feedstock \
    r-rym-feedstock \
    r-rzabbix-feedstock \
    r-saver-feedstock \
    r-scrobbler-feedstock \
    r-segmgarch-feedstock \
    r-seleniumpipes-feedstock \
    r-sensibo.sky-feedstock

build_all \
    r-sensmediation-feedstock \
    r-shutterstock-feedstock \
    r-siebanxicor-feedstock \
    r-sightabilitymodel-feedstock \
    r-sigoptr-feedstock \
    r-skat-feedstock \
    r-smoother-feedstock \
    r-sn-feedstock \
    r-sotkanet-feedstock \
    r-spatstat.random-feedstock \
    r-spectrino-feedstock \
    r-spgwr-feedstock \
    r-spikes-feedstock \
    r-spinbayes-feedstock \
    r-spiritr-feedstock \
    r-sprintr-feedstock

build_all \
    r-ssgraph-feedstock \
    r-ssh-feedstock \
    r-stopes-feedstock \
    r-tandem-feedstock \
    r-tcgaretriever-feedstock \
    r-tciapathfinder-feedstock \
    r-teamr-feedstock \
    r-tejapi-feedstock \
    r-telegram-feedstock \
    r-telegram.bot-feedstock \
    r-tesseract-feedstock \
    r-texreg-feedstock \
    r-thankyoustars-feedstock \
    r-threewords-feedstock \
    r-thresholdroc-feedstock \
    r-tm1r-feedstock

build_all \
    r-tmdb-feedstock \
    r-treetools-feedstock \
    r-trading-feedstock \
    r-transcriber-feedstock \
    r-treebase-feedstock \
    r-truncreg-feedstock \
    r-trustedtimestamping-feedstock \
    r-tsgsis-feedstock \
    r-tubern-feedstock \
    r-tumblr-feedstock \
    r-turboem-feedstock \
    r-twfy-feedstock \
    r-twilio-feedstock \
    r-twitter-feedstock \
    r-udapi-feedstock \
    r-ui-feedstock

build_all \
    r-ukgasapi-feedstock \
    r-vegalite-feedstock \
    r-vembedr-feedstock \
    r-virustotal-feedstock \
    r-vkr-feedstock \
    r-vstsr-feedstock \
    r-wee-feedstock \
    r-weightquant-feedstock \
    r-whoami-feedstock \
    r-wikipedir-feedstock \
    r-wikipediar-feedstock \
    r-worms-feedstock \
    r-yhatr-feedstock


build_all \
    r-tseries-feedstock \
    r-aggregater-feedstock \
    r-anovareplication-feedstock \
    r-antaresread-feedstock \
    r-aoos-feedstock \
    r-ggplot2-feedstock \
    r-argondash-feedstock \
    r-assertive-feedstock \
    r-attachment-feedstock \
    r-shinyjs-feedstock \
    r-autodeskr-feedstock \
    r-autoshiny-feedstock \
    r-usethis-feedstock \
    r-rvest-feedstock \
    r-dplyr-feedstock \
    r-bayest-feedstock

build_all \
    r-shinybs-feedstock \
    r-beginr-feedstock \
    r-binb-feedstock \
    r-bold-feedstock \
    r-bookdown-feedstock \
    r-fresh-feedstock \
    r-waiter-feedstock \
    r-bsplus-feedstock \
    r-bullwhipgame-feedstock \
    r-bunchr-feedstock \
    r-prodlim-feedstock \
    r-canprot-feedstock \
    r-checkpoint-feedstock \
    r-ciplot-feedstock \
    r-cloneseeker-feedstock \
    r-cloudml-feedstock

build_all \
    r-clustmixtype-feedstock \
    r-coin-feedstock \
    r-complexity-feedstock \
    r-nodbi-feedstock \
    r-cttinshiny-feedstock \
    r-curvecomp-feedstock \
    r-cxhull-feedstock \
    r-cytobankapi-feedstock \
    r-dcovts-feedstock \
    r-docstring-feedstock \
    r-document-feedstock \
    r-dropr-feedstock \
    r-echarts2shiny-feedstock \
    r-edgebundler-feedstock \
    r-elhmc-feedstock \
    r-emsaov-feedstock

build_all \
    r-epimdr-feedstock \
    r-flextable-feedstock \
    r-estudy2-feedstock \
    r-eurosarcbayes-feedstock \
    r-extremis-feedstock \
    r-factorplot-feedstock \
    r-feather-feedstock \
    r-financialinstrument-feedstock \
    r-flexdashboard-feedstock \
    r-formattable-feedstock \
    r-freesurferformats-feedstock \
    r-fuzzyr-feedstock \
    r-gamesga-feedstock \
    r-glmc-feedstock \
    r-gmdatabase-feedstock \
    r-shinycssloaders-feedstock

build_all \
    r-shinydashboard-feedstock \
    r-gradientpickerd3-feedstock \
    r-hardhat-feedstock \
    r-hhg-feedstock \
    r-icestaf-feedstock \
    r-icranks-feedstock \
    r-icsnp-feedstock \
    r-igraphinshiny-feedstock \
    r-imputeyn-feedstock \
    r-ioncopy-feedstock \
    r-irtdemo-feedstock \
    r-univariateml-feedstock \
    r-tensorflow-feedstock \
    r-shinythemes-feedstock \
    r-knitrbootstrap-feedstock \
    r-komaletter-feedstock

build_all \
    r-lcyanalysis-feedstock \
    r-learnr-feedstock \
    r-liftr-feedstock \
    r-linl-feedstock \
    r-lisa-feedstock \
    r-listviewer-feedstock \
    r-logcondiscr-feedstock \
    r-lwgeom-feedstock \
    r-forcats-feedstock \
    r-mangotraining-feedstock \
    r-miniui-feedstock \
    r-mavtgsa-feedstock \
    r-memor-feedstock \
    r-timereg-feedstock \
    r-midas-feedstock \
    r-miscfuncs-feedstock

build_all \
    r-monographar-feedstock \
    r-mratios-feedstock \
    r-muchpoint-feedstock \
    r-multica-feedstock \
    r-mwshiny-feedstock \
    r-natserv-feedstock \
    r-nbc4va-feedstock \
    r-ndp-feedstock \
    r-neurohcp-feedstock \
    r-nhsrdatasets-feedstock \
    r-normalr-feedstock \
    r-nparcomp-feedstock \
    r-nycflights13-feedstock \
    r-usdata-feedstock \
    r-optimstrat-feedstock \
    r-owea-feedstock

build_all \
    r-pairsd3-feedstock \
    r-pder-feedstock \
    r-pdshiny-feedstock \
    r-piggyback-feedstock \
    r-pinp-feedstock \
    r-pins-feedstock \
    r-pkgdown-feedstock \
    r-pqantimalarials-feedstock \
    r-preknitposthtmlrender-feedstock \
    r-prereg-feedstock \
    r-prettydoc-feedstock \
    r-prodigenr-feedstock \
    r-projecttemplate-feedstock \
    r-projmgr-feedstock \
    r-pushbar-feedstock \
    r-qgam-feedstock

build_all \
    r-spatstat.core-feedstock \
    r-rchallenge-feedstock \
    r-rclipboard-feedstock \
    r-rd2roxygen-feedstock \
    r-redland-feedstock \
    r-read.gb-feedstock \
    r-repogenerator-feedstock \
    r-revealjs-feedstock \
    r-rgexf-feedstock \
    r-rintrojs-feedstock \
    r-rmake-feedstock \
    r-rmawgen-feedstock \
    r-rmdfiltr-feedstock \
    r-rmdshower-feedstock \
    r-rncl-feedstock \
    r-rnpn-feedstock

build_all \
    r-rticles-feedstock \
    r-rtsplot-feedstock \
    r-secr-feedstock \
    r-serieslcb-feedstock \
    r-shiny.i18n-feedstock \
    r-shiny.router-feedstock \
    r-shiny.semantic-feedstock \
    r-shinyace-feedstock \
    r-shinyaframe-feedstock \
    r-shinyalert-feedstock \
    r-shinyanimate-feedstock \
    r-shinybusy-feedstock \
    r-shinycustomloader-feedstock \
    r-shinydnd-feedstock \
    r-shinyeffects-feedstock \
    r-shinyfeedback-feedstock

build_all \
    r-shinyglide-feedstock \
    r-shinyhelper-feedstock \
    r-shinyjqui-feedstock \
    r-shinylp-feedstock \
    r-shinymaterial-feedstock \
    r-shinymatrix-feedstock \
    r-shinytime-feedstock \
    r-shinytoastr-feedstock \
    r-shinytree-feedstock \
    r-shinywidgets-feedstock \
    r-spearmanci-feedstock \
    r-sqlutils-feedstock \
    r-stacomirtools-feedstock \
    r-statgraph-feedstock \
    r-svsweave-feedstock \
    r-synthacs-feedstock

build_all \
    r-tablehtml-feedstock \
    r-tablerdash-feedstock \
    r-taipan-feedstock \
    r-worrms-feedstock \
    r-ternary-feedstock \
    r-tilegramsr-feedstock \
    r-timevis-feedstock \
    r-tint-feedstock \
    r-tippy-feedstock \
    r-totalcopheneticindex-feedstock \
    r-truncsp-feedstock \
    r-tsetools-feedstock \
    r-tufte-feedstock \
    r-tufterhandout-feedstock \
    r-xaringan-feedstock \
    r-wrassp-feedstock

build_all \
    r-xllim-feedstock \
    r-xplorerr-feedstock \
    r-yonder-feedstock \
    r-cellranger-feedstock \
    r-vroom-feedstock \
    r-rematch2-feedstock


build_all \
    r-acp-feedstock \
    r-antareseditobject-feedstock \
    r-antaresprocessing-feedstock \
    r-auth0-feedstock \
    r-dlstats-feedstock \
    r-banxicor-feedstock \
    r-ggridges-feedstock \
    r-bdp2-feedstock \
    r-beyondbenford-feedstock \
    r-bhm-feedstock \
    r-tidyr-feedstock \
    r-bivrec-feedstock \
    r-bmrbr-feedstock \
    r-bpcp-feedstock \
    r-breakfast-feedstock \
    r-bs4dash-feedstock

build_all \
    r-cccrm-feedstock \
    r-cplm-feedstock \
    r-patchwork-feedstock \
    r-ggrepel-feedstock \
    r-clusterbootstrap-feedstock \
    r-kableextra-feedstock \
    r-cowplot-feedstock \
    r-ctrdata-feedstock \
    r-stars-feedstock \
    r-cytobankbridger-feedstock \
    r-readxl-feedstock \
    r-readr-feedstock \
    r-dfidx-feedstock \
    r-viridis-feedstock \
    r-distcomp-feedstock \
    r-distributional-feedstock

build_all \
    r-distributions3-feedstock \
    r-dockerfiler-feedstock \
    r-dragular-feedstock \
    r-dtrreg-feedstock \
    r-embedsom-feedstock \
    r-enrichr-feedstock \
    r-epir-feedstock \
    r-fdrci-feedstock \
    r-fisherem-feedstock \
    r-forecast-feedstock \
    r-genesysr-feedstock \
    r-ggsci-feedstock \
    r-ggsignif-feedstock \
    r-ggtext-feedstock \
    r-ggvis-feedstock \
    r-gistr-feedstock

build_all \
    r-glmtlp-feedstock \
    r-gmse-feedstock \
    r-googleformr-feedstock \
    r-grangers-feedstock \
    r-hdrcde-feedstock \
    r-helsinki-feedstock \
    r-iadapt-feedstock \
    r-icpsrdata-feedstock \
    r-dbplyr-feedstock \
    r-ipred-feedstock \
    r-isingsampler-feedstock \
    r-jdmbs-feedstock \
    r-kaps-feedstock \
    r-kdensity-feedstock \
    r-keras-feedstock \
    r-kgc-feedstock

build_all \
    r-lahman-feedstock \
    r-lightsout-feedstock \
    r-localgauss-feedstock \
    r-lsm-feedstock \
    r-magclass-feedstock \
    r-manipulatewidget-feedstock \
    r-mediacloudr-feedstock \
    r-meta4diag-feedstock \
    r-metavcov-feedstock \
    r-mets-feedstock \
    r-mgarchbekk-feedstock \
    r-microseq-feedstock \
    r-sbm-feedstock \
    r-rstan-feedstock \
    r-mrpostman-feedstock \
    r-mstrio-feedstock

build_all \
    r-multnonparam-feedstock \
    r-noaaoceans-feedstock \
    r-party-feedstock \
    r-pca4ts-feedstock \
    r-permgs-feedstock \
    r-pipefittr-feedstock \
    r-pixels-feedstock \
    r-pkconverter-feedstock \
    r-publish-feedstock \
    r-qqvases-feedstock \
    r-radviz-feedstock \
    r-rankfd-feedstock \
    r-rasciidoc-feedstock \
    r-spatstat.linnet-feedstock \
    r-rdrobust-feedstock \
    r-readoffice-feedstock

build_all \
    r-regexselect-feedstock \
    r-reval-feedstock \
    r-solrium-feedstock \
    r-rlmdatadriven-feedstock \
    r-rmdplugr-feedstock \
    r-rolldown-feedstock \
    r-rotl-feedstock \
    r-rrpp-feedstock \
    r-scraep-feedstock \
    r-sgmcmc-feedstock \
    r-shinydashboardplus-feedstock \
    r-shotgroups-feedstock \
    r-sitree-feedstock \
    r-smoothhazard-feedstock \
    r-supernova-feedstock \
    r-superranker-feedstock

build_all \
    r-teachingsampling-feedstock \
    r-tfdatasets-feedstock \
    r-tidytext-feedstock \
    r-tm.plugin.factiva-feedstock \
    r-tourr-feedstock \
    r-transurv-feedstock \
    r-trimr-feedstock \
    r-uiucthemes-feedstock \
    r-uncdecomp-feedstock \
    r-unikn-feedstock \
    r-urlshortener-feedstock \
    r-visielse-feedstock \
    r-voxr-feedstock \
    r-webchem-feedstock \
    r-wikifacts-feedstock \
    r-waldo-feedstock

build_all \
    r-spatstat-feedstock \
    r-testthat-feedstock \
    r-rdflib-feedstock \
    r-badger-feedstock \
    r-posterior-feedstock \
    r-bigtime-feedstock \
    r-recipes-feedstock \
    r-plotly-feedstock \
    r-concordance-feedstock \
    r-conquestr-feedstock \
    r-cubeview-feedstock \
    r-janitor-feedstock \
    r-dataverse-feedstock \
    r-diagrammer-feedstock \
    r-do-feedstock \
    r-broom-feedstock

build_all \
    r-hmisc-feedstock \
    r-rainbow-feedstock \
    r-fields-feedstock \
    r-geojsonio-feedstock \
    r-geosapi-feedstock \
    r-ggfortify-feedstock \
    r-mlogit-feedstock \
    r-quadmesh-feedstock \
    r-tsdyn-feedstock \
    r-idiogramfish-feedstock \
    r-implyr-feedstock \
    r-imputets-feedstock \
    r-interva5-feedstock \
    r-haven-feedstock \
    r-leaflet-feedstock \
    r-migest-feedstock

build_all \
    r-mlearning-feedstock \
    r-mrbayes-feedstock \
    r-openintro-feedstock \
    r-params-feedstock \
    r-rbokeh-feedstock \
    r-rglobi-feedstock \
    r-ritis-feedstock \
    r-rnumerai-feedstock \
    r-ruta-feedstock \
    r-scdhlm-feedstock \
    r-sparklyr-feedstock \
    r-tsclust-feedstock \
    r-vegdata-feedstock \
    r-vlad-feedstock \
    r-wikidataqueryservicer-feedstock


build_all \
    r-nloptr-feedstock \
    r-affluenceindex-feedstock \
    r-devtools-feedstock \
    r-aprof-feedstock \
    r-atlas-feedstock \
    r-atom4r-feedstock \
    r-bayesplot-feedstock \
    r-caret-feedstock \
    r-chemospecutils-feedstock \
    r-rmapshaper-feedstock \
    r-dams-feedstock \
    r-geepack-feedstock \
    r-rms-feedstock \
    r-esvis-feedstock \
    r-fds-feedstock \
    r-fselectorrcpp-feedstock

build_all \
    r-gap-feedstock \
    r-gd-feedstock \
    r-grader-feedstock \
    r-graticule-feedstock \
    r-gvarx-feedstock \
    r-hedgehog-feedstock \
    r-hero-feedstock \
    r-highcharter-feedstock \
    r-httptest-feedstock \
    r-humanformat-feedstock \
    r-hypercube-feedstock \
    r-irtrees-feedstock \
    r-labelled-feedstock \
    r-lintr-feedstock \
    r-lomb-feedstock \
    r-tsdist-feedstock

build_all \
    r-markmyassignment-feedstock \
    r-mcmcse-feedstock \
    r-micropop-feedstock \
    r-mockery-feedstock \
    r-monetdb.r-feedstock \
    r-msbox-feedstock \
    r-npde-feedstock \
    r-osmose-feedstock \
    r-pch-feedstock \
    r-poolfstat-feedstock \
    r-radiosonde-feedstock \
    r-randomforestsrc-feedstock \
    r-randomglm-feedstock \
    r-rcarbon-feedstock \
    r-rio-feedstock \
    r-riverload-feedstock

build_all \
    r-seminr-feedstock \
    r-separationplot-feedstock \
    r-soilphysics-feedstock \
    r-stableestim-feedstock \
    r-swirl-feedstock \
    r-toordinal-feedstock \
    r-valection-feedstock \
    r-vote-feedstock \
    r-wikidatar-feedstock


build_all \
    r-adoptr-feedstock \
    r-lme4-feedstock \
    r-anylib-feedstock \
    r-bisectr-feedstock \
    r-bnviewer-feedstock \
    r-riskregression-feedstock \
    r-chemospec-feedstock \
    r-chemospec2d-feedstock \
    r-cshapes-feedstock \
    r-datr-feedstock \
    r-discsurv-feedstock \
    r-ems-feedstock \
    r-fda-feedstock \
    r-foretell-feedstock \
    r-grcdata-feedstock \
    r-infotrad-feedstock

build_all \
    r-junctions-feedstock \
    r-lsdinterface-feedstock \
    r-maxpro-feedstock \
    r-misssbm-feedstock \
    r-saemix-feedstock \
    r-mssm-feedstock \
    r-nlshrink-feedstock \
    r-npbayesimputecat-feedstock \
    r-opalr-feedstock \
    r-pgsc-feedstock \
    r-r2beat-feedstock \
    r-rcppnloptexample-feedstock \
    r-riskparityportfolio-feedstock \
    r-riskportfolios-feedstock \
    r-robustgasp-feedstock \
    r-rrscale-feedstock

build_all \
    r-simms-feedstock \
    r-survauc-feedstock \
    r-wikitaxa-feedstock \
    r-zen4r-feedstock


build_all \
    r-lmertest-feedstock \
    r-pbkrtest-feedstock \
    r-altmeta-feedstock \
    r-aods3-feedstock \
    r-arm-feedstock \
    r-blme-feedstock \
    r-bradleyterry2-feedstock \
    r-buildmer-feedstock \
    r-buysetest-feedstock \
    r-rlrsim-feedstock \
    r-evolvability-feedstock \
    r-faraway-feedstock \
    r-fishmethods-feedstock \
    r-gamm4-feedstock \
    r-glmmrr-feedstock \
    r-gtheory-feedstock

build_all \
    r-taxize-feedstock \
    r-helpersmg-feedstock \
    r-iccbeta-feedstock \
    r-inferference-feedstock \
    r-influence.me-feedstock \
    r-intrvals-feedstock \
    r-jlctree-feedstock \
    r-longpower-feedstock \
    r-mbest-feedstock \
    r-memss-feedstock \
    r-mixedpsy-feedstock \
    r-mixmap-feedstock \
    r-mixrf-feedstock \
    r-mkin-feedstock \
    r-mlid-feedstock \
    r-mlmrev-feedstock

build_all \
    r-multirr-feedstock \
    r-mvmise-feedstock \
    r-pec-feedstock \
    r-pbimisc-feedstock \
    r-pedigreemm-feedstock \
    r-robustblme-feedstock \
    r-rrreg-feedstock \
    r-rsq-feedstock \
    r-sae-feedstock \
    r-spcdanalyze-feedstock \
    r-standardize-feedstock \
    r-unmarked-feedstock \
    r-vca-feedstock \
    r-welchadf-feedstock


build_all \
    r-car-feedstock \
    r-caic4-feedstock \
    r-doby-feedstock \
    r-helminthr-feedstock \
    r-mi-feedstock \
    r-pammtools-feedstock \
    r-rr-feedstock \
    r-swissmrp-feedstock \
    r-tukeytrend-feedstock \
    r-wfe-feedstock


build_all \
    r-aer-feedstock \
    r-afex-feedstock \
    r-systemfit-feedstock \
    r-clusterpower-feedstock \
    r-cna-feedstock \
    r-flipscores-feedstock \
    r-rstatix-feedstock \
    r-lmviz-feedstock \
    r-nardl-feedstock \
    r-relsurv-feedstock \
    r-scottknott-feedstock \
    r-signifreg-feedstock


build_all \
    r-chainladder-feedstock \
    r-ggpubr-feedstock \
    r-glm.predict-feedstock


build_all \
    r-apc-feedstock \
    r-rpaci-feedstock

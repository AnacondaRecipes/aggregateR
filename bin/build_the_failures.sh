#!/bin/bash


echo "Please run this from inside a tmux session in case your network connection becomes disconnected!"


#export EXTRA_BUILD_ARGS=
export EXTRA_BUILD_ARGS=' --skip-existing'

mkdir -p logs

DATE=`date -Iseconds`
BUILD_LIST="logs/build_the_failures_list.log"
BUILD_GOOD="logs/build_the_failures_good.log"
BUILD_FAIL="logs/build_the_failures_fail.log"
BUILD_FULL="logs/build_the_failures_full.log"

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
    `rg -o " .*feedstock" logs/build_the_rest_fail.log`

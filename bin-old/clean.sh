#!/bin/sh

conda clean -a        || exit
conda build purge-all || exit

for f in ${@} ; do
    conda build  --error-overdepending --error-overlinking ${f}
done

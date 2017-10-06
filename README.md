# aggregateR

# 1. .. to clean everything up:
git reset --hard
git submodule foreach git reset --hard
git submodule foreach git clean -dxf .
git clean -dxf .

# 2. .. to update the recipes:
conda skeleton cran --output-suffix=-feedstock/recipe --recursive --add-maintainer=mingwandroid --update-policy=merge-keep-build-num $(echo * | sed 's/rstudio-feedstock//' | sed 's/r-essentials-feedstock//' | sed 's/r-recommended-feedstock//' | sed 's/r-shinysky-feedstock//' | sed 's/r-rmr2-feedstock//' | sed 's/rpy2-feedstock//' | sed 's/r-base-feedstock//')

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

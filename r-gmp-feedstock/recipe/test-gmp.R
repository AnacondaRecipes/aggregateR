
r <- try(library('gmp'), silent=TRUE)
if (inherits (r, 'try-error')) {
    cat("Failed to load DLL: ", r)
    quit(save="no", status=1, runLast=FALSE)
}

# This should work
r <- try(factorize(15959989))
if (inherits (r, 'try-error')) {
    cat("Failed to call factorize: ", r)
    quit(save="no", status=1, runLast=FALSE)
}

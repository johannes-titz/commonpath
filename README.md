
# Analysis script and data accompanying Falsifying the Common Path Hypothesis in Judgments of Frequency and Duration

## Download repo

You can download the repo in the normal way or do it with `usethis`
(install it if you do not have it):

``` r
# install.packages("usethis")
usethis::use_course("https://github.com/johannes-titz/commonpath/archive/master.zip")
```

    ## ✓ Downloading from 'https://github.com/johannes-titz/commonpath/archive/master.zip'

    ## 

    ## ✓ Download stored in '/home/jt/commonpath-master.zip'

    ## ✓ Unpacking ZIP file into 'commonpath-master/' (9 files extracted)

Then fire up `R` (or some GUI) in the chosen directory.

## Install and load dependencies

``` r
install.packages(c("xtable", "tidyverse", "ggplot2", "extrafont",
                   "psychometric", "readr"))
lapply(c("xtable", "tidyverse", "ggplot2", "extrafont",
         "psychometric", "readr"), require, character.only = TRUE)
```

## Run Script

``` r
source("1-prepare.R")
source("2-analyse.R")
```

This will create the figure and table in the corresponding directories
(figures and tables).

## Reporting Problems

You can file a github issue or write me an e-mail: joahnnes at
titz.science

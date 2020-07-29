
# Analysis script and data accompanying Falsifying the Common Path Hypothesis in Judgments of Frequency and Duration

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

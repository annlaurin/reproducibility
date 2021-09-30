# Package names
packages <- c('knitr', 'coda', 'plyr', "tidyverse", 'ggplot2',
              'xtable', 'dplyr', 'SIN', 'papaja', 'tidybayes',
              'rstantools', 'brms', 'riverplot', 'boot')

# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Packages loading
invisible(lapply(packages, library, character.only = TRUE))
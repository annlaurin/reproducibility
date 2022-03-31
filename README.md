# Introduction 

This repository provides all the materials needed to reproduce the contents of the paper entitled 

**"Share the code, not just the data: A case study of reproducibility of JML articles published under the open data policy"**.

Authors: [Anna Laurinavichyute](https://annlaurin.netlify.app/), [Himanshu Yadav](https://sites.google.com/site/himanshuyadavjnu/), and [Shravan Vasishth](https://vasishth.github.io/).

**Download the paper from here**: https://psyarxiv.com/hf297/

# Structure

The directory has the following structure: 

            .
            ├── LYVReproducibility2022.pdf
            ├── R
            │   └── install_packages.R
            ├── README.md
            ├── data
            │   └── overview_numeric_anon.csv
            └── paper
                ├── LYVReproducibility2022.R
                ├── LYVReproducibility2022.Rnw
                ├── LYVReproducibility2022.bib
                ├── model_inf_priors.rds
                ├── model_inf_priors_relaxed.rds
 
- LYVReproducibility2022.pdf is a copy of the paper as submitted on 31st March 2022.
- The *R* folder contains supplementary scripts that you may need (see below, Prerequisites). Please read all the instructions below before running the R code.
- README.md. This file.
- The *data* folder contains the anonymized table with information about the surveyed papers.
- The *paper* folder contains all the files necessary for generating the pdf of the manuscript, as well as the extracted R code from the paper. Compiling the Rnw assumes that you have a proper LaTeX setup (see below).

These files also include the descriptive and inferential statistical analyses that were performed.

# Prerequisites for compiling the paper: Install packages

You will need a number of R packages to run the code generating the paper (the file "paper/LYVReproducibility2022.Rnw"). The .Rnw file assumes that the packages are installed and can be loaded. If you don't have them installed, the document will not compile. 

Either you should install each of the required R packages yourself or, if you want to install all the packages in one go, run the script "R/install_packages.R". This script checks whether the needed packages are installed and if not, installs them for you. Particularly for the package rstan, user will need to so some extra work:

Please look at the instructions here for installing rstan and follow the instructions carefully, otherwise the code will not work:

https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started

macOS users will need to have Xcode installed. For the latest version of macOS (Monterey), follow the instructions below for installing the needed R compiler tools:

https://thecoatlessprofessor.com/programming/cpp/r-compiler-tools-for-rcpp-on-macos/ 

# Compiling the manuscript (Linux/macOS)

The explanation below presupposes that you are using either some kind of Linux machine or a machine running a recent macOS version. For comments on trying to run the code on Windows, see below.

In principle, and assuming that everything is installed corrected on your machine, the paper can be compiled by opening the file "paper/LYVReproducibility2022.Rnw" in RStudio and pressing the "Compile pdf" button. To generate the references you will have to run "biber LYVReproducibility2022" on the command line (in the terminal or within RStudio itself) and then compile the file twice. 

To bypass RStudio, you can compile the Rnw on the command line by typing the following command:

    Rscript -e "library(knitr); knit('LYVReproducibility2022.Rnw')"; pdflatex LYVReproducibility2022.tex; biber LYVReproducibility2022; pdflatex LYVReproducibility2022.tex; pdflatex LYVReproducibility2022.tex

## Extracting the R code


We have already provided the extracted R code in the file: "paper/LYVReproducibility2022.R".

If for some reason you want to extract the R code again from the .Rnw file, run the R command below on the R command line (make sure you are in the directory where the Rnw file lives):

    knitr::purl("LYVReproducibility2022.Rnw") 


# Compiling the manuscript (Windows)

To compile the paper on a recent version of Windows, you need to take the following steps:

- After installing the latest versions of R and RStudio, follow these instructions to install RTools and rstan as explained here: https://github.com/stan-dev/rstan/wiki/Configuring-C---Toolchain-for-Windows
- Then, install all the packages as discussed above under Prerequisites.
- After that, you should be able to at least run all the R code after extracting it using purl.
- If you want to compile the pdf from the Rnw file, you will need to install MiKTeX: https://miktex.org/. Once MiKTeX is installed, compile the Rnw file within RStudio, and then use MiKTeX to compile the .tex output to pdf as discussed above (biber is included in MiKTeX). This may or may not work, depending on whether MiKTeX is properly installed. But at least the above steps will allow you to run the R code on Windows.

# sessionInfo() output

    > sessionInfo()
    R version 4.1.1 (2021-08-10)
    Platform: x86_64-apple-darwin17.0 (64-bit)
    Running under: macOS Big Sur 11.5.2

    Matrix products: default
    LAPACK: /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRlapack.dylib

    locale:
    [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base     

    other attached packages:
     [1] boot_1.3-28       riverplot_0.10    brms_2.16.1       Rcpp_1.0.7       
     [5] rstantools_2.1.1  tidybayes_3.0.1   forcats_0.5.1     stringr_1.4.0    
     [9] purrr_0.3.4       readr_2.0.1       tidyr_1.1.3       tibble_3.1.4     
    [13] tidyverse_1.3.1   papaja_0.1.0.9997 SIN_0.6           dplyr_1.0.7      
    [17] xtable_1.8-4      ggplot2_3.3.5     plyr_1.8.6        coda_0.19-4      
    [21] knitr_1.33       

    loaded via a namespace (and not attached):
      [1] readxl_1.3.1         backports_1.2.1      igraph_1.2.6        
      [4] splines_4.1.1        svUnit_1.0.6         crosstalk_1.1.1     
      [7] inline_0.3.19        digest_0.6.28        htmltools_0.5.2     
     [10] rsconnect_0.8.24     fansi_0.5.0          magrittr_2.0.1      
     [13] checkmate_2.0.0      tzdb_0.1.2           modelr_0.1.8        
     [16] RcppParallel_5.1.4   matrixStats_0.60.1   xts_0.12.1          
     [19] prettyunits_1.1.1    colorspace_2.0-2     rvest_1.0.1         
     [22] ggdist_3.0.0         haven_2.4.3          xfun_0.25           
     [25] callr_3.7.0          crayon_1.4.1         jsonlite_1.7.2      
     [28] lme4_1.1-27.1        zoo_1.8-9            glue_1.4.2          
     [31] gtable_0.3.0         V8_3.4.2             distributional_0.2.2
     [34] pkgbuild_1.2.0       rstan_2.21.2         abind_1.4-5         
     [37] scales_1.1.1         mvtnorm_1.1-2        DBI_1.1.1           
     [40] miniUI_0.1.1.1       stats4_4.1.1         StanHeaders_2.21.0-7
     [43] DT_0.19              htmlwidgets_1.5.3    httr_1.4.2          
     [46] threejs_0.3.3        arrayhelpers_1.1-0   RColorBrewer_1.1-2  
     [49] posterior_1.0.1      ellipsis_0.3.2       pkgconfig_2.0.3     
     [52] loo_2.4.1            farver_2.1.0         dbplyr_2.1.1        
     [55] utf8_1.2.2           tidyselect_1.1.1     rlang_0.4.11        
     [58] reshape2_1.4.4       later_1.3.0          munsell_0.5.0       
     [61] cellranger_1.1.0     tools_4.1.1          cli_3.0.1           
     [64] generics_0.1.0       broom_0.7.9.9000     ggridges_0.5.3      
     [67] evaluate_0.14        fastmap_1.1.0        processx_3.5.2      
     [70] fs_1.5.0             nlme_3.1-152         mime_0.11           
     [73] projpred_2.0.2       xml2_1.3.2           compiler_4.1.1      
     [76] bayesplot_1.8.1      shinythemes_1.2.0    rstudioapi_0.13     
     [79] gamm4_0.2-6          curl_4.3.2           reprex_2.0.1        
     [82] stringi_1.7.4        ps_1.6.0             Brobdingnag_1.2-6   
     [85] lattice_0.20-44      Matrix_1.3-4         nloptr_1.2.2.2      
     [88] markdown_1.1         shinyjs_2.0.0        tensorA_0.36.2      
     [91] vctrs_0.3.8          pillar_1.6.3         lifecycle_1.0.1     
     [94] bridgesampling_1.1-2 httpuv_1.6.2         R6_2.5.1            
     [97] promises_1.2.0.1     gridExtra_2.3        codetools_0.2-18    
    [100] colourpicker_1.1.0   MASS_7.3-54          gtools_3.9.2        
    [103] assertthat_0.2.1     withr_2.4.2          shinystan_2.5.0     
    [106] mgcv_1.8-36          parallel_4.1.1       hms_1.1.0           
    [109] grid_4.1.1           minqa_1.2.4          shiny_1.6.0         
    [112] lubridate_1.7.10     base64enc_0.1-3      dygraphs_1.1.1.6  

# Citation

     @unpublished{LYVReproducibility2022,
     title={Share the code, not just the data: {A} case study of reproducibility of {JML} articles published under the open data policy},
     author={Anna Laurinavichyute, Himanshu Yadav, and Shravan Vasishth},
     year = {2022},
     code = {https://osf.io/3bzu8/},
     pdf = {https://psyarxiv.com/hf297/},
     note = {submitted to the Journal of Memory and Language}
     }

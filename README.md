This repository provides all the materials needed to reproduce the contents of the paper "The (ir)reproducibility of published analyses: A case study of
57 JML articles published between 2019 and 2021".

## Structure

The directory has the following structure: the "data" folder contains the anonymized table with information about the surveyed papers. The "R" folder contains supplementary scripts that you may need. The "paper" folder contains all the files necessary for generating the pdf of the manuscript. This files also include the descriptive and inferential statistical analyses that were performed.

## Loading packages

You will need a number of packages to run the code generating the paper (the file "paper/LaurinavichyuteVasishthJML2021.Rnw"). The .Rnw file assumes that the packages are installed and can be loaded. If you don't have them installed, the document will not compile. We recommend running the "R/Install_load.R" script that checkes whether the needed packages are installed and if not, installs them for you.

## Regenerating the manuscript

The paper can then be compiled by opening the "LaurinavichyuteVasishthJML2021.Rnw" from the "paper" folder in RStudio and pressing the "Compile pdf" button. 

## Citation

@unpublished{LaurinavichyuteVasishth2021,
title={The (Ir)reproducibility of published analyses: {A} case study of 57 {JML} articles published between 2019 and 2021},
  author={Anna Laurinavichyute and Shravan Vasishth},
  year = {2021},
  code = {},
  OPTpdf = {},
  note = {submitted to the Journal of Memory and Language}
  }

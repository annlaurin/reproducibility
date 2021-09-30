This repository provides all the materials needed to reproduce the contents of the paper entitled 

    "The (ir)reproducibility of published analyses: A case study of 57 JML articles published between 2019 and 2021", by [Anna Laurinavichyute](https://annlaurin.github.io/) and [Shravan Vasishth](vasishth.github.io).

## Structure

The directory has the following structure: 

- The *data* folder contains the anonymized table with information about the surveyed papers. - The *R* folder contains supplementary scripts that you may need. 
- The *paper* folder contains all the files necessary for generating the pdf of the manuscript. 

These files also include the descriptive and inferential statistical analyses that were performed.

## Prerequisites for compiling the paper: Install packages

You will need a number of packages to run the code generating the paper (the file "paper/LaurinavichyuteVasishthJML2021.Rnw"). The .Rnw file assumes that the packages are installed and can be loaded. If you don't have them installed, the document will not compile. 

Either you should install each of the required packages yourself or, if you want to install all the packages in one go, run the script "R/install_packages.R". This script checks whether the needed packages are installed and if not, installs them for you.

## Compiling the manuscript

The paper can then be compiled by opening the file "paper/LaurinavichyuteVasishthJML2021.Rnw" in RStudio and pressing the "Compile pdf" button. 

## Citation

   @unpublished{LaurinavichyuteVasishth2021,
   title={The (Ir)reproducibility of published analyses: {A} case study of 57 {JML} articles published between 2019 and 2021},
  author={Anna Laurinavichyute and Shravan Vasishth},
  year = {2021},
  code = {https://osf.io/3bzu8/},
  OPTpdf = {},
  note = {submitted to the Journal of Memory and Language}
  }

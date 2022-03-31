## ----setup,include=FALSE,cache=FALSE,echo=FALSE--------------------------
knitr::opts_chunk$set(echo = FALSE, purl=TRUE)
library('knitr')
library('coda') 
library('plyr') 
library('ggplot2') 
library('xtable')
library('dplyr')
library('SIN')
library('tidyverse') 
library('tidybayes')
library('rstantools')
library('brms')
library('riverplot') 
library('boot')


## ----loaddata, include=FALSE---------------------------------------------
data <- read.delim("../data/overview_numeric_anon.csv", sep=";", 
                   header=TRUE, na.strings=c(""))%>%
  select(-Processed, -Assigned) 

# Open data policy subset
sbst <- data %>%
  filter(Group == "Open data policy")

papers_with_data <- sbst %>% filter(Data_accessible == "yes") 
papers_with_data_no_code <- sbst %>% filter(Data_accessible == "yes", Code == "no") 
papers_with_code <- papers_with_data %>% filter(Code == "yes") 
papers_with_full_data <- sbst %>% filter(Data_accessible == "yes" & Full_dataset == "yes")


# Papers published before open data policy
pre_policy <- data %>%
  filter(Group == "Before open data policy")

papers_with_data_pp <- pre_policy %>% filter(Data_accessible == "yes") 
papers_with_data_no_code_pp <- pre_policy %>% filter(Data_accessible == "yes", Code == "no") 
papers_with_code_pp <- papers_with_data_pp %>% filter(Code == "yes") 
papers_with_full_data_pp <- pre_policy %>% filter(Data_accessible == "yes" & Full_dataset == "yes")


## ----summaryfig,echo=FALSE,fig.height=2.3--------------------------------
data_plot <- data %>%
  rename("Data accessible" = "Data_accessible") %>%
  select(`Data accessible`, Preregistered, Code,
         Readme, Group)

data_long <- gather(data=data_plot, key=condition, value=y,
                    `Data accessible`:Readme,
                    factor_key=TRUE)
data_long$y<-factor(data_long$y)

data_long %>%
  group_by(Group) %>%
  count(condition,y) %>%
  pivot_wider(names_from = y, values_from = n)%>%
  reshape2::melt(id = c("Group", "condition")) %>%
  ggplot(aes(x = condition, y = value,
             fill = variable, label = value)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ Group) + 
  geom_text(size=4, position = position_stack(vjust=0.5)) +
  coord_flip() + theme_bw() +
  scale_fill_grey(start = 0.9, end = 0.75,
                  guide=guide_legend(reverse=TRUE)) +
  xlab("") + ylab("") +
  theme(legend.title = element_blank(),
        text = element_text(size =15))


## ----reproducibilityfig, eval=FALSE, include = FALSE, echo=FALSE, message=FALSE----
## ifelse(!dir.exists("images"), dir.create("images"), FALSE)
## 
## palette <- c("#c9c9c9", "#f2a7b1", "#c9c9c9",
##              "#9bb6d1", "#9bb6d1", "#f2a7b1",
##              "#c9c9c9", "#c991b1", "#c991b1")
## 
## labels <- c("A", "B")
## 
## # first panel
## myedges = data.frame(ID = 1:8,
##                      N1 = c("Not reproduced", "Reproduced",  "Not reproduced",
##                             "Reproduced",  "No code", "Code","No data", "Data"),
##                      Value = c(13,19,18,1,19,32,8,51))
## 
## myedges$N1 <- paste(myedges$N1, "\n", paste0(myedges$Value))
## myedges$N2 <- c(rep("Code \n 32", 2),
##                 rep("No code \n 19", 2),
##                 rep("Data \n 51", 2),
##                 rep(paste("All surveyed papers \n", 59), 2))
## 
## 
## mynodes <- data.frame(ID=c(myedges$N1, paste("All surveyed papers \n", 59)),
##                       x=c(4,  4 ,  4,   4,    3,  3,  2,   2,  1),
##                       y=c(5,  1,   13,  9,   11,  3,  1,   7.5,  4))
## 
## 
## mystyles = lapply(mynodes$y, function(n) {
##   list(col = palette[n])
## })
## 
## for(i in 1:length(palette)){
##   mystyles[[i]]$col<-palette[i]
## }
## 
## names(mystyles) <- mynodes$ID
## 
## custom.style <- riverplot::default.style()
## custom.style$textcex <- 1.8
## 
## myriv <- makeRiver(nodes=mynodes, edges=myedges, node_styles=mystyles)
## 
## # second panel
## myedges2 = data.frame(ID = 1:8,
##                       N1 = c("Not reproduced", "Reproduced",  "Not reproduced",
##                              "Reproduced",  "No code", "Code","No data", "Data"),
##                       Value = c(6,26,12,7,19,32,8,51))
## 
## myedges2$N1 <- paste(myedges2$N1, "\n", paste0(myedges2$Value))
## myedges2$N2 <- c(rep("Code \n 32", 2),
##                  rep("No code \n 19", 2),
##                  rep("Data \n 51", 2),
##                  rep(paste("All surveyed papers \n", 59), 2))
## 
## 
## mynodes2 <- data.frame(ID=c(myedges2$N1, paste("All surveyed papers \n", 59)),
##                       x=c(4,  4 ,  4,   4,    3,  3,  2,   2,  1),
##                       y=c(5,  1,   13,  9,   11,  3,  1,   7.5,  4))
## 
## mystyles2 = lapply(mynodes2$y, function(n) {
##   list(col = palette[n])
## })
## 
## for(i in 1:length(palette)){
##   mystyles2[[i]]$col<-palette[i]
## }
## 
## names(mystyles2) <- mynodes2$ID
## myriv2 <- makeRiver(nodes=mynodes2, edges=myedges2, node_styles=mystyles2)
## 
## 
## png("RiverJoint.png", units="in", res=120, height=20, width=10)
## par(mfrow = c(2, 1))
## plot(myriv2, default_style=custom.style, nodewidth=2, plot_area=.88)
## title(ylab="The most lenient criterion",
##       cex.lab=2, line = -1)
## mtext(labels[2], side = 1, cex = 2, las = 2)
## plot(myriv, default_style=custom.style, nodewidth=2, plot_area=.88)
## title(ylab="The strict criterion",
##       cex.lab=2, line = -1)
## mtext(labels[1], side = 1, line = - 4,
##       outer = TRUE, cex = 2, las = 2)
## dev.off()


## ----modelingpriors, include=FALSE, echo=FALSE---------------------------
data <- read.csv("../data/overview_numeric_anon.csv", sep = ";", 
                 stringsAsFactors = FALSE) %>%
  rename("Data accessible" = "Data_accessible") %>%
  filter(Group == "Open data policy") %>%
  select(`Data accessible`, Preregistered, Code,
         Readme, Reproducible)

data[data=="yes"] <- 1
data[data=="no"] <- 0

data <- data %>%
    mutate_if(is.character,as.numeric)

data_filtered <- data %>%
  filter(`Data accessible` == 1)

### Bayesian model
priors <- c(prior(normal(0, 1.2), class = Intercept),          
            prior(normal(0, 1.5), class = b)) 


## ----computepriorpred,echo=FALSE,include=FALSE,cache=TRUE----------------
set.seed(14)
model_priorpred <- brm(Reproducible ~ Readme + Preregistered + Code, 
             data = data_filtered, family="bernoulli",
             prior = priors,
             sample_prior = "only"
             )


## ----computepriorpred2,echo=FALSE----------------------------------------
alpha_samples <- as_draws_df(model_priorpred)$b_Intercept
av_accuracy <- plogis(alpha_samples)

int_summary<-c(mean = mean(av_accuracy), quantile(av_accuracy, c(0.025, 0.975)))

beta_samples <- as_draws_df(model_priorpred)$b_Code

## the prior predicted effect of code present:
effect_code <-  plogis(alpha_samples + beta_samples) - plogis(alpha_samples)

effect_code_summary<-c(mean = mean(effect_code), quantile(effect_code,
c(0.025, 0.975)))


## ----modeling, include=FALSE, echo=FALSE---------------------------------
model_treatment <- brm(Reproducible ~ Readme + Preregistered + Code, 
             data = data_filtered, family="bernoulli",
             prior = priors, file = "model_inf_priors")

# computing credible interval for Code on % scale
model_treatment %>%
  spread_draws(b_Intercept, b_Code) %>%
  mutate(code=plogis(b_Intercept + b_Code)-plogis(b_Intercept)) -> x

# computing credible interval for the intercept on % scale
model_treatment %>%
  spread_draws(b_Intercept) %>%
  mutate(intercept=plogis(b_Intercept)) -> intercept


## ----modeling_summary, echo=FALSE,results='asis'-------------------------
m<-fixef(model_treatment)
m<-round(m,2)
print(xtable(m, comment=FALSE, caption = "Estimates of the log odds of reproducing an analysis according to the strict reproducibility criterion: estimating the contribution of analysis code, readme, and preregistration.", label = "tab:logistic"), math.style.negative = TRUE, type="latex", caption.placement = "top")


## ----modelingprep2, include=FALSE, echo=FALSE----------------------------
data_rel <- read.csv("../data/overview_numeric_anon.csv", sep = ";", 
                 stringsAsFactors = FALSE) %>%
  rename("Data accessible" = "Data_accessible") %>%
  filter(Group == "Open data policy") %>%
  select(`Data accessible`, Preregistered, Code,
         Readme, Relaxed_reproducible_20)

data_rel[data_rel=="yes"] <- 1
data_rel[data_rel=="no"] <- 0

data_rel <- data_rel %>%
    mutate_if(is.character,as.numeric)

data_filtered_rel <- data_rel %>%
  filter(`Data accessible` == 1)



## ----modeling2, include=FALSE, echo=FALSE--------------------------------
model_treatment_rel <- brm(Relaxed_reproducible_20 ~ Readme + Preregistered + Code, 
                       data = data_filtered_rel, family="bernoulli",
                       prior = priors, file = "model_inf_priors_relaxed")

# computing credible interval for Code on % scale
model_treatment_rel %>%
  spread_draws(b_Intercept, b_Code) %>%
  mutate(code=plogis(b_Intercept + b_Code)-plogis(b_Intercept)) -> x_rel

# computing credible interval for the intercept on % scale
model_treatment_rel %>%
  spread_draws(b_Intercept) %>%
  mutate(intercept=plogis(b_Intercept)) -> intercept_rel


## ----modeling_summary2, echo=FALSE,results='asis'------------------------
m<-fixef(model_treatment_rel)
m<-round(m,2)
print(xtable(m, comment=FALSE, caption = "Estimates of the log odds of reproducing an analysis according to the most lenient reproducibility criterion: estimating the contribution of analysis code, readme, and preregistration.", label = "tab:logistic2"), math.style.negative = TRUE, type="latex", caption.placement = "top")


## ----bootstrapping_our_reproducibility, echo=FALSE-----------------------
## Computing confidence intervals using bootstrapping:

meanfun <- function(data, i){
  d <- data[i, ]
  return(mean(d))   
}

# our estimate
papers_code <- data %>%
  filter(`Data accessible` == 1 & Code == 1)

bo <- boot(papers_code[ , "Reproducible", drop = FALSE],
           statistic=meanfun, R=5000)
boot_lower <- boot.ci(bo, conf=0.95, type="bca")[4]$bca[4]
boot_upper <- boot.ci(bo, conf=0.95, type="bca")[4]$bca[5]

# Obels et al. estimate
Reproducible <- c(rep(0, 15), rep(1, 21))
obels <- data.frame(Reproducible)
bo_O <- boot(obels[ , "Reproducible", drop = FALSE],
           statistic=meanfun, R=5000)
boot_lower_O <- boot.ci(bo_O, conf=0.95, type="bca")[4]$bca[4]
boot_upper_O <- boot.ci(bo_O, conf=0.95, type="bca")[4]$bca[5]


# Artner et al. estimate (using bootstrapping):
Reproducible <- c(rep(0, 69), rep(1, 163))
artner <- data.frame(Reproducible)
bo_A <- boot(artner[ , "Reproducible", drop = FALSE],
           statistic=meanfun, R=5000)
boot_lower_A <- boot.ci(bo_A, conf=0.95, type="bca")[4]$bca[4]
boot_upper_A <- boot.ci(bo_A, conf=0.95, type="bca")[4]$bca[5]


## ----countingproblems,echo=FALSE,include=FALSE,cache=TRUE----------------
sbst <- sbst %>%
  rename("Data accessible" = "Data_accessible") %>%
  filter(Group == "Open data policy") %>%
  select(-Paper.ID, -Group) %>%
  mutate(across(everything(), as.character)) %>%
  mutate(across(everything(), ~ ifelse(.x == "yes", 1, 0)))

sbst[is.na(sbst)] <- 0


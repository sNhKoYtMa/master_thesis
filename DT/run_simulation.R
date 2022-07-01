# Run simulation

set.seed(722)
library(tidyverse)
library(MASS)
library(caret)
library(MLmetrics)
library(corpcor)
library(mvtnorm)
Result <- matrix(NA,0,11) %>% as.data.frame()
for(train_ratio in c(0.28)){
  make.data <- 1; run <- 1
  source("LDA.R"); make.data <- 2
  source("QDA.R")
  source("Logistic_Multi.R")
  for(run in c(1,4,6)) source("MLR.R")
  for(run in c(1,4,6)) source("iMvTa.R")
  for(run in c(1,4,6)) source("MvTa.R")
  for(run in c(1,4,6)) source("MvT+a.R")
}
Result

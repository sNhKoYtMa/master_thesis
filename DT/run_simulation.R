# Run simulation

# Check list
#  data_read.R
#  data_main.R
#  output.csv

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
  # source("QDA.R")
  # source("Logistic_Multi.R")
  # for(run in c(1,4,6)) source("MLR.R")
  # for(run in c(1,4,6)) source("iMvTa.R")
  for(run in c(1,4,6)) source("MvTa.R")
  for(run in c(1,4,6)) source("MvT+a.R")
}
Result

# seq(0.02, 0.50, 0.02)
# table(train_target)
# X_dim
# make.data <- 1
# train_ratio <- 0.1
# conversion <- "DC_D"

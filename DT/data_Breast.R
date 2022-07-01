# Breast Cancer data
# https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+(Diagnostic)

set.seed(722)
data_name <- 'Breast'
# train_ratio <- 0.20
SimTime <- 10
class_num <- 2

df <- read.csv('real_data/breast.csv') %>%
  mutate(Target = as.character(diagnosis)) %>% 
  dplyr::select(-c(id, diagnosis, X))

source('data_dummy_variable.R')


set.seed(722)
data_name <- "Glass"
# train_ratio <- 0.20
SimTime <- 10
class_num <- 7

# library(tidyverse)
df <- read.csv("real_data/glass.data", header = F) %>%
  mutate(Target = as.character(V11)) %>% 
  rename(Id = V1,
         RI = V2,
         Na = V3,
         Mg = V4,
         Al = V5,
         Si = V6,
         K = V7,
         Ca = V8,
         Ba = V9,
         Fe = V10) %>% 
  dplyr::select(-c(Id, V11))

source("data_dummy_variable.R")

# Wine Data Set
# https://archive.ics.uci.edu/ml/datasets/Wine

set.seed(722)
data_name <- "Wine"
# train_ratio <- 0.20
SimTime <- 10
class_num <- 3

df <- read.csv("real_data/wine.data", header = F) %>%
  mutate(Target = as.character(V1)) %>% 
  rename(Alcohol = V2,
         Malic_acid = V3,
         Ash = V4,
         Alcalinity_of_ash = V5,
         Magnesium = V6,
         Total_phenols = V7,
         Flavanoids = V8,
         Nonflavanoid_phenols = V9,
         Proanthocyanins = V10,
         Color_intensity = V11,
         Hue = V12,
         OD280_OD315_of_diluted_wines = V13,
         Proline = V14,
         ) %>% 
  dplyr::select(-c(V1))

source("data_dummy_variable.R")



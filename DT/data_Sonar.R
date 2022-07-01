# Sonar data
set.seed(722)
data_name <- 'Sonar'
train_ratio <- 0.05
SimTime <- 1000
class_num <- 2

df <- read.csv('real_data/sonar.all-data',header=F) %>% 
  rename(Target = V61) %>% 
  mutate(Target = as.character(Target))

source('data_dummy_variable.R')

df %>% 
  dplyr::select(-Target) %>%
  cor() %>% 
  corrplot::corrplot()



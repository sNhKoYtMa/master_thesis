# Ionosphere Data Set
# https://archive.ics.uci.edu/ml/datasets/ionosphere

set.seed(722)
data_name <- 'Ionosphere'
train_ratio <- 0.1
SimTime <- 10
class_num <- 2
df <- read.csv('real_data/ionosphere.data', header = F) %>%
  dplyr::select(-c(V1,V2)) %>% 
  set_names(paste0('X',1:32),'Target') %>% 
  mutate(Target = as.character(Target))
sapply(df, class)
# df %>% head()
# df %>% 
#   dplyr::select(-Target) %>%
#   cor() %>% 
#   corrplot::corrplot()

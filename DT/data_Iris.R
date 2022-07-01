# irisのデータ
library(mvtnorm)
set.seed(722)
data_name <- 'Iris'
train_ratio <- 0.2
SimTime <- 10
class_num <- 2

df <- iris %>%
  rename(Target = Species) %>% 
  mutate(Target = as.character(Target)) %>% 
  filter(if (class_num == 2) Target != 'virginica' else Target != '')
# df <- df[1:62,]
# df <- df[1:80,]
# df <- df[1:120,]

source('data_dummy_variable.R')

# if ((conversion == 'LS-LDA') | (conversion == '1-of-K')){
#   df_dummy <- dummyVars(~.,data=df)
# }else if (conversion == 'vec'){
#   df_dummy <- dummyVars(~.,data=df,fullRank=T)
# }
# df_dummy <- as.data.frame(predict(df_dummy, df))
# target_name <- sub('Target','',colnames(df_dummy)[-c(1:ncol(df)-1)])
# colnames(df_dummy)[-c(1:ncol(df)-1)] <- target_name
# train_index <- df$Target %>%
#   createDataPartition(p = train_ratio, list = F, times = SimTime)
# train_size <- nrow(train_index)
# test_size <- nrow(df) - train_size
# X_dim <- ncol(df) - 1
# Y_dim <- ncol(df_dummy) - ncol(df) + 1

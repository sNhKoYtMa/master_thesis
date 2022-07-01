# LDA・QDAなどのDiscriminant Analysisのための前処理
if(data_name == "Artificial" || data_name == "Tmethod_behind"){
  train_data <- dfs[[sim]][ train_index[,sim],]
  test_data  <- dfs[[sim]][-train_index[,sim],]
}else if(data_name == "Linear_behind"){
  train_data <- dfs[[sim]][ index_list[[sim]],]
  test_data  <- dfs[[sim]][-index_list[[sim]],]
}else if(data_name %in% c("Breast", "Glass", "Wine")){
  train_data <- df[ train_index[,sim],]
  test_data  <- df[-train_index[,sim],]
}
# preproc_param <- train_data %>%
#   preProcess(method = c("center"))#, "scale")) # 標準化 N(0,1)
# train_transformed <- preproc_param %>% predict(train_data)
# test_transformed  <- preproc_param %>% predict(test_data)
train_transformed <- train_data
test_transformed  <- test_data

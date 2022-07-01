if(data_name == "Artificial" || data_name == "Tmethod_behind"){
  train_data   <- dfs_dummy[[sim]][ train_index[,sim],]
  test_data    <- dfs_dummy[[sim]][-train_index[,sim],]
  train_target <- dfs[[sim]][ train_index[,sim],"Target"] %>% as.character()
  test_target  <- dfs[[sim]][-train_index[,sim],"Target"] %>% as.character()
}else if(data_name == "Linear_behind"){
  train_data   <- dfs_dummy[[sim]][ index_list[[sim]],]
  test_data    <- dfs_dummy[[sim]][-index_list[[sim]],]
  train_target <- dfs[[sim]][ index_list[[sim]],"Target"] %>% as.character()
  test_target  <- dfs[[sim]][-index_list[[sim]],"Target"] %>% as.character()
}else if(data_name %in% c("Breast", "Glass", "Wine")){
  train_data   <- df_dummy[ train_index[,sim],]
  test_data    <- df_dummy[-train_index[,sim],]
  train_target <- df[ train_index[,sim],"Target"] %>% as.character()
  test_target  <- df[-train_index[,sim],"Target"] %>% as.character()
}
# データ変換
if(conversion == conversions[1]){
  train_data <- conversion.A(train_data, target_name)
}else if(conversion == conversions[2]){
  train_data <- conversion.B(train_data, target_name)
}else if(conversion == conversions[3]){
  train_data[,target_name] <- train_data[,target_name] * 2 - 1
# }else if(conversion == conversions[4]){
#   train_data <- conversion.D(train_data, target_name)
}else if(conversion == conversions[5]){
  train_data[,target_name] <- train_data[,target_name] * 2 - 1
# }else if(conversion == conversions[6]){
#   train_data <- conversion.F(train_data, target_name)
}

# X,Yに分割
X_train <- train_data[, !(colnames(train_data) %in% target_name)]
X_test  <- test_data [, !(colnames(test_data)  %in% target_name)]
Y_train <- train_data[, target_name] %>% as.matrix()
# 規準化(X_train,X_test):中心化
X_train_norm <- sweep(X_train, 2, apply(X_train,2,mean))
X_test_norm  <- sweep(X_test,  2, apply(X_train,2,mean))
Y_train_norm <- sweep(Y_train, 2, apply(Y_train,2,mean))
# Y_train_norm <- Y_train
Y_ave <- apply(Y_train,2,mean)
# データ整形
X_train_norm <- X_train_norm %>% as.matrix(); dimnames(X_train_norm) <- NULL
X_test_norm  <- X_test_norm  %>% as.matrix(); dimnames(X_test_norm)  <- NULL
Y_train_norm <- Y_train_norm %>% as.matrix(); dimnames(Y_train_norm) <- NULL

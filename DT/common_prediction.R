# データの整形
Y_train_hat <- Y_train_hat %>% as.data.frame()
colnames(Y_train_hat) <- target_name
Y_test_hat <- Y_test_hat %>% as.data.frame()
colnames(Y_test_hat) <- target_name
# Classにする
if(conversion %in% paste0("DC_", LETTERS[1:4])){ # DC-ABCD
  Y_train_pred <- colnames(Y_train_hat)[apply(Y_train_hat,1,which.max)] # 学習データ
  Y_test_pred <- colnames(Y_test_hat)[apply(Y_test_hat,1,which.max)] # テストデータ
}else if(conversion == paste0("DC_", LETTERS[5]) || Method == "MLR"){ # DC-E or MLR
  target_names <- unique(df$Target)
  # 学習データ
  Y_train_pred <- apply(Y_train_hat,1,function(Y){
    if(Y > 0){
      return(target_name)
    }else{return(target_names[!(target_names %in% target_name)])}
  })
  # テストデータ
  Y_test_pred <- apply(Y_test_hat,1,function(Y){
    if(Y > 0){
      return(target_name)
    }else{return(target_names[!(target_names %in% target_name)])}
  })
}else if(conversion == paste0("DC_", LETTERS[6])){ # MLR以外のDC-F
  target_names <- unique(df$Target)
  # 学習データ
  Y_train_pred <- apply(Y_train_hat,1,function(Y){
    if(Y > 0.5){
      return(target_name)
    }else{return(target_names[!(target_names %in% target_name)])}
  })
  # テストデータ
  Y_test_pred <- apply(Y_test_hat,1,function(Y){
    if(Y > 0.5){
      return(target_name)
    }else{return(target_names[!(target_names %in% target_name)])}
  })
}
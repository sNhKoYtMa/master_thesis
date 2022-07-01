set.seed(722)
conversions <- paste0("DC_", LETTERS[1:6])
conversion <- conversions[run]
##### スクリプト読み込み #####
source("data_read.R")
source("parameter_iMvTa.R")
source("func_conversion.R")
##### シミュレーション開始 #####
for(sim in 1:SimTime){
  ##### データ前処理 #####
  if(data_name == "Linear_behind") source("parameter_iMvTa_Linear.R")
  source("common_preprocessing.R")
  
  ##### 学習 #####
  r  <- diag(t(Y_train_norm) %*% Y_train_norm) %>% as.matrix() # q x 1
  ST <- diag(t(X_train_norm) %*% X_train_norm) %>% as.matrix() # p x 1
  XY <- t(X_train_norm) %*% Y_train_norm # p x q
  B  <- matrix(t(apply(XY, 1, function(Z) Z/r)),   X_dim, Y_dim) # p x q
  SB <- matrix(t(apply(XY, 1, function(Z) Z^2/r)), X_dim, Y_dim) # p x q
  SE <- -(SB - ST[,1]) # p x q
  VE <- SE / (train_size - 1) # p x q
  SN <- (SB - VE)/matrix(t(apply(VE, 1, function(Z) Z*r)), X_dim, Y_dim) # p x q
  SN <- ifelse(SN<0, 0, SN) # p x q
  SN <- ifelse(is.nan(SN), 0, SN)
  if(sum(SN)==0) SN <- matrix(rep(1,X_dim*Y_dim), X_dim, Y_dim)

  ##### 予測 #####
  for(k in 1:Y_dim){
    # 学習データ
    X_train_hat <- t(apply(X_train_norm, 1, function(X) X/B[,k]))
    X_train_hat[is.na(X_train_hat)] <- 0
    Y_train_hat[,k] <- X_train_hat %*% SN[,k] / sum(SN[,k]) + Y_ave[k] # n x q
    # テストデータ
    X_test_hat <- t(apply(X_test_norm, 1, function(X) X/B[,k]))
    X_test_hat[is.na(X_test_hat)] <- 0
    Y_test_hat[,k] <- X_test_hat %*% SN[,k] / sum(SN[,k]) + Y_ave[k] # n x q
  }
  source("common_prediction.R")
  
  ##### 評価・進捗 #####
  source("common_evaluation.R")
  source("common_progress.R")
}
##### 保存 #####
source("common_save.R")
Result

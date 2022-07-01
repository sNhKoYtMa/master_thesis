set.seed(722)
conversions <- paste0("DC_", LETTERS[1:6])
conversion <- conversions[run]
##### スクリプト読み込み #####
source("data_read.R")
source("parameter_MvTa.R")
source("func_conversion.R")
##### シミュレーション開始 #####
for(sim in 1:SimTime){
  ##### データ前処理 #####
  source("common_preprocessing.R")
  
  ##### 学習 #####
  B   <- pseudoinverse(t(Y_train_norm) %*% Y_train_norm) %*% t(Y_train_norm) %*% X_train_norm # q x p
  Sig <- 1/train_size * t(X_train_norm - Y_train_norm %*% B) %*% (X_train_norm - Y_train_norm %*% B) # p x p
  A_m <- pseudoinverse(Sig) %*% t(B) %*% pseudoinverse(B %*% pseudoinverse(Sig) %*% t(B)) # p x q
  SN  <- pseudoinverse(t(A_m) %*% Sig %*% A_m) # q x q
  SN  <- ifelse(SN<0, 0, SN)
  SN  <- ifelse(is.nan(SN), 0, SN)
  if(sum(SN)==0) SN <- matrix(rep(1,Y_dim+Y_dim), Y_dim, Y_dim)
  
  ##### 予測 #####
  # 学習データ
  Y_train_hat <- X_train_norm %*% A_m
  Y_train_hat <- (Y_train_hat%*%SN)/sum(diag(SN))
  if(conversion %in% paste0("DC_", LETTERS[5:6])){
    Y_train_hat <- apply(Y_train_hat, 1, function(Y) Y + Y_ave) %>% as.matrix()
  }else{
    Y_train_hat <- t(apply(Y_train_hat, 1, function(Y) Y + Y_ave))
  }
  # テストデータ
  Y_test_hat <- X_test_norm %*% A_m
  Y_test_hat <- (Y_test_hat%*%SN)/sum(diag(SN))
  if(conversion %in% paste0("DC_", LETTERS[5:6])){
    Y_test_hat <- apply(Y_test_hat, 1, function(Y) Y + Y_ave) %>% as.matrix()
  }else{
    Y_test_hat <- t(apply(Y_test_hat, 1, function(Y) Y + Y_ave))
  }
  source("common_prediction.R")
  
  ##### 評価・進捗 #####
  source("common_evaluation.R")
  source("common_progress.R")
}
##### 保存 #####
source("common_save.R")
Result
# if(conversion == "LS-LDA") temp <- mean(score[!is.na(score[,3]),3])

set.seed(722)
conversions <- paste0("DC_", LETTERS[1:6])
conversion <- conversions[run]
##### スクリプト読み込み #####
source("data_read.R")
source("func_conversion.R")
##### シミュレーション開始 #####
Method <- "MLR"
score <- matrix(NA, SimTime, 4)
time <- proc.time()
for(sim in 1:SimTime){
  ##### データ前処理 #####
  source("common_preprocessing.R")
  
  ##### 学習 #####
  W <- pseudoinverse(t(X_train_norm) %*% X_train_norm) %*% t(X_train_norm) %*% Y_train_norm
  ##### 予測 #####
  Y_train_hat <- X_train_norm %*% W
  Y_test_hat <- X_test_norm %*% W
  source("common_prediction.R")
  
  ##### 評価・時間計算#####
  source("common_evaluation.R")
  source("common_progress.R")
}
##### 保存 #####
source("common_save.R")
Result

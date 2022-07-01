library(MASS)
library(tidyverse)
library(caret)
library(MLmetrics)
library(corpcor)
set.seed(722)
# Result <- matrix(NA,0,11) %>% as.data.frame()
# train_ratio <- 0.1
# SimTime <- 1000
# class_num <- 2
conversion <- "DC_A" # 本当はいらない

##### スクリプト読み込み #####
source("data_read.R")

##### シミュレーション開始 #####
Method <- "Logistic"
score <- matrix(NA, SimTime, 4)
time <- proc.time()
for(sim in 1:SimTime){
  ##### データ前処理 #####
  if(data_name == "Artificial" || data_name == "Tmethod_behind"){
    train_data <- dfs[[sim]][ train_index[,sim],]
    test_data  <- dfs[[sim]][-train_index[,sim],]
  }else if(data_name == "Linear_behind"){
    train_data <- dfs[[sim]][ index_list[[sim]],]
    test_data  <- dfs[[sim]][-index_list[[sim]],]
  }else{
    train_data <- df[ train_index[,sim],]
    test_data  <- df[-train_index[,sim],]
  }
  preproc_param <- train_data %>%
    preProcess(method = c("center"))#, "scale")) # 標準化 N(0,1)
  train_transformed <- preproc_param %>% predict(train_data)
  test_transformed  <- preproc_param %>% predict(test_data)
  
  # df_dummy <- dummyVars(~.,data=train_transformed,fullRank=T)
  df_dummy <- dummyVars(~.,data=train_transformed,fullRank=T)
  df_dummy <- predict(df_dummy, train_transformed) %>% as.data.frame()
  target_name <- sub("Target","",colnames(df_dummy)[-c(1:ncol(df)-1)])
  colnames(df_dummy)[-c(1:ncol(df)-1)] <- "Target" # ここだ
  df_dummy$Target <- df_dummy$Target %>% as.integer()
  
  ##### 学習・予測 #####
  model <- glm(Target~., data=df_dummy, family=binomial)
  
  Y_train_hat <- model %>%
    predict(train_transformed, type = "response") %>% 
    as.data.frame() %>% 
    set_names(target_name)
  Y_test_hat <- model %>%
    predict(test_transformed, type = "response") %>% 
    as.data.frame() %>% 
    set_names(target_name)
  
  target_names <- unique(df$Target)
  Y_train_pred <- apply(Y_train_hat,1,function(Y){
    if(Y > 0.5){
      return(target_name)
    }else{return(target_names[!(target_names %in% target_name)])}
  }) %>% as.vector()
  Y_test_pred <- apply(Y_test_hat,1,function(Y){
    if(Y > 0.5){
      return(target_name)
    }else{return(target_names[!(target_names %in% target_name)])}
  }) %>% as.vector()
  train_target <- train_data[,"Target"]
  test_target  <- test_data[,"Target"]

  ##### 評価 #####
  source("common_evaluation.R")

  ##### 時間計算 #####
  source("common_progress.R")
}
##### 保存 #####
conversion <- NA
source("common_save.R")
Result


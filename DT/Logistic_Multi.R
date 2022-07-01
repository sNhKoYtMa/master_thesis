library(MASS)
library(tidyverse)
library(caret)
library(MLmetrics)
library(corpcor)
library(nnet)
set.seed(722)
# Result <- matrix(NA,0,11) %>% as.data.frame()
# train_ratio <- 0.1
# SimTime <- 1000
# class_num <- 2
conversion <- "DC_D" # 本当はいらない

##### スクリプト読み込み #####
source("data_read.R")

##### シミュレーション開始 #####
Method <- "Logistic"
score <- matrix(NA, SimTime, 4)
time <- proc.time()
for(sim in 1:SimTime){
  ##### データ前処理 #####
  train_data <- df[ train_index[,sim],]
  test_data  <- df[-train_index[,sim],]
  
  ##### 学習・予測 #####
  model <- multinom(Target~., data=train_data)
  
  Y_train_pred <- model %>% 
    predict(train_data) %>% 
    as.vector()
  Y_test_pred <- model %>% 
    predict(test_data) %>% 
    as.vector()
  
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


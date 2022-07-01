set.seed(722)
conversion <- "DC_D" # 本当はいらない
source("data_read.R")
##### シミュレーション開始 #####
Method <- "QDA"
score <- matrix(NA, SimTime, 4)
time <- proc.time()
for(sim in 1:SimTime){
  source("common_preprocessing_DA.R")
  model <- qda(Target~., data=train_transformed)
  source("common_prediction_DA.R")
  source("common_progress.R")
}
##### 保存 #####
conversion <- NA
source("common_save.R")
Result

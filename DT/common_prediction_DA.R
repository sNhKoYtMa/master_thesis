# LDA・QDAなどのDiscriminant Analysisのための予測と評価

##### 予測 #####
pred_train <- model %>%
  predict(train_transformed)
pred_test <- model %>%
  predict(test_transformed)

##### 評価 #####
score[sim,1] <- mean(train_transformed$Target==pred_train$class) # accuracy train
score[sim,2] <- mean(test_transformed$Target==pred_test$class)   # accuracy test
score[sim,3] <- F1_Score_macro(as.character(train_transformed$Target),
                               as.character(pred_train$class))   # F-measure train
score[sim,4] <- F1_Score_macro(as.character(test_transformed$Target),
                               as.character(pred_test$class))    # F-measure test

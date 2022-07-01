score[sim,1] <- mean(train_target==Y_train_pred) # accuracy train
score[sim,2] <- mean(test_target==Y_test_pred) # accuracy test
score[sim,3] <- F1_Score_macro(train_target,Y_train_pred) # F-measure train
score[sim,4] <- F1_Score_macro(test_target, Y_test_pred) # F-measure test
result <- data.frame(data_name, Method, conversion, train_size, X_dim, class_num, 
                     mean(score[,3]), mean(score[,4]), NA, mean(score[,2]), mean(score[,1]))
colnames(result) <- c("Data","Method","Conversion","Size","Dim","Class",
                      "F1_train","F1_test","Graph","Acc_test","Acc_train")
Result <- rbind(Result, result)
write.csv(Result, "output.csv", row.names=F)

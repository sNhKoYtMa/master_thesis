##### dummy variable #####
if(conversion %in% paste0("DC_", LETTERS[1:4])){
  df_dummy <- dummyVars(~.,data=df)
}else if(conversion %in% paste0("DC_", LETTERS[5:6])){
  df_dummy <- dummyVars(~.,data=df,fullRank=T)
}
df_dummy <- predict(df_dummy, df) %>% as.data.frame()
target_name <- sub("Target","",colnames(df_dummy)[-c(1:ncol(df)-1)])
colnames(df_dummy)[-c(1:ncol(df)-1)] <- target_name
if(make.data == 1){
  train_index <- df$Target %>%
    createDataPartition(p = train_ratio, list = F, times = SimTime)
}
train_size <- nrow(train_index)
test_size <- nrow(df) - train_size
X_dim <- ncol(df) - 1
Y_dim <- ncol(df_dummy) - ncol(df) + 1

##### dummy variable #####
# 線形回帰データの作成におけるインデックス作成
df <- dfs[[1]]
# if ((conversion == "LS-LDA") || (conversion == "1-of-K")){
if(conversion %in% paste0("DC_", LETTERS[1:4])){
    df_dummy <- dummyVars(~.,data=df)
# }else if ((conversion == "vec") || (conversion == "N_Nk")){
}else if(conversion %in% paste0("DC_", LETTERS[5:6])){
  df_dummy <- dummyVars(~.,data=df,fullRank=T)
}
df_dummy <- predict(df_dummy, df) %>% as.data.frame()
target_name <- sub("Target","",colnames(df_dummy)[-c(1:ncol(df)-1)])
colnames(df_dummy)[-c(1:ncol(df)-1)] <- target_name
train_index <- df$Target %>%
  createDataPartition(p = train_ratio, list = F, times = 1)
train_size <- nrow(train_index)
test_size <- nrow(df) - train_size
X_dim <- ncol(df) - 1
Y_dim <- ncol(df_dummy) - ncol(df) + 1

if(make.data == 1){
  index_list <- lapply(dfs, function(d) Make.Train.Index(d, train_ratio))
}

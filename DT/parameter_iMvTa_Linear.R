train_size <- nrow(index_list[[sim]])
test_size <- nrow(dfs[[sim]]) - train_size

X_train_hat <- matrix(NA,train_size,X_dim)
Y_train_hat <- matrix(NA,train_size,Y_dim)
X_test_hat <- matrix(NA,test_size,X_dim)
Y_test_hat <- matrix(NA,test_size,Y_dim)

Method <- "iMvTa"

B  <- matrix(NA,X_dim,Y_dim)
ST <- matrix(NA,X_dim,Y_dim)
SB <- matrix(NA,X_dim,Y_dim)
SE <- matrix(NA,X_dim,Y_dim)
VE <- matrix(NA,X_dim,Y_dim)
SN <- matrix(NA,X_dim,Y_dim)
X_train_hat <- matrix(NA,train_size,X_dim)
Y_train_hat <- matrix(NA,train_size,Y_dim)
X_test_hat <- matrix(NA,test_size,X_dim)
Y_test_hat <- matrix(NA,test_size,Y_dim)

score <- matrix(NA, SimTime, 4)

time <- proc.time()

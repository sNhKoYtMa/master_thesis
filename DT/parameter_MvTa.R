Method <- "MvTa"

B   <- matrix(NA,Y_dim,X_dim) # q x p
Sig <- matrix(NA,X_dim,X_dim) # p x p
A_m <- matrix(NA,X_dim,Y_dim) # p x q
SN  <- matrix(NA,Y_dim,Y_dim) # q x q

X_train_hat <- matrix(NA,train_size,X_dim)
Y_train_hat <- matrix(NA,train_size,Y_dim)
X_test_hat <- matrix(NA,test_size,X_dim)
Y_test_hat <- matrix(NA,test_size,Y_dim)

score <- matrix(NA, SimTime, 4)

time <- proc.time()

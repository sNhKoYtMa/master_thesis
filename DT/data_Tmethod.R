##### 人工データ #####
set.seed(722)
data_name <- "Tmethod_behind"
ntrain <- 10
ntest <- 100
size <- ntrain + ntest
train_ratio <- ntrain / size
class_ratio <- 0.5
SimTime <- 1000
class_num <- 2
X_dim <- 2
reg_coef <- c(1, -1)
sig <- c(1, 1)
# sig <- c(5, 0.2)
corr <- c(0, 0)
phi <- 1
class_sizes <- c(round(class_ratio * size),
                 size - round(class_ratio * size))

# データ作成
source("func_data_Artificial.R")
if(make.data == 1){
  # 正規分布
  # dfs <- lapply(1:SimTime, function(i) Generate.2class.Tmethod.Data(X_dim, class_sizes, reg_coef, sig, corr))
  # 多変量t分布
  dfs <- lapply(1:SimTime, function(i) Generate.2class.Tmethod.Data3(X_dim, class_sizes, reg_coef, sig, corr, phi))
}
df <- dfs[[1]]
source("data_dummy_variable.R")
dfs_dummy <- lapply(dfs, function(d) Convert.Dummy.Variable(d, conversion, target_name))

# cor(dfs[[1]][1:size*class_ratio,1:X_dim])


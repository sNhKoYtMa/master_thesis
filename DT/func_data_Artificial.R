##### T法背後モデルのデータ発生 #####
Generate.2class.Tmethod.Data <- function(dim, C_sizes, rc, s, rho){
  Ym <- rbind(cbind(rep(1, C_sizes[1]), rep(0, C_sizes[1])),
              cbind(rep(0, C_sizes[2]), rep(1, C_sizes[2])))
  B <- rbind(rep(rc[1], dim),
             rep(rc[2], dim))
  Esig1 <- matrix(rho[1], dim, dim); diag(Esig1) <- 1
  Esig2 <- matrix(rho[2], dim, dim); diag(Esig2) <- 1
  Esig1 <- Esig1 * s[1]
  Esig2 <- Esig2 * s[2]
  E <- rbind(rmvnorm(C_sizes[1], rep(0, dim), Esig1),
             rmvnorm(C_sizes[2], rep(0, dim), Esig2))
  X <- Ym %*% B + E %>% 
    as.data.frame() %>% 
    set_names(paste0("X", 1:dim))
  Y <- c(paste0("C", rep(1, C_sizes[1])),
         paste0("C", rep(2, C_sizes[2])))
  DF <- X %>% 
    mutate(Target = Y)
  return(DF)
}

# 列から発生
Generate.2class.Tmethod.Data2 <- function(dim, C_sizes, rc, s, rho){
  Ym <- c(rep(1, C_sizes[1]), rep(-1, C_sizes[2]))
  B <- rep(rc, dim)
  Esig1 <- matrix(rho[1], dim, dim); diag(Esig1) <- s[1]
  Esig2 <- matrix(rho[2], dim, dim); diag(Esig2) <- s[2]
  E <- rbind(rmvnorm(C_sizes[1], rep(0, dim), Esig1),
             rmvnorm(C_sizes[2], rep(0, dim), Esig2))
  Esig1 <- Esig1 * s[1]
  Esig2 <- Esig2 * s[2] 
  X <- as.matrix(Ym) %*% B + E %>%
    as.data.frame() %>% 
    set_names(paste0("X", 1:dim))
  Y <- c(paste0("C", rep(1, C_sizes[1])),
         paste0("C", rep(2, C_sizes[2])))
  DF <- X %>% 
    mutate(Target = Y)
  return(DF)
}

##### T法背後モデルのデータ発生(多変量t分布) #####
Generate.2class.Tmethod.Data3 <- function(dim, C_sizes, rc, s, rho, p){
  Ym <- rbind(cbind(rep(1, C_sizes[1]), rep(0, C_sizes[1])),
              cbind(rep(0, C_sizes[2]), rep(1, C_sizes[2])))
  B <- rbind(rep(rc[1], dim),
             rep(rc[2], dim))
  Esig1 <- matrix(rho[1], dim, dim); diag(Esig1) <- 1
  Esig2 <- matrix(rho[2], dim, dim); diag(Esig2) <- 1
  Esig1 <- Esig1 * s[1]
  Esig2 <- Esig2 * s[2]
  E <- rbind(rmvt(C_sizes[1], df = p, delta = rep(0, dim), sigma = Esig1),
             rmvt(C_sizes[2], df = p, delta = rep(0, dim), sigma = Esig2))
  X <- Ym %*% B + E %>% 
    as.data.frame() %>% 
    set_names(paste0("X", 1:dim))
  Y <- c(paste0("C", rep(1, C_sizes[1])),
         paste0("C", rep(2, C_sizes[2])))
  DF <- X %>% 
    mutate(Target = Y)
  return(DF)
}

##### ロジスティック回帰モデルのデータ発生 #####
Generate.2class.Linear.Data <- function(dim, C_sizes, m, s, rho){
  Mu1 <- rep(m[1], dim)
  Mu2 <- rep(m[2], dim)
  Sigma1 <- matrix(rho[1], dim, dim); diag(Sigma1) <- s[1]
  Sigma2 <- matrix(rho[2], dim, dim); diag(Sigma2) <- s[2]
  X <- rbind(rmvnorm(C_sizes[1], Mu1, Sigma1),
             rmvnorm(C_sizes[2], Mu2, Sigma2))
  B <- rep(1,dim)
  a <- X %*% B
  P <- 1/(1+exp(-a))
  Y <- apply(P, 1, function(p){
    if(p > 0.5){
      return("C1")
    } else return("C2")
  })
  DF <- data.frame(X) %>%
    mutate(Target = Y)
  return(DF)
}

# softmax関数
softmax <- function(par){
  n.par <- length(par)
  par1 <- sort(par, decreasing = T)
  Lk <- par1[1]
  for (k in 1:(n.par-1)) {
    Lk <- max(par1[k+1], Lk) + log1p(exp(-abs(par1[k+1] - Lk))) 
  }
  val <- exp(par - Lk)
  return(val)
}

# softmaxの形
Generate.2class.Linear.Data2 <- function(dim, C_sizes, m, s, rho){
  Mu1 <- rep(m[1], dim)
  Mu2 <- rep(m[2], dim)
  Sigma1 <- matrix(rho[1], dim, dim); diag(Sigma1) <- s[1]
  Sigma2 <- matrix(rho[2], dim, dim); diag(Sigma2) <- s[2]
  X <- rbind(rmvnorm(C_sizes[1], Mu1, Sigma1),
             rmvnorm(C_sizes[2], Mu2, Sigma2))
  W <- rbind(matrix(1, 1, dim), 
             matrix(-1, 1, dim)) # q x p
  a <- X %*% t(W) # n x q
  P <- t(apply(a, 1, softmax)) # n x q
  Y <- paste0("C", apply(P,1,which.max))
  DF <- data.frame(X) %>%
    mutate(Target = Y)
  return(DF)
}

# 多項分布を出力
Mn.2class <- function(p){
  res_mn <- rmultinom(n = 1, size = 1, prob = c(p[1], p[2])) %>% 
    t() %>%
    as.data.frame() %>% 
    set_names(paste0("C", 1:2))
  return(colnames(res_mn)[apply(res_mn, 1, which.max)])
}

# 多項分布を活用したロジスティック回帰モデル
Generate.2class.Linear.Data3 <- function(dim, C_sizes, m, s, rho){
  Mu1 <- rep(m[1], dim)
  Mu2 <- rep(m[2], dim)
  Sigma1 <- matrix(rho[1], dim, dim); diag(Sigma1) <- s[1]
  Sigma2 <- matrix(rho[2], dim, dim); diag(Sigma2) <- s[2]
  X <- rbind(rmvnorm(C_sizes[1], Mu1, Sigma1),
             rmvnorm(C_sizes[2], Mu2, Sigma2))
  W <- rbind(matrix(1, 1, dim), 
             matrix(-1, 1, dim)) # q x p
  a <- X %*% t(W) # n x q
  P <- t(apply(a, 1, softmax)) # n x q
  Y <- apply(P, 1, Mn.2class)
  DF <- data.frame(X) %>%
    mutate(Target = Y)
  return(DF)
}

##### ロジスティック回帰モデル(多変量t分布) #####
Generate.2class.Linear.Data4 <- function(dim, C_sizes, m, s, rho, p){
  Mu1 <- rep(m[1], dim)
  Mu2 <- rep(m[2], dim)
  Sigma1 <- matrix(rho[1], dim, dim); diag(Sigma1) <- s[1]
  Sigma2 <- matrix(rho[2], dim, dim); diag(Sigma2) <- s[2]
  X <- rbind(rmvt(C_sizes[1], df = p, delta = Mu1, sigma = Sigma1),
             rmvt(C_sizes[2], df = p, delta = Mu2, sigma = Sigma2))
  W <- rbind(matrix(1, 1, dim), 
             matrix(-1, 1, dim)) # q x p
  a <- X %*% t(W) # n x q
  P <- t(apply(a, 1, softmax)) # n x q
  Y <- apply(P, 1, Mn.2class)
  DF <- data.frame(X) %>%
    mutate(Target = Y)
  return(DF)
}

##### その他の関数 #####
# ダミー変数化関数
Convert.Dummy.Variable <- function(d, conv, name){
  if(conv %in% paste0("DC_", LETTERS[1:4])){
    df_d <- dummyVars(~., data=d)
  }else if(conv %in% paste0("DC_", LETTERS[5:6])){
    df_d <- dummyVars(~., data=d, fullRank=T)
  }
  df_d <- as.data.frame(predict(df_d, d))
  colnames(df_d)[-c(1:ncol(d)-1)] <- name
  return(df_d)
}

# インデックス作成｜線形のデータ時に利用
Make.Train.Index <- function(d, ratio){
  idx <- d$Target %>% 
    createDataPartition(p = ratio, list = F, times = 1)
  return(idx)
}

# set.seed(42)
# num <- 1000
# cor_d <- matrix(NA, num, 2)
# mean_d <- matrix(NA, num, 2)
# for(i in 1:num){
#   dft1 <- rmvt(10000, sigma = diag(2), df = 1, delta = rep(0, 2))
#   cor_d[i,1] <- cor(dft1)[1,2]
#   mean_d[i,1] <- colMeans(dft1)[1]
#   
#   dft2 <- rmvt(10000, sigma = diag(2), df = 2, delta = rep(0, 2))
#   cor_d[i,2] <- cor(dft2)[1,2]
#   mean_d[i,2] <- colMeans(dft2)[1]
# }
# plot(density(cor_d[,1]))
# plot(density(cor_d[,2]))
# plot(density(mean_d[,1]))
# plot(density(mean_d[,2]))

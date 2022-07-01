# LS-LDAと同じ変換コード
conversion.A <- function(data, names){
  for(j in 1:length(names)){
    target_vec <- data[,names[j]]
    a <- sqrt(length(target_vec)/sum(target_vec))
    b <- sqrt(sum(target_vec)/length(target_vec))
    for(i in 1:length(target_vec)){
      if(target_vec[i] == 1) target_vec[i] <- a - b # if y_j = j
      else target_vec[i] <- -b # otherwise
    }
    data[,names[j]] <- target_vec
  }
  return(data)
}

conversion.B <- function(data, names){
  not1 <- -1/(length(names)-1)
  data[names] <- t(apply(data[names], 1, function(irow){
        for(j in 1:length(irow)){
          if(irow[j] != 1) irow[j] <- not1 # otherwise
        }
        return(irow)
      }
    )
  )
  return(data)
}

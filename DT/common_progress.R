cat(sim,"/",SimTime)
cat(" Elapsed:", round(proc.time()[1]-time[1]), "s ")
cat("Rest:",round((proc.time()[1]-time[1])/(sim)*SimTime-(proc.time()[1]-time[1])),"s ")
# cat("Total:",round((proc.time()[1]-time[1])/(sim)*SimTime),"s",Method,conversion,ntrain,X_dim,"\n")
cat("Total:",round((proc.time()[1]-time[1])/(sim)*SimTime),"s",Method,conversion,train_size,X_dim,"\n")

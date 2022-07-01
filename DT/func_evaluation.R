
ConfusionDF <- function(y_pred, y_true) {
  Confusion_DF <- transform(as.data.frame(ConfusionMatrix(y_pred, y_true)),
                            y_true = as.character(y_true),
                            y_pred = as.character(y_pred),
                            Freq = as.integer(Freq))
  return(Confusion_DF)
}

Precision_macro <- function(y_true, y_pred, labels = NULL) {
  Confusion_DF <- ConfusionDF(y_pred, y_true)
  
  if (is.null(labels) == TRUE) labels <- unique(c(y_true, y_pred))
  # this is not bulletproof since there might be labels missing (in strange cases)
  # in strange cases where they existed in training set but are missing from test ground truth and predictions.
  
  Prec <- c()
  for (i in c(1:length(labels))) {
    positive <- labels[i]
    
    # it may happen that a label is never predicted (missing from y_pred) but exists in y_true
    # in this case ConfusionDF will not have these lines and thus the simplified code crashes
    # Prec[i] <- Precision(y_true, y_pred, positive = labels[i])
    
    # workaround:
    tmp <- Confusion_DF[which(Confusion_DF$y_true==positive & Confusion_DF$y_pred==positive), "Freq"]
    TP <- if (length(tmp)==0) 0 else as.integer(tmp)
    tmp <- Confusion_DF[which(Confusion_DF$y_true!=positive & Confusion_DF$y_pred==positive), "Freq"]
    FP <- if (length(tmp)==0) 0 else as.integer(sum(tmp))
    
    Prec[i] <- TP/(TP+FP)
  }
  Prec[is.na(Prec)] <- 0
  Precision_macro <- mean(Prec) # sum(Prec) / length(labels)
  return(Precision_macro)
}

Recall_macro <- function(y_true, y_pred, labels = NULL) {
  Confusion_DF <- ConfusionDF(y_pred, y_true)
  
  if (is.null(labels) == TRUE) labels <- unique(c(y_true, y_pred))
  # this is not bulletproof since there might be labels missing (in strange cases)
  # in strange cases where they existed in training set but are missing from test ground truth and predictions.
  
  Rec <- c()
  for (i in c(1:length(labels))) {
    positive <- labels[i]
    
    # short version, comment out due to bug or feature of Confusion_DF
    # TP[i] <- as.integer(Confusion_DF[which(Confusion_DF$y_true==positive & Confusion_DF$y_pred==positive), "Freq"])
    # FP[i] <- as.integer(sum(Confusion_DF[which(Confusion_DF$y_true==positive & Confusion_DF$y_pred!=positive), "Freq"]))
    
    # workaround:
    tmp <- Confusion_DF[which(Confusion_DF$y_true==positive & Confusion_DF$y_pred==positive), "Freq"]
    TP <- if (length(tmp)==0) 0 else as.integer(tmp)
    
    tmp <- Confusion_DF[which(Confusion_DF$y_true==positive & Confusion_DF$y_pred!=positive), "Freq"]
    FN <- if (length(tmp)==0) 0 else as.integer(sum(tmp))
    
    Rec[i] <- TP/(TP+FN)
  }
  
  Rec[is.na(Rec)] <- 0
  Recall_macro <- mean(Rec) # sum(Rec) / length(labels)
  return(Recall_macro)
}


F1_Score_macro <- function(y_true, y_pred, labels = NULL) {
  if (is.null(labels) == TRUE) labels <- unique(c(y_true, y_pred)) 
  # possible problems if labels are missing from y_*
  Precision <- Precision_macro(y_true, y_pred, labels)
  Recall <- Recall_macro(y_true, y_pred, labels)
  F1_Score_macro <- 2 * (Precision * Recall) / (Precision + Recall)
  return(F1_Score_macro)
}
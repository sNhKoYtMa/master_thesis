# Pima Indians Diabetes Database
# http://networkrepository.com/pima-indians-diabetes.php

set.seed(722)
data_name <- 'Diabetes'
train_ratio <- 0.01
SimTime <- 10
class_num <- 2
df <- read.csv('real_data/pima-indians-diabetes.csv', header = F) %>%
  # set_names('Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness',
  #           'Insulin', 'BMI', 'DiabetesPedigreeFunction', 'Age', 'Target') %>%
  set_names(paste0('X',1:8),'Target') %>%
  mutate(X1 = as.numeric(X1),
         X2 = as.numeric(X2),
         X3 = as.numeric(X3),
         X4 = as.numeric(X4),
         X5 = as.numeric(X5),
         X8 = as.numeric(X8),
         Target = as.character(Target))
sapply(df, class)

source('data_dummy_variable.R')

df %>% 
  dplyr::select(-Target) %>%
  cor() %>% 
  corrplot::corrplot()


# Pregnancies: 妊娠した回数
# Glucose: 経口ブドウ糖負荷試験における 2 時間の血漿ブドウ糖濃度
# BloodPressure: 拡張期血圧 (mm Hg)
# SkinThickness: 三頭筋の皮膚のひだの厚さ (mm)
# Insulin: 2 時間血清インスリン (mu U/ml)
# BMI: 体格指数 (体重 (kg)/(身長 (m))^2)
# DiabetesPedigreeFunction: 糖尿病の血統関数
# Age: 年齢 (歳)
# Outcome: クラス変数 (0or1) / 768のうち268が1,残りは0


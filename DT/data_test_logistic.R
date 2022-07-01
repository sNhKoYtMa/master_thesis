b1=1
b2=1
n=1000
x1=rnorm(n,0,8)
x2=x1^2
e=rnorm(n,0,200)
pi=exp(b1*x1+b2*x2+e)/(1+exp(b1*x1+b2*x2+e))
y=rbinom(n,1,prob = pi)
# summary(glm(y~x1+x2,family="binomial"))

library(tidyverse)
df <- data.frame(x1,x2,y)
df %>% 
  ggplot(aes(y = x2, x = x1, color = y)) +
  geom_point()
  
# geom_point(x1, x2, colour = y)
# plot(x1, x2)
table(y)

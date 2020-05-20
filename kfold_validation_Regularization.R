#k fold cross validation
set.seed(17)
cv.error.10 <- rep(0,10)
for(i in 1:10){
glm.fit <- glm(mpg~poly(horsepower,i),data=ISLR::Auto)
cv.error.10[i] <- boot::cv.glm(ISLR::Auto,glm.fit,K=10)$delta[i]
}
cv.error.10

glm.fit <- glm(mpg~poly(horsepower,3),data=ISLR::Auto)
cv.error.10 <- boot::cv.glm(ISLR::Auto,glm.fit,K=10)
cv.error.10$delta
cv.error.10$call

#Subset 
install.packages("leaps")
library(leaps)
#by default at max it can create upto 8 variable model
regfit.full=regsubsets(Salary~.,ISLR::Hitters)
summary(regfit.full)
#we can expand that by using nvmax
regfit.full=regsubsets(Salary~.,ISLR::Hitters,nvmax=19)
summary(regfit.full)
reg.summary=summary(regfit.full)
names(reg.summary)
plot(reg.summary$rsq,xlab='Number of variables')
plot(reg.summary$adjr2,xlab='No. of variables')

which.max(reg.summary$adjr2)
plot(regfit.full)

#Lasso(alpha=1) & Ridge(alpha=0)
#use glmnet package
#use a model matrix

#get coefficients of the model with max. adj r2
coef(regfit.full,11)

#Forward Regression
regfit.fwd=regsubsets(Salary~.,ISLR::Hitters,nvmax=19,method='forward')
summary(regfit.fwd)
coef(regfit.fwd,7)
#Backward Regression
regfit.bwd=regsubsets(Salary~.,ISLR::Hitters,nvmax=19,method='backward')
summary(regfit.bwd)
coef(regfit.bwd,7)

#Cross Validation
set.seed(1)
train=caTools::sample.split(ISLR::Hitters,SplitRatio = 0.7)
test=(!train)

#fit model on the training set
regfit.full <- regsubsets(Salary~.,data=ISLR::Hitters[train,],nvmax=19)
#create model matrix for the test data
test.mat <- model.matrix(Salary~.,data=ISLR::Hitters[test,])

for(i in 1:19){
  coefi=coef(regfit.full,i)
  pred=test.mat[,names(coefi)]%*%coefi
  val.errors[i]=mean(ISLR::Hitters$Salary[test]-pred)^2
}
val.errors


#create a correlation plot
library(GGally)
library(dplyr)
df <- ISLR::Hitters[train,]
GGally::ggscatmat(df, columns = 1: ncol(df))
df

full.model <- lm(Salary~.,data=ISLR::Hitters[train,])
library(MASS)
step.model <- MASS::stepAIC(full.model, direction = "backward", 
                      trace = FALSE)
step.model

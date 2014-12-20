 
library(randomForest)
library(gbm)

dataset <- mtcars
dataset$cyl <- as.numeric(dataset$cyl)

lm_formula <- lm(mpg~as.factor(cyl)+hp+wt+drat+disp+gear+carb, data=dataset)
#gbm_formula <- gbm(mpg~as.factor(cyl)+hp+wt+drat+disp+gear+carb, data=dataset)
rf_formula <- randomForest(mpg~cyl+hp+wt+drat+disp+gear+carb, data=dataset)

# "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear" "carb"

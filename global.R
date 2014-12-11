
library(randomForest)

dataset <- mtcars
dataset$cyl <- as.numeric(dataset$cyl)

lm_formula <- lm(mpg~cyl+hp+wt+drat+disp+gear+carb, data=dataset)
glm_formula <- glm(mpg~cyl+hp+wt+drat+disp+gear+carb, data=dataset)
rf_formula <- randomForest(mpg~cyl+hp+wt+drat+disp+gear+carb, data=dataset, ntree=150,mtry=3)
# "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear" "carb"

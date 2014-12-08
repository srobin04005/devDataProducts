
dataset <- mtcars
lm_formula <- lm(mpg~as.numeric(cyl)+hp+wt+drat, data=dataset)
glm_formula <- glm(mpg~as.numeric(cyl)+hp+wt+drat, data=dataset)

# "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear" "carb"

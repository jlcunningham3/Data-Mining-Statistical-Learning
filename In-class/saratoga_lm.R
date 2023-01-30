library(tidyverse)
library(ggplot2)
library(modelr)
library(rsample)
library(mosaic)
data(SaratogaHouses)

glimpse(SaratogaHouses)

####
# Compare out-of-sample predictive performance
####

# Split into training and testing sets
saratoga_split = initial_split(SaratogaHouses, prop = 0.8)
saratoga_train = training(saratoga_split)
saratoga_test = testing(saratoga_split)
	
# Fit to the training data
# Sometimes it's easier to name the variables we want to leave out
# The command below yields exactly the same model.
# the dot (.) means "all variables not named"
# the minus (-) means "exclude this variable"
lm1 = lm(price ~ lotSize + bedrooms + bathrooms, data=saratoga_train)
lm2 = lm(price ~ . - pctCollege - sewer - waterfront - landValue - newConstruction, data=saratoga_train)
lm3 = lm(price ~ (. - pctCollege - sewer - waterfront - landValue - newConstruction)^2, data=saratoga_train)

coef(lm1) %>% round(0)
coef(lm2) %>% round(0)
coef(lm3) %>% round(0)

# Predictions out of sample
# Root mean squared error
rmse(lm1, saratoga_test)
rmse(lm2, saratoga_test)
rmse(lm3, saratoga_test)

# Can you hand-build a model that improves on all three?
# Remember feature engineering, and remember not just to rely on a single train/test split


# construct the training and test-set feature matrices
# note the "-1": this says "don't add a column of ones for the intercept" 
Xtrain = model.matrix(~ age + livingArea + bedrooms - 1, data=saratoga_train) 
Xtest = model.matrix(~ age + livingArea + bedrooms - 1, data=saratoga_test)

# training and testing set responses
ytrain = saratoga_train$price 
ytest = saratoga_test$price

# now rescale:
scale_train = apply(Xtrain, 2, sd) # calculate std dev for each column 
Xtilde_train = scale(Xtrain, scale = scale_train)
Xtilde_test = scale(Xtest, scale = scale_train) # use the training set scales!

head(Xtrain, 2)
head(Xtilde_train, 2) %>% round(2)

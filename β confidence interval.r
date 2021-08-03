library(tidyverse)
library(tidymodels)
library(scales)
library(lubridate)
library(textrecipes)
library(stacks)

set.seed(2021)


holdout <- read.csv("E:\\test.csv")
dataset <- read.csv("E:\\train.csv")
head(dataset)


spl <- initial_split(dataset, prop = 0.75)
test <- testing(spl)
train <- training(spl)


variable.names(train)


train_fold <- train %>%  vfold_cv(v = 5)

#V-fold cross-validation randomly splits the data into V groups of 
#roughly equal size (called "folds")


#metric_set() allows you to combine multiple metric functions together into a new function that calculates all of them at once.

mset <- metric_set(mn_log_loss)

?metric_set
?mn_log_loss

grid_control <- control_grid(save_pred = TRUE, save_workflow = TRUE, extract = extract_model)

?control_grid



summarize_rainfall <- function(tbl) {
  ret <- tbl %>% summarize(n_rain = sum(rain_tomorrow), 
                           n= n()) %>% arrange(desc(n)) %>% 
    ungroup() %>% mutate(pct_rain = n_rain / n,low = qbeta(0.025, n_rain + 5,n - n_rain + .5 ),high = qbeta(0.975, n_rain + 5,n - n_rain + .5 )) %>% mutate(pct = n /sum(n))
  ret
}


?qbeta


qbeta(0.025, 5756, 19892.5)

test_t

train %>% summarize_rainfall()


train %>% group_by(location = fct_lump(location, 50)) %>% summarize_rainfall() %>% mutate(location = fct_reorder(location, pct_rain)) %>% 
ggplot(aes(pct_rain, location)) + geom_point(aes( size = pct)) + geom_errorbarh(aes(xmin = low, xmax = high), width = .1) +theme_minimal() + scale_size_continuous(labels = percent) + scale_x_continuous(labels = percent) + labs(x = "Probability of raining tomorrow", y = "", title = "What locations get the most/least rain?",subtitle = "Including 95% confidence intervals. Size of the points is proportional to frequency")

#The selection of a confidence level for an interval determines the probability that the confidence interval produced will contain the true parameter value.



